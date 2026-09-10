# Nhóm Hành Vi: Các Ca Sử Dụng Thực Tế (Behavioral Patterns Cases)

---

## 1. Case: Công Cụ Tính Phí Vận Chuyển Linh Hoạt (Strategy Pattern)

### 📌 Bối cảnh Nghiệp vụ (Business Problem)
Cửa hàng hỗ trợ nhiều đối tác vận chuyển với thuật toán tính phí khác nhau:
* **Giao Hàng Tiết Kiệm (GHTK)**: Tính theo khối lượng quy đổi + khoảng cách tỉnh/thành.
* **Giao Hàng Nhanh (GHN)**: Tính theo thể tích gói hàng ($D \times R \times C / 5000$).
* **Hỏa Tốc Nội Thành (GrabExpress)**: Tính theo cước cố định 4km đầu + số km vượt.

Hệ thống cần hoán đổi linh hoạt thuật toán tính cước tùy theo lựa chọn của khách hàng mà không dùng chuỗi `if-else` dài ngoằng trong hàm thanh toán.

---

### 💻 Triển khai theo từng Ngôn ngữ

#### 🐘 PHP 8.x
```php
<?php
declare(strict_types=1);

interface ShippingStrategyInterface {
    public function calculateFee(float $weightKg, float $distanceKm): float;
}

class GhtkShippingStrategy implements ShippingStrategyInterface {
    public function calculateFee(float $weightKg, float $distanceKm): float {
        return 22000 + ($weightKg * 5000);
    }
}

class GhnShippingStrategy implements ShippingStrategyInterface {
    public function calculateFee(float $weightKg, float $distanceKm): float {
        return 25000 + ($weightKg * 4500) + ($distanceKm > 50 ? 10000 : 0);
    }
}

class GrabExpressStrategy implements ShippingStrategyInterface {
    public function calculateFee(float $weightKg, float $distanceKm): float {
        return 30000 + max(0, $distanceKm - 4) * 6000;
    }
}

// Context: Tầng tính cước đơn hàng
class ShippingFeeCalculator {
    public function __construct(private ShippingStrategyInterface $strategy) {}

    public function setStrategy(ShippingStrategyInterface $strategy): void {
        $this->strategy = $strategy;
    }

    public function estimate(float $weightKg, float $distanceKm): float {
        return $this->strategy->calculateFee($weightKg, $distanceKm);
    }
}
```

#### 🟦 TypeScript
```typescript
export interface ShippingStrategy {
    calculate(weightKg: number, distanceKm: number): number;
}

export const ghtkStrategy: ShippingStrategy = {
    calculate: (w, d) => 22000 + w * 5000,
};

export const ghnStrategy: ShippingStrategy = {
    calculate: (w, d) => 25000 + w * 4500 + (d > 50 ? 10000 : 0),
};

export const grabStrategy: ShippingStrategy = {
    calculate: (w, d) => 30000 + Math.max(0, d - 4) * 6000,
};

export class ShippingCalculator {
    constructor(private strategy: ShippingStrategy) {}

    setStrategy(newStrategy: ShippingStrategy) {
        this.strategy = newStrategy;
    }

    calculateFee(weight: number, distance: number): number {
        return this.strategy.calculate(weight, distance);
    }
}
```

#### 🐹 Go (Golang)
```go
package shipping

type FeeStrategy interface {
	Calculate(weightKg float64, distanceKm float64) float64
}

type GHTKStrategy struct{}
func (s GHTKStrategy) Calculate(w, d float64) float64 {
	return 22000 + (w * 5000)
}

type GrabExpressStrategy struct{}
func (s GrabExpressStrategy) Calculate(w, d float64) float64 {
	extraKm := d - 4
	if extraKm < 0 {
		extraKm = 0
	}
	return 30000 + (extraKm * 6000)
}

type Calculator struct {
	strategy FeeStrategy
}

func NewCalculator(s FeeStrategy) *Calculator {
	return &Calculator{strategy: s}
}

func (c *Calculator) SetStrategy(s FeeStrategy) {
	c.strategy = s
}

func (c *Calculator) Estimate(w, d float64) float64 {
	return c.strategy.Calculate(w, d)
}
```

---

## 2. Case: Chuỗi Kiểm Duyệt Chống Gian Lận (Chain of Responsibility)

### 📌 Bối cảnh Nghiệp vụ (Business Problem)
Trước khi một giao dịch mua hàng hoặc rút tiền được duyệt, hệ thống phải vượt qua một chuỗi các lớp kiểm tra an ninh (Pipeline):
1. **Blacklist Check**: Tài khoản/IP có nằm trong danh sách đen cấm giao dịch?
2. **Velocity Check**: Người dùng có thực hiện quá 5 giao dịch trong vòng 1 phút?
3. **Stock Verification**: Toàn bộ sản phẩm trong giỏ còn đủ tồn kho thực tế?
4. **Credit / Balance Check**: Số dư tài khoản hoặc thẻ tín dụng có đủ hạn mức?

Nếu bất kỳ khâu nào thất bại, chuỗi sẽ dừng ngay lập tức và trả về lý do cụ thể. Nếu thành công, chuyển tiếp cho khâu tiếp theo.

---

### 💻 Triển khai theo từng Ngôn ngữ

#### 🟦 TypeScript
```typescript
export interface OrderContext {
    userId: string;
    ip: string;
    totalAmount: number;
    items: { sku: string; qty: number }[];
}

export abstract class OrderVerificationHandler {
    private nextHandler?: OrderVerificationHandler;

    public setNext(handler: OrderVerificationHandler): OrderVerificationHandler {
        this.nextHandler = handler;
        return handler;
    }

    public async handle(context: OrderContext): Promise<void> {
        await this.check(context);
        if (this.nextHandler) {
            await this.nextHandler.handle(context);
        }
    }

    protected abstract check(context: OrderContext): Promise<void>;
}

// Handler 1: Kiểm tra Blacklist
export class BlacklistVerification extends OrderVerificationHandler {
    protected async check(ctx: OrderContext): Promise<void> {
        if (ctx.userId === "banned_user_99") {
            throw new Error("Tài khoản đang bị khóa do vi phạm chính sách.");
        }
    }
}

// Handler 2: Kiểm tra Tần suất Giao dịch (Velocity)
export class VelocityVerification extends OrderVerificationHandler {
    protected async check(ctx: OrderContext): Promise<void> {
        // Giả lập kiểm tra Redis xem IP có spam không
        console.log(`[PASS] Velocity check passed for IP: ${ctx.ip}`);
    }
}

// Handler 3: Kiểm tra Hạn mức Giao dịch
export class LimitVerification extends OrderVerificationHandler {
    protected async check(ctx: OrderContext): Promise<void> {
        if (ctx.totalAmount > 100_000_000) {
            throw new Error("Giao dịch vượt quá hạn mức tối đa cho phép.");
        }
    }
}

// Cách lắp ráp chuỗi kiểm duyệt
const pipeline = new BlacklistVerification();
pipeline
    .setNext(new VelocityVerification())
    .setNext(new LimitVerification());

// Thực thi
// await pipeline.handle(currentOrder);
```

---

## 3. Case: Máy Trạng Thái Đơn Hàng Chống Nhảy Cóc (State Pattern)

### 📌 Bối cảnh Nghiệp vụ (Business Problem)
Đơn hàng trải qua các trạng thái: `Mới tạo (Draft)` -> `Chờ thanh toán (Pending)` -> `Đã thanh toán (Paid)` -> `Đang vận chuyển (Shipped)` -> `Đã hủy (Cancelled)`.
Cần ngăn chặn tuyệt đối các hành vi phi logic như:
* Không được phép bấm **Hủy đơn** khi đơn đã chuyển trạng thái `Shipped`.
* Không được phép bấm **Thanh toán lại** khi đơn đã ở trạng thái `Paid`.
* Mỗi trạng thái tự quyết định hành vi cho phép và trạng thái kế tiếp, không dùng `switch-case` lồng nhau.

---

### 💻 Triển khai bằng PHP 8.x

```php
<?php
declare(strict_types=1);

interface OrderStateInterface {
    public function pay(OrderContext $order): void;
    public function ship(OrderContext $order): void;
    public function cancel(OrderContext $order): void;
    public function getName(): string;
}

class OrderContext {
    private OrderStateInterface $state;

    public function __construct() {
        $this->state = new PendingPaymentState();
    }

    public function setState(OrderStateInterface $state): void {
        $this->state = $state;
    }

    public function pay(): void {
        $this->state->pay($this);
    }

    public function ship(): void {
        $this->state->ship($this);
    }

    public function cancel(): void {
        $this->state->cancel($this);
    }

    public function getStateName(): string {
        return $this->state->getName();
    }
}

class PendingPaymentState implements OrderStateInterface {
    public function pay(OrderContext $order): void {
        echo "Thanh toán thành công. Chuyển sang trạng thái Đã Thanh Toán.\n";
        $order->setState(new PaidState());
    }

    public function ship(OrderContext $order): void {
        throw new LogicException("Không thể giao hàng khi đơn chưa thanh toán!");
    }

    public function cancel(OrderContext $order): void {
        echo "Đã hủy đơn hàng chờ thanh toán.\n";
        $order->setState(new CancelledState());
    }

    public function getName(): string { return "PENDING_PAYMENT"; }
}

class PaidState implements OrderStateInterface {
    public function pay(OrderContext $order): void {
        throw new LogicException("Đơn hàng này đã được thanh toán trước đó!");
    }

    public function ship(OrderContext $order): void {
        echo "Đã xuất kho và bàn giao cho đơn vị vận chuyển.\n";
        $order->setState(new ShippedState());
    }

    public function cancel(OrderContext $order): void {
        echo "Hủy đơn và tiến hành hoàn tiền cho khách hàng.\n";
        $order->setState(new CancelledState());
    }

    public function getName(): string { return "PAID"; }
}

class ShippedState implements OrderStateInterface {
    public function pay(OrderContext $order): void { throw new LogicException("Đơn hàng đã thanh toán và đang giao!"); }
    public function ship(OrderContext $order): void { throw new LogicException("Đơn hàng đã được giao trước đó!"); }
    public function cancel(OrderContext $order): void {
        throw new LogicException("Không thể hủy đơn hàng khi shipper đã mang đi giao!");
    }
    public function getName(): string { return "SHIPPED"; }
}

class CancelledState implements OrderStateInterface {
    public function pay(OrderContext $order): void { throw new LogicException("Đơn hàng đã hủy!"); }
    public function ship(OrderContext $order): void { throw new LogicException("Đơn hàng đã hủy!"); }
    public function cancel(OrderContext $order): void { throw new LogicException("Đơn hàng đã ở trạng thái hủy!"); }
    public function getName(): string { return "CANCELLED"; }
}
```

---

## 4. Case: Phát Sự Kiện Bất Đồng Bộ Sau Đặt Hàng (Observer / Pub-Sub)

### 📌 Bối cảnh Nghiệp vụ (Business Problem)
Sau khi thanh toán thành công (`OrderPaidEvent`), hệ thống cần:
1. Gửi email xác nhận hóa đơn.
2. Trừ số lượng tồn kho thực tế.
3. Tích lũy điểm thưởng thành viên (Loyalty points).
4. Phát thông báo realtime qua WebSocket tới màn hình kho hàng.

Tầng thanh toán chính không nên trực tiếp gọi email hay websocket; nó chỉ cần phát ra một **Sự kiện (Domain Event)** và các **Subscribers** tự động xử lý độc lập.

---

### 💻 Triển khai bằng Go (Goroutines & Channels)

```go
package events

import (
	"fmt"
	"sync"
)

type OrderPaidEvent struct {
	OrderID    string
	CustomerID string
	Amount     float64
}

type EventListener func(event OrderPaidEvent)

type EventDispatcher struct {
	mu        sync.RWMutex
	listeners []EventListener
}

func (d *EventDispatcher) Subscribe(listener EventListener) {
	d.mu.Lock()
	defer d.mu.Unlock()
	d.listeners = append(d.listeners, listener)
}

func (d *EventDispatcher) Publish(event OrderPaidEvent) {
	d.mu.RLock()
	defer d.mu.RUnlock()

	for _, listener := range d.listeners {
		// Thực thi song song bất đồng bộ qua Goroutines
		go listener(event)
	}
}

// Các Subscribers độc lập
func SendEmailListener(event OrderPaidEvent) {
	fmt.Printf("[Email] Gửi hoá đơn điện tử cho đơn hàng: %s\n", event.OrderID)
}

func DeductStockListener(event OrderPaidEvent) {
	fmt.Printf("[Inventory] Trừ tồn kho thành công cho đơn hàng: %s\n", event.OrderID)
}

func AddLoyaltyPointsListener(event OrderPaidEvent) {
	fmt.Printf("[Loyalty] Tích điểm thưởng cho khách hàng: %s\n", event.CustomerID)
}
```

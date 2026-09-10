# Nhóm Khởi Tạo: Các Ca Sử Dụng Thực Tế (Creational Patterns Cases)

---

## 1. Case: Khởi Tạo Cổng Thanh Toán Đa Kênh (Factory Method)

### 📌 Bối cảnh Nghiệp vụ (Business Problem)
Hệ thống thương mại điện tử cần hỗ trợ nhiều cổng thanh toán: **VNPay**, **MoMo**, **Stripe**, **ZaloPay**. Mỗi cổng có thông tin xác thực, URL endpoint và thuật toán tạo URL thanh toán khác nhau. Tầng thanh toán không được phép dùng lệnh `switch-case` rải rác khắp nơi; khi bổ sung một cổng thanh toán mới (vd: Apple Pay), code nghiệp vụ đặt hàng không được phép thay đổi.

---

### 💻 Triển khai theo từng Ngôn ngữ

#### 🐘 PHP 8.x
```php
<?php
declare(strict_types=1);

interface PaymentGatewayInterface {
    public function charge(float $amount, string $orderId): string;
}

class VnPayGateway implements PaymentGatewayInterface {
    public function charge(float $amount, string $orderId): string {
        return "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?orderId={$orderId}&amount={$amount}";
    }
}

class MoMoGateway implements PaymentGatewayInterface {
    public function charge(float $amount, string $orderId): string {
        return "https://payment.momo.vn/v2/gateway/pay?orderId={$orderId}&amount={$amount}";
    }
}

// Factory Method
class PaymentGatewayFactory {
    public static function create(string $method): PaymentGatewayInterface {
        return match (strtolower($method)) {
            'vnpay' => new VnPayGateway(),
            'momo'  => new MoMoGateway(),
            default => throw new InvalidArgumentException("Unsupported payment method: {$method}"),
        };
    }
}

// Cách dùng
$gateway = PaymentGatewayFactory::create('vnpay');
$redirectUrl = $gateway->charge(2500000, 'ORDER-101');
```

#### 🟦 TypeScript
```typescript
interface PaymentGateway {
    charge(amount: number, orderId: string): Promise<string>;
}

class VnPayGateway implements PaymentGateway {
    async charge(amount: number, orderId: string): Promise<string> {
        return `https://vnpay.vn/pay?orderId=${orderId}&amount=${amount}`;
    }
}

class MoMoGateway implements PaymentGateway {
    async charge(amount: number, orderId: string): Promise<string> {
        return `https://momo.vn/pay?orderId=${orderId}&amount=${amount}`;
    }
}

export class PaymentGatewayFactory {
    private static registry = new Map<string, () => PaymentGateway>([
        ['vnpay', () => new VnPayGateway()],
        ['momo', () => new MoMoGateway()],
    ]);

    public static register(method: string, factory: () => PaymentGateway): void {
        this.registry.set(method.toLowerCase(), factory);
    }

    public static create(method: string): PaymentGateway {
        const creator = this.registry.get(method.toLowerCase());
        if (!creator) throw new Error(`Unsupported payment method: ${method}`);
        return creator();
    }
}

// Cách dùng (Dễ mở rộng không sửa code gốc)
const gateway = PaymentGatewayFactory.create('momo');
const url = await gateway.charge(150000, 'ORD-999');
```

#### 🐹 Go (Golang)
```go
package payment

import (
	"fmt"
	"strings"
)

type Gateway interface {
	Charge(amount float64, orderID string) (string, error)
}

type VnPayGateway struct{}
func (v *VnPayGateway) Charge(amount float64, orderID string) (string, error) {
	return fmt.Sprintf("https://vnpay.vn/pay?orderId=%s&amount=%.0f", orderID, amount), nil
}

type MoMoGateway struct{}
func (m *MoMoGateway) Charge(amount float64, orderID string) (string, error) {
	return fmt.Sprintf("https://momo.vn/pay?orderId=%s&amount=%.0f", orderID, amount), nil
}

// Factory function
func NewPaymentGateway(method string) (Gateway, error) {
	switch strings.ToLower(method) {
	case "vnpay":
		return &VnPayGateway{}, nil
	case "momo":
		return &MoMoGateway{}, nil
	default:
		return nil, fmt.Errorf("unsupported payment method: %s", method)
	}
}
```

#### 🐍 Python 3.10+
```python
from typing import Protocol

class PaymentGateway(Protocol):
    def charge(self, amount: float, order_id: str) -> str:
        ...

class VnPayGateway:
    def charge(self, amount: float, order_id: str) -> str:
        return f"https://vnpay.vn/pay?orderId={order_id}&amount={amount}"

class MoMoGateway:
    def charge(self, amount: float, order_id: str) -> str:
        return f"https://momo.vn/pay?orderId={order_id}&amount={amount}"

class PaymentGatewayFactory:
    _registry: dict[str, type] = {
        "vnpay": VnPayGateway,
        "momo": MoMoGateway,
    }

    @classmethod
    def register(cls, name: str, gateway_cls: type) -> None:
        cls._registry[name.lower()] = gateway_cls

    @classmethod
    def create(cls, method: str) -> PaymentGateway:
        gateway_cls = cls._registry.get(method.lower())
        if not gateway_cls:
            raise ValueError(f"Unsupported payment method: {method}")
        return gateway_cls()
```

---

## 2. Case: Xây Dựng Cấu Hình & Báo Cáo Phức Tạp (Builder & Functional Options)

### 📌 Bối cảnh Nghiệp vụ (Business Problem)
Một báo cáo doanh thu (`RevenueReport`) hoặc một đơn hàng có rất nhiều tham số tuỳ chọn: khoảng thời gian (startDate, endDate), danh sách chi nhánh (branchIds), định dạng xuất (PDF/Excel/JSON), có gom nhóm theo danh mục hay không, có kèm chi phí thuế hay không. Nếu dùng Constructor bình thường, hàm sẽ nhận 7-10 tham số (`telescoping constructor`), rất dễ nhầm lẫn vị trí tham số và khó đọc.

---

### 💻 Triển khai theo từng Ngôn ngữ

#### 🟦 TypeScript (Fluent Builder)
```typescript
interface ReportQuery {
    startDate: Date;
    endDate: Date;
    branchIds: string[];
    format: 'pdf' | 'excel' | 'json';
    includeTax: boolean;
    groupByCategory: boolean;
}

export class RevenueReportBuilder {
    private query: Partial<ReportQuery> = {
        branchIds: [],
        format: 'pdf',
        includeTax: false,
        groupByCategory: false,
    };

    setDateRange(start: Date, end: Date): this {
        this.query.startDate = start;
        this.query.endDate = end;
        return this;
    }

    withBranches(...branchIds: string[]): this {
        this.query.branchIds = branchIds;
        return this;
    }

    formatAs(format: 'pdf' | 'excel' | 'json'): this {
        this.query.format = format;
        return this;
    }

    includeTax(enable = true): this {
        this.query.includeTax = enable;
        return this;
    }

    build(): ReportQuery {
        if (!this.query.startDate || !this.query.endDate) {
            throw new Error("Date range is required to build revenue report.");
        }
        return this.query as ReportQuery;
    }
}

// Cách dùng
const reportConfig = new RevenueReportBuilder()
    .setDateRange(new Date("2026-01-01"), new Date("2026-01-31"))
    .withBranches("HN-01", "HCM-02")
    .formatAs("excel")
    .includeTax()
    .build();
```

#### 🐹 Go (Functional Options Pattern - Chuẩn Go Idiom)
> Trong Go, idiom tốt nhất để thay thế Builder Pattern là **Functional Options Pattern**.

```go
package report

import (
	"errors"
	"time"
)

type Options struct {
	StartDate       time.Time
	EndDate         time.Time
	BranchIDs       []string
	Format          string
	IncludeTax      bool
	GroupByCategory bool
}

type Option func(*Options)

func WithBranches(branchIDs ...string) Option {
	return func(o *Options) {
		o.BranchIDs = append(o.BranchIDs, branchIDs...)
	}
}

func WithFormat(format string) Option {
	return func(o *Options) {
		o.Format = format
	}
}

func WithTax() Option {
	return func(o *Options) {
		o.IncludeTax = true
	}
}

func NewRevenueReport(start, end time.Time, opts ...Option) (*Options, error) {
	if start.After(end) {
		return nil, errors.New("startDate cannot be after endDate")
	}

	config := &Options{
		StartDate: start,
		EndDate:   end,
		Format:    "pdf", // default
	}

	for _, opt := range opts {
		opt(config)
	}

	return config, nil
}

// Cách dùng
// report, err := NewRevenueReport(start, end, WithBranches("HN-01"), WithFormat("excel"), WithTax())
```

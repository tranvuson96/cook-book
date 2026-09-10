# Nhóm Cấu Trúc: Các Ca Sử Dụng Thực Tế (Structural Patterns Cases)

---

## 1. Case: Chuẩn Hóa Cổng Gửi Tin Nhắn / SMS SDK (Adapter Pattern)

### 📌 Bối cảnh Nghiệp vụ (Business Problem)
Doanh nghiệp cần gửi mã OTP và thông báo đơn hàng. Hiện tại đang dùng **Twilio**, nhưng muốn chuyển dần sang **Zalo ZNS** và **eSMS**. Mỗi nhà cung cấp có tên hàm và cấu trúc tham số khác nhau hoàn toàn (`twilio->messages->create`, `esms->SendMultipleMessage_V4_post_json`). Nếu nhúng trực tiếp SDK của bên thứ ba vào Use Case, code sẽ bị khóa chặt vào nhà cung cấp đó và cực kỳ khó viết Unit Test (mock).

---

### 💻 Triển khai theo từng Ngôn ngữ

#### 🐘 PHP 8.x
```php
<?php
declare(strict_types=1);

// Cổng chung trong Domain (Domain Port)
interface SmsSenderInterface {
    public function send(string $phoneNumber, string $content): bool;
}

// SDK Bên thứ 3 A (Twilio SDK Giả lập)
class TwilioClient {
    public function createMessage(string $to, array $payload): array {
        // payload: ['body' => '...']
        return ['sid' => 'SM123', 'status' => 'sent'];
    }
}

// SDK Bên thứ 3 B (eSMS API Giả lập)
class EsmsClient {
    public function SendMultipleMessage_V4(string $Phone, string $Content, int $Type): array {
        return ['CodeResult' => '100', 'ErrorMessage' => 'Success'];
    }
}

// Adapter cho Twilio
class TwilioSmsAdapter implements SmsSenderInterface {
    public function __construct(private TwilioClient $client) {}

    public function send(string $phoneNumber, string $content): bool {
        $res = $this->client->createMessage($phoneNumber, ['body' => $content]);
        return ($res['status'] ?? '') === 'sent';
    }
}

// Adapter cho eSMS
class EsmsSmsAdapter implements SmsSenderInterface {
    public function __construct(private EsmsClient $client) {}

    public function send(string $phoneNumber, string $content): bool {
        $res = $this->client->SendMultipleMessage_V4($phoneNumber, $content, 2);
        return ($res['CodeResult'] ?? '') === '100';
    }
}

// Tầng Use Case chỉ phụ thuộc vào SmsSenderInterface
class SendOtpUseCase {
    public function __construct(private SmsSenderInterface $smsSender) {}

    public function execute(string $phone, string $otp): void {
        $this->smsSender->send($phone, "Mã xác thực của bạn là: {$otp}");
    }
}
```

#### 🟦 TypeScript
```typescript
export interface SmsSenderPort {
    send(phone: string, text: string): Promise<boolean>;
}

// Giả lập Twilio SDK
class TwilioSdk {
    async sendMessage(params: { to: string; message: string }): Promise<{ success: boolean }> {
        return { success: true };
    }
}

// Twilio Adapter
export class TwilioAdapter implements SmsSenderPort {
    constructor(private readonly client: TwilioSdk) {}

    async send(phone: string, text: string): Promise<boolean> {
        const res = await this.client.sendMessage({ to: phone, message: text });
        return res.success;
    }
}
```

#### 🐹 Go (Golang)
```go
package notification

type SmsSender interface {
	Send(phone string, message string) error
}

type ThirdPartyVendorClient struct{}
func (c *ThirdPartyVendorClient) DispatchSms(msisdn string, textPayload string) int {
	// Giả lập trả về code 200 nếu thành công
	return 200
}

// Adapter
type VendorSmsAdapter struct {
	client *ThirdPartyVendorClient
}

func NewVendorSmsAdapter(c *ThirdPartyVendorClient) SmsSender {
	return &VendorSmsAdapter{client: c}
}

func (a *VendorSmsAdapter) Send(phone string, message string) error {
	code := a.client.DispatchSms(phone, message)
	if code != 200 {
		return fmt.Errorf("vendor failed with code: %d", code)
	}
	return nil
}
```

---

## 2. Case: Bọc Cache & Logging Trong Suốt (Decorator Pattern)

### 📌 Bối cảnh Nghiệp vụ (Business Problem)
Một `ProductRepository` truy xuất cơ sở dữ liệu MySQL rất chậm. Cần bổ sung thêm bộ nhớ đệm **Redis Cache** và ghi nhật ký thời gian thực thi (**Execution Time Logging**) mà **không được sửa đổi bất kỳ dòng code nào** trong class MySQL gốc, và tầng Use Case gọi hàm hoàn toàn không biết có cache hay log bên dưới.

---

### 💻 Triển khai theo từng Ngôn ngữ

#### 🐘 PHP 8.x
```php
<?php
declare(strict_types=1);

interface ProductRepositoryInterface {
    public function findById(string $id): ?array;
}

// Class thực thi gốc (Giao tiếp MySQL)
class SqlProductRepository implements ProductRepositoryInterface {
    public function findById(string $id): ?array {
        // Giả lập truy vấn DB tốn 50ms
        return ['id' => $id, 'name' => 'Vợt Pickleball Titanium', 'price' => 2560000];
    }
}

// Decorator 1: Tự động Caching vào Redis
class CachedProductRepository implements ProductRepositoryInterface {
    public function __construct(
        private ProductRepositoryInterface $inner,
        private Redis $redis
    ) {}

    public function findById(string $id): ?array {
        $cacheKey = "product:{$id}";
        $cached = $this->redis->get($cacheKey);
        if ($cached) {
            return json_decode($cached, true);
        }

        $data = $this->inner->findById($id);
        if ($data) {
            $this->redis->setex($cacheKey, 3600, json_encode($data));
        }
        return $data;
    }
}

// Decorator 2: Đo lường thời gian & Audit Log
class LoggingProductRepository implements ProductRepositoryInterface {
    public function __construct(
        private ProductRepositoryInterface $inner,
        private LoggerInterface $logger
    ) {}

    public function findById(string $id): ?array {
        $start = microtime(true);
        $result = $this->inner->findById($id);
        $elapsed = (microtime(true) - $start) * 1000;
        
        $this->logger->info("Query product {$id} executed in {$elapsed} ms");
        return $result;
    }
}

// Lắp ghép (Dependency Injection Composition Root)
// Use Case -> Logging -> Caching -> SQL
$repo = new LoggingProductRepository(
    new CachedProductRepository(
        new SqlProductRepository(),
        $redisClient
    ),
    $logger
);
```

#### 🟦 TypeScript
```typescript
export interface ProductRepository {
    findById(id: string): Promise<Product | null>;
}

export class SqlProductRepository implements ProductRepository {
    async findById(id: string): Promise<Product | null> {
        return { id, name: "Vợt Pickleball", price: 2560000 };
    }
}

// Cached Decorator
export class CachedProductRepository implements ProductRepository {
    constructor(
        private readonly next: ProductRepository,
        private readonly cache: CacheStore
    ) {}

    async findById(id: string): Promise<Product | null> {
        const cached = await this.cache.get(`prod:${id}`);
        if (cached) return cached;

        const result = await this.next.findById(id);
        if (result) await this.cache.set(`prod:${id}`, result, 300);
        return result;
    }
}
```

#### 🐍 Python 3.10+
```python
import time
from typing import Protocol, Optional

class ProductRepository(Protocol):
    def find_by_id(self, product_id: str) -> Optional[dict]:
        ...

class SqlProductRepository:
    def find_by_id(self, product_id: str) -> Optional[dict]:
        return {"id": product_id, "name": "Vợt Pickleball"}

class LoggingProductDecorator:
    def __init__(self, inner: ProductRepository):
        self._inner = inner

    def find_by_id(self, product_id: str) -> Optional[dict]:
        start = time.perf_counter()
        result = self._inner.find_by_id(product_id)
        duration = (time.perf_counter() - start) * 1000
        print(f"[AUDIT] find_by_id({product_id}) took {duration:.2f}ms")
        return result
```

---

## 3. Case: Đơn Giản Hóa Quy Trình Mua Hàng Phức Tạp (Facade Pattern)

### 📌 Bối cảnh Nghiệp vụ (Business Problem)
Một thao tác **Checkout (Thanh toán đơn hàng)** liên quan đến 5 hệ thống con phức tạp:
1. `InventoryService`: Giữ tồn kho.
2. `PricingService`: Tính thuế và giảm giá voucher.
3. `PaymentGateway`: Khởi tạo thanh toán.
4. `ShippingService`: Đặt lịch giao hàng.
5. `EmailNotificationService`: Gửi email xác nhận.

Nếu Controller hoặc API endpoint phải gọi trực tiếp cả 5 service này, code Controller sẽ phình to, dễ sai sót và không thể tái sử dụng cho các ứng dụng khác (Web, Mobile App, POS tại quầy).

---

### 💻 Triển khai Facade Pattern

```typescript
export class CheckoutFacade {
    constructor(
        private readonly inventory: InventoryService,
        private readonly pricing: PricingService,
        private readonly payment: PaymentGateway,
        private readonly shipping: ShippingService,
        private readonly email: NotificationService
    ) {}

    // Cung cấp 1 phương thức duy nhất dễ dùng cho Controller / API
    async placeOrder(customerId: string, items: CartItem[], address: string): Promise<OrderResult> {
        // 1. Khóa tồn kho
        await this.inventory.reserveStock(items);

        // 2. Tính tiền
        const total = await this.pricing.calculateTotal(items);

        // 3. Đặt giao vận
        const trackingCode = await this.shipping.createShipment(address, items);

        // 4. Tạo thanh toán
        const paymentUrl = await this.payment.createPayment(customerId, total);

        // 5. Gửi email
        await this.email.sendConfirmation(customerId, trackingCode);

        return { success: true, paymentUrl, trackingCode };
    }
}
```

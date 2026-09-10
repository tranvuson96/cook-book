# Các Mẫu Thiết Kế Dạng Helper & Tiện Ích (Helper & Utility Patterns)

Trong phát triển phần mềm thực tế, các mẫu thiết kế như **Singleton**, **Registry**, **Null Object**, **Context Scope** và **Flyweight** thường được các lập trình viên sử dụng làm "Helper" hoặc "Infrastructure Glue" (chất keo kết nối hệ thống).

Tuy nhiên, nếu sử dụng sai cách, các pattern này rất dễ biến thành **Anti-Pattern** (gây rò rỉ bộ nhớ, khó viết Unit Test, tạo Global State độc hại). Tài liệu này phân tích chi tiết cách áp dụng đúng và an toàn trên từng ngôn ngữ.

---

## 1. Singleton Pattern: Áp Dụng Đúng vs Sai (The Truth About Singleton)

### 📌 Khi nào NÊN dùng Singleton?
* Khi việc khởi tạo đối tượng tốn rất nhiều tài nguyên phần cứng (vd: Database Connection Pool, Socket Client, In-memory Cache Engine, Heavy Config Loader).
* Khi hệ thống bắt buộc chỉ được có **duy nhất một người điều phối** để tránh xung đột tài nguyên (File Logger ghi vào 1 file, Hardware Device Driver).

### ⚠️ Mặt tối (Tại sao Singleton hay bị coi là Anti-Pattern)?
1. **Global State ẩn (Hidden Dependencies):** Các hàm gọi `Database::getInstance()` ở khắp nơi làm mất tính tường minh; người đọc code không biết hàm đó phụ thuộc vào Database trừ khi đọc từng dòng bên trong.
2. **Phá vỡ Unit Test (Test Pollution):** Do Singleton sống dai dẳng suốt quá trình chạy test, dữ liệu test của Test Case A có thể làm sai kết quả của Test Case B. Rất khó để Mocking.
3. **Xung đột đa luồng (Race Condition):** Trong Go, Java, hoặc Node.js (worker threads), nếu khởi tạo không an toàn sẽ tạo ra 2 instance cùng lúc.

> 💡 **Giải pháp hiện đại (Modern Best Practice):**  
> **Đừng tự viết Singleton bằng `private static $instance`**. Thay vào đó, hãy viết class bình thường và đăng ký nó với **Dependency Injection (DI) Container ở chế độ `Singleton Scope`** (như trong NestJS, Laravel, Spring, Wire trong Go). Lúc chạy thật nó là duy nhất, nhưng khi viết test bạn có thể inject Mock Object vào cực kỳ dễ dàng!

---

### 💻 Triển khai Singleton Chuẩn theo từng Ngôn ngữ

#### 🐹 Go (Golang) — Chuẩn Thread-Safe với `sync.Once`
Trong Go, cách duy nhất chuẩn mực để tạo Singleton đa luồng an toàn là dùng `sync.Once` (không bao giờ dùng mutex thủ công hay double-checked locking).

```go
package config

import (
	"fmt"
	"sync"
)

type AppConfig struct {
	AppName string
	Port    int
}

var (
	instance *AppConfig
	once     sync.Once
)

// GetInstance đảm bảo chỉ khởi tạo đúng 1 lần duy nhất dù có 1000 goroutines gọi đồng thời
func GetInstance() *AppConfig {
	once.Do(func() {
		fmt.Println("Khởi tạo AppConfig từ môi trường (chỉ chạy 1 lần)...")
		instance = &AppConfig{
			AppName: "3UPPP Sport Core",
			Port:    8080,
		}
	})
	return instance
}
```

#### 🟦 TypeScript / Node.js — Module Caching Singleton
Trong Node.js và ES Modules, **bản thân file module đã được Node.js cache lại theo đường dẫn tuyệt đối**. Do đó, export một instance trực tiếp là cách viết Singleton tự nhiên và gọn nhất:

```typescript
// logger.helper.ts
class LoggerHelper {
    private logs: string[] = [];

    log(message: string): void {
        const entry = `[${new Date().toISOString()}] ${message}`;
        this.logs.push(entry);
        console.log(entry);
    }

    getRecentLogs(): string[] {
        return [...this.logs];
    }
}

// Export một instance duy nhất (Node.js tự động biến thành Singleton)
export const appLogger = new LoggerHelper();

// File khác chỉ cần import dùng trực tiếp:
// import { appLogger } from './logger.helper';
// appLogger.log("Hệ thống khởi động");
```

Nếu muốn hỗ trợ Reset trạng thái cho Unit Test (Testability):
```typescript
export class DatabasePool {
    private static instance: DatabasePool | null = null;

    private constructor() { /* Kết nối DB tốn kém */ }

    public static getInstance(): DatabasePool {
        if (!this.instance) {
            this.instance = new DatabasePool();
        }
        return this.instance;
    }

    // Cổng thoát dành riêng cho kiểm thử Unit Test
    public static resetForTesting(): void {
        this.instance = null;
    }
}
```

#### 🐍 Python 3.10+ — Borg / Monostate Pattern (Chia sẻ State)
Trong Python, thay vì ép chỉ có một đối tượng bằng Singleton, người ta thường dùng **Borg Pattern (Monostate)**: Cho phép tạo nhiều instance, nhưng tất cả instance đều **dùng chung một vùng nhớ thuộc tính (`__dict__`)**.

```python
class AppStateHelper:
    _shared_state = {}

    def __init__(self):
        # Mọi instance tạo ra đều trỏ vào cùng 1 dictionary bộ nhớ
        self.__dict__ = self._shared_state

    @property
    def current_tenant(self) -> str:
        return self._shared_state.get("tenant_id", "default")

    @current_tenant.setter
    def current_tenant(self, value: str):
        self._shared_state["tenant_id"] = value

# Cách dùng:
a = AppStateHelper()
b = AppStateHelper()

a.current_tenant = "org_apple"
print(b.current_tenant)  # In ra: 'org_apple' (tự động đồng bộ dù là 2 object khác nhau!)
print(a is b)            # False (hai instance khác nhau nhưng cùng state)
```

#### 🐘 PHP 8.x — Singleton an toàn cho Unit Test
```php
<?php
declare(strict_types=1);

class GlobalConfigHelper {
    private static ?self $instance = null;
    private array $configs = [];

    // Chặn khởi tạo bằng từ khoá new từ bên ngoài
    protected function __construct() {}

    // Chặn nhân bản (clone)
    private function __clone() {}

    // Chặn phục hồi từ chuỗi serialize
    public function __wakeup() {
        throw new Exception("Cannot unserialize singleton");
    }

    public static function getInstance(): self {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    // Helper method reset phục vụ riêng cho tearDown() trong PHPUnit
    public static function resetInstance(): void {
        self::$instance = null;
    }

    public function set(string $key, mixed $val): void { $this->configs[$key] = $val; }
    public function get(string $key, mixed $default = null): mixed { return $this->configs[$key] ?? $default; }
}
```

---

## 2. Null Object Pattern: Helper Triệt Tiêu `if (x != null)`

### 📌 Vấn đề Thực tế
Trong nghiệp vụ, rất nhiều thuộc tính có thể rỗng: Người dùng vãng lai (`GuestUser`), không có mã giảm giá (`NoDiscount`), không bật ghi log (`NoLogger`). Nếu ở Use Case chỗ nào cũng phải viết:
```php
if ($this->logger !== null) {
    $this->logger->info("Đang xử lý đơn hàng...");
}
if ($user !== null) {
    $discount = $user->getDiscount();
}
```
Code sẽ đầy rẫy câu lệnh kiểm tra `null`, dễ dẫn đến lỗi crash nghiêm trọng `NullPointerException` hoặc `Call to a member function on null`.

### 💡 Giải pháp với Null Object
Tạo một đối tượng "rỗng" cùng implements interface, nhưng các phương thức bên trong không làm gì cả (no-op) hoặc trả về giá trị mặc định an toàn.

```typescript
// 1. Interface
export interface LoggerPort {
    info(msg: string): void;
    error(msg: string, err: any): void;
}

// 2. Real Object
export class ConsoleLogger implements LoggerPort {
    info(msg: string) { console.log(`[INFO] ${msg}`); }
    error(msg: string, err: any) { console.error(`[ERROR] ${msg}`, err); }
}

// 3. Null Object Helper (Hoạt động an toàn, không sinh lỗi, không in gì)
export class NullLogger implements LoggerPort {
    info(msg: string): void { /* No-op */ }
    error(msg: string, err: any): void { /* No-op */ }
}

// 4. Use Case: Code sạch 100%, không cần bất kỳ lệnh `if (logger != null)` nào!
export class ProcessOrderUseCase {
    constructor(private readonly logger: LoggerPort = new NullLogger()) {}

    execute(orderId: string) {
        this.logger.info(`Bắt đầu xử lý: ${orderId}`); // Luôn chạy an toàn!
    }
}
```

---

## 3. Registry Pattern: "Cuốn Danh Bạ" Tra Cứu Động (Service / Handler Registry)

### 📌 Vấn đề Thực tế
Khi xây dựng các hệ thống mở rộng theo plugin hoặc module độc lập, ta cần một cơ chế đăng ký (Register) và lấy ra (Lookup) các handler mà không cần hardcode danh sách class trong code lõi.

```typescript
export interface PaymentWebhookHandler {
    supports(gatewayName: string): boolean;
    handle(payload: Record<string, any>): Promise<boolean>;
}

export class WebhookHandlerRegistry {
    private static handlers: PaymentWebhookHandler[] = [];

    public static register(handler: PaymentWebhookHandler): void {
        this.handlers.push(handler);
    }

    public static getHandler(gatewayName: string): PaymentWebhookHandler {
        const found = this.handlers.find(h => h.supports(gatewayName));
        if (!found) {
            throw new Error(`Không tìm thấy webhook handler cho cổng: ${gatewayName}`);
        }
        return found;
    }
}
```

---

## 4. Context Scope Pattern: Truyền Ngữ Cảnh Tự Động (Tenant & Tracing Helper)

### 📌 Vấn đề Thực tế
Trong kiến trúc Multi-Tenancy hoặc Microservices, ta cần truyền `tenantId`, `requestId`, `currentUserId` từ Controller xuống Use Case, rồi xuống Repository. Nếu thêm tham số này vào từng hàm:
`findById(orderId, tenantId, requestId, userId)` -> Chữ ký hàm bị ô nhiễm (polluted function signatures).

### 💡 Giải pháp: Dùng Execution Context ngầm
* **Trong Node.js / TypeScript**: Dùng `AsyncLocalStorage`.
* **Trong Go**: Dùng `context.Context`.

#### 🟦 TypeScript (AsyncLocalStorage)
```typescript
import { AsyncLocalStorage } from 'async_hooks';

interface RequestContext {
    tenantId: string;
    traceId: string;
}

export class ContextHelper {
    private static storage = new AsyncLocalStorage<RequestContext>();

    public static runWith(context: RequestContext, callback: () => Promise<any>): Promise<any> {
        return this.storage.run(context, callback);
    }

    public static getTenantId(): string {
        const ctx = this.storage.getStore();
        if (!ctx) throw new Error("Chạy ngoài Request Context!");
        return ctx.tenantId;
    }
}

// Middleware bắt đầu Context:
// ContextHelper.runWith({ tenantId: "tenant_123", traceId: "req_abc" }, async () => {
//     // Tại bất kỳ đâu trong sâu thẳm Repository:
//     const currentTenant = ContextHelper.getTenantId(); // Lấy được ngay mà không cần truyền param!
// });
```

#### 🐹 Go (context.Context)
```go
package contexthelper

import "context"

type contextKey string
const tenantKey contextKey = "tenant_id"

func WithTenantID(ctx context.Context, tenantID string) context.Context {
	return context.WithValue(ctx, tenantKey, tenantID)
}

func GetTenantID(ctx context.Context) (string, bool) {
	val, ok := ctx.Value(tenantKey).(string)
	return val, ok
}
```

---

## 5. Bảng So Sánh Các Helper Patterns

| Helper Pattern | Mục Đích Chính | Rủi Ro Nếu Lạm Dụng | Khuyến Nghị Thực Chiến |
| :--- | :--- | :--- | :--- |
| **Singleton** | Đảm bảo duy nhất 1 instance chia sẻ tài nguyên nặng | Tạo Global State, khó test | **Ưu tiên Singleton Scope trong DI Container** |
| **Null Object** | Cung cấp đối tượng rỗng thay cho `null` | Có thể che giấu lỗi nếu dùng nhầm chỗ | **Rất tốt cho Logger, Optional Services, Default Strategy** |
| **Registry** | Sổ danh bạ tra cứu động các Handler/Plugin | Biến thành "túi chứa đồ" không kiểm soát | **Tốt cho Plugin Architecture, Webhook Routers** |
| **Context Scope** | Truyền ngầm `tenantId`, `traceId` theo request | Dễ quên khởi tạo context trước khi gọi hàm | **Bắt buộc cho Multi-Tenancy và Distributed Tracing** |
| **Flyweight** | Chia sẻ các object nhỏ bất biến để tiết kiệm RAM | Tăng độ phức tạp quản lý Pool | **Dùng khi có >100.000 đối tượng giống hệt nhau trong RAM** |

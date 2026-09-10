# Hướng Dẫn Đặc Thù Triển Khai Pattern Theo Từng Ngôn Ngữ (Language-Specific Idioms)

Mỗi ngôn ngữ lập trình có triết lý và hệ thống kiểu dữ liệu khác nhau. Áp dụng máy móc các mẫu thiết kế hướng đối tượng kinh điển (Gang of Four - GoF) từ Java/C++ sang các ngôn ngữ khác sẽ dẫn đến code cồng kềnh và thiếu tự nhiên (*non-idiomatic*).

Dưới đây là cẩm nang hướng dẫn cách viết Pattern chuẩn theo bản sắc của 4 ngôn ngữ: **PHP**, **TypeScript**, **Go** và **Python**.

---

## 1. 🐘 PHP 8.x: Tận Dụng Tính Năng Ngôn Ngữ Hiện Đại

* **Thay thế Factory `switch-case` bằng `match expression`**:  
  `match` an toàn hơn (so sánh nghiêm ngặt `===`, ném `UnhandledMatchError` nếu thiếu case) và trả về giá trị trực tiếp.
  ```php
  public static function create(string $type): PaymentGatewayInterface {
      return match ($type) {
          'vnpay' => new VnPayGateway(),
          'momo'  => new MoMoGateway(),
          default => throw new InvalidArgumentException("Unknown type: {$type}"),
      };
  }
  ```
* **Constructor Property Promotion**:  
  Giảm 70% boilerplate khi inject dependency vào Service/UseCase.
  ```php
  // ✅ Chuẩn PHP 8:
  class CreateOrderUseCase {
      public function __construct(
          private OrderRepositoryInterface $orderRepo,
          private LoggerInterface $logger
      ) {}
  }
  ```
* **Backed Enums với Business Methods**:  
  Thay thế các chuỗi hằng số bằng Enums có kiểu dữ liệu mạnh:
  ```php
  enum OrderStatus: string {
      case PENDING = 'pending';
      case PAID = 'paid';
      case CANCELLED = 'cancelled';

      public function canBeCancelled(): bool {
          return $this === self::PENDING;
      }
  }
  ```

---

## 2. 🟦 TypeScript: First-Class Functions & Structural Typing

* **Strategy Pattern không nhất thiết phải tạo Class**:  
  Trong TypeScript, hàm là công dân hạng nhất (First-Class Citizen). Một Strategy có thể đơn giản là một hàm hoặc object chứa các hàm, không cần tạo hàng chục class con.
  ```typescript
  type DiscountStrategy = (amount: number) => number;

  const vipDiscount: DiscountStrategy = (amount) => amount * 0.85;
  const standardDiscount: DiscountStrategy = (amount) => amount * 0.95;
  ```
* **Discriminated Unions thay cho State Pattern phức tạp**:  
  Khi số lượng trạng thái ít và logic đơn giản, sử dụng Discriminated Unions kết hợp `switch (state.type)` giúp TypeScript kiểm tra exhaustiveness lúc compile:
  ```typescript
  type OrderState =
      | { status: 'pending'; payUrl: string }
      | { status: 'paid'; transactionId: string; paidAt: Date }
      | { status: 'cancelled'; reason: string };
  ```

---

## 3. 🐹 Go (Golang): Composition, Interfaces Ngầm & Functional Options

Go **hoàn toàn không có từ khóa `class`** và **không có kế thừa (`extends`)**. Mọi pattern trong Go đều dựa trên:
1. **Struct Embedding (Composition over Inheritance)**.
2. **Implicit Interfaces (Vịt biết bơi là con vịt)**: Không cần khai báo `implements`.
3. **Functional Options Pattern**: Chuẩn mực thay thế Builder Pattern trong Go.

```go
// Functional Options Pattern: Cách tạo đối tượng an toàn và dễ mở rộng nhất trong Go
type Server struct {
    host string
    port int
    timeout time.Duration
}

type Option func(*Server)

func WithPort(port int) Option {
    return func(s *Server) { s.port = port }
}

func NewServer(host string, opts ...Option) *Server {
    srv := &Server{host: host, port: 8080, timeout: 30 * time.Second}
    for _, opt := range opts {
        opt(srv)
    }
    return srv
}
```

* **Observer Pattern bằng Goroutines & Channels**:  
  Tận dụng concurrency nguyên bản của Go để xử lý sự kiện song song, không cần thêm thư viện phức tạp.

---

## 4. 🐍 Python 3.10+: Protocols & Decorators

* **Structural Subtyping với `typing.Protocol` (PEP 544)**:  
  Không cần kế thừa lớp cha trừu tượng (`ABC`), chỉ cần class có cùng các phương thức là tự động thỏa mãn interface (tương tự TypeScript/Go):
  ```python
  from typing import Protocol

  class Greeter(Protocol):
      def greet(self, name: str) -> str:
          ...

  # Tự động thỏa mãn Greeter mà không cần Greeter trong định nghĩa class
  class FormalGreeter:
      def greet(self, name: str) -> str:
          return f"Good day, {name}."
  ```
* **Python Decorator Syntax (`@`)**:  
  Python có cú pháp riêng biệt cho Decorator pattern, cực kỳ tiện lợi cho Caching, Logging, Timing, Authentication:
  ```python
  import time
  from functools import wraps

  def audit_log(func):
      @wraps(func)
      def wrapper(*args, **kwargs):
          start = time.perf_counter()
          result = func(*args, **kwargs)
          print(f"{func.__name__} took {(time.perf_counter() - start)*1000:.2f}ms")
          return result
      return wrapper

  @audit_log
  def calculate_tax(amount: float) -> float:
      return amount * 0.1
  ```

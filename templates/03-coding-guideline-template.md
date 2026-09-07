# Tài liệu Hướng dẫn Viết code cho Module (Coding Guideline Template)

> **Tên Module:** [Tên Module]  
> **Dựa trên Thiết kế:** [Đường dẫn đến file System Design Document]  
> **Tech Stack áp dụng:** [Ngôn ngữ / Framework / ORM / Test Runner]  

---

## 1. Cấu trúc Thư mục Module (Directory Structure)

Quy định cấu trúc thư mục phân tầng rõ ràng cho module:

```text
src/modules/[module-name]/
├── domain/                    # Thực thể và logic nghiệp vụ thuần tuý
│   ├── entities/              # Các Entity (vd: Order, OrderItem)
│   ├── value-objects/         # Các Value Object (vd: Money, Address)
│   └── repositories/          # Interface repository (trừu tượng)
├── application/               # Use cases và điều phối nghiệp vụ
│   ├── commands/              # Command handler (CreateOrderCommand)
│   ├── queries/               # Query handler (GetOrderDetailsQuery)
│   └── dtos/                  # Request / Response Data Transfer Objects
├── infrastructure/            # Tầng hạ tầng và cài đặt cụ thể
│   ├── persistence/           # DB schema, ORM entities, Repo implementations
│   └── external-services/     # Cài đặt kết nối bên ngoài (StripeAdapter,...)
└── presentation/              # Tầng giao diện / API
    ├── controllers/           # HTTP REST / GraphQL Controllers
    └── routes/                # Khai báo Endpoint routes
```

---

## 2. Quy chuẩn Đặt tên (Naming Conventions)

* **Files & Thư mục:** `kebab-case` (vd: `order-service.ts`, `create-order-command.go`).
* **Classes & Interfaces:** `PascalCase` (vd: `OrderService`, `PaymentGatewayInterface`).
* **Hàm & Phương thức:** `camelCase` (thể hiện rõ hành động: `findOrderById`, `validatePaymentInfo`).
* **Biến & Thuộc tính:** `camelCase`, mô tả rõ ràng nghĩa, tránh viết tắt tối nghĩa (vd: `isPaymentCompleted`, không dùng `flg`).
* **Hằng số:** `UPPER_SNAKE_CASE` (vd: `DEFAULT_MAX_RETRY_COUNT`).

---

## 3. Các Quy tắc Code cụ thể (Specific Coding Rules)

1. **Dependency Injection:**
   * Không bao giờ khởi tạo trực tiếp instance bằng từ khoá `new` bên trong Service nghiệp vụ; luôn inject thông qua constructor.
2. **DTO & Validation:**
   * Mọi dữ liệu đầu vào từ Controller phải được validate qua DTO / Schema Validator trước khi truyền xuống Application layer.
3. **Transaction Management:**
   * Mọi usecase làm thay đổi trạng thái của nhiều bảng phải được điều phối thông qua Unit of Work hoặc Transaction Manager.
4. **Error Handling & Response Format:**
   * Chỉ throw Custom Domain Exception (vd: `OrderNotFoundException`, `InsufficientStockException`).
   * Không để lộ stack trace nội bộ ra client. Trả về response chuẩn dạng JSON:
     ```json
     {
       "success": false,
       "errorCode": "ORDER_NOT_FOUND",
       "message": "Không tìm thấy đơn hàng với mã được yêu cầu"
     }
     ```

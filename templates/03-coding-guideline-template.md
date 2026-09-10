# Tài liệu Hướng dẫn Viết code cho Module (Coding Guideline Template)

> **Tên Module:** [Tên Module]  
> **Dựa trên Thiết kế:** [Đường dẫn đến file System Design Document]  
> **Tech Stack áp dụng:** [Ngôn ngữ / Framework / ORM / Test Runner]  

---

## 1. Cấu trúc Thư mục Module (Directory Structure)

Quy định cấu trúc thư mục phân tầng Hexagonal (Ports & Adapters) hỗ trợ Đa Giao thức (Multi-Protocol) & Đa Khách thuê (Multi-Tenancy):

```text
src/modules/[module-name]/
├── domain/                         # 1. TẦNG DOMAIN: Nghiệp vụ cốt lõi (100% độc lập)
│   ├── entities/                   # Các Entity (vd: Order, OrderItem)
│   ├── value-objects/              # Các Value Object (vd: Money, TenantId, OrderStatus)
│   ├── exceptions/                 # Custom Domain Exceptions (vd: OutOfStockException)
│   └── ports/                      # Cổng ra trừu tượng (Outbound Ports)
│       ├── order-repository.port.ts
│       └── payment-gateway.port.ts
│
├── application/                    # 2. TẦNG APPLICATION: Use Cases & Inbound Ports
│   ├── use-cases/                  # Các kịch bản nghiệp vụ (CreateOrderUseCase)
│   ├── dtos/                       # Input & Output DTOs thuần tuý (CreateOrderInput, CreateOrderOutput)
│   └── ports/                      # Cổng vào (Inbound Ports / Use Case Interfaces)
│
├── infrastructure/                 # 3. TẦNG DRIVEN ADAPTERS: Hạ tầng & Bên ngoài
│   ├── persistence/                # DB Repositories, ORM Mappings, Migrations
│   │   ├── multi-tenant/           # TenantConnectionManager, TenantQueryFilter
│   │   └── repositories/           # MySQLOrderRepository (implements OrderRepositoryPort)
│   ├── external-services/          # Adapters cổng thanh toán, SMS, Mail (VnPayAdapter)
│   └── cache/                      # RedisCacheAdapter (có tenant prefix tự động)
│
└── presentation/                   # 4. TẦNG DRIVING ADAPTERS: Cổng giao tiếp đa giao thức
    ├── middleware/                 # TenantResolutionMiddleware, AuthMiddleware
    ├── rest/                       # REST API: Controllers, DTO request/response, Express/FastAPI routes
    ├── soap/                       # SOAP Service: WSDL definitions, SoapOrderHandler
    ├── graphql/                    # GraphQL: Schemas, Query & Mutation Resolvers
    ├── websocket/                  # WebSocket: Event handlers, Socket.io / TCP listeners
    └── cli/                        # CLI Commands: WP-CLI / Artisan / Terminal commands
```

---

## 2. Quy chuẩn Đặt tên (Naming Conventions)

* **Files & Thư mục:** `kebab-case` (vd: `order-service.ts`, `create-order-use-case.ts`, `mysql-order-repository.ts`).
* **Classes & Interfaces:** `PascalCase` (vd: `CreateOrderUseCase`, `OrderRepositoryPort`, `SoapOrderHandler`).
* **Hàm & Phương thức:** `camelCase` (thể hiện rõ hành động: `createOrder`, `findOrderById`, `validateStock`).
* **Biến & Thuộc tính:** `camelCase`, mô tả rõ ràng nghĩa, tránh viết tắt tối nghĩa (vd: `tenantId`, `isPaymentCompleted`, không dùng `flg`).
* **Hằng số:** `UPPER_SNAKE_CASE` (vd: `DEFAULT_MAX_RETRY_COUNT`, `TENANT_HEADER_KEY`).

---

## 3. Các Quy tắc Code cụ thể (Specific Coding Rules)

### A. Quy tắc Tách tầng Nghiệp vụ & Đa Giao thức (Multi-Protocol Rules)
1. **Zero Protocol Leakage (Không rò rỉ giao thức vào Use Case):**
   * Use Case và Domain TUYỆT ĐỐI KHÔNG nhận các object của giao thức mạng (`HttpRequest`, `HttpResponse`, `SoapServer`, `GraphQLResolveInfo`, `Socket`).
   * Tầng Presentation chịu trách nhiệm trích xuất dữ liệu, validate schema đầu vào và đóng gói thành `InputDTO` trước khi gọi `UseCase.execute(input)`.
2. **Protocol-Specific Error Transformation:**
   * Tầng Use Case chỉ throw `DomainException`.
   * Mỗi Adapter tự bắt và format lỗi theo chuẩn của mình:
     * **REST:** HTTP status code (`400`, `404`, `409`) + JSON payload.
     * **SOAP:** Ném `SoapFault` với mã fault code và fault string.
     * **GraphQL:** Ném `GraphQLError` với `extensions.code`.
     * **WebSocket:** Emit socket error event `{ event: "error", code: "..." }`.

### B. Quy tắc Đa Khách thuê (Multi-Tenancy Rules)
1. **Tenant Context Immutability:**
   * Mọi request/job phải được `TenantResolutionMiddleware` nhận diện và gán vào `TenantContext` ngay tại cửa ngõ vào của request.
   * `TenantContext` trong suốt vòng đời của request là bất biến (Read-only).
2. **Automatic Data Scoping (Tránh lộ dữ liệu chéo):**
   * Không bao giờ viết query SQL thủ công mà quên `tenant_id` khi dùng mô hình Shared Database.
   * Bắt buộc sử dụng ORM Global Filter / Repository Scoping để tự động thêm điều kiện `tenant_id = currentTenantId` cho mọi thao tác đọc/ghi.
3. **Cache Key Isolation:**
   * Mọi key lưu vào bộ nhớ đệm (Redis/Memcached) bắt buộc có định dạng: `tenant:{tenant_id}:{module}:{key}`.
4. **Dependency Injection:**
   * Không bao giờ dùng `new` trực tiếp trong Use Case; inject Port / Repository qua Constructor.
5. **Transaction Management:**
   * Mọi thay đổi đa thực thể phải được bọc trong Unit of Work / Database Transaction có gắn ngữ cảnh Tenant.

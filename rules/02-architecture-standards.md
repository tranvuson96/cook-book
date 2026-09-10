# Tiêu chuẩn Kiến trúc & Thiết kế Phần mềm (Architecture Standards)

Tài liệu này định nghĩa các nguyên tắc kiến trúc mà Antigravity phải tuân thủ khi thiết kế và triển khai bất kỳ hệ thống nào.

---

## 0. Nguyên tắc Tiên quyết: Business Clarity First (Sáng tỏ Nghiệp vụ Trước khi Kiến trúc)

> **"Architecture serves business, not assumptions."**  
> Mọi giải pháp kỹ thuật, mẫu thiết kế và mô hình dữ liệu đều vô nghĩa nếu nghiệp vụ nền tảng bị hiểu sai hoặc xây dựng trên các giả định ngầm.

1. **Zero Assumptions:** Tuyệt đối không phỏng đoán luồng nghiệp vụ khi yêu cầu chưa rõ ràng.
2. **Làm rõ các Điểm xám (Clarify Gray Areas):** Chủ động rà soát, phát hiện và đặt câu hỏi làm rõ các điểm xám, ngoại lệ và ràng buộc nghiệp vụ với người dùng/chủ hệ thống trước khi bắt tay vào thiết kế kiến trúc.
3. **Tránh Over-engineering do giả định sai:** Chỉ xây dựng kiến trúc mở rộng khi nghiệp vụ thực sự đòi hỏi và đã được xác nhận.

---

## 1. Nguyên tắc cốt lõi (Core Principles)

1. **SOLID Principles:**
   * **S (Single Responsibility):** Mỗi class, module hoặc hàm chỉ nên có một lý do duy nhất để thay đổi.
   * **O (Open/Closed):** Mở rộng tính năng bằng cách thêm mới (extension), không sửa đổi trực tiếp code đang hoạt động ổn định (modification).
   * **L (Liskov Substitution):** Các lớp con phải có khả năng thay thế lớp cha mà không làm gãy hành vi hệ thống.
   * **I (Interface Segregation):** Tránh các Interface quá cồng kềnh ("fat interfaces"); chia nhỏ thành các interface chuyên biệt cho từng mục đích.
   * **D (Dependency Inversion):** Phụ thuộc vào trừu tượng (Abstraction/Interface), không phụ thuộc trực tiếp vào cài đặt cụ thể (Concretion). Sử dụng Dependency Injection (DI) khi có thể.

2. **KISS & DRY:**
   * **KISS (Keep It Simple, Stupid):** Ưu tiên giải pháp đơn giản, rõ ràng, dễ bảo trì nhất. Tránh tối ưu hoá sớm (premature optimization) hoặc tạo trừu tượng dư thừa (over-engineering).
   * **DRY (Don't Repeat Yourself):** Không lặp lại logic nghiệp vụ. Nếu một đoạn logic xuất hiện từ 3 lần trở lên, cần tách thành hàm/service dùng chung.

3. **Separation of Concerns (Tách biệt mối quan tâm):**
   * Tách bạch rành mạch giữa các tầng:
     * **Domain/Entity Layer**: Logic nghiệp vụ cốt lõi, độc lập với framework, cơ sở dữ liệu và thư viện bên ngoài.
     * **Application/Use Case Layer**: Điều phối các luồng nghiệp vụ.
     * **Infrastructure Layer**: Giao tiếp với DB, Message Queue, External API, File System.
     * **Presentation/Interface Layer**: Controller, CLI, GraphQL/REST Endpoints, DTO mapping.

---

## 2. Tiêu chuẩn Quản lý Dữ liệu & Error Handling

* **Không bao giờ nuốt lỗi (No Silent Failures):** Mọi exception hoặc error phải được log hoặc xử lý có chủ đích.
* **Idempotency (Tính bất biến theo lần chạy):** Các API/Job thực hiện tác vụ ghi hoặc trừ tiền, cập nhật trạng thái phải thiết kế idempotent (sử dụng idempotency key hoặc transaction check).
* **Database Transactions:** Mọi chuỗi thao tác ghi liên quan đến nhiều bảng hoặc ràng buộc toàn vẹn dữ liệu phải được bọc trong database transaction an toàn.

---

## 3. Kiến trúc Đa Giao thức (Multi-Protocol Architecture) & Hexagonal (Ports & Adapters)

Khi xây dựng các hệ thống mà tầng nghiệp vụ có thể phục vụ đồng thời nhiều giao thức mạng khác nhau (REST, SOAP, GraphQL, WebSocket, gRPC, Queue, CLI):

1. **Transport-Agnostic Core (Tầng nghiệp vụ độc lập giao vận):**
   * **Domain & Use Case** là trung tâm bất biến, tuyệt đối không phụ thuộc vào bất kỳ khái niệm mạng nào (`HttpRequest`, `SoapHeader`, `GraphQLContext`, `Socket`).
   * Tầng nghiệp vụ chỉ tiếp nhận **Input DTO** thuần túy và trả về **Output DTO** hoặc ném ra **Domain Exception**.
2. **Driving Adapters (Bộ điều phối giao thức đầu vào):**
   * Mỗi giao thức mạng là một Adapter độc lập nằm ở tầng ngoài cùng:
     * **REST Adapter:** Tiếp nhận HTTP Request -> Map sang Input DTO -> Thực thi UseCase -> Trả về HTTP Status + JSON.
     * **SOAP Adapter:** Tiếp nhận XML SOAP Envelope -> Map sang Input DTO -> Thực thi UseCase -> Trả về SOAP XML Response / SOAP Fault.
     * **GraphQL Adapter:** Tiếp nhận Query/Mutation Resolver -> Map sang Input DTO -> Thực thi UseCase -> Trả về GraphQL Type.
     * **WebSocket Adapter:** Lắng nghe Socket Event -> Map sang Input DTO -> Thực thi UseCase -> Emit Event / Broadcast.
     * **CLI / Queue Adapter:** Tiếp nhận Terminal args hoặc Message queue payload (Kafka/RabbitMQ) -> Map sang Input DTO -> Thực thi UseCase.
3. **Protocol-Specific Error Mapping:**
   * Tầng nghiệp vụ chỉ phát sinh Domain Exception (vd: `EntityNotFoundException`, `InsufficientBalanceException`).
   * Từng Adapter chịu trách nhiệm ánh xạ Domain Exception sang chuẩn tương ứng của giao thức đó (REST HTTP Status Code, SOAP Fault, GraphQL Error Extension, Socket Error Event).

---

## 4. Tiêu chuẩn Kiến trúc Đa Khách thuê (Multi-Tenancy Standards)

Đối với các hệ thống SaaS hoặc phục vụ nhiều tổ chức, khách hàng doanh nghiệp (Tenants) trên cùng hạ tầng:

1. **Ba Mô hình Cách ly Dữ liệu (Tenant Data Isolation Models):**
   * **Mô hình 1: Database-per-Tenant (Cô lập tối đa)**
     * Mỗi Tenant sở hữu một database riêng biệt.
     * *Ưu điểm:* Bảo mật tuyệt đối, backup/restore độc lập, không lo rủi ro lộ dữ liệu chéo, dễ tùy biến scale riêng cho tenant VIP.
     * *Nhược điểm:* Chi phí tài nguyên cao, độ phức tạp khi migration schema trên hàng trăm/hàng nghìn database.
   * **Mô hình 2: Schema-per-Tenant (Chung DB, riêng Schema)**
     * Chung 1 Database Server, nhưng mỗi Tenant là một Schema riêng (vd: PostgreSQL schemas: `tenant_a.orders`, `tenant_b.orders`).
     * *Ưu điểm:* Cân bằng tốt giữa bảo mật và chi phí tài nguyên, dễ quản lý hơn DB riêng.
   * **Mô hình 3: Shared Database, Shared Schema with Discriminator Column (Mô hình Cột Tenant ID)**
     * Chung toàn bộ Database và Tables, mọi bảng dữ liệu nghiệp vụ đều có cột định danh `tenant_id`.
     * *Ưu điểm:* Chi phí thấp nhất, dễ mở rộng quy mô đại trà, quản lý migration tập trung một chỗ.
     * *Yêu cầu bắt buộc:* Bắt buộc áp dụng **Global Query Filter / Row-Level Security (RLS)** tại tầng Repository/ORM để tự động chèn `WHERE tenant_id = :current_tenant` cho 100% các câu truy vấn.

2. **Chiến lược Nhận diện Khách thuê (Tenant Resolution Strategy):**
   * Quá trình nhận diện Tenant phải diễn ra ở **Middleware / Interceptor** của tầng Driving Adapter trước khi chuyển giao vào Use Case:
     * Qua **Subdomain / Host**: `tenant1.domain.com` -> resolve tenant `tenant1`.
     * Qua **HTTP Header**: `X-Tenant-ID` hoặc `X-Tenant-Code`.
     * Qua **JWT Claim**: Giải mã token người dùng chứa thuộc tính `tenant_id`.
     * Qua **SOAP Header**: `<soapenv:Header><tns:TenantId>...</tns:TenantId></soapenv:Header>`.
     * Qua **WebSocket Handshake**: Query param hoặc Authentication handshake payload.
     * Qua **CLI / Worker Flag**: Tham số `--tenant=...` hoặc message header trong Queue.

3. **Vòng đời Ngữ cảnh Khách thuê (Tenant Context Lifecycle):**
   * Khởi tạo đối tượng `TenantContext` bất biến cho từng request/job (sử dụng Scoped Container / AsyncLocalStorage / ThreadLocal).
   * Tầng Application và Infrastructure truy xuất `TenantContext` thông qua Interface (Port) để tự động định tuyến kết nối DB (Dynamic Connection Routing) hoặc tự động áp `tenant_id` vào dữ liệu ghi và đọc.
4. **Cách ly Bộ nhớ đệm (Cache Isolation):**
   * Mọi key lưu trữ trong Redis / Memcached đều bắt buộc phải có prefix gắn liền với tenant: `{tenant_id}:{module}:{key}` (vd: `tenant_101:products:item_456`). Tuyệt đối không dùng cache key dùng chung giữa các tenant.


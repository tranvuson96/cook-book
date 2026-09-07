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

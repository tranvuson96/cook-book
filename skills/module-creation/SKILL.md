---
name: module-creation
description: >-
  Quy trình dẫn dắt Antigravity tạo và phát triển module mới theo chuẩn nghiêm ngặt:
  0. Làm rõ Điểm xám & Xác nhận nghiệp vụ -> 1. User Story -> 2. System Analysis (Usecase, Entity, Class Diagram, SSD) -> 3. Coding Guideline -> 4. Implementation -> 5. Unit & Integration Tests.
---

# Kỹ năng Tạo Module Mới (Module Creation Skill)

Kỹ năng này bắt buộc kích hoạt bất cứ khi nào người dùng yêu cầu tạo mới, xây dựng thêm hoặc phát triển một module/tính năng trong hệ thống.

---

## Các Bước Triển Khai Bắt Buộc

Antigravity phải tuần tự thực hiện qua các bước sau, **bắt buộc làm rõ nghiệp vụ trước khi thực thi**:

### Bước 0: Rà soát Điểm xám & Hỏi Xác nhận Nghiệp vụ Trước khi Thực thi (Clarify Gray Areas)
> **NGUYÊN TẮC BẮT BUỘC: ZERO ASSUMPTIONS**  
> Tuyệt đối không phỏng đoán luồng nghiệp vụ hoặc tự đưa ra quyết định thay cho người dùng khi yêu cầu còn điểm xám.

1. Phân tích yêu cầu và phát hiện toàn bộ các điểm xám, câu hỏi chưa rõ về:
   * Quy tắc kinh doanh, chính sách giá, hoa hồng, hạn mức, phân quyền.
   * Luồng dữ liệu, trạng thái giao dịch và các kịch bản ngoại lệ / lỗi.
   * Tương tác với hệ thống thứ 3 (Thanh toán, Giao vận, Xác thực).
2. **Chủ động đặt câu hỏi**:
   * Liệt kê danh sách các điểm xám cần làm rõ.
   * Đưa ra gợi ý các phương án khả thi kèm ưu/nhược điểm ngắn gọn để người dùng dễ chọn.
3. **Chỉ khi người dùng phản hồi và xác nhận** thì mới chuyển sang Bước 1.

### Bước 1: Viết tài liệu User Story (Kịch bản sử dụng)
1. Xác định bối cảnh, mục tiêu và các Persona người dùng liên quan đến module.
2. Tổng hợp các điểm xám nghiệp vụ đã được xác nhận ở Bước 0 vào tài liệu.
3. Viết chi tiết các User Stories theo cấu trúc chuẩn:
   * *Là một (As a)... Tôi muốn (I want)... Để (So that)...*
4. Định nghĩa tiêu chí nghiệm thu (Acceptance Criteria) dạng Given - When - Then cho từng kịch bản (Thành công, Lỗi dữ liệu, Ngoại lệ).
5. Sử dụng template chuẩn tại [templates/01-user-story-template.md](../../templates/01-user-story-template.md).

### Bước 2: Viết tài liệu Phân tích Thiết kế (System Analysis & Design Document)
Dựa vào User Story đã có ở Bước 1, lập tài liệu phân tích thiết kế gồm 3 phần:
* **Phần A: Liệt kê các chức năng chính:** Lập bảng danh mục các chức năng `FUNC-01`, `FUNC-02`,... và mô tả vai trò.
* **Phần B: Chi tiết từng chức năng chính:**
  1. *Kịch bản Usecase*: Tên usecase, Actor, Pre-conditions, Post-conditions, Kịch bản hoạt động từng bước (Basic Flow), Các trường hợp đặc biệt & ngoại lệ (Edge cases & Exception Flows).
  2. *Phân tích Thực thể*: Xác định thực thể, mối quan hệ, bảng CSDL mapping, vẽ **Class Diagram** và **Communication Diagram** bằng mã Mermaid.
  3. *Tổng hợp kịch bản*: User Story hoàn chỉnh và biểu đồ tuần tự hệ thống (**System Sequence Diagram - SSD**).
* **Phần C: Lựa chọn Mẫu thiết kế (Design Patterns):**
  * Đề xuất các mẫu thiết kế thích hợp (Strategy, Factory, Observer, Repository, Adapter,...).
  * Phân tích rõ ràng **Ưu điểm** và **Nhược điểm** của từng mẫu khi áp dụng vào bài toán cụ thể.
* Sử dụng template chuẩn tại [templates/02-system-design-template.md](../../templates/02-system-design-template.md).

### Bước 3: Xây dựng Hướng dẫn Viết code (Coding Guideline)
1. Dựa trên tài liệu phân tích thiết kế ở Bước 2, soạn thảo Coding Guideline riêng cho module.
2. Quy định rõ ràng: Cấu trúc thư mục module, quy chuẩn đặt tên file/hàm/biến/class, các quy tắc nghiệp vụ, cơ chế xử lý lỗi và định dạng response.
3. Sử dụng template chuẩn tại [templates/03-coding-guideline-template.md](../../templates/03-coding-guideline-template.md).

### Bước 4: Thực thi Viết code (Implementation)
1. Triển khai viết mã nguồn bám sát $100\%$ theo Coding Guideline ở Bước 3 và cấu trúc thiết kế ở Bước 2.
2. Tuân thủ nguyên tắc SOLID, Clean Architecture, Dependency Injection. Không viết code tắt hoặc vi phạm chuẩn đặt tên.

### Bước 5: Viết Unit Test & Integration Test (Testing)
1. Lập ma trận test case bao phủ cả Happy Path, Edge cases và Exception Flows.
2. Viết Unit Tests độc lập với đầy đủ mocks/stubs.
3. Viết Integration Tests kiểm thử tương tác thực tế với cơ sở dữ liệu/API.
4. Chạy toàn bộ test suite trên terminal và đảm bảo $100\%$ test cases đều PASS trước khi báo cáo hoàn tất cho người dùng.

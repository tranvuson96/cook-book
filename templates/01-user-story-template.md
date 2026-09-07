# Mẫu Kịch bản Sử dụng (User Story Template)

> **Tên Module:** [Tên Module / Tính năng]  
> **Người thực hiện:** [Tác giả / Antigravity]  
> **Ngày tạo:** [YYYY-MM-DD]  
> **Phiên bản:** [1.0.0]  

---

## 0. Bảng Rà Soát & Làm Rõ Điểm Xám Nghiệp Vụ (Business Ambiguities & Clarification Table)

> **NGUYÊN TẮC ZERO ASSUMPTIONS:**  
> Bắt buộc phải liệt kê các câu hỏi nghiệp vụ chưa rõ ràng, đề xuất phương án và nhận được xác nhận từ Người dùng / Product Owner trước khi thực thi viết code.

| STT | Điểm xám / Câu hỏi nghiệp vụ chưa rõ | Đề xuất Phương án (Option A / Option B) | Xác nhận từ Người dùng / PO | Trạng thái |
| :---: | :--- | :--- | :--- | :---: |
| 1 | [Mô tả điểm xám về quy tắc tính toán hoặc luồng xử lý] | **A**: [Mô tả cách xử lý A]<br>**B**: [Mô tả cách xử lý B] | [Xác nhận chọn Phương án A/B] | **ĐÃ CHỐT** |
| 2 | [Mô tả kịch bản biên hoặc luồng ngoại lệ khi lỗi xảy ra] | **A**: [Hủy giao dịch và rollback]<br>**B**: [Lưu tạm trạng thái chờ retry] | [Xác nhận chọn Phương án A/B] | **ĐÃ CHỐT** |
| 3 | [Mô tả phạm vi quyền hạn các Role trong hệ thống] | **A**: [Chỉ Admin được thao tác]<br>**B**: [Cho phép Manager có quyền duyệt] | [Xác nhận chọn Phương án A/B] | **ĐÃ CHỐT** |

---

## 1. Bối cảnh & Mục tiêu (Context & Objectives)

* **Bối cảnh nghiệp vụ:** [Mô tả ngắn gọn bối cảnh hiện tại của hệ thống và lý do cần có module này].
* **Mục tiêu đạt được:** [Giá trị mang lại cho người dùng hoặc hệ thống khi module hoàn thành].

---

## 2. Danh sách Persona Người dùng (User Personas)

| Persona | Vai trò trong hệ thống | Mục tiêu chính |
| :--- | :--- | :--- |
| **[Tên Persona 1]** | [Ví dụ: Khách hàng vãng lai, Quản trị viên, Hệ thống bên ngoài] | [Mục tiêu của họ khi sử dụng module] |
| **[Tên Persona 2]** | [Ví dụ: Kế toán, Nhân viên CSKH] | [Mục tiêu của họ khi sử dụng module] |

---

## 3. Danh sách User Stories chi tiết

### User Story 1: [Tiêu đề tính năng chính]
* **Là một (As a):** [Loại người dùng / Persona]
* **Tôi muốn (I want to):** [Hành động mong muốn thực hiện]
* **Để (So that):** [Lợi ích hoặc giá trị đạt được]

#### Tiêu chí nghiệm thu (Acceptance Criteria - Gherkin / Given-When-Then):
* **Kịch bản 1: [Thực hiện thành công - Happy Path]**
  * **Given (Cho):** [Trạng thái tiền đề của hệ thống và người dùng]
  * **When (Khi):** [Người dùng thực hiện hành động cụ thể]
  * **Then (Thì):** [Hệ thống phản hồi, dữ liệu được cập nhật thành công]

* **Kịch bản 2: [Trường hợp lỗi / Dữ liệu không hợp lệ]**
  * **Given (Cho):** [Người dùng đã đăng nhập vào hệ thống]
  * **When (Khi):** [Người dùng nhập dữ liệu không hợp lệ hoặc thiếu trường bắt buộc]
  * **Then (Thì):** [Hệ thống từ chối xử lý và hiển thị thông báo lỗi chi tiết tương ứng]

* **Kịch bản 3: [Trường hợp ngoại lệ / Quyền truy cập]**
  * **Given (Cho):** [Người dùng không có quyền truy cập tính năng]
  * **When (Khi):** [Người dùng cố gắng kích hoạt tính năng]
  * **Then (Thì):** [Hệ thống chặn thao tác và trả về lỗi 403 Forbidden]

---

## 4. Các ràng buộc phi chức năng (Non-functional Requirements)
* **Hiệu năng (Performance):** [Thời gian phản hồi API, thông lượng xử lý]
* **Bảo mật (Security):** [Xác thực, phân quyền RBAC, mã hoá dữ liệu nhạy cảm]
* **Khả năng mở rộng (Scalability):** [Khả năng xử lý khi lượng dữ liệu hoặc người dùng tăng trưởng]

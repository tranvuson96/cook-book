# Quy tắc Tạo Module mới (Module Creation Rules)

Khi tạo hoặc phát triển bất kỳ module mới nào, bạn phải tuân thủ nghiêm ngặt các quy trình và quy định thiết kế sau đây:

---

## 0. BƯỚC TIỀN ĐỀ: RÀ SOÁT ĐIỂM XÁM & HỎI XÁC NHẬN NGHIỆP VỤ TRƯỚC KHI THỰC THI (Clarify Gray Areas & Ambiguities Before Execution)

> **NGUYÊN TẮC BẮT BUỘC (ZERO ASSUMPTIONS):**  
> Tuyệt đối **KHÔNG** được tự ý suy diễn hoặc giả định ngầm bất kỳ quy tắc nghiệp vụ nào khi yêu cầu của người dùng còn mơ hồ, đa nghĩa hoặc chưa đầy đủ.

1. **Rà soát & Phát hiện Điểm xám Nghiệp vụ (Identify Gray Areas):**
   * Phân tích sâu yêu cầu đầu vào để chỉ ra các điểm xám, bao gồm:
     * Quy tắc kinh doanh cốt lõi (Business Rules): chính sách tính toán, xử lý tranh chấp, giới hạn hạn mức, phân quyền chi tiết.
     * Luồng dữ liệu và trạng thái nghiệp vụ (State Machine): chuyển đổi trạng thái thế nào, điều kiện nào được phép/chặn.
     * Kịch bản biên và xử lý lỗi (Edge Cases & Failure Scenarios): mất kết nối bên thứ 3, xung đột dữ liệu, hoàn tiền/hủy tác vụ.
     * Phạm vi tính năng (Scope): tính năng nào bắt buộc làm ngay trong phạm vi hiện tại, tính năng nào để phiên bản sau.
2. **Chủ động Hỏi & Đề xuất Phương án (Ask & Propose Options):**
   * Trước khi bắt đầu viết bất kỳ tài liệu hay dòng code nào, **BẮT BUỘC PHẢI HỎI NGƯỜI DÙNG** để làm rõ toàn bộ các điểm xám đã phát hiện.
   * Khi đặt câu hỏi, phải cấu trúc theo dạng:
     * *Vấn đề/Điểm xám là gì?*
     * *Đề xuất các phương án giải quyết (Phương án A, Phương án B... kèm ưu/nhược điểm ngắn gọn).*
     * *Khuyến nghị của Antigravity (nếu có).*
3. **Chốt Xác nhận trước khi Triển khai (Confirmation Gate):**
   * Chỉ khi người dùng phản hồi, xác nhận rõ ràng các câu hỏi nghiệp vụ thì mới chính thức bắt tay vào Bước 1 (Viết User Story) và các bước tiếp theo.

---

## 1. Viết tài liệu User Story (Kịch bản sử dụng)
* Dựa trên các thông tin nghiệp vụ đã được làm rõ và xác nhận ở Bước 0, tạo tài liệu User Story để lên kịch bản sử dụng thực tế của người dùng đối với module.
* Bắt buộc có bảng tổng hợp các điểm xám nghiệp vụ đã được chốt với người dùng.

## 2. Viết tài liệu Phân tích Thiết kế (System Analysis & Design Document)
Dựa trên tài liệu User Story đã xây dựng ở bước 1, viết tài liệu phân tích thiết kế chi tiết bao gồm các phần sau:

### A. Liệt kê và phân tích các chức năng chính
Liệt kê toàn bộ các chức năng chính có trong module và mô tả ngắn gọn vai trò của từng chức năng.

### B. Chi tiết từng chức năng chính
Với mỗi chức năng chính được liệt kê ở trên, phải phân tích chi tiết qua 3 phần sau:
1. **Các kịch bản Usecase:**
   * **Tên usecase** (Usecase Name)
   * **Tác nhân** (Actor)
   * **Tiền điều kiện** (Pre-conditions)
   * **Hậu điều kiện** (Post-conditions)
   * **Kịch bản hoạt động** (Basic Flow - liệt kê chi tiết từng bước thực hiện)
   * **Các trường hợp đặc biệt/ngoại lệ** (Edge cases & Exception Flows)
2. **Phân tích Thực thể (Entity Analysis):**
   * Các thực thể tham gia trong usecase.
   * Mối quan hệ giữa các thực thể (Relationships).
   * Các bảng cơ sở dữ liệu tương ứng (Database Tables mapping).
   * Biểu đồ phân tích lớp (Class Diagram).
   * Biểu đồ truyền thông (Communication Diagram) thể hiện sự liên kết, tương tác và mối quan hệ giữa các lớp (class) và thực thể (entity) trong usecase đó.
3. **Tổng hợp kịch bản:**
   * User Story hoàn chỉnh.
   * Biểu đồ tuần tự hệ thống (System Sequence Diagram - SSD).

### C. Lựa chọn Mẫu thiết kế (Design Patterns)
* Đề xuất và đưa ra các mẫu thiết kế (Design Patterns) phù hợp để xử lý bài toán trong module.
* Phân tích rõ ràng **Ưu điểm** và **Nhược điểm** của từng mẫu thiết kế khi áp dụng vào bài toán cụ thể này.

## 3. Xây dựng Hướng dẫn Viết code (Coding Guideline)
* Phải xây dựng một tài liệu hướng dẫn viết code (Coding Guideline) riêng biệt dựa trên kết quả phân tích thiết kế của Phần 2.
* Tài liệu này định nghĩa rõ quy chuẩn đặt tên, cấu trúc thư mục, các quy tắc code cụ thể cho module.

## 4. Thực thi Viết code (Implementation)
* Khi triển khai viết mã nguồn, phải đảm bảo code tuân thủ tuyệt đối theo **Coding Guideline** (Phần 3) và đúng theo cấu trúc cấu phần, thiết kế đã được phân tích ở **Phần 2**.

## 5. Viết Unit Test & Integration Test (Testing Rules)
* Phải viết Unit Test và Integration Test đầy đủ cho tất cả các tính năng mới hoặc thay đổi logic trong module.
* Đảm bảo độ bao phủ (coverage) tốt, bao gồm cả luồng hoạt động chính (Happy Path) và các trường hợp lỗi/ngoại lệ (Edge cases & Exception Flows).
* Tất cả test cases phải chạy thành công (passed) trước khi hoàn thành công việc.

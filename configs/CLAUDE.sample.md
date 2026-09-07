# Claude Code Project Guidelines (Antigravity Cook-Book Integration)

> File mẫu này dùng để đặt tại thư mục gốc dự án của bạn với tên `CLAUDE.md`. Claude Code sẽ tự động nạp mỗi khi khởi động.

---

## ⚡ CORE PRINCIPLE: ZERO ASSUMPTIONS (HỎI TRƯỚC KHI THỰC THI)
- **Tuyệt đối KHÔNG giả định ngầm**: Khi yêu cầu của người dùng còn bất kỳ điểm xám nào (quy tắc tính toán, luồng ngoại lệ, chính sách đổi trả/đặt trước, quyền hạn các role...), bạn **BẮT BUỘC PHẢI DỪNG LẠI VÀ HỎI** người dùng.
- **Cấu trúc câu hỏi**: Nêu rõ điểm xám là gì + Đề xuất các phương án giải quyết (Option A, Option B kèm ưu/nhược điểm) để người dùng dễ chọn.
- **Chỉ thực thi khi người dùng đã xác nhận**.

---

## 🛠️ WORKFLOW SELECTION

### 1. Khi phát triển Module / Feature mới (Track 1):
Tuân thủ nghiêm ngặt quy trình tại: `[Đường dẫn tới cook-book]/rules/01-module-creation-rules.md`
- Bước 0: Rà soát điểm xám & hỏi xác nhận.
- Bước 1: Viết User Story (`templates/01-user-story-template.md`).
- Bước 2: Phân tích thiết kế chi tiết (`templates/02-system-design-template.md`).
- Bước 3: Viết Coding Guideline (`templates/03-coding-guideline-template.md`).
- Bước 4: Thực thi viết code chuẩn SOLID / Clean Architecture.
- Bước 5: Viết Unit & Integration Test (Đạt độ bao phủ >= 85%, 100% test cases pass).

### 2. Khi xây dựng / vận hành website WordPress (Track 2):
Tuân thủ quy trình tại: `[Đường dẫn tới cook-book]/rules/05-wordpress-site-workflow-rules.md`
- Bước 0: Rà soát điểm xám & xác nhận nghiệp vụ (Pre-order, cổng thanh toán VietQR/COD, tắt bình luận MXH, xử lý rác demo).
- Bước 1: Client Brief & Vibe (`templates/wordpress/01-client-brief-template.md`).
- Bước 2: Solution Research Theme & Plugins (`templates/wordpress/02-plugin-theme-solution-template.md`).
- Bước 3: Tinh chỉnh Content chuẩn Vibe & SEO (`templates/wordpress/03-content-and-vibe-template.md`).
- Bước 4: Kiểm định 4 lớp (Visual, Functional, Technical PageSpeed, 0 JS/PHP error) (`templates/wordpress/04-site-audit-and-qa-template.md`).
- Bước 5: Bàn giao, backup & dọn dẹp (`templates/wordpress/05-handover-and-finalize-template.md`).

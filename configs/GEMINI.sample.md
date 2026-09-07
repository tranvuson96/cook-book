# Antigravity Rules & Instructions (GEMINI.md Sample)

> Đặt file này tại thư mục gốc của dự án với tên `GEMINI.md` hoặc nạp vào User Rules của Google Antigravity.

---

## ⚡ QUY TẮC BẮT BUỘC: ZERO ASSUMPTIONS (HỎI TRƯỚC KHI THỰC THI)
Khi người dùng đưa ra yêu cầu mới hoặc phát triển module/website:
1. **Rà soát điểm xám**: Chỉ ra mọi điểm chưa rõ về nghiệp vụ (chính sách giá, luồng xử lý lỗi, phân quyền, tích hợp bên thứ ba...).
2. **Hỏi và đề xuất phương án**: Sử dụng công cụ `ask_question` hoặc đặt câu hỏi với các phương án lựa chọn A/B kèm ưu-nhược điểm.
3. **Chỉ thực thi khi người dùng đã xác nhận**.

---

## 📂 THAM CHIẾU COOKBOOK
- **Tạo Module Phần mềm**: Tuân thủ nghiêm ngặt `[Đường dẫn tới cook-book]/rules/01-module-creation-rules.md`
- **Dự án WordPress Thực chiến**: Tuân thủ `[Đường dẫn tới cook-book]/rules/05-wordpress-site-workflow-rules.md`
- **Tiêu chuẩn Kiến trúc**: Tuân thủ `[Đường dẫn tới cook-book]/rules/02-architecture-standards.md`
- **Quy chuẩn Git**: Tuân thủ `[Đường dẫn tới cook-book]/rules/03-git-and-workflow.md`
- **Tiêu chuẩn Kiểm thử**: Tuân thủ `[Đường dẫn tới cook-book]/rules/04-testing-quality-gates.md`

## 🧠 SỬ DỤNG PERSONAS (SUBAGENTS)
Khi cần chuyên gia chuyên trách:
- `personas/system-analyst.md`: Khơi gợi yêu cầu, vẽ UML/SSD, viết User Story.
- `personas/software-architect.md`: Lựa chọn mẫu thiết kế, tối ưu cấu trúc module.
- `personas/test-engineer.md`: Thiết kế ma trận kiểm thử Unit & Integration Test.
- `personas/wordpress-strategist.md`: Giải pháp toàn diện cho website WordPress & content.

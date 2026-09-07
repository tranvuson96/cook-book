---
name: design-pattern-advisor
description: >-
  Kỹ năng phân tích, so sánh và đề xuất các Mẫu thiết kế (Design Patterns) phù hợp cho bài toán kỹ thuật,
  luôn đi kèm phân tích ưu điểm và nhược điểm chi tiết khi áp dụng.
---

# Kỹ năng Tư vấn Mẫu Thiết kế (Design Pattern Advisor)

Kỹ năng này giúp Antigravity đánh giá bài toán kiến trúc một cách khách quan, chọn lựa pattern chuẩn xác và tránh over-engineering.

---

## 1. Nguyên tắc Đề xuất Pattern

Khi đứng trước một bài toán kỹ thuật cần giải quyết bằng mẫu thiết kế:
1. **Luôn đề xuất tối thiểu 2 phương án khả thi** để so sánh (ví dụ: Strategy vs State, Factory Method vs Builder, Observer vs Event-Bus).
2. **Không áp dụng pattern chỉ vì muốn "viết cho đẹp"**: Phải chỉ ra vấn đề thực tế mà pattern này giải quyết (giảm coupling, dễ mở rộng, dễ test, tránh if-else lồng nhau).
3. **Phân tích Ưu & Nhược điểm khách quan**:
   * *Ưu điểm*: Khả năng mở rộng (Scalability), tính đóng gói (Encapsulation), dễ bảo trì (Maintainability), dễ viết test.
   * *Nhược điểm*: Chi phí tạo thêm file/class (Boilerplate), độ phức tạp cho người đọc mới, phụ thuộc vào dependency injection.

---

## 2. Bảng Tra Cứu Nhanh (Pattern Cheat Sheet)

| Vấn đề Nghiệp vụ / Kỹ thuật | Mẫu Thiết kế Khuyến nghị | Lý do áp dụng |
| :--- | :--- | :--- |
| Cần hoán đổi linh hoạt các thuật toán/phương thức (Thanh toán, Tính phí vận chuyển, Format báo cáo) | **Strategy Pattern** | Tách thuật toán khỏi ngữ cảnh sử dụng, tuân thủ Open/Closed. |
| Khởi tạo các nhóm đối tượng phức tạp phụ thuộc vào môi trường hoặc cấu hình | **Factory Method / Abstract Factory** | Đóng gói logic khởi tạo, caller không cần biết cụ thể class con nào được tạo. |
| Đối tượng có quá nhiều tham số tuỳ chọn khi khởi tạo (Config, Query Filter, DTO phức tạp) | **Builder Pattern** | Tạo đối tượng từng bước một cách an toàn và dễ đọc (fluent interface). |
| Cần tích hợp với SDK / Thư viện bên thứ 3 có interface không tương thích | **Adapter Pattern** | Đóng vai trò lớp chuyển đổi trung gian, giữ nguyên domain code. |
| Cần thông báo cho nhiều module khi có sự thay đổi trạng thái (Sự kiện Đặt hàng thành công) | **Observer / Pub-Sub Pattern** | Loose-coupling giữa nhà phát hành sự kiện (Publisher) và người lắng nghe (Subscriber). |
| Bổ sung hành vi (Logging, Caching, Rate Limiting, Audit) vào đối tượng mà không sửa class gốc | **Decorator Pattern** | Bọc đối tượng gốc bằng các wrapper layer linh hoạt. |

---
name: wordpress-site-builder
description: >-
  Kỹ năng dẫn dắt Antigravity vận hành toàn diện dự án WordPress theo quy trình thực chiến:
  0. Làm rõ Điểm xám & Xác nhận nghiệp vụ với khách
  1. Nhận & phân tích yêu cầu (Client Brief & Vibe)
  2. Research Plugins & Theme đưa ra giải pháp
  3. Tinh chỉnh Content phù hợp với Vibe của khách
  4. Kiểm tra (QA) và xử lý vấn đề phát sinh (Troubleshooting)
  5. Finalize & Bàn giao.
---

# Kỹ năng Vận hành Dự án WordPress (WordPress Site Builder Skill)

Kỹ năng này được kích hoạt khi bạn thực hiện các tác vụ liên quan đến xây dựng website WordPress, cấu hình theme/plugin, sản xuất nội dung chuẩn SEO theo phong cách thương hiệu và kiểm thử/bàn giao website.

---

## QUY TRÌNH THỰC THI BẮT BUỘC

### Bước 0: Rà soát Điểm xám & Hỏi Xác nhận Nghiệp vụ Trước khi Thực thi (Clarify Gray Areas)
> **NGUYÊN TẮC VÀNG:** *"Làm rõ trước khi làm - Tuyệt đối không tự suy diễn nghiệp vụ của khách"*

1. **Rà soát phát hiện các điểm xám**:
   * Mô hình bán hàng: Có tính năng Đặt trước (Pre-order) không? Chính sách cọc và giao hàng?
   * Phương thức thanh toán: Chuyển khoản VietQR, COD hay thẻ quốc tế?
   * Phí vận chuyển: Đồng giá, miễn phí vận chuyển hay tính động theo khu vực?
   * Tính năng xã hội & tương tác: Có bật bình luận (Comments) và đánh giá (Reviews) không hay cần tắt hoàn toàn vì website không phải mạng xã hội?
   * Mẫu dữ liệu demo: Có cần giữ lại thành phần nào không hay phải xóa sạch toàn bộ rác và nội dung ẩm thực/demo cũ?
2. **Chủ động đặt câu hỏi**:
   * Soạn bảng câu hỏi làm rõ các điểm xám, đề xuất các phương án A/B kèm phân tích ưu nhược điểm.
3. **Chờ xác nhận**:
   * Chỉ tiến hành cài đặt plugin, theme hay cấu hình website sau khi khách hàng đã phản hồi xác nhận.

### Bước 1: Tiếp nhận và Phân tích Yêu cầu (Client Brief & Vibe)
1. **Lắng nghe & Khảo sát**:
   * Xác định rõ loại website (Doanh nghiệp, Bán hàng, Landing page, Đặt lịch...).
   * Khai thác sâu về **Phong cách & Vibe mong muốn**: Sang trọng (Luxury), Tối giản (Minimalism), Trẻ trung (Playful), Công nghệ (Tech), hay Thân thiện (Warm).
   * Thống nhất bảng màu thương hiệu, font chữ và các trang web tham khảo (Reference sites).
   * Lập danh sách tính năng: Phân loại rõ Must-have và Nice-to-have.
2. **Sử dụng Template**: [templates/wordpress/01-client-brief-template.md](../../templates/wordpress/01-client-brief-template.md).

### Bước 2: Research Plugins & Theme để Đưa ra Giải pháp
1. **Chọn Theme**:
   * Đề xuất theme nhẹ, chuẩn SEO, responsive tốt (Astra, Kadence, GeneratePress, Bricks, Hello Elementor).
2. **Lựa chọn Plugin Stack**:
   * **Core Stack**: Tốc độ (LiteSpeed Cache / WP Rocket), SEO (Rank Math), Form (Fluent Forms), Bảo mật (Wordfence / Cloudflare), SMTP (FluentSMTP).
   * **Feature Stack**: WooCommerce, VietQR, ACF, Polylang...
3. **Thẩm định Rủi ro**:
   * Đảm bảo không trùng tính năng (không cài cùng lúc 2 plugin cache hoặc 2 plugin SEO).
   * Đánh giá chi phí (ưu tiên tối đa các giải pháp Free chất lượng cao).
4. **Sử dụng Template**: [templates/wordpress/02-plugin-theme-solution-template.md](../../templates/wordpress/02-plugin-theme-solution-template.md).

### Bước 3: Tinh chỉnh Content Phù hợp với Vibe của Khách
1. **Tone & Voice Guideline**: Xác định rõ từ ngữ gợi cảm xúc nên dùng và từ sáo rỗng cần tránh.
2. **Wireframe Copywriting Trang chủ**:
   * Viết tiêu đề Hero Banner (H1) đánh trúng tâm lý khách hàng.
   * Lợi thế cạnh tranh (USP), dịch vụ/sản phẩm trọng tâm, đánh giá của khách hàng (Testimonials).
   * Lời kêu gọi hành động (Call To Action - CTA) dứt khoát, hấp dẫn.
3. **SEO On-page**:
   * Tối ưu Title Tag (dưới 60 ký tự), Meta Description (dưới 155 ký tự), Heading H1/H2/H3 và Alt text ảnh.
4. **Sử dụng Template**: [templates/wordpress/03-content-and-vibe-template.md](../../templates/wordpress/03-content-and-vibe-template.md).

### Bước 4: Kiểm tra lại và Xử lý Vấn đề Phát sinh (Audit & Troubleshooting)
1. **Kiểm tra Giao diện (Visual QA)**: Test responsive trên Mobile, Tablet, Desktop. Đảm bảo màu sắc, font chữ và khoảng trắng đồng nhất theo đúng Vibe.
2. **Kiểm tra Tính năng (Functional QA)**: Test submit form liên hệ (email có về không), test luồng mua hàng và thanh toán VietQR, quét link 404.
3. **Kiểm tra Tốc độ & Lỗi ngầm (Technical QA)**:
   * Chạy PageSpeed Insights (đảm bảo Mobile $\ge 80$, Desktop $\ge 90$).
   * Kiểm tra F12 Console (0 JavaScript error).
   * Kiểm tra `debug.log` (0 fatal error).
4. **Xử lý sự cố (Troubleshooting)**: Nếu phát hiện lỗi xung đột plugin hoặc vỡ layout, phân tích nguyên nhân gốc rễ và xử lý triệt để.
5. **Sử dụng Template**: [templates/wordpress/04-site-audit-and-qa-template.md](../../templates/wordpress/04-site-audit-and-qa-template.md).

### Bước 5: Finalize & Bàn giao
1. **Dọn dẹp (Cleanup)**: Xoá trang/bài viết mẫu, xoá plugin không dùng, dọn database rác, tắt debug log, bật HTTPS/SSL.
2. **Sao lưu (Backup)**: Tạo bản Full Site Backup (Database + `wp-content`).
3. **Bàn giao (Handover Guide)**: Soạn hướng dẫn quản trị cho khách, bàn giao tài khoản.
4. **Sử dụng Template**: [templates/wordpress/05-handover-and-finalize-template.md](../../templates/wordpress/05-handover-and-finalize-template.md).

# Đề xuất Giải pháp Theme & Plugins WordPress (Solution Blueprint)

> **Tên Dự án:** [Tên Dự án]  
> **Dựa trên Client Brief:** [Đường dẫn file Client Brief liên quan]  
> **Người thực hiện:** [Tác giả / Antigravity]  
> **Ngày:** [YYYY-MM-DD]  

---

## 1. Đề xuất Theme Nền tảng (Theme Selection)

| Tiêu chí | Theme được đề xuất: [Tên Theme, vd: Kadence / Astra / Hello Elementor] | Theme dự phòng: [Tên Theme dự phòng] |
| :--- | :--- | :--- |
| **Lý do lựa chọn** | Nhẹ (< 50KB), code chuẩn SEO, tuỳ biến header/footer linh hoạt không cần code | Phổ biến, cộng đồng hỗ trợ lớn |
| **Điểm hiệu năng gốc** | 98/100 trên Google PageSpeed | 95/100 trên Google PageSpeed |
| **Độ tương thích Page Builder** | Gutenberg / Elementor / Bricks | Elementor / Gutenberg |
| **Chi phí** | Bản Free đáp ứng 100% yêu cầu | Bản Free |

---

## 2. Danh mục Bộ Plugin Tối ưu (Plugin Stack Blueprint)

### A. Core Stack (Bắt buộc cho mọi website WordPress)

| Danh mục | Plugin đề xuất | Bản dùng (Free/Pro) | Vai trò & Lý do lựa chọn |
| :--- | :--- | :---: | :--- |
| **Tốc độ & Caching** | **LiteSpeed Cache** (hoặc WP Rocket) | Free | Tối ưu nén HTML/CSS/JS, Object Cache, Image Optimization |
| **SEO On-page** | **Rank Math SEO** | Free | Nhẹ hơn Yoast, hỗ trợ Schema Rich Snippet phong phú, quản lý redirect 301 |
| **Bảo mật (Security)** | **Wordfence** (hoặc Cloudflare integration) | Free | WAF chống brute-force, quét malware, khoá IP bất thường |
| **Form liên hệ** | **Fluent Forms** (hoặc WPForms) | Free | Rất nhẹ, không render script rác ở các trang không có form, lưu data vào DB |
| **Gửi Email (SMTP)** | **FluentSMTP** (hoặc WP Mail SMTP) | Free | 100% Free không giới hạn log, kết nối Gmail/SendGrid/Amazon SES mượt mà |

### B. Feature Stack (Theo yêu cầu nghiệp vụ cụ thể)

| Tính năng yêu cầu | Plugin đề xuất | Bản dùng | Đánh giá rủi ro & giải pháp thay thế |
| :--- | :--- | :---: | :--- |
| **Bán hàng trực tuyến** | **WooCommerce** | Free | Hệ sinh thái chuẩn, dễ mở rộng cổng thanh toán |
| **Thanh toán VietQR** | **VietQR Plugin** (SePay / Casso) | Free/Sub | Quét mã QR tự động xác nhận đơn trong 3 giây |
| **Tuỳ biến trường dữ liệu** | **Advanced Custom Fields (ACF)** | Free | Chuẩn mực quản lý meta fields cho CPT |
| **Đa ngôn ngữ** | **Polylang** (hoặc TranslatePress) | Free | Rất nhẹ, không làm nặng database như WPML |

---

## 3. Đánh giá Rủi ro & Ma trận Xung đột (Risk & Conflict Assessment)

1. **Xung đột Caching & Minification:**
   * *Rủi ro*: Bật gộp file JS (Combine JS) trong plugin Cache có thể gây vỡ hiệu ứng menu hoặc slider.
   * *Giải pháp*: Chỉ bật Minify, không bật Combine JS nếu theme đã dùng module loading hiện đại.
2. **Kiểm soát dung lượng & Tốc độ (Bloatware Prevention):**
   * Tổng số lượng plugin kích hoạt: $\le 12 - 15$ plugins.
   * Tuyệt đối không cài cùng lúc 2 plugin cùng chức năng.
3. **Ước tính Tổng Chi phí Bản quyền (Budget Summary):**
   * Giải pháp đề xuất sử dụng 100% bản Free ổn định, chi phí bản quyền phát sinh: **0 VNĐ**.

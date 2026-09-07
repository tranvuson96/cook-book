# Quy tắc Vận hành Dự án WordPress (WordPress Site Workflow Rules)

Quy tắc này áp dụng cho các dự án xây dựng, tuỳ biến và vận hành website WordPress (tập trung vào cấu hình theme, lựa chọn plugin, xây dựng content theo phong cách/vibe và tối ưu hệ thống).

Mô hình này chạy song song với quy chuẩn phát triển phần mềm/module thuần code và tuân thủ quy trình thực chiến nghiêm ngặt sau:

---

## BƯỚC TIỀN ĐỀ: RÀ SOÁT ĐIỂM XÁM & HỎI LÀM RÕ NGHIỆP VỤ TRƯỚC KHI THỰC THI (CLARIFY GRAY AREAS & CONFIRMATION)

> **NGUYÊN TẮC VÀNG:** *"Làm rõ trước khi làm - Tuyệt đối không tự suy diễn nghiệp vụ của khách"*

Trước khi cài đặt bất kỳ theme, plugin, tạo bài viết hay thay đổi cấu hình nào, Antigravity **BẮT BUỘC** phải rà soát và làm rõ các điểm xám:
1. **Phát hiện các điểm xám thường gặp trong dự án website**:
   * **Chính sách bán hàng & Đặt hàng**: Có cho phép đặt trước (Pre-order) không? Cọc bao nhiêu %? Chính sách đổi trả/bảo hành thế nào?
   * **Cổng thanh toán & Vận chuyển**: Khách thanh toán qua VietQR tự động, COD, hay thẻ quốc tế? Phí ship tính cố định hay theo địa bàn/cân nặng?
   * **Phân quyền & Tương tác người dùng**: Website có cho phép khách bình luận (Comments), đánh giá (Reviews) hay không? Có cần đăng ký thành viên hay cho phép mua hàng ẩn danh (Guest Checkout)?
   * **Bản quyền & Tồn tại dữ liệu demo**: Có giữ lại tính năng nào từ demo không hay phải dọn sạch 100% rác và nội dung mẫu?
2. **Chủ động Đặt câu hỏi và Đề xuất Giải pháp**:
   * Liệt kê cụ thể từng vấn đề nghiệp vụ chưa rõ ràng.
   * Cung cấp các phương án lựa chọn (Option A, Option B) kèm ưu/nhược điểm ngắn gọn để khách dễ dàng lựa chọn.
3. **Cổng Xác nhận (Confirmation Gate)**:
   * Chỉ bắt đầu thực hiện các bước tiếp theo khi khách hàng đã phản hồi xác nhận phương án rõ ràng.

---

## BƯỚC 1: TIẾP NHẬN VÀ PHÂN TÍCH YÊU CẦU (REQUIREMENT INTAKE & VIBE ANALYSIS)
Sau khi đã làm rõ các điểm xám ở bước tiền đề, tiến hành chuẩn hoá:
1. **Mục tiêu cốt lõi của website**: Bán hàng, giới thiệu dịch vụ doanh nghiệp, landing page chuyển đổi, tin tức hay đặt lịch/booking.
2. **Khách hàng mục tiêu & Định hình Phong cách (Vibe & Aesthetics)**:
   * Tone & Voice: Sang trọng quý phái, tối giản hiện đại (Minimalism), trẻ trung năng động, công nghệ cao hay ấm cúng thân thiện.
   * Gam màu chủ đạo và font chữ mong muốn.
3. **Yêu cầu chức năng**: Danh sách các tính năng bắt buộc phải có (Must-have) và tính năng mở rộng (Nice-to-have).
4. **Ràng buộc kỹ thuật & ngân sách**: Thông số hosting/server (LiteSpeed, Nginx, Apache), ngân sách cho plugin trả phí (Pro) hay ưu tiên giải pháp miễn phí (Free/Open-source).
* **Bắt buộc**: Hoàn thành tài liệu theo mẫu [templates/wordpress/01-client-brief-template.md](../templates/wordpress/01-client-brief-template.md).

---

## BƯỚC 2: RESEARCH PLUGINS & THEME ĐƯA RA GIẢI PHÁP (SOLUTION RESEARCH)
1. **Lựa chọn Theme nền tảng**:
   * Ưu tiên các theme nhẹ, code chuẩn SEO, điểm tốc độ cao (Astra, GeneratePress, Kadence, Hello Elementor, Bricks).
   * Không sử dụng các theme "ôm đồm" quá nhiều tính năng rác làm chậm website.
2. **Nghiên cứu & Đề xuất Bộ Plugin tối ưu (Plugin Stack)**:
   * **Core Stack**: Bảo mật (Wordfence/Cloudflare), SEO (RankMath/Yoast), Caching/Tốc độ (LSCache/WP Rocket), Form (Fluent Forms/WPForms/Gravity Forms).
   * **Feature Stack**: WooCommerce (E-commerce), ACF/Pods (Custom Data), WPML/Polylang (Đa ngôn ngữ)...
3. **Đánh giá Rủi ro & Khả năng Xung đột**:
   * Kiểm tra mức độ cập nhật, số lượng cài đặt hoạt động, đánh giá từ cộng đồng.
   * Tránh cài nhiều plugin có cùng chức năng (ví dụ cài 2 plugin SEO hoặc 2 plugin Cache).
   * Đưa ra so sánh giữa phương án Free vs Pro kèm chi phí ước tính.
* **Bắt buộc**: Hoàn thành tài liệu giải pháp theo mẫu [templates/wordpress/02-plugin-theme-solution-template.md](../templates/wordpress/02-plugin-theme-solution-template.md).

---

## BƯỚC 3: TINH CHỈNH CONTENT PHÙ HỢP VỚI VIBE CỦA KHÁCH (CONTENT & VIBE TAILORING)
1. **Định hình Cấu trúc Nội dung (Sitemap & Page Structure)**:
   * Lên sơ đồ các trang quan trọng: Trang chủ (Home), Giới thiệu (About), Dịch vụ/Sản phẩm, Liên hệ, Blog.
   * Cấu trúc wireframe nội dung trang chủ: Hero Section $\rightarrow$ USP (Lợi thế cạnh tranh) $\rightarrow$ Dịch vụ cốt lõi $\rightarrow$ Bằng chứng xã hội (Social Proof/Review) $\rightarrow$ FAQ $\rightarrow$ CTA cuối trang.
2. **Soạn thảo & Tinh chỉnh Copywriting chuẩn Vibe**:
   * Điều chỉnh văn phong, tiêu đề (Headlines) và lời kêu gọi hành động (Call to Action - CTA) đúng với vibe đã thống nhất ở Bước 1.
   * Tránh văn phong chung chung, sáo rỗng; tập trung vào lợi ích khách hàng nhận được.
3. **Chuẩn hóa SEO On-page cho Content**:
   * Tiêu đề SEO (Title Tag), Thẻ mô tả (Meta Description) hấp dẫn kích thích tỷ lệ click (CTR).
   * Tối ưu Heading (H1, H2, H3) chứa từ khoá tự nhiên, hình ảnh có thẻ Alt mô tả chuẩn xác.
* **Bắt buộc**: Hoàn thành tài liệu content theo mẫu [templates/wordpress/03-content-and-vibe-template.md](../templates/wordpress/03-content-and-vibe-template.md).

---

## BƯỚC 4: KIỂM TRA LẠI VÀ XỬ LÝ VẤN ĐỀ PHÁT SINH (AUDIT & TROUBLESHOOTING)
Trước khi bàn giao hoặc public website, phải trải qua quy trình kiểm thử 4 lớp:
1. **Kiểm tra Giao diện (Visual & Responsive QA)**:
   * Hiển thị chuẩn trên 3 kích thước: Mobile, Tablet và Desktop.
   * Không bị tràn viền (horizontal scroll lỗi), font chữ dễ đọc, nút bấm đủ lớn cho ngón tay trên mobile.
2. **Kiểm tra Tính năng (Functional QA)**:
   * Test gửi form liên hệ: Email thông báo có về hộp thư quản trị không (kiểm tra cấu hình SMTP).
   * Test luồng giỏ hàng, đặt hàng, tính thuế, phí vận chuyển (với website e-commerce).
   * Kiểm tra tất cả đường link nội bộ và link mạng xã hội, đảm bảo không có link 404.
3. **Kiểm tra Hiệu năng & Kỹ thuật (Technical & Speed QA)**:
   * Kiểm tra Google PageSpeed Insights (đạt điểm xanh hoặc cam cao trên Mobile & Desktop).
   * Hình ảnh được nén dạng WebP, dung lượng dưới 150KB cho ảnh thông thường.
   * Mở F12 Console kiểm tra không có lỗi JavaScript (JS fatal errors).
   * Kiểm tra file `wp-content/debug.log` đảm bảo không có PHP Warning/Fatal error ngầm.
4. **Troubleshooting**: Khi có sự cố (xung đột CSS, vỡ layout, plugin không kích hoạt được), khoanh vùng và xử lý dứt điểm nguyên nhân gốc rễ.
* **Bắt buộc**: Hoàn thành biên bản kiểm định theo mẫu [templates/wordpress/04-site-audit-and-qa-template.md](../templates/wordpress/04-site-audit-and-qa-template.md).

---

## BƯỚC 5: BÀN GIAO & NGHIỆM THU (FINALIZE & HANDOVER)
1. **Dọn dẹp hệ thống (Sanitization & Cleanup)**:
   * Xoá toàn bộ bài viết, trang, bình luận, ảnh mẫu (dummy/sample data).
   * Xoá hoàn toàn các plugin/theme đã cài thử nhưng không sử dụng.
   * Tắt chế độ `WP_DEBUG` và ẩn các thông báo lỗi debug ra ngoài giao diện.
2. **Tạo bản sao lưu toàn diện (Full Site Backup)**:
   * Tạo backup gồm toàn bộ Cơ sở dữ liệu (Database) và thư mục `wp-content`.
3. **Lập tài liệu hướng dẫn quản trị (Admin Handover Guide)**:
   * Hướng dẫn khách hàng: Cách chỉnh sửa nội dung, thay ảnh banner, xem danh sách liên hệ/đơn hàng.
   * Cung cấp các khuyến cáo an toàn: Cách đặt mật khẩu mạnh, quy trình cập nhật plugin định kỳ.
* **Bắt buộc**: Hoàn thành tài liệu nghiệm thu theo mẫu [templates/wordpress/05-handover-and-finalize-template.md](../templates/wordpress/05-handover-and-finalize-template.md).

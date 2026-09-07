# Tài liệu Khảo sát Yêu cầu & Định vị Vibe (Client Brief & Vibe Spec)

> **Tên Dự án / Khách hàng:** [Tên Dự án]  
> **Lĩnh vực hoạt động:** [Ví dụ: Thời trang, Bất động sản, Nha khoa, Công ty Luật, F&B, Thể thao...]  
> **Người thực hiện khảo sát:** [Tên người thực hiện / Antigravity]  
> **Ngày lập:** [YYYY-MM-DD]  

---

## 0. Bảng Rà Soát Điểm Xám & Câu Hỏi Nghiệp Vụ Cần Chốt (Business Gray Areas & Clarification)

> **NGUYÊN TẮC:** Bắt buộc hỏi và làm rõ toàn bộ các điểm xám này với khách hàng trước khi bắt tay vào cài đặt plugin/theme hay cấu hình website.

| STT | Điểm xám / Vấn đề chưa rõ về nghiệp vụ | Phương án đề xuất (A / B) | Ý kiến / Xác nhận từ Khách hàng | Trạng thái |
| :---: | :--- | :--- | :--- | :---: |
| 1 | *Ví dụ: Chính sách Đặt trước (Pre-order): Có cọc trước không hay trả sau?* | **A**: Cọc 30% qua VietQR.<br>**B**: Đăng ký giữ chỗ, thanh toán khi nhận hàng. | [Khách chốt chọn Phương án B] | **ĐÃ CHỐT** |
| 2 | *Ví dụ: Tính năng Bình luận / Đánh giá: Có bật trên bài viết & sản phẩm?* | **A**: Tắt hoàn toàn (tránh spam, website không phải MXH).<br>**B**: Bật đánh giá sản phẩm WooCommerce có duyệt. | [Khách chốt Phương án A] | **ĐÃ CHỐT** |
| 3 | *Ví dụ: Phương thức thanh toán*: | **A**: Chuyển khoản VietQR + COD.<br>**B**: Tích hợp thêm cổng thẻ tín dụng. | [Khách chốt Phương án A] | **ĐÃ CHỐT** |
| 4 | *Ví dụ: Xử lý dữ liệu demo sau khi cài theme*: | **A**: Xoá sạch 100% rác demo, chỉ giữ khung sườn.<br>**B**: Giữ lại các layout phụ. | [Khách chốt Phương án A] | **ĐÃ CHỐT** |

---

## 1. Mục tiêu Cốt lõi của Website (Primary Objectives)
* **Loại hình website:**
  - [ ] Website giới thiệu công ty / doanh nghiệp (Corporate / Lead Generation)
  - [ ] Website bán hàng thương mại điện tử (E-commerce / WooCommerce)
  - [ ] Landing page giới thiệu dịch vụ / chiến dịch quảng cáo
  - [ ] Blog chuyên gia / Tạp chí tin tức
  - [ ] Đặt lịch hẹn / Booking dịch vụ
* **Mục tiêu chuyển đổi chính (Conversion Goal):** [Ví dụ: Khách điền form nhận báo giá, Khách bấm nút gọi hotline, Khách thanh toán đơn hàng online...]
* **Đối tượng người dùng mục tiêu (Target Audience):** [Ví dụ: Nam/Nữ 25-40 tuổi, nhân viên văn phòng, quan tâm thể thao/lối sống xanh, thu nhập khá...]

---

## 2. Định vị Phong cách & "Vibe" Mong muốn (Brand Vibe & Aesthetics)

* **Tone & Voice (Giọng điệu thương hiệu):**
  - [ ] Sang trọng, Đẳng cấp, Tinh tế (Luxury, Premium, High-end)
  - [ ] Tối giản, Hiện đại, Công nghệ (Minimalism, Modern, Clean, Tech)
  - [ ] Trẻ trung, Năng động, Thể thao (Vibrant, Energetic, Athletic)
  - [ ] Chuyên nghiệp, Đáng tin cậy, Chuẩn mực (Professional, Trustworthy, Corporate)
  - [ ] Ấm cúng, Gần gũi, Thân thiện (Warm, Welcoming, Eco-friendly)
* **Bảng màu chủ đạo (Color Palette):**
  * Màu chính (Primary): `#[Mã màu]` ([Mô tả cảm xúc, vd: Xanh lá năng động thể thao])
  * Màu phụ (Secondary): `#[Mã màu]`
  * Màu nhấn nút bấm (Accent/CTA): `#[Mã màu]` ([Cần nổi bật để kích thích hành động])
* **Định hướng Font chữ:**
  * Font tiêu đề (Heading): [Ví dụ: Playfair Display / Montserrat / Inter / Plus Jakarta Sans]
  * Font nội dung (Body): [Ví dụ: Roboto / Open Sans / Inter]
* **Website tham khảo (Reference Sites):**
  1. `[URL 1]`: [Điểm khách thích: màu sắc, bố cục banner...]
  2. `[URL 2]`: [Điểm khách thích: hiệu ứng mượt mà, cách trình bày sản phẩm...]

---

## 3. Danh sách Chức năng Yêu cầu (Feature Requirements)

| Nhóm chức năng | Tính năng chi tiết | Mức độ ưu tiên (Must / Nice-to-have) |
| :--- | :--- | :---: |
| **Giao tiếp & Lead** | Form liên hệ báo giá có validation | **Must-have** |
| | Nút chat Zalo / Messenger / Hotline góc màn hình | **Must-have** |
| **Nội dung & Danh mục**| Quản lý sản phẩm thể thao / bài viết chuyên sâu | **Must-have** |
| | Blog tin tức chia sẻ kiến thức chuyên ngành | Nice-to-have |
| **Bán hàng / Booking** | Cổng thanh toán quét mã VietQR tự động | **Must-have** |
| | Tính năng đặt trước Pre-order kèm lộ trình mở bán | **Must-have** |
| **Ngôn ngữ** | Tiếng Việt chuẩn hóa 100% | **Must-have** |

---

## 4. Ràng buộc Hạ tầng & Ngân sách (Technical & Budget Constraints)

* **Hosting / Server hiện có:** [Ví dụ: Cloud Server LiteSpeed, cPanel Shared Host, Docker VPS...]
* **Khả năng chi trả cho Plugin/Theme bản quyền:**
  - [ ] Ưu tiên 100% giải pháp Miễn phí (Free / Open-source)
  - [ ] Sẵn sàng mua bản quyền các plugin cốt lõi (WooCommerce Addons, WP Rocket, Rank Math Pro...)
  - [ ] Đã có sẵn Theme/Plugin trả phí do khách cung cấp

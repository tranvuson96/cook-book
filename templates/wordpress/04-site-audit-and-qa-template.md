# Biên bản Kiểm định & Xử lý Lỗi (Site Audit & QA Checklist)

> **Tên Dự án:** [Tên Website / URL]  
> **Người kiểm thử:** [Tên người kiểm thử / Antigravity]  
> **Ngày kiểm tra:** [YYYY-MM-DD]  
> **Trạng thái:** [Passed / Issues Found / Resolved]  

---

## 1. Bảng Kiểm định Giao diện & Trải nghiệm (Visual & UX QA)

| Hạng mục kiểm tra | Tiêu chuẩn đạt | Kết quả (Pass/Fail) | Ghi chú / Lỗi phát hiện |
| :--- | :--- | :---: | :--- |
| **Mobile Responsive (375px - 414px)** | Bố cục không tràn ngang, font chữ dễ đọc, menu toggle mượt mà | [Pass/Fail] | |
| **Tablet Responsive (768px - 1024px)** | Cột chia cân đối, không đè chữ lên hình | [Pass/Fail] | |
| **Desktop (1280px - 1920px)** | Khung trang căn giữa chuẩn, khoảng trắng hài hoà | [Pass/Fail] | |
| **Độ đồng bộ Vibe & Brand** | Màu nút bấm, font chữ, icon đồng bộ 100% theo Brand Guideline | [Pass/Fail] | |
| **Favicon & Logo** | Hiển thị sắc nét trên tab trình duyệt và thanh header | [Pass/Fail] | |

---

## 2. Bảng Kiểm định Tính năng Nghiệp vụ (Functional QA)

| Hạng mục kiểm tra | Kịch bản kiểm thử | Kết quả (Pass/Fail) | Ghi chú xử lý |
| :--- | :--- | :---: | :--- |
| **Form liên hệ (Fluent Forms)** | Gửi thử thông tin hợp lệ $\rightarrow$ Email thông báo về ngay hộp thư | [Pass/Fail] | |
| **Validation Form** | Bỏ trống email hoặc nhập sai định dạng $\rightarrow$ Hiện thông báo đỏ | [Pass/Fail] | |
| **Luồng Đặt hàng (WooCommerce)** | Chọn sản phẩm $\rightarrow$ Giỏ hàng $\rightarrow$ Thanh toán $\rightarrow$ Sinh mã đơn | [Pass/Fail] | |
| **Thanh toán VietQR** | Quét mã QR hiện đúng số tiền và nội dung đơn hàng | [Pass/Fail] | |
| **Kiểm tra Broken Link (404)** | Quét toàn bộ link nội bộ, không có link chết | [Pass/Fail] | |

---

## 3. Bảng Kiểm định Tốc độ & Kỹ thuật (Technical & Performance QA)

| Tiêu chí kỹ thuật | Chỉ số mục tiêu | Kết quả đo đạc | Đánh giá |
| :--- | :--- | :--- | :---: |
| **Google PageSpeed Mobile** | $\ge 80/100$ | [Điểm thực tế] | [Đạt / Cần tối ưu] |
| **Google PageSpeed Desktop** | $\ge 90/100$ | [Điểm thực tế] | [Đạt / Cần tối ưu] |
| **Định dạng & Dung lượng Ảnh** | Định dạng WebP, dung lượng $< 150\text{KB}$ | [Số lượng ảnh chưa tối ưu] | [Đạt / Cần nén thêm] |
| **F12 Browser Console** | 0 JavaScript Fatal Error | [Log lỗi nếu có] | [Đạt / Sạch lỗi] |
| **PHP Debug Log (`debug.log`)** | 0 PHP Fatal Error / Warning | [Log cảnh báo nếu có] | [Đạt / Sạch log] |

---

## 4. Nhật ký Xử lý Sự cố (Troubleshooting Log)

*(Ghi lại các vấn đề kỹ thuật phát sinh và cách khắc phục trong quá trình build)*

| Mã sự cố | Vấn đề phát hiện | Nguyên nhân gốc rễ | Giải pháp đã xử lý | Trạng thái |
| :---: | :--- | :--- | :--- | :---: |
| `ISSUE-01` | [Ví dụ: Form gửi không nhận được mail] | Hosting chặn hàm `mail()` mặc định của PHP | Cài đặt FluentSMTP kết nối qua Gmail App Password | **Đã xử lý (Fixed)** |
| `ISSUE-02` | [Ví dụ: Vỡ layout slider trên mobile] | Xung đột tính năng Combine JS của plugin Cache | Thêm file JS của slider vào danh sách loại trừ (Exclude JS) | **Đã xử lý (Fixed)** |

# Biên bản Bàn giao & Nghiệm thu Dự án (Handover & Finalize Pack)

> **Tên Dự án / Website:** [Tên Website / Domain chính]  
> **Khách hàng tiếp nhận:** [Tên đại diện khách hàng]  
> **Đơn vị bàn giao:** [Tác giả / Antigravity]  
> **Ngày bàn giao:** [YYYY-MM-DD]  

---

## 1. Biên bản Nghiệm thu & Checklist Dọn dẹp (Cleanup Checklist)

Trước khi bàn giao, hệ thống đã hoàn thành các bước dọn dẹp sau:
- [x] Đã xoá toàn bộ dữ liệu mẫu (Sample pages, dummy posts, dummy comments, demo products).
- [x] Đã gỡ bỏ toàn bộ plugin và theme thử nghiệm không sử dụng.
- [x] Đã dọn dẹp database rác (Post revisions, auto-drafts, transients quá hạn).
- [x] Đã tắt chế độ `WP_DEBUG` và ẩn thông báo lỗi trên giao diện ngoài.
- [x] Đã kích hoạt chứng chỉ bảo mật SSL (HTTPS hiển thị ổ khoá xanh).
- [x] Đã cấu hình chống lập chỉ mục (Search engine visibility) chính xác: Cho phép Google index website.

---

## 2. Thông tin Bản sao lưu Toàn diện (Full Site Backup Info)

* **Thời điểm tạo bản sao lưu:** [YYYY-MM-DD HH:MM]
* **Tên file sao lưu:** `[backup_domain_YYYYMMDD.zip]`
* **Dung lượng file:** `[... MB]`
* **Vị trí lưu trữ an toàn:** [Google Drive / S3 / Thư mục an toàn trên hosting]
* **Công cụ khôi phục khuyến nghị:** [All-in-One WP Migration / Duplicator / Cpanel Restore]

---

## 3. Hướng dẫn Vận hành Dành cho Quản trị viên (Admin Handover Guide)

### A. Đăng nhập & Phân quyền
* **Đường dẫn đăng nhập Admin:** `https://[your-domain]/wp-admin`
* **Quy tắc an toàn:**
  * Luôn sử dụng tài khoản có mật khẩu mạnh (tối thiểu 12 ký tự gồm chữ hoa, thường, số, ký tự đặc biệt).
  * Không chia sẻ tài khoản Administrator cấp cao nhất cho cộng tác viên viết bài (chỉ cấp quyền Editor hoặc Author).

### B. Cách chỉnh sửa Nội dung & Hình ảnh
* **Chỉnh sửa Trang (Pages):** Vào *Trang (Pages)* $\rightarrow$ Chọn trang cần sửa $\rightarrow$ Bấm *Chỉnh sửa* $\rightarrow$ Thay đổi văn bản hoặc ảnh $\rightarrow$ Bấm *Cập nhật*.
* **Đăng Bài viết Mới (Blog/News):** Vào *Bài viết (Posts)* $\rightarrow$ *Viết bài mới* $\rightarrow$ Đặt tiêu đề, nội dung, chọn Chuyên mục (Category), tải Ảnh đại diện (Featured Image) đã nén dưới 150KB $\rightarrow$ Bấm *Đăng*.
* **Xem Form Liên hệ gửi về:** Vào mục *Fluent Forms* $\rightarrow$ Chọn form $\rightarrow$ Bấm *Entries* để xem danh sách khách hàng để lại thông tin.

### C. Khuyến cáo Bảo trì Định kỳ (Maintenance Routine)
1. **Sao lưu dữ liệu định kỳ:** Tối thiểu 1 lần/tuần (đối với site tin tức/công ty) hoặc mỗi ngày (đối với site bán hàng).
2. **Cập nhật Plugin & Theme:**
   * Trước khi bấm cập nhật hàng loạt, hãy luôn tạo một bản sao lưu (backup) nhanh.
   * Cập nhật từng plugin một để nếu có lỗi phát sinh sẽ dễ dàng phát hiện nguyên nhân.

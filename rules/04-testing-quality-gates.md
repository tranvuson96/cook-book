# Tiêu chuẩn Kiểm thử & Cổng Chất lượng (Testing & Quality Gates)

Mỗi đoạn mã nguồn được sinh ra hoặc thay đổi phải vượt qua các cổng chất lượng kiểm thử nghiêm ngặt trước khi coi là hoàn thành tác vụ.

---

## 1. Phân loại Kiểm thử bắt buộc

### A. Unit Tests (Kiểm thử đơn vị)
* **Phạm vi**: Kiểm tra từng hàm, method, class cô lập (isolated).
* **Quy định Mocking**: Mọi phụ thuộc bên ngoài (DB, Network, Clock, External Service, File System) phải được mock hoặc stub bằng interface.
* **Quy tắc 3A (Arrange - Act - Assert)**: Mọi test case phải viết rõ ràng 3 pha.
* **Thời gian thực thi**: Phải chạy cực nhanh (mili-giây), không phụ thuộc môi trường mạng.

### B. Integration Tests (Kiểm thử tích hợp)
* **Phạm vi**: Kiểm tra sự tương tác giữa nhiều thành phần thực tế (Service $\leftrightarrow$ Repository $\leftrightarrow$ Database/Cache).
* **Dữ liệu kiểm thử**: Sử dụng database kiểm thử (in-memory hoặc test container riêng), đảm bảo dữ liệu được rollback hoặc dọn sạch sau mỗi test suite.

---

## 2. Tiêu chuẩn Bao phủ (Test Coverage Criteria)

1. **Happy Path (Luồng hoạt động chuẩn)**: Đảm bảo dữ liệu hợp lệ được xử lý chính xác và trả về kết quả mong đợi.
2. **Edge Cases (Các trường hợp biên)**:
   * Giá trị rỗng (`null`, `undefined`, empty string, empty list).
   * Giá trị cực đại, cực tiểu (boundary values, integer overflow, chuỗi ký tự quá dài).
   * Định dạng dữ liệu không hợp lệ, ký tự đặc biệt, SQL injection / XSS payload strings.
3. **Exception Flows (Xử lý ngoại lệ)**:
   * Xử lý khi DB timeout, lỗi kết nối external service.
   * Xử lý trùng lặp khoá chính (duplicate key), vi phạm ràng buộc dữ liệu.
   * Xử lý khi người dùng không có quyền (Unauthorized/Forbidden).

---

## 3. Điều kiện Nghiệm thu (Definition of Done - DoD)

1. ✅ $100\%$ các test case mới viết phải PASS.
2. ✅ Không làm gãy (regression) bất kỳ test case cũ nào có sẵn trong dự án.
3. ✅ Không còn cảnh báo nghiêm trọng từ Linter/Compiler.
4. ✅ Đã chạy thực tế bằng lệnh terminal và có kết quả test output rõ ràng.

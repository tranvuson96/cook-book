---
name: automated-test-runner
description: >-
  Kỹ năng xây dựng, thực thi và thẩm định các bộ kiểm thử tự động (Unit Test, Integration Test)
  với độ bao phủ cao và kiểm soát chặt chẽ các trường hợp biên (Edge Cases).
---

# Kỹ năng Kiểm thử Tự động (Automated Test Runner)

Kỹ năng này hướng dẫn Antigravity thiết kế và chạy test một cách bài bản, đảm bảo tính ổn định và ngăn ngừa lỗi hồi quy (Regression).

---

## 1. Quy trình Thiết kế Test Suite

Khi hoàn thành phần viết code cho bất kỳ module nào:

1. **Rà soát danh mục chức năng**:
   * Đối chiếu với tài liệu System Design Document (SSD và Usecase).
   * Lập danh sách các kịch bản cần test: Happy Path, Boundary values, Invalid formats, Exception throws.
2. **Viết Unit Tests trước hoặc song song**:
   * Đặt tên test method thể hiện rõ mục đích: `should_return_success_when_payload_is_valid()` hoặc `TestCreateOrder_Success`.
   * Sử dụng cấu trúc 3A: **Arrange** (chuẩn bị mock & dữ liệu) $\rightarrow$ **Act** (gọi hàm kiểm thử) $\rightarrow$ **Assert** (so sánh kết quả và verify số lần gọi mock).
3. **Viết Integration Tests**:
   * Kiểm thử luồng đi qua middleware, controller, service và tương tác với database.
   * Đảm bảo cô lập dữ liệu kiểm thử (mỗi test tự dọn dẹp data của mình).
4. **Chạy test bằng Terminal Tool**:
   * Gọi công cụ terminal (`run_command`) để thực thi test suite thực tế.
   * Nếu có test fail: Phân tích log lỗi, sửa code hoặc test cho tới khi 100% test cases pass.
   * Kiểm tra chỉ số Coverage (dòng lệnh, nhánh điều kiện).

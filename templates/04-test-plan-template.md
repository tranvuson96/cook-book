# Kế hoạch Kiểm thử & Ma trận Test Cases (Test Plan Template)

> **Tên Module:** [Tên Module]  
> **Mục tiêu Coverage:** Tối thiểu 85% Line Coverage, 100% Critical Logic Paths  

---

## 1. Ma trận Kịch bản Kiểm thử Đơn vị (Unit Test Matrix)

| Test ID | Thành phần / Hàm kiểm thử | Kịch bản / Input | Kết quả kỳ vọng | Phân loại |
| :---: | :--- | :--- | :--- | :---: |
| `UT-01` | `OrderService.createOrder` | Payload hợp lệ, tồn kho đủ, thanh toán thành công | Tạo đơn hàng trạng thái `CONFIRMED`, lưu DB, gửi event | Happy Path |
| `UT-02` | `OrderService.createOrder` | Payload thiếu thông tin người nhận hàng | Ném `ValidationException`, không gọi DB ghi | Edge Case |
| `UT-03` | `OrderService.createOrder` | Số lượng tồn kho < số lượng yêu cầu | Ném `InsufficientStockException`, rollback | Exception |
| `UT-04` | `OrderService.createOrder` | Cổng thanh toán timeout / ngắt kết nối | Đơn lưu trạng thái `PENDING_RETRY`, ném cảnh báo | Exception |
| `UT-05` | `Order.calculateTotal` | Giỏ hàng có 10 items với các mức thuế VAT khác nhau | Tổng tiền tính chính xác đến chữ số thập phân | Boundary |

---

## 2. Ma trận Kịch bản Kiểm thử Tích hợp (Integration Test Matrix)

| Test ID | Luồng tích hợp (Flow) | Thành phần tham gia | Điều kiện kiểm thử | Kết quả kỳ vọng |
| :---: | :--- | :--- | :--- | :--- |
| `IT-01` | API `POST /api/v1/orders` | Controller $\rightarrow$ Service $\rightarrow$ DB | Gửi HTTP request có JWT token hợp lệ | HTTP 201 Created, bản ghi tồn tại trong Test DB |
| `IT-02` | API `POST /api/v1/orders` | Controller $\rightarrow$ Security Middleware | Không truyền Bearer Token hoặc token hết hạn | HTTP 401 Unauthorized |
| `IT-03` | Rollback Transaction | Service $\rightarrow$ Repository $\rightarrow$ DB | Lỗi phát sinh ở bước ghi bảng phụ (OrderItem) | Bảng chính (Order) tự động rollback, DB sạch |

---

## 3. Lệnh thực thi & Đánh giá kết quả

* **Lệnh chạy Unit Test:** `[npm test / go test -v ./... / pytest]`
* **Lệnh đo Coverage:** `[npm run test:cov / go test -cover / pytest --cov]`
* **Tiêu chuẩn vượt qua:**
  * Toàn bộ các test cases đều PASS (0 failure).
  * Không có memory leak hoặc unhandled promise rejections.

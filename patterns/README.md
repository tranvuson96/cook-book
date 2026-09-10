# Cẩm Nang Mẫu Thiết Kế Theo Từng Ngôn Ngữ (Design Patterns by Language)

Thư mục này tổng hợp các bài toán nghiệp vụ thực tế (Real-World Business Cases) và cách áp dụng các **Mẫu Thiết Kế (Design Patterns)** chuẩn mực trên 4 ngôn ngữ lập trình phổ biến nhất hiện nay: **PHP**, **TypeScript**, **Go (Golang)** và **Python**.

---

## 🧭 Ma trận Tra cứu Nhanh Bài toán & Pattern

| Bài toán Nghiệp vụ Thực tế | Pattern Khuyến nghị | File Chi tiết | Ngôn ngữ hỗ trợ |
| :--- | :--- | :--- | :--- |
| **Cổng thanh toán đa kênh** (VnPay, MoMo, Stripe, ZaloPay) | **Factory Method + Adapter** | [01-creational-cases.md](./01-creational-cases.md)<br/>[02-structural-cases.md](./02-structural-cases.md) | PHP, TS, Go, Python |
| **Khởi tạo đối tượng phức tạp / Query Builder** | **Builder / Functional Options** | [01-creational-cases.md](./01-creational-cases.md) | PHP, TS, Go, Python |
| **Tính phí ship & chính sách giảm giá linh hoạt** | **Strategy Pattern** | [03-behavioral-cases.md](./03-behavioral-cases.md) | PHP, TS, Go, Python |
| **Tự động thêm Cache & Log không sửa code gốc** | **Decorator Pattern** | [02-structural-cases.md](./02-structural-cases.md) | PHP, TS, Go, Python |
| **Pipeline kiểm duyệt chống gian lận (Fraud Check)** | **Chain of Responsibility** | [03-behavioral-cases.md](./03-behavioral-cases.md) | PHP, TS, Go, Python |
| **Sự kiện sau thanh toán** (Trừ kho, gửi mail, push socket) | **Observer / Domain Events** | [03-behavioral-cases.md](./03-behavioral-cases.md) | PHP, TS, Go, Python |
| **Quản lý vòng đời đơn hàng** (Draft -> Paid -> Shipped) | **State Pattern** | [03-behavioral-cases.md](./03-behavioral-cases.md) | PHP, TS, Go, Python |
| **Tích hợp hệ thống con phức tạp thành 1 điểm gọi** | **Facade Pattern** | [02-structural-cases.md](./02-structural-cases.md) | PHP, TS, Go, Python |

---

## 📚 Danh mục Tài liệu

1. **[01-creational-cases.md](./01-creational-cases.md)**:
   * Case 1: Khởi tạo Cổng thanh toán (Factory Method)
   * Case 2: Xây dựng Cấu hình & Báo cáo phức tạp (Builder & Functional Options trong Go)
   * Case 3: Quản lý Tài nguyên Dùng chung (Singleton & Thread-safety)
2. **[02-structural-cases.md](./02-structural-cases.md)**:
   * Case 1: Tích hợp SDK Đối tác không cùng chuẩn (Adapter)
   * Case 2: Bọc Caching, Logging, Retry trong suốt (Decorator)
   * Case 3: Đóng gói Quy trình Thanh toán Toàn diện (Facade)
   * Case 4: Cây Phân cấp Danh mục & Tổ chức Đa cấp (Composite)
3. **[03-behavioral-cases.md](./03-behavioral-cases.md)**:
   * Case 1: Công cụ Tính phí Vận chuyển & Chiết khấu (Strategy)
   * Case 2: Luồng Sự kiện Bất đồng bộ sau Mua hàng (Observer / Pub-Sub)
   * Case 3: Máy Trạng thái Đơn hàng Chống Nhảy cóc (State)
   * Case 4: Chuỗi Middleware & Kiểm duyệt Gian lận Đa tầng (Chain of Responsibility)
4. **[04-language-idioms.md](./04-language-idioms.md)**:
   * Đặc thù triển khai Pattern chuẩn theo triết lý từng ngôn ngữ:
     * **PHP (8.x)**: Typed Properties, Match Expression, Constructor Promotion, Attributes.
     * **TypeScript**: Structural Typing, Generics, First-class Functions, Method Decorators.
     * **Go (Golang)**: Composition over Inheritance, Implicit Interfaces, Functional Options, Goroutines/Channels.
     * **Python (3.10+)**: Protocols (`typing.Protocol`), Closures/Decorators, Dataclasses, Duck Typing.

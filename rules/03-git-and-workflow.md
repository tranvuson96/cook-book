# Tiêu chuẩn Git & Quy trình Phối hợp Đội ngũ (Git Conventions & Team Collaboration)

Tài liệu này định nghĩa quy chuẩn quản lý mã nguồn, chiến lược phân nhánh khi làm việc nhiều người (Multi-Developer Workflow), quy trình Rebase bắt buộc trước khi tạo PR và quy chuẩn commit message.

---

## 1. Thiết lập Hệ thống Nhánh khi Khởi tạo Dự án (Git Init & Branch Strategy)

Khi khởi tạo hoặc thiết lập bất kỳ repository nào cho đội ngũ, **bắt buộc phải xác định rõ 3 nhánh chính (Core Branches)**:

```
                  ┌──────────────┐
                  │ main / prod  │ ──► Deploy Production (Live / Tag vX.Y.Z)
                  └──────▲───────┘
                         │ Merge sau khi nghiệm thu UAT
                  ┌──────┴───────┐
                  │   staging    │ ──► Deploy Staging / UAT (Kiểm thử tiền phát hành)
                  └──────▲───────┘
                         │ Merge sau Sprint / Test tích hợp
                  ┌──────┴───────┐
                  │ dev / develop│ ──► Nhánh trung tâm của Developers (Integration)
                  └──────▲───────┘
                         │ Rebase & PR
         ┌───────────────┼───────────────┐
         │               │               │
┌────────┴───────┐┌──────┴───────┐┌──────┴───────┐
│ feature/auth   ││ feature/cart ││ bugfix/header│ ──► Các nhánh phụ (Working Branches)
└────────────────┘└──────────────┘└──────────────┘
```

### A. Hệ thống Nhánh Chính (Core Branches - Được bảo vệ / Protected):
1. **`main` (hoặc `production`)**:
   * **Mục đích**: Nhánh chính thức, chứa mã nguồn ổn định nhất đang chạy thực tế trên môi trường Production.
   * **Quy định**: Tuyệt đối **KHÔNG** commit hoặc push trực tiếp vào `main`. Chỉ nhận code thông qua PR được merge từ nhánh `staging` (hoặc nhánh `hotfix/`).
   * **Release Tag**: Mỗi lần deploy lên Production phải gắn tag phiên bản theo chuẩn SemVer (vd: `v1.0.0`, `v1.1.0`).
2. **`staging`**:
   * **Mục đích**: Môi trường tiền phát hành (Pre-production / UAT). Tích hợp các tính năng đã hoàn thiện từ `dev` để đội QA/PO kiểm thử nghiệm thu toàn diện trước khi release.
3. **`dev` (hoặc `develop`)**:
   * **Mục đích**: Nhánh làm việc trung tâm của đội ngũ lập trình (Integration branch). Nơi hội tụ toàn bộ các tính năng mới sau khi đã vượt qua code review.

### B. Hệ thống Nhánh Phụ (Working / Ephemeral Branches):
* `feature/<mã-ticket-hoặc-tên-tính-năng>`: Tách từ `dev` để phát triển tính năng mới (vd: `feature/order-tracking`, `feature/ABC-12-vietqr`).
* `bugfix/<mã-lỗi>`: Tách từ `dev` hoặc `staging` để sửa lỗi phát hiện trong quá trình kiểm thử nội bộ.
* `hotfix/<mã-lỗi>`: Tách trực tiếp từ `main` để vá lỗi khẩn cấp trên Production. Sau khi vá xong, phải merge/rebase vào cả `main`, `staging` và `dev`.
* `refactor/<tên-module>`: Tái cấu trúc code nội bộ, không làm thay đổi hành vi người dùng.

---

## 2. Quy trình Rebase Bắt Buộc Trước Khi Tạo Pull Request (PR)

> **NGUYÊN TẮC VÀNG:** *"Rebase at Local, Never Push Conflicts"*  
> Trước khi push code và tạo PR vào bất kỳ nhánh chính nào (`dev`, `staging`), lập trình viên **BẮT BUỘC** phải chạy `git rebase` với nhánh đích mới nhất tại máy local để xử lý conflict và giữ lịch sử commit thẳng (Linear Git History).

### Các bước thực hiện chuẩn:

```bash
# Bước 1: Commit toàn bộ công việc trên nhánh làm việc hiện tại
git checkout feature/my-feature
git add .
git commit -m "feat(module): add user profile update logic"

# Bước 2: Kéo toàn bộ dữ liệu mới nhất từ remote server về
git fetch origin

# Bước 3: Thực hiện Rebase nhánh làm việc của mình trên nền nhánh đích mới nhất (ví dụ: dev)
git rebase origin/dev

# ── NẾU CÓ XUNG ĐỘT (CONFLICT) XẢY RA ──
# a. Mở file xung đột, kiểm tra và chỉnh sửa giữ lại code chính xác.
# b. Đánh dấu file đã giải quyết conflict:
git add <file-da-giai-quyet>
# c. Tiếp tục quá trình rebase:
git rebase --continue
# (Lặp lại cho đến khi rebase hoàn tất thành công)
# (Lưu ý: Tuyệt đối KHÔNG dùng 'git commit' trong khi đang rebase)

# Bước 4: Chạy kiểm thử tự động tại Local sau khi Rebase
# Đảm bảo code vẫn build thành công và 100% test cases đều pass sau khi ghép code mới
npm test   # hoặc: go test ./... / pytest

# Bước 5: Push code lên Remote
# Nếu nhánh này chưa từng push lên remote:
git push -u origin feature/my-feature
# Nếu nhánh đã từng push trước đó, dùng cờ an toàn --force-with-lease:
git push origin feature/my-feature --force-with-lease

# Bước 6: Tạo Pull Request (PR) trên GitHub / GitLab
# Tiêu đề PR tuân thủ Conventional Commits
# Chọn Base branch chính xác (thường là dev)
```

### Tại sao phải Rebase thay vì Merge Commit?
1. **Lịch sử Git sạch đẹp & thẳng tắp**: Không sinh ra hàng loạt commit rác tự động như `Merge branch 'dev' of ... into ...`.
2. **Dễ dàng bóc tách lỗi**: Khi có bug, dễ dàng dùng `git bisect` để tìm chính xác commit gây lỗi mà không bị rối loạn bởi các nút merge chằng chịt.
3. **Chủ động xử lý conflict**: Lập trình viên tự tay giải quyết conflict trên máy của mình trước khi đồng nghiệp review code.

---

## 3. Quy ước Commit Message (Conventional Commits)

Định dạng chuẩn:
```text
<type>(<scope>): <mô tả ngắn gọn bằng thể mệnh lệnh, chữ thường>

[Body tùy chọn mô tả chi tiết lý do và bối cảnh thay đổi]

[Footer tùy chọn ghi mã ticket/issue: e.g., Closes #123]
```

### Danh sách Types hợp lệ:
* `feat`: Thêm tính năng mới.
* `fix`: Sửa lỗi.
* `refactor`: Tái cấu trúc code (không đổi chức năng, không sửa lỗi).
* `perf`: Cải thiện hiệu năng xử lý.
* `test`: Bổ sung hoặc cập nhật test cases.
* `docs`: Cập nhật tài liệu, README, schemas.
* `chore`: Thay đổi cấu hình build, dependencies, tooling.

### Ví dụ hợp lệ:
```text
feat(auth): implement jwt refresh token rotation mechanism
fix(payment): resolve race condition in concurrent wallet balance deduction
test(order): add integration tests for checkout edge cases
chore(deps): update licespeed cache extension to v6.1
```

---

## 4. Quy tắc An toàn khi Thực thi Lệnh Git & Terminal (Safety Guardrails)

Antigravity và các thành viên trong đội ngũ phải tuân thủ nghiêm ngặt các rào chắn an toàn:
1. **Tuyệt đối KHÔNG chạy `git push --force` (`-f`)** lên các nhánh chính (`main`, `staging`, `dev`). Cờ `--force-with-lease` chỉ được phép dùng trên nhánh cá nhân (`feature/*`, `bugfix/*`) sau khi đã rebase.
2. **Không chạy `git reset --hard` hoặc `git clean -fd`** khi trong working directory đang có thay đổi chưa được commit hoặc stash.
3. **Mọi PR phải có ít nhất 1 thành viên review và approve**, đồng thời toàn bộ CI/CD Pipeline phải Passed thì mới được phép merge.

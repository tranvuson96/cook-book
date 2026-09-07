# Antigravity Cook-Book 🚀

> **Bộ khung quy chuẩn, kịch bản nghiệp vụ (Skills), tài liệu mẫu (Templates) và hồ sơ tác nhân (Personas) giúp Antigravity, Claude Code và OpenAI Codex/Cursor vận hành nhất quán, bài bản và chuyên nghiệp theo chuẩn kỹ thuật cao.**

---

## ⚡ NGUYÊN TẮC BẮT BUỘC: ZERO ASSUMPTIONS (HỎI TRƯỚC KHI THỰC THI)

> **"Không tự ý suy diễn — Nghiệp vụ phải sáng tỏ trước khi viết code hay dựng site."**  
> Dù vận hành ở bất kỳ mô hình nào, AI Assistant **BẮT BUỘC** phải rà soát, chỉ ra các điểm xám/mơ hồ về nghiệp vụ, đặt câu hỏi cho người dùng kèm đề xuất phương án (Option A/B) và chỉ bắt tay vào thực thi khi đã có xác nhận rõ ràng.

---

## 🌟 Kiến trúc 2 Mô hình Song song (Dual-Track Architecture)

Cookbook này được thiết kế linh hoạt với **2 chế độ vận hành độc lập**, đáp ứng cả nhu cầu kỹ thuật phần mềm chuyên sâu lẫn nhu cầu xây dựng/vận hành website thực tế:

```
                                  ┌──────────────────────────────┐
                                  │   ANTIGRAVITY COOKBOOK       │
                                  └──────────────┬───────────────┘
                                                 │
                                                 ▼
             ┌────────────────────────────────────────────────────────────────────────┐
             │  BƯỚC 0: RÀ SOÁT ĐIỂM XÁM & HỎI XÁC NHẬN NGHIỆP VỤ TRƯỚC KHI THỰC THI  │
             │  (Zero Assumptions - Phát hiện câu hỏi nghiệp vụ & chốt phương án)     │
             └───────────────────────────────────┬────────────────────────────────────┘
                                                 │
            ┌────────────────────────────────────┴────────────────────────────────────┐
            ▼                                                                         ▼
┌──────────────────────────────────────────────┐               ┌──────────────────────────────────────────────┐
│  TRACK 1: SOFTWARE & MODULE ENGINEERING      │               │     TRACK 2: WORDPRESS SITE & CONTENT OPS    │
│       (Khi phát triển module / plugin code)  │               │      (80% công việc WordPress thực chiến)    │
├──────────────────────────────────────────────┤               ├──────────────────────────────────────────────┤
│ 1. Viết User Story kịch bản thực tế          │               │ 1. Nhận & Phân tích yêu cầu (Brief & Vibe)   │
│ 2. Phân tích thiết kế (UML, Class, SSD, DP)  │               │ 2. Research Plugins & Theme ra giải pháp     │
│ 3. Xây dựng Coding Guideline riêng           │               │ 3. Tinh chỉnh Content chuẩn Vibe & SEO       │
│ 4. Thực thi viết code theo chuẩn             │               │ 4. Kiểm định (QA) & Xử lý sự cố phát sinh    │
│ 5. Viết Unit Test & Integration Test (>=85%) │               │ 5. Finalize: Dọn dẹp, Backup & Bàn giao      │
└──────────────────────────────────────────────┘               └──────────────────────────────────────────────┘
```

---

## 📂 Cấu trúc Repository

```text
cook-book/
├── README.md                          # Hướng dẫn tổng quan, cài đặt & tích hợp đa nền tảng
├── install.sh                         # Script cài đặt & liên kết tự động một chạm
├── rules/                             # Các quy tắc cốt lõi (Core Rules)
│   ├── 01-module-creation-rules.md    # [Track 1] Quy tắc tạo module phần mềm (kèm Bước 0 làm rõ điểm xám)
│   ├── 02-architecture-standards.md   # [Track 1] Tiêu chuẩn kiến trúc (Business Clarity First, SOLID)
│   ├── 03-git-and-workflow.md         # Quy chuẩn Git, commit, branching và terminal safety
│   ├── 04-testing-quality-gates.md    # [Track 1] Tiêu chuẩn kiểm thử & coverage
│   └── 05-wordpress-site-workflow-rules.md # [Track 2] Quy tắc vận hành dự án WordPress thực chiến
│
├── templates/                         # Mẫu tài liệu chuẩn (Markdown Artifacts)
│   ├── 01-user-story-template.md      # [Track 1] Mẫu User Story (kèm bảng làm rõ điểm xám nghiệp vụ)
│   ├── 02-system-design-template.md   # [Track 1] Mẫu Phân tích thiết kế (Class Diagram, SSD Mermaid)
│   ├── 03-coding-guideline-template.md# [Track 1] Mẫu Coding Guideline cho module
│   ├── 04-test-plan-template.md       # [Track 1] Mẫu ma trận Unit & Integration test
│   └── wordpress/                     # [Track 2] Thư mục Templates chuyên biệt cho WordPress
│       ├── 01-client-brief-template.md           # Khảo sát yêu cầu, điểm xám & định vị Vibe
│       ├── 02-plugin-theme-solution-template.md  # Đề xuất giải pháp Theme & Plugins
│       ├── 03-content-and-vibe-template.md       # Tinh chỉnh Content & Copywriting theo Vibe
│       ├── 04-site-audit-and-qa-template.md      # Checklist kiểm thử giao diện, chức năng, tốc độ
│       └── 05-handover-and-finalize-template.md  # Biên bản bàn giao & dọn dẹp hệ thống
│
├── skills/                            # Thư viện Skills chuyên biệt (Progressive Disclosure)
│   ├── module-creation/               # [Track 1] Quy trình tự động hoá tạo module code
│   ├── design-pattern-advisor/        # [Track 1] Tư vấn, so sánh ưu/nhược điểm Design Patterns
│   ├── automated-test-runner/         # [Track 1] Hướng dẫn thiết lập Unit & Integration Test
│   └── wordpress-site-builder/        # [Track 2] Điều phối quy trình xây dựng site WordPress
│
├── personas/                          # Hồ sơ Subagents chuyên trách
│   ├── system-analyst.md              # [Track 1] Chuyên viên phân tích nghiệp vụ & làm rõ điểm xám
│   ├── software-architect.md          # [Track 1] Kiến trúc sư phần mềm & tối ưu mẫu thiết kế
│   ├── test-engineer.md               # [Track 1] Kỹ sư kiểm thử tự động
│   └── wordpress-strategist.md        # [Track 2] Chuyên gia giải pháp & Content Director WordPress
│
└── configs/                           # Mẫu cấu hình tích hợp sẵn cho các AI Agents
    ├── CLAUDE.sample.md               # File mẫu hướng dẫn cho Anthropic Claude Code
    ├── AGENTS.sample.md               # File mẫu cho OpenAI Codex / Copilot / Cursor
    ├── GEMINI.sample.md               # File mẫu cho Google Antigravity / Gemini CLI
    ├── hooks.sample.json              # Hook tự động kiểm tra code quality & an toàn
    └── mcp_config.sample.json         # Cấu hình tích hợp công cụ qua MCP (DB, Git...)
```

---

## 📥 Hướng Dẫn Cài Đặt (Installation & Setup)

### Cách 1: Cài đặt tự động qua Script (Khuyến nghị)
Chỉ cần chạy file `install.sh` ngay trong thư mục repository:

```bash
cd /path/to/cook-book
bash install.sh
```

Menu tương tác sẽ hiển thị để bạn chọn công cụ mong muốn:
* `1` - Tích hợp cho **Google Antigravity** (tự động tạo symlink skills vào `~/.gemini/antigravity/skills/` và tạo `GEMINI.md`).
* `2` - Tích hợp cho **Anthropic Claude Code** (tạo `CLAUDE.md`).
* `3` - Tích hợp cho **OpenAI Codex / Copilot / Cursor** (tạo `AGENTS.md`, `.cursorrules` và `.github/copilot-instructions.md`).
* `4` - Tích hợp **TẤT CẢ** các công cụ trên vào dự án hiện tại.

Bạn cũng có thể chỉ định dự án đích trực tiếp bằng dòng lệnh:
```bash
# Cài đặt cho một dự án cụ thể ở thư mục khác:
bash install.sh /home/username/code/my-new-project --all
```

---

### Cách 2: Cài đặt thủ công từng bước

#### 1. Dành cho Google Antigravity (AGY):
* **Liên kết Skills**:
  ```bash
  mkdir -p ~/.gemini/antigravity/skills
  ln -sfn /path/to/cook-book/skills/* ~/.gemini/antigravity/skills/
  ```
* **Cấu hình Quy tắc Dự án**: Copy file mẫu `configs/GEMINI.sample.md` vào thư mục gốc của dự án bạn đang làm và đổi tên thành `GEMINI.md`:
  ```bash
  cp /path/to/cook-book/configs/GEMINI.sample.md /path/to/my-project/GEMINI.md
  ```

#### 2. Dành cho Anthropic Claude Code (`claude`):
* Copy file `configs/CLAUDE.sample.md` vào thư mục dự án với tên `CLAUDE.md`:
  ```bash
  cp /path/to/cook-book/configs/CLAUDE.sample.md /path/to/my-project/CLAUDE.md
  ```
* Hoặc cài đặt toàn cục (Global Memory) cho mọi dự án:
  ```bash
  mkdir -p ~/.claude
  cp /path/to/cook-book/configs/CLAUDE.sample.md ~/.claude/CLAUDE.md
  ```

#### 3. Dành cho OpenAI Codex / GitHub Copilot / Cursor:
* **Cursor IDE**: Copy `configs/AGENTS.sample.md` vào `.cursorrules` hoặc `.cursor/rules/cookbook.mdc`:
  ```bash
  cp /path/to/cook-book/configs/AGENTS.sample.md /path/to/my-project/.cursorrules
  ```
* **GitHub Copilot Workspace**:
  ```bash
  mkdir -p /path/to/my-project/.github
  cp /path/to/cook-book/configs/AGENTS.sample.md /path/to/my-project/.github/copilot-instructions.md
  ```
* **OpenAI Codex / CLI Agents chuẩn mở**:
  ```bash
  cp /path/to/cook-book/configs/AGENTS.sample.md /path/to/my-project/AGENTS.md
  ```

---

## 🤖 Hướng Dẫn Sử Dụng Chi Tiết Với Từng AI Agent

### 1. Sử dụng với Google Antigravity (AGY)
* **Kích hoạt tự động**: Khi mở workspace dự án đã có file `GEMINI.md`, Antigravity tự động tải các quy tắc cốt lõi và thư viện skills.
* **Câu lệnh mẫu cho Track 1 (Phần mềm / Module)**:
  > *"Hãy kích hoạt skill `module-creation`. Tôi muốn xây dựng module 'Quản lý Ví điểm thưởng Loyalty'. Hãy bắt đầu từ Bước 0: rà soát các điểm xám nghiệp vụ và hỏi tôi trước khi viết code."*
* **Câu lệnh mẫu cho Track 2 (WordPress thực chiến)**:
  > *"Hãy dùng skill `wordpress-site-builder` và persona `wordpress-strategist`. Tôi cần xây dựng website bán dụng cụ thể thao Pickleball theo vibe năng động, trẻ trung. Rà soát các điểm xám về thanh toán VietQR và chính sách đặt trước rồi hỏi tôi trước khi cài đặt."*

---

### 2. Sử dụng với Anthropic Claude Code (`claude`)
* **Cách vận hành**: Khi bạn chạy lệnh `claude` tại thư mục dự án, Claude Code sẽ tự động đọc file `CLAUDE.md` và hiểu rằng nó phải tuân thủ nguyên tắc Zero Assumptions của Cookbook.
* **Câu lệnh mẫu trong terminal Claude Code**:
  ```text
  > Áp dụng quy chuẩn rules/01-module-creation-rules.md trong cook-book. Tôi cần tạo API xác thực 2 lớp (2FA). Hãy chỉ ra các kịch bản biên và câu hỏi nghiệp vụ cần làm rõ trước.
  ```
* **Chế độ kiểm thử**:
  ```text
  > Sau khi viết xong code, hãy đối chiếu với rules/04-testing-quality-gates.md và chạy toàn bộ unit test trên terminal.
  ```

---

### 3. Sử dụng với OpenAI Codex / GitHub Copilot / Cursor
* **Cách vận hành**: File `AGENTS.md` hoặc `.cursorrules` đóng vai trò là System Context cố định. Bất kể bạn dùng chế độ Composer, Chat hay Agent mode trong Cursor / Copilot, AI sẽ tự động bị ràng buộc bởi các quy định kỹ thuật.
* **Câu lệnh mẫu (Prompting)**:
  > *"Theo chuẩn trong `AGENTS.md`, hãy lập tài liệu phân tích Usecase và Class Diagram Mermaid cho tính năng Hủy đơn hàng tự động. Nhớ liệt kê các trường hợp ngoại lệ và hỏi xác nhận từ tôi trước khi sinh mã nguồn."*

---

## 🛠️ Phân Định Trách Nhiệm: Khi Nào Dùng Track 1 vs Track 2?

| Tiêu chí | Track 1: Software & Module Engineering | Track 2: WordPress Site & Content Operations |
| :--- | :--- | :--- |
| **Bối cảnh sử dụng** | Viết module phần mềm, custom plugin PHP/Node/Go/Python, xây dựng REST API, hệ thống microservice phức tạp. | Làm website cho khách hàng, cấu hình Theme/Plugin, dựng landing page, tối ưu SEO on-page, tinh chỉnh content đúng vibe thương hiệu. |
| **Quy trình áp dụng** | 0. Rà soát điểm xám $\rightarrow$ 1. User Story $\rightarrow$ 2. Phân tích thiết kế (UML, SSD, Design Pattern) $\rightarrow$ 3. Coding Guideline $\rightarrow$ 4. Implementation $\rightarrow$ 5. Unit & Integration Test ($\ge 85\%$). | 0. Rà soát điểm xám $\rightarrow$ 1. Client Brief & Vibe $\rightarrow$ 2. Solution Research (Plugin stack) $\rightarrow$ 3. Tinh chỉnh Content $\rightarrow$ 4. QA 4 lớp (PageSpeed $\ge 90$, 0 JS error) $\rightarrow$ 5. Bàn giao & Backup. |
| **Skill tương ứng** | `module-creation`, `design-pattern-advisor`, `automated-test-runner` | `wordpress-site-builder` |
| **Persona hỗ trợ** | `system-analyst`, `software-architect`, `test-engineer` | `wordpress-strategist` |

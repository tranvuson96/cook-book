# Antigravity Cook-Book 🚀

> **Bộ khung quy chuẩn, kịch bản nghiệp vụ (Skills), tài liệu mẫu (Templates) và hồ sơ tác nhân (Personas) giúp Antigravity vận hành nhất quán, bài bản và chuyên nghiệp theo chuẩn kỹ thuật cao.**

---

## ⚡ NGUYÊN TẮC BẮT BUỘC: ZERO ASSUMPTIONS (HỎI TRƯỚC KHI THỰC THI)

> **"Không tự ý suy diễn - Làm rõ các điểm xám nghiệp vụ trước khi viết code hay dựng site."**  
> Dù vận hành ở bất kỳ mô hình nào, Antigravity **BẮT BUỘC** phải rà soát, chỉ ra các điểm xám/mơ hồ về nghiệp vụ, đặt câu hỏi cho người dùng kèm đề xuất phương án (Option A/B) và chỉ bắt tay vào thực thi khi đã có xác nhận rõ ràng.

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
├── README.md                          # Hướng dẫn tổng quan
├── rules/                             # Các quy tắc cốt lõi (Core Rules)
│   ├── 01-module-creation-rules.md    # [Track 1] Quy tắc tạo module phần mềm (có bước làm rõ điểm xám)
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
└── configs/                           # Mẫu cấu hình tự động hoá
    ├── hooks.sample.json              # Hook tự động kiểm tra code quality & an toàn
    └── mcp_config.sample.json         # Cấu hình tích hợp công cụ qua MCP (DB, Git...)
```

---

## 🛠️ Hướng dẫn Sử dụng

### Khi nào dùng Track 1 (Software Engineering)?
* Khi bạn phát triển một module phần mềm độc lập, viết một Custom Plugin từ đầu cho WordPress với logic phức tạp, hoặc xây dựng hệ thống REST API / Microservice.
* Kích hoạt skill: `module-creation` hoặc yêu cầu: *"Hãy phân tích và viết module X theo chuẩn các bước"*.

### Khi nào dùng Track 2 (WordPress Site Operations)?
* Khi bạn nhận dự án làm website cho khách hàng, cấu hình Theme/Plugin, lên wireframe content, viết bài chuẩn SEO theo vibe thương hiệu, hoặc tối ưu tốc độ/bảo mật.
* Kích hoạt skill: `wordpress-site-builder` hoặc yêu cầu: *"Tôi cần làm website WordPress về lĩnh vực X cho khách, hãy bắt đầu từ bước nhận yêu cầu"*.

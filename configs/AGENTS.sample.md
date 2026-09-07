# Agent Guidelines (Antigravity Cook-Book Integration for Codex / Copilot / Cursor)

> File mẫu này dùng để đặt tại thư mục gốc dự án của bạn với tên `AGENTS.md` (hoặc `.cursorrules` / `.github/copilot-instructions.md`).

---

## ⚡ MANDATORY RULE: ZERO ASSUMPTIONS (CONFIRM BEFORE EXECUTION)
- Never make assumptions regarding underspecified business logic, unclear edge cases, or ambiguous requirements.
- Always identify "gray areas" first.
- Formulate clear questions with practical options (Option A / Option B with pros & cons) and obtain explicit user approval before modifying files, creating database schemas, or writing code.

---

## 📐 ENGINEERING STANDARDS

### Software Engineering Lifecycle (Track 1)
Reference: `[Path to cook-book]/rules/01-module-creation-rules.md`
- Step 0: Clarify gray areas & confirm with user.
- Step 1: User Story with Acceptance Criteria (Given-When-Then).
- Step 2: System Analysis (Usecases, Entity Analysis, Class Diagram & SSD in Mermaid, Design Pattern tradeoffs).
- Step 3: Module-specific Coding Guideline.
- Step 4: Strict implementation conforming to SOLID, Clean Architecture.
- Step 5: Comprehensive Unit & Integration Tests (Coverage >= 85%, all tests passing).

### WordPress & Content Operations (Track 2)
Reference: `[Path to cook-book]/rules/05-wordpress-site-workflow-rules.md`
- Step 0: Clarify business & operational gray areas.
- Step 1: Client Brief & Vibe analysis.
- Step 2: Optimal Theme & Plugin stack evaluation.
- Step 3: Copywriting aligned with brand vibe & On-page SEO.
- Step 4: 4-layer QA (Visual, Functional, Technical PageSpeed >= 90, 0 JS/PHP errors).
- Step 5: Full backup, cleanup dummy data, and admin handover.

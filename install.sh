#!/usr/bin/env bash
# ==============================================================================
# Antigravity Cook-Book Quick Setup Script
# Tự động hóa tích hợp Cook-Book vào Google Antigravity, Claude Code, Codex/Cursor
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_PROJECT="${1:-.}"

echo "========================================================"
echo "🚀 Antigravity Cook-Book Setup Assistant"
echo "📂 Cookbook Location: $SCRIPT_DIR"
echo "🎯 Target Project:    $(cd "$TARGET_PROJECT" && pwd)"
echo "========================================================"

show_menu() {
    echo ""
    echo "Chọn công cụ AI bạn muốn cài đặt tích hợp:"
    echo "1) Google Antigravity (AGY) - Nạp Skills & GEMINI.md"
    echo "2) Anthropic Claude Code    - Tạo CLAUDE.md"
    echo "3) OpenAI Codex / Copilot / Cursor - Tạo AGENTS.md & .cursorrules"
    echo "4) Cài đặt TẤT CẢ (All AI Assistants)"
    echo "5) Thoát (Exit)"
    echo ""
    read -p "Lựa chọn của bạn [1-5]: " choice
    case "$choice" in
        1) setup_antigravity ;;
        2) setup_claude ;;
        3) setup_codex ;;
        4) setup_all ;;
        5) exit 0 ;;
        *) echo "Lựa chọn không hợp lệ!"; exit 1 ;;
    esac
}

setup_antigravity() {
    echo ""
    echo "⚙️ Đang cấu hình cho Google Antigravity..."
    # 1. Symlink skills to global gemini skills if directory exists
    GEMINI_SKILLS_DIR="$HOME/.gemini/antigravity/skills"
    mkdir -p "$GEMINI_SKILLS_DIR"
    for skill in "$SCRIPT_DIR/skills"/*; do
        if [ -d "$skill" ]; then
            sname=$(basename "$skill")
            ln -sfn "$skill" "$GEMINI_SKILLS_DIR/$sname"
            echo "   ✅ Linked skill: $sname -> $GEMINI_SKILLS_DIR/$sname"
        fi
    done

    # 2. Copy sample GEMINI.md to target project
    sed "s|\[Đường dẫn tới cook-book\]|$SCRIPT_DIR|g" "$SCRIPT_DIR/configs/GEMINI.sample.md" > "$TARGET_PROJECT/GEMINI.md"
    echo "   ✅ Created $TARGET_PROJECT/GEMINI.md"
    echo "🎉 Hoàn tất tích hợp Google Antigravity!"
}

setup_claude() {
    echo ""
    echo "⚙️ Đang cấu hình cho Anthropic Claude Code..."
    sed "s|\[Đường dẫn tới cook-book\]|$SCRIPT_DIR|g" "$SCRIPT_DIR/configs/CLAUDE.sample.md" > "$TARGET_PROJECT/CLAUDE.md"
    echo "   ✅ Created $TARGET_PROJECT/CLAUDE.md"
    echo "🎉 Hoàn tất tích hợp Claude Code!"
}

setup_codex() {
    echo ""
    echo "⚙️ Đang cấu hình cho OpenAI Codex / Copilot / Cursor..."
    sed "s|\[Path to cook-book\]|$SCRIPT_DIR|g" "$SCRIPT_DIR/configs/AGENTS.sample.md" > "$TARGET_PROJECT/AGENTS.md"
    echo "   ✅ Created $TARGET_PROJECT/AGENTS.md"
    
    # Cursor rules
    cp "$TARGET_PROJECT/AGENTS.md" "$TARGET_PROJECT/.cursorrules"
    echo "   ✅ Created $TARGET_PROJECT/.cursorrules"

    # Copilot instructions
    mkdir -p "$TARGET_PROJECT/.github"
    cp "$TARGET_PROJECT/AGENTS.md" "$TARGET_PROJECT/.github/copilot-instructions.md"
    echo "   ✅ Created $TARGET_PROJECT/.github/copilot-instructions.md"
    echo "🎉 Hoàn tất tích hợp Codex / Copilot / Cursor!"
}

setup_all() {
    setup_antigravity
    setup_claude
    setup_codex
    echo ""
    echo "✨ ĐÃ TÍCH HỢP TOÀN DIỆN CHO TẤT CẢ CÁC AI ASSISTANTS!"
}

# Run menu or argument
if [ -n "$2" ]; then
    case "$2" in
        --antigravity) setup_antigravity ;;
        --claude) setup_claude ;;
        --codex) setup_codex ;;
        --all) setup_all ;;
        *) show_menu ;;
    esac
else
    show_menu
fi

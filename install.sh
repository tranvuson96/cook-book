#!/usr/bin/env bash
# ==============================================================================
# Antigravity Cook-Book Quick Setup Script
# Tự động hóa tích hợp Cook-Book vào Google Antigravity, Claude Code, Codex/Cursor
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Parse arguments
MODE=""
TARGET_PROJECT="."

if [[ "$1" == --* ]]; then
    MODE="$1"
    TARGET_PROJECT="${2:-.}"
elif [[ -n "$1" && -d "$1" ]]; then
    TARGET_PROJECT="$1"
    MODE="$2"
fi

RESOLVED_TARGET="$(cd "$TARGET_PROJECT" && pwd)"

echo "========================================================"
echo "🚀 Antigravity Cook-Book Setup Assistant"
echo "📂 Cookbook Location: $SCRIPT_DIR"
echo "🎯 Target Project:    $RESOLVED_TARGET"
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
    # 1. Symlink skills to global gemini skills (in both ~/.gemini/config/skills and ~/.gemini/antigravity/skills)
    for dest_dir in "$HOME/.gemini/config/skills" "$HOME/.gemini/antigravity/skills"; do
        mkdir -p "$dest_dir"
        for skill in "$SCRIPT_DIR/skills"/*; do
            if [ -d "$skill" ]; then
                sname=$(basename "$skill")
                ln -sfn "$skill" "$dest_dir/$sname"
                echo "   ✅ Linked skill: $sname -> $dest_dir/$sname"
            fi
        done
    done

    # 2. Update Global GEMINI.md & AGENTS.md in ~/.gemini/config/ if directory exists
    if [ -d "$HOME/.gemini/config" ]; then
        sed "s|\[Đường dẫn tới cook-book\]|$SCRIPT_DIR|g" "$SCRIPT_DIR/configs/GEMINI.sample.md" > "$HOME/.gemini/config/GEMINI.md"
        sed "s|\[Path to cook-book\]|$SCRIPT_DIR|g" "$SCRIPT_DIR/configs/AGENTS.sample.md" > "$HOME/.gemini/config/AGENTS.md"
        echo "   ✅ Updated global rules: $HOME/.gemini/config/GEMINI.md & AGENTS.md"
    fi

    # 3. Copy sample GEMINI.md to target project
    if [ -d "$TARGET_PROJECT" ]; then
        sed "s|\[Đường dẫn tới cook-book\]|$SCRIPT_DIR|g" "$SCRIPT_DIR/configs/GEMINI.sample.md" > "$TARGET_PROJECT/GEMINI.md"
        echo "   ✅ Created $TARGET_PROJECT/GEMINI.md"
    fi
    echo "🎉 Hoàn tất tích hợp Google Antigravity!"
}

setup_claude() {
    echo ""
    echo "⚙️ Đang cấu hình cho Anthropic Claude Code..."
    if [ -d "$TARGET_PROJECT" ]; then
        sed "s|\[Đường dẫn tới cook-book\]|$SCRIPT_DIR|g" "$SCRIPT_DIR/configs/CLAUDE.sample.md" > "$TARGET_PROJECT/CLAUDE.md"
        echo "   ✅ Created $TARGET_PROJECT/CLAUDE.md"
    fi
    echo "🎉 Hoàn tất tích hợp Claude Code!"
}

setup_codex() {
    echo ""
    echo "⚙️ Đang cấu hình cho OpenAI Codex / Copilot / Cursor..."
    if [ -d "$TARGET_PROJECT" ]; then
        sed "s|\[Path to cook-book\]|$SCRIPT_DIR|g" "$SCRIPT_DIR/configs/AGENTS.sample.md" > "$TARGET_PROJECT/AGENTS.md"
        echo "   ✅ Created $TARGET_PROJECT/AGENTS.md"
        
        # Cursor rules
        cp "$TARGET_PROJECT/AGENTS.md" "$TARGET_PROJECT/.cursorrules"
        echo "   ✅ Created $TARGET_PROJECT/.cursorrules"

        # Copilot instructions
        mkdir -p "$TARGET_PROJECT/.github"
        cp "$TARGET_PROJECT/AGENTS.md" "$TARGET_PROJECT/.github/copilot-instructions.md"
        echo "   ✅ Created $TARGET_PROJECT/.github/copilot-instructions.md"
    fi
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
case "$MODE" in
    --antigravity) setup_antigravity ;;
    --claude) setup_claude ;;
    --codex) setup_codex ;;
    --all) setup_all ;;
    *) show_menu ;;
esac

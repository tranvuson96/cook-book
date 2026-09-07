# ==============================================================================
# Antigravity Cook-Book Quick Setup Script for Windows (PowerShell)
# Tự động hóa tích hợp Cook-Book vào Google Antigravity, Claude Code, Codex/Cursor
# ==============================================================================

[CmdletBinding()]
param (
    [string]$TargetProject = ".",
    [string]$Tool = ""
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ResolvedTarget = Resolve-Path $TargetProject

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "🚀 Antigravity Cook-Book Windows Setup Assistant" -ForegroundColor Green
Write-Host "📂 Cookbook Location: $ScriptDir"
Write-Host "🎯 Target Project:    $ResolvedTarget"
Write-Host "========================================================" -ForegroundColor Cyan

function Setup-Antigravity {
    Write-Host "`n⚙️ Đang cấu hình cho Google Antigravity (Windows)..." -ForegroundColor Yellow
    $GeminiSkillsDir = Join-Path $env:USERPROFILE ".gemini\antigravity\skills"
    if (-not (Test-Path $GeminiSkillsDir)) {
        New-Item -ItemType Directory -Path $GeminiSkillsDir -Force | Out-Null
    }

    $SkillsPath = Join-Path $ScriptDir "skills"
    Get-ChildItem -Path $SkillsPath -Directory | ForEach-Object {
        $dest = Join-Path $GeminiSkillsDir $_.Name
        try {
            # Thử tạo Symlink trước (cần Developer Mode hoặc Run as Admin)
            New-Item -ItemType SymbolicLink -Path $dest -Target $_.FullName -Force -ErrorAction Stop | Out-Null
            Write-Host "   ✅ Linked skill (Symlink): $($_.Name)" -ForegroundColor Green
        } catch {
            # Fallback sang copy nếu không có quyền Symlink trên Windows
            Copy-Item -Path $_.FullName -Destination $dest -Recurse -Force
            Write-Host "   ✅ Copied skill: $($_.Name)" -ForegroundColor Green
        }
    }

    # Tạo GEMINI.md trong thư mục dự án
    $SampleGemini = Join-Path $ScriptDir "configs\GEMINI.sample.md"
    $DestGemini = Join-Path $ResolvedTarget "GEMINI.md"
    $content = Get-Content $SampleGemini -Raw -Encoding UTF8
    $content = $content.Replace("[Đường dẫn tới cook-book]", $ScriptDir)
    Set-Content -Path $DestGemini -Value $content -Encoding UTF8
    Write-Host "   ✅ Created $DestGemini" -ForegroundColor Green
    Write-Host "🎉 Hoàn tất tích hợp Google Antigravity!" -ForegroundColor Cyan
}

function Setup-Claude {
    Write-Host "`n⚙️ Đang cấu hình cho Anthropic Claude Code (Windows)..." -ForegroundColor Yellow
    $SampleClaude = Join-Path $ScriptDir "configs\CLAUDE.sample.md"
    $DestClaude = Join-Path $ResolvedTarget "CLAUDE.md"
    $content = Get-Content $SampleClaude -Raw -Encoding UTF8
    $content = $content.Replace("[Đường dẫn tới cook-book]", $ScriptDir)
    Set-Content -Path $DestClaude -Value $content -Encoding UTF8
    Write-Host "   ✅ Created $DestClaude" -ForegroundColor Green
    Write-Host "🎉 Hoàn tất tích hợp Claude Code!" -ForegroundColor Cyan
}

function Setup-Codex {
    Write-Host "`n⚙️ Đang cấu hình cho OpenAI Codex / Copilot / Cursor (Windows)..." -ForegroundColor Yellow
    $SampleAgents = Join-Path $ScriptDir "configs\AGENTS.sample.md"
    $DestAgents = Join-Path $ResolvedTarget "AGENTS.md"
    $content = Get-Content $SampleAgents -Raw -Encoding UTF8
    $content = $content.Replace("[Path to cook-book]", $ScriptDir)
    Set-Content -Path $DestAgents -Value $content -Encoding UTF8
    Write-Host "   ✅ Created $DestAgents" -ForegroundColor Green

    # Cursor rules
    $DestCursor = Join-Path $ResolvedTarget ".cursorrules"
    Copy-Item -Path $DestAgents -Destination $DestCursor -Force
    Write-Host "   ✅ Created $DestCursor" -ForegroundColor Green

    # Copilot instructions
    $GithubDir = Join-Path $ResolvedTarget ".github"
    if (-not (Test-Path $GithubDir)) {
        New-Item -ItemType Directory -Path $GithubDir -Force | Out-Null
    }
    $DestCopilot = Join-Path $GithubDir "copilot-instructions.md"
    Copy-Item -Path $DestAgents -Destination $DestCopilot -Force
    Write-Host "   ✅ Created $DestCopilot" -ForegroundColor Green

    Write-Host "🎉 Hoàn tất tích hợp Codex / Copilot / Cursor!" -ForegroundColor Cyan
}

function Setup-All {
    Setup-Antigravity
    Setup-Claude
    Setup-Codex
    Write-Host "`n✨ ĐÃ TÍCH HỢP TOÀN DIỆN CHO TẤT CẢ CÁC AI ASSISTANTS TRÊN WINDOWS!" -ForegroundColor Magenta
}

function Show-Menu {
    Write-Host "`nChọn công cụ AI bạn muốn cài đặt tích hợp:" -ForegroundColor Yellow
    Write-Host "1) Google Antigravity (AGY) - Nạp Skills & GEMINI.md"
    Write-Host "2) Anthropic Claude Code    - Tạo CLAUDE.md"
    Write-Host "3) OpenAI Codex / Copilot / Cursor - Tạo AGENTS.md & .cursorrules"
    Write-Host "4) Cài đặt TẤT CẢ (All AI Assistants)"
    Write-Host "5) Thoát (Exit)"
    
    $choice = Read-Host "`nLựa chọn của bạn [1-5]"
    switch ($choice) {
        "1" { Setup-Antigravity }
        "2" { Setup-Claude }
        "3" { Setup-Codex }
        "4" { Setup-All }
        "5" { exit }
        default { Write-Host "Lựa chọn không hợp lệ!" -ForegroundColor Red; exit }
    }
}

if ($Tool -ne "") {
    switch ($Tool.ToLower()) {
        "antigravity" { Setup-Antigravity }
        "claude" { Setup-Claude }
        "codex" { Setup-Codex }
        "all" { Setup-All }
        default { Show-Menu }
    }
} else {
    Show-Menu
}

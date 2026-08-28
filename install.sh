#!/usr/bin/env bash
# ==============================================================================
# 🚀 Pero Agent Skills Universal Installer (Standalone v3.0)
# Creator: Pero (https://github.com/okyFaishal/pero-agent-skills)
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/okyFaishal/pero-agent-skills/main/install.sh | bash
#   Or: bash install.sh [TARGET_DIR] [--check]
# ==============================================================================
set -euo pipefail

REPO_URL="https://github.com/okyFaishal/pero-agent-skills.git"

# 24 Universal Engineering & SDLC Skills
SKILLS=(
  "pero-problem-framing"
  "pero-prd-writing"
  "pero-user-stories"
  "pero-system-architecture"
  "pero-quality-governance"
  "pero-task-decomposition"
  "pero-granular-refinement"
  "pero-context-validation"
  "find-skill"
  "context-7"
  "web-search"
  "grilling"
  "test-driven-development"
  "systematic-debugging"
  "verification-before-completion"
  "code-reviewer"
  "api-contract-design"
  "schema-validator"
  "decision-recorder"
  "living-doc-sync"
  "git-ops"
  "env-guard"
  "eli5"
  "anti-slop"
)

# Parse Arguments
TARGET_DIR=""
CHECK_ONLY=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --check)
      CHECK_ONLY=true
      shift
      ;;
    --help|-h)
      echo "Penggunaan: install.sh [TARGET_DIR] [OPTIONS]"
      echo ""
      echo "Opsi:"
      echo "  --check       Memeriksa integritas 23 modul skill dan AGENTS.md"
      echo "  --help, -h    Tampilkan panduan bantuan ini"
      exit 0
      ;;
    *)
      if [[ -z "$TARGET_DIR" && ! "$1" =~ ^-- ]]; then
        TARGET_DIR="$1"
      fi
      shift
      ;;
  esac
done

TARGET_DIR="${TARGET_DIR:-$(pwd)}"
mkdir -p "$TARGET_DIR"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"
TARGET_SKILLS_DIR="${TARGET_DIR}/.agents/skills"
TARGET_AGENTS_MD="${TARGET_DIR}/AGENTS.md"
TARGET_GITIGNORE="${TARGET_DIR}/.gitignore"

echo "================================================================="
echo " 🚀 Pero Agent Skills Universal Installer (v3.0 Standalone)"
echo " 📂 Target Workspace: ${TARGET_DIR}"
echo "================================================================="

# ------------------------------------------------------------------------------
# 1. Mode Health Check (--check)
# ------------------------------------------------------------------------------
if [[ "$CHECK_ONLY" == true ]]; then
  echo "-> Memeriksa status kesehatan ${#SKILLS[@]} modul skill di target workspace..."
  ERRORS=0
  for skill in "${SKILLS[@]}"; do
    skill_file="${TARGET_SKILLS_DIR}/${skill}/SKILL.md"
    if [[ ! -f "$skill_file" ]]; then
      echo "   [❌] ${skill}: File SKILL.md tidak ditemukan."
      ERRORS=$((ERRORS + 1))
    elif ! head -n 5 "$skill_file" | grep -q "^name: ${skill}"; then
      echo "   [⚠️ ] ${skill}: Frontmatter name tidak valid."
      ERRORS=$((ERRORS + 1))
    else
      echo "   [✓] ${skill}: Sehat & aktif."
    fi
  done

  if [[ -f "$TARGET_AGENTS_MD" ]]; then
    echo "   [✓] AGENTS.md: Terverifikasi ada di root."
  else
    echo "   [❌] AGENTS.md: Tidak ditemukan di root workspace."
    ERRORS=$((ERRORS + 1))
  fi

  echo "================================================================="
  if [[ $ERRORS -eq 0 ]]; then
    echo " ✨ Seluruh ${#SKILLS[@]} modul skill Pero SEHAT 100%!"
    exit 0
  else
    echo " ⚠️  Ditemukan ${ERRORS} masalah pada target workspace."
    exit 1
  fi
fi

# ------------------------------------------------------------------------------
# 2. Mode Pemasangan (Installation Mode)
# ------------------------------------------------------------------------------
mkdir -p "${TARGET_SKILLS_DIR}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo "")"
SOURCE_SKILLS=""
SOURCE_AGENTS_MD=""
TEMP_DIR=""

if [[ -n "$SCRIPT_DIR" && -d "${SCRIPT_DIR}/skills" && -f "${SCRIPT_DIR}/AGENTS.md" ]]; then
  echo "-> Menggunakan paket lokal (${SCRIPT_DIR})..."
  SOURCE_SKILLS="${SCRIPT_DIR}/skills"
  SOURCE_AGENTS_MD="${SCRIPT_DIR}/AGENTS.md"
else
  echo "-> Mengunduh paket resmi dari GitHub (${REPO_URL})..."
  TEMP_DIR="$(mktemp -d)"
  if git clone --depth 1 "$REPO_URL" "${TEMP_DIR}/repo" 2>/dev/null; then
    SOURCE_SKILLS="${TEMP_DIR}/repo/skills"
    SOURCE_AGENTS_MD="${TEMP_DIR}/repo/AGENTS.md"
  else
    echo "❌ Gagal mengunduh repositori. Pastikan koneksi internet atau hak akses GitHub tersedia."
    rm -rf "$TEMP_DIR"
    exit 1
  fi
fi

# Salin 23 Skill Universal
echo "-> Menyebarkan ${#SKILLS[@]} modul skill ke ${TARGET_SKILLS_DIR}..."
for skill in "${SKILLS[@]}"; do
  if [[ -d "${SOURCE_SKILLS}/${skill}" ]]; then
    mkdir -p "${TARGET_SKILLS_DIR}/${skill}"
    cp -r "${SOURCE_SKILLS}/${skill}/"* "${TARGET_SKILLS_DIR}/${skill}/"
    echo "   [✓] ${skill} terpasang."
  else
    echo "   [⚠️ ] Warning: Modul ${skill} tidak ditemukan di sumber."
  fi
done

# Salin AGENTS.md jika belum ada atau perbarui
echo "-> Menyiapkan aturan tata kelola AGENTS.md..."
if [[ "$SOURCE_AGENTS_MD" != "$TARGET_AGENTS_MD" ]]; then
  if [[ -f "$TARGET_AGENTS_MD" ]]; then
    echo "   [i] AGENTS.md sudah ada. Membuat cadangan AGENTS.md.bak..."
    cp "$TARGET_AGENTS_MD" "${TARGET_AGENTS_MD}.bak"
  fi
  cp "$SOURCE_AGENTS_MD" "$TARGET_AGENTS_MD"
fi
echo "   [✓] AGENTS.md aktif di root workspace."

# Proteksi .gitignore Otomatis
echo "-> Memeriksa perlindungan keamanan di .gitignore..."
TOUCHED_GITIGNORE=false
if [[ ! -f "$TARGET_GITIGNORE" ]]; then
  touch "$TARGET_GITIGNORE"
fi

SECURITY_RULES=(
  ".env"
  ".env.*"
  "*.pem"
  "*.key"
  "credentials.json"
)

for rule in "${SECURITY_RULES[@]}"; do
  if ! grep -Fxq "$rule" "$TARGET_GITIGNORE" 2>/dev/null; then
    echo "$rule" >> "$TARGET_GITIGNORE"
    TOUCHED_GITIGNORE=true
  fi
done

if [[ "$TOUCHED_GITIGNORE" == true ]]; then
  echo "   [🛡️ ] Menambahkan aturan proteksi file rahasia ke .gitignore."
else
  echo "   [✓] .gitignore sudah terlindungi aman."
fi

# Bersihkan temp dir jika ada
if [[ -n "$TEMP_DIR" && -d "$TEMP_DIR" ]]; then
  rm -rf "$TEMP_DIR"
fi

echo "================================================================="
echo " ✨ Berhasil! ${#SKILLS[@]} Skill Pero & AGENTS.md siap digunakan di:"
echo " 📂 ${TARGET_DIR}"
echo "================================================================="

#!/usr/bin/env bash
# ==============================================================================
# Pero Agent Skills One-Line Universal Installer
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/okyFaishal/pero-agent-skills/main/install.sh | bash
#   Or: bash install.sh [TARGET_DIR]
# ==============================================================================
set -euo pipefail

TARGET_DIR="${1:-$(pwd)}"
mkdir -p "$TARGET_DIR"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"
TARGET_SKILLS_DIR="${TARGET_DIR}/.agents/skills"
TARGET_AGENTS_MD="${TARGET_DIR}/AGENTS.md"
TARGET_GITIGNORE="${TARGET_DIR}/.gitignore"

REPO_URL="https://github.com/okyFaishal/pero-agent-skills.git"
RAW_BASE_URL="https://raw.githubusercontent.com/okyFaishal/pero-agent-skills/main"

echo "================================================================="
echo " 🚀 Pero Agent Skills Universal Installer"
echo " 📂 Target Directory: ${TARGET_DIR}"
echo "================================================================="

# Create .agents/skills directory
mkdir -p "${TARGET_SKILLS_DIR}"

# Check if we are running from a cloned repo locally or via curl pipe
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo "")"

if [[ -n "$SCRIPT_DIR" && -d "${SCRIPT_DIR}/skills" ]]; then
  echo "-> Memasang dari berkas lokal..."
  cp -r "${SCRIPT_DIR}/skills/"* "${TARGET_SKILLS_DIR}/"
  if [[ ! -f "$TARGET_AGENTS_MD" ]]; then
    cp "${SCRIPT_DIR}/AGENTS.md" "$TARGET_AGENTS_MD"
  fi
else
  echo "-> Mengunduh paket lengkap dari GitHub (${REPO_URL})..."
  TEMP_DIR="$(mktemp -d)"
  if git clone --depth 1 "$REPO_URL" "${TEMP_DIR}/repo" 2>/dev/null; then
    cp -r "${TEMP_DIR}/repo/skills/"* "${TARGET_SKILLS_DIR}/"
    if [[ ! -f "$TARGET_AGENTS_MD" ]]; then
      cp "${TEMP_DIR}/repo/AGENTS.md" "$TARGET_AGENTS_MD"
    fi
    rm -rf "$TEMP_DIR"
  else
    echo "❌ Gagal mengunduh repositori. Pastikan koneksi internet atau hak akses GitHub tersedia."
    rm -rf "$TEMP_DIR"
    exit 1
  fi
fi

# Run installer script to ensure health & .gitignore safety
if [[ -f "${TARGET_SKILLS_DIR}/pero-workspace-setup/scripts/install-skills.sh" ]]; then
  chmod +x "${TARGET_SKILLS_DIR}/pero-workspace-setup/scripts/install-skills.sh"
  bash "${TARGET_SKILLS_DIR}/pero-workspace-setup/scripts/install-skills.sh" "$TARGET_DIR"
fi

echo "================================================================="
echo " ✨ Berhasil! 23 Skill Pero & AGENTS.md siap digunakan di:"
echo " 📂 ${TARGET_DIR}"
echo "================================================================="

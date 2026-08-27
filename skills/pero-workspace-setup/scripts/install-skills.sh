#!/usr/bin/env bash
# ==============================================================================
# Script: install-skills.sh (v2.2 Complete Universal SDLC & Remote-Ready)
# Creator: Pero
# Purpose: Universal, Portable & Idempotent Agent Skills Provisioner
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEMPLATES_DIR="${SKILL_ROOT}/templates"

# Optional Remote Git Hub Repository URL (default can be overridden via --remote)
PERO_REMOTE_URL="${PERO_REMOTE_URL:-""}"

# Parse CLI Arguments & Flags
TARGET_DIR=""
CHECK_ONLY=false
FORCE_REPAIR=false
BACKUP_EXISTING=true
REMOTE_MODE=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --check)
      CHECK_ONLY=true
      shift
      ;;
    --force|--repair)
      FORCE_REPAIR=true
      shift
      ;;
    --no-backup)
      BACKUP_EXISTING=false
      shift
      ;;
    --remote)
      REMOTE_MODE=true
      if [[ $# -gt 1 && ! "$2" =~ ^-- ]]; then
        PERO_REMOTE_URL="$2"
        shift 2
      else
        shift 1
      fi
      ;;
    --help|-h)
      echo "Penggunaan: install-skills.sh [TARGET_DIR] [OPTIONS]"
      echo ""
      echo "Opsi Universal:"
      echo "  --check              Hanya memeriksa integritas skill dan AGENTS.md tanpa menulis"
      echo "  --repair             Menimpa/memperbaiki skill yang rusak dari template bawaan"
      echo "  --remote [GIT_URL]   Sinkronisasi & unduh skill langsung dari repositori Git remote"
      echo "  --no-backup          Jangan membuat file cadangan AGENTS.md.bak"
      echo "  --help, -h           Tampilkan panduan bantuan ini"
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

# Resolve Target Workspace
if [[ -z "$TARGET_DIR" ]]; then
  if [[ -f "${SCRIPT_DIR}/../../../../AGENTS.md" || -d "${SCRIPT_DIR}/../../../../.agents" ]]; then
    TARGET_DIR="$(cd "${SCRIPT_DIR}/../../../../" && pwd)"
  else
    TARGET_DIR="$(pwd)"
  fi
else
  mkdir -p "$TARGET_DIR"
  TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"
fi

TARGET_SKILLS_DIR="${TARGET_DIR}/.agents/skills"
TARGET_AGENTS_MD="${TARGET_DIR}/AGENTS.md"
TARGET_GITIGNORE="${TARGET_DIR}/.gitignore"

echo "================================================================="
echo " 🛠️  Pero Agent Ecosystem Installer (Universal v2.2)"
echo " 📂 Target Workspace: ${TARGET_DIR}"
if [[ "$CHECK_ONLY" == true ]]; then
  echo " 🔍 Mode: Health Check Only"
elif [[ "$REMOTE_MODE" == true ]]; then
  echo " 🌐 Mode: Remote Git Sync (${PERO_REMOTE_URL:-"Default Remote"})"
elif [[ "$FORCE_REPAIR" == true ]]; then
  echo " 🔧 Mode: Force Repair / Reinstall"
else
  echo " 🚀 Mode: Complete Universal SDLC Setup"
fi
echo "================================================================="

SKILLS=(
  "pero-workspace-setup"
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
)

# ------------------------------------------------------------------------------
# 1. Health Check Mode
# ------------------------------------------------------------------------------
if [[ "$CHECK_ONLY" == true ]]; then
  echo "-> Memeriksa status kesehatan ${#SKILLS[@]} modul skill di target workspace..."
  ERRORS=0
  for skill in "${SKILLS[@]}"; do
    skill_file="${TARGET_SKILLS_DIR}/${skill}/SKILL.md"
    if [[ ! -f "$skill_file" ]]; then
      echo "   [❌] ${skill}: File SKILL.md tidak ditemukan."
      ERRORS=$((ERRORS + 1))
    elif ! grep -q "^name: " "$skill_file" || ! grep -q "^description: " "$skill_file"; then
      echo "   [⚠️ ] ${skill}: Format YAML frontmatter rusak."
      ERRORS=$((ERRORS + 1))
    else
      echo "   [✓] ${skill}: Sehat & aktif (Universal)."
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
    echo " ⚠️  Ditemukan ${ERRORS} masalah. Jalankan dengan flag --repair untuk memulihkan."
    exit 1
  fi
fi

# ------------------------------------------------------------------------------
# 2. Remote Git Sync (Optional)
# ------------------------------------------------------------------------------
TEMP_REMOTE_DIR=""
if [[ "$REMOTE_MODE" == true ]]; then
  if [[ -n "$PERO_REMOTE_URL" ]]; then
    echo "-> Mengunduh pembaruan skill dari Git Remote: ${PERO_REMOTE_URL}..."
    TEMP_REMOTE_DIR="$(mktemp -d)"
    if git clone --depth 1 "$PERO_REMOTE_URL" "${TEMP_REMOTE_DIR}/repo" 2>/dev/null; then
      echo "   [✓] Berhasil mengunduh repositori remote."
      if [[ -d "${TEMP_REMOTE_DIR}/repo/.agents/skills" ]]; then
        TEMPLATES_DIR="${TEMP_REMOTE_DIR}/repo/.agents/skills/pero-workspace-setup/templates"
      fi
    else
      echo "   [⚠️ ] Gagal terhubung ke remote Git. Beralih ke template offline bawaan."
    fi
  else
    echo "   [ℹ️ ] Belum ada URL remote yang disetel. Menggunakan template bawaan lokal."
  fi
fi

# ------------------------------------------------------------------------------
# 3. Provisioning & Scaffolding Skills
# ------------------------------------------------------------------------------
mkdir -p "${TARGET_SKILLS_DIR}"

echo "-> Menyebarkan dan memverifikasi ${#SKILLS[@]} modul skill universal..."
for skill in "${SKILLS[@]}"; do
  skill_dir="${TARGET_SKILLS_DIR}/${skill}"
  skill_file="${skill_dir}/SKILL.md"
  mkdir -p "${skill_dir}"

  template_file="${TEMPLATES_DIR}/skills/${skill}/SKILL.md"

  if [[ -f "$skill_file" && "$FORCE_REPAIR" == false ]]; then
    echo "   [✓] ${skill} sudah terpasang (Universal)."
  else
    if [[ -f "$template_file" ]]; then
      cp "$template_file" "$skill_file"
      echo "   [+] ${skill} disalin dari template universal."
    else
      echo "   [+] ${skill} dibuat dari kerangka default."
      cat <<EOF > "$skill_file"
---
name: ${skill}
description: Use when working with ${skill} workflows
---

# ${skill}
EOF
    fi
  fi
done

# Ensure installer script itself is copied to target if target is an external project
if [[ "$TARGET_DIR" != "$(cd "${SCRIPT_DIR}/../../../../" && pwd 2>/dev/null)" ]]; then
  mkdir -p "${TARGET_SKILLS_DIR}/pero-workspace-setup/scripts"
  cp "$0" "${TARGET_SKILLS_DIR}/pero-workspace-setup/scripts/install-skills.sh"
  chmod +x "${TARGET_SKILLS_DIR}/pero-workspace-setup/scripts/install-skills.sh"
  if [[ -d "$TEMPLATES_DIR" ]]; then
    cp -r "$TEMPLATES_DIR" "${TARGET_SKILLS_DIR}/pero-workspace-setup/"
  fi
fi

# ------------------------------------------------------------------------------
# 4. AGENTS.md Generation & Safe Backup
# ------------------------------------------------------------------------------
echo "-> Menyelaraskan AGENTS.md di root workspace..."
if [[ -f "$TARGET_AGENTS_MD" ]]; then
  if grep -q "Agent Workspace Rules" "$TARGET_AGENTS_MD" 2>/dev/null && [[ "$FORCE_REPAIR" == false ]]; then
    echo "   [✓] AGENTS.md sudah aktif dengan aturan terkini."
  else
    if [[ "$BACKUP_EXISTING" == true ]]; then
      TIMESTAMP="$(date +%Y%m%d%H%M%S)"
      BACKUP_FILE="${TARGET_AGENTS_MD}.bak.${TIMESTAMP}"
      cp "$TARGET_AGENTS_MD" "$BACKUP_FILE"
      echo "   [💾] Membuat cadangan aman: AGENTS.md.bak.${TIMESTAMP}"
    fi
    if [[ -f "${TEMPLATES_DIR}/AGENTS.md" ]]; then
      cp "${TEMPLATES_DIR}/AGENTS.md" "$TARGET_AGENTS_MD"
    fi
    echo "   [✓] AGENTS.md berhasil diselaraskan."
  fi
else
  if [[ -f "${TEMPLATES_DIR}/AGENTS.md" ]]; then
    cp "${TEMPLATES_DIR}/AGENTS.md" "$TARGET_AGENTS_MD"
  fi
  echo "   [✓] AGENTS.md baru berhasil dibuat."
fi

# ------------------------------------------------------------------------------
# 5. .gitignore Safety Auto-Guard
# ------------------------------------------------------------------------------
echo "-> Memeriksa perlindungan keamanan di .gitignore..."
GITIGNORE_RULES=(
  ".env"
  ".env.*"
  "*.pem"
  "*.key"
  ".agents/scratch/"
)

touch "$TARGET_GITIGNORE"
ADDED_RULES=0
for rule in "${GITIGNORE_RULES[@]}"; do
  if ! grep -Fxq "$rule" "$TARGET_GITIGNORE" 2>/dev/null; then
    if [[ $ADDED_RULES -eq 0 && $(wc -l < "$TARGET_GITIGNORE") -gt 0 ]]; then
      echo "" >> "$TARGET_GITIGNORE"
      echo "# Pero Safety Guard" >> "$TARGET_GITIGNORE"
    elif [[ $ADDED_RULES -eq 0 ]]; then
      echo "# Pero Safety Guard" >> "$TARGET_GITIGNORE"
    fi
    echo "$rule" >> "$TARGET_GITIGNORE"
    ADDED_RULES=$((ADDED_RULES + 1))
  fi
done

if [[ $ADDED_RULES -gt 0 ]]; then
  echo "   [🛡️ ] Menambahkan ${ADDED_RULES} aturan keamanan ke .gitignore."
else
  echo "   [✓] .gitignore sudah terlindungi."
fi

# Clean up temp if any
if [[ -n "$TEMP_REMOTE_DIR" && -d "$TEMP_REMOTE_DIR" ]]; then
  rm -rf "$TEMP_REMOTE_DIR"
fi

echo "================================================================="
echo " ✨ Sukses! Seluruh ${#SKILLS[@]} skill Pero & AGENTS.md siap digunakan di:"
echo " 📂 ${TARGET_DIR}"
echo "================================================================="

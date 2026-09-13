#!/usr/bin/env bash
# ==============================================================================
# 0. POSIX-Safe Bootstrap Guard (Mencegah Crash di dash/sh/ash)
# ==============================================================================
if [ -z "${BASH_VERSION:-}" ]; then
  if [ -n "${0:-}" ] && [ -f "$0" ] && command -v bash >/dev/null 2>&1; then
    exec bash "$0" "$@"
  fi
  printf "\033[1;31m[ERROR] Pero Agent Skills Installer membutuhkan GNU Bash.\033[0m\n" >&2
  printf "Terdeteksi shell non-Bash atau POSIX sh/dash murni.\n" >&2
  printf "\nCara menjalankan yang benar:\n" >&2
  printf "  curl -fsSL https://raw.githubusercontent.com/okyFaishal/pero-agent-skills/main/install.sh | bash\n" >&2
  printf "Atau jalankan lokal:\n" >&2
  printf "  bash install.sh [TARGET_DIR]\n\n" >&2
  exit 1
fi

# ==============================================================================
# 🚀 Pero Agent Skills Universal Installer (Standalone v3.1)
# Creator: Pero (https://github.com/okyFaishal/pero-agent-skills)
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/okyFaishal/pero-agent-skills/main/install.sh | bash
#   Or: bash install.sh [TARGET_DIR] [--check] [--dry-run] [--harness=<list>]
# ==============================================================================
set -euo pipefail

REPO_URL="https://github.com/okyFaishal/pero-agent-skills.git"

# 30 Universal Engineering & SDLC Skills
SKILLS=(
  "pero-problem-framing"
  "pero-prd-writing"
  "pero-user-stories"
  "pero-system-architecture"
  "pero-uiux-design"
  "pero-quality-governance"
  "pero-task-decomposition"
  "pero-granular-refinement"
  "pero-context-validation"
  "pero-change-management"
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
  "llm-council"
  "dispatching-parallel-agents"
  "subagent-driven-development"
  "taste-skill"
)

# ------------------------------------------------------------------------------
# 1. Cleanup & Signal Trap Mechanism
# ------------------------------------------------------------------------------
TEMP_DIR=""

cleanup() {
  local exit_code=$?
  trap - EXIT INT TERM HUP
  if [[ -n "${TEMP_DIR:-}" && -d "${TEMP_DIR}" ]]; then
    rm -rf "${TEMP_DIR}"
  fi
  exit "$exit_code"
}

trap 'cleanup' EXIT INT TERM HUP

# ------------------------------------------------------------------------------
# 2. Non-Destructive Harness Adapters
# ------------------------------------------------------------------------------
setup_single_adapter() {
  local target_file="$1"
  local harness_name="$2"
  local dry_run="$3"
  local target_agents_md="$4"
  local rel_target="AGENTS.md"
  local file_dir
  file_dir="$(dirname "$target_file")"

  # Hitung relative path jika adapter berada di subdirektori (misal .cursor/rules/)
  if [[ "$file_dir" != "$target_dir" && "$file_dir" == "$target_dir"/* ]]; then
    local rel_sub="${file_dir#"${target_dir}"}"
    rel_sub="${rel_sub#/}"
    rel_sub="${rel_sub%/}"

    local depth=0
    if [[ -n "$rel_sub" ]]; then
      local old_ifs="$IFS"
      IFS='/'
      read -r -a segments <<< "$rel_sub"
      IFS="$old_ifs"
      local seg
      for seg in "${segments[@]}"; do
        [[ -n "$seg" ]] && ((depth++))
      done
    fi

    local up_prefix=""
    local i
    for ((i = 0; i < depth; i++)); do
      up_prefix="../${up_prefix}"
    done
    rel_target="${up_prefix}AGENTS.md"
  fi

  # Pastikan direktori induk target ada sebelum membuat berkas/symlink
  if [[ ! -d "$file_dir" && "$dry_run" == false ]]; then
    mkdir -p "$file_dir"
  fi

  # Skenario 1: Berkas belum ada -> Buat relative symlink
  if [[ ! -e "$target_file" && ! -L "$target_file" ]]; then
    if [[ "$dry_run" == true ]]; then
      echo "   [🔍 DRY-RUN] Akan membuat adapter ${harness_name}: ${target_file} -> ${rel_target}"
    else
      ln -s "$rel_target" "$target_file" 2>/dev/null || cp "$target_agents_md" "$target_file"
      echo "   [✓] Adapter ${harness_name} dibuat (${target_file} -> ${rel_target})."
    fi
    return 0
  fi

  # Skenario 2: Berkas sudah berupa symlink yang menunjuk ke AGENTS.md yang valid
  if [[ -L "$target_file" ]]; then
    local current_link
    current_link="$(readlink "$target_file" 2>/dev/null || echo "")"
    if [[ "$current_link" == "$rel_target" || "$current_link" == "$target_agents_md" ]]; then
      echo "   [✓] Adapter ${harness_name} sudah terhubung (${target_file})."
      return 0
    else
      # Jika symlink rusak atau mengarah ke target usang, perbaiki
      if [[ "$dry_run" == false ]]; then
        rm -f "$target_file"
        ln -s "$rel_target" "$target_file" 2>/dev/null || cp "$target_agents_md" "$target_file"
        echo "   [✓] Adapter ${harness_name} diperbaiki (${target_file} -> ${rel_target})."
      else
        echo "   [🔍 DRY-RUN] Akan memperbaiki adapter ${harness_name}: ${target_file} -> ${rel_target}"
      fi
      return 0
    fi
  fi

  # Skenario 3: Berkas reguler milik pengguna sudah ada -> Non-Destructive Managed Block
  local start_marker="<!-- PERO_AGENT_SKILLS_START -->"
  local end_marker="<!-- PERO_AGENT_SKILLS_END -->"

  if grep -Fq "$start_marker" "$target_file" 2>/dev/null; then
    echo "   [✓] Adapter ${harness_name} (${target_file}) sudah memuat integrasi Pero."
    return 0
  fi

  local injection_block
  injection_block=$(cat << 'EOF'

<!-- PERO_AGENT_SKILLS_START -->
## Pero Agent Skills Integration
Proyek ini dilengkapi dengan 30 Pero Agent Skills & Aturan Rekayasa Mandiri.
- Aturan Tata Kelola & Daftar Skill Lengkap: Silakan patuhi [AGENTS.md](./AGENTS.md)
- Direktori Skill Operasional: [.agents/skills/](./.agents/skills/)
<!-- PERO_AGENT_SKILLS_END -->
EOF
)

  if [[ "$dry_run" == true ]]; then
    echo "   [🔍 DRY-RUN] Akan menyisipkan blok rujukan Pero ke berkas yang ada: ${target_file}"
  else
    local timestamp
    timestamp="$(date +%Y%m%d_%H%M%S)"
    cp "$target_file" "${target_file}.bak_${timestamp}"
    printf "%s\n" "$injection_block" >> "$target_file"
    echo "   [🛡️ ] Menambahkan blok rujukan Pero ke berkas: ${target_file} (Cadangan: ${target_file}.bak_${timestamp})."
  fi
}

# ------------------------------------------------------------------------------
# 3. Main Operational Logic
# ------------------------------------------------------------------------------
main() {
  local target_dir=""
  local check_only=false
  local dry_run=false
  local harness_arg="antigravity"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --check)
        check_only=true
        shift
        ;;
      --dry-run)
        dry_run=true
        shift
        ;;
      --harness=*)
        harness_arg="${1#*=}"
        shift
        ;;
      -H|--harness)
        harness_arg="$2"
        shift 2
        ;;
      --version|-v)
        echo "pero-agent-skills installer v3.1.0 (standalone)"
        exit 0
        ;;
      --help|-h)
        echo "Penggunaan: install.sh [TARGET_DIR] [OPTIONS]"
        echo ""
        echo "Opsi:"
        echo "  --check               Memeriksa integritas 30 modul skill dan AGENTS.md"
        echo "  --dry-run             Menampilkan simulasi tindakan tanpa menyalin berkas"
        echo "  --harness=<list>      Pasang adapter harness (antigravity, claude, cursor, windsurf, cline, all)"
        echo "  --version, -v         Tampilkan versi installer resmi"
        echo "  --help, -h            Tampilkan panduan bantuan ini"
        exit 0
        ;;
      *)
        if [[ -z "$target_dir" && ! "$1" =~ ^-- ]]; then
          target_dir="$1"
          shift
        else
          echo "Error: Opsi tidak dikenal: $1" >&2
          echo "Gunakan 'install.sh --help' untuk melihat daftar opsi yang tersedia." >&2
          exit 1
        fi
        ;;
    esac
  done

  target_dir="${target_dir:-.}"
  if [[ "$dry_run" == false ]]; then
    mkdir -p "$target_dir"
  fi
  target_dir="$(cd "$target_dir" 2>/dev/null && pwd || echo "$target_dir")"
  local target_skills_dir="${target_dir}/.agents/skills"
  local target_agents_md="${target_dir}/AGENTS.md"
  local target_gitignore="${target_dir}/.gitignore"

  # Mode Pemeriksaan Status Integritas (--check)
  if [[ "$check_only" == true ]]; then
    echo "================================================================="
    echo " 🚀 Pero Agent Skills Universal Installer (v3.1 Standalone)"
    echo " 📂 Target Workspace: ${target_dir}"
    echo "================================================================="
    echo "-> Memeriksa status kesehatan ${#SKILLS[@]} modul skill di target workspace..."
    local missing=0
    for skill in "${SKILLS[@]}"; do
      if [[ -d "${target_skills_dir}/${skill}" && -f "${target_skills_dir}/${skill}/SKILL.md" ]]; then
        echo "   [✓] ${skill}: Sehat & aktif."
      else
        echo "   [✗] ${skill}: HILANG atau TIDAK LENGKAP."
        missing=$((missing + 1))
      fi
    done
    if [[ -f "$target_agents_md" ]]; then
      echo "   [✓] AGENTS.md: Terverifikasi ada di root."
    else
      echo "   [✗] AGENTS.md: HILANG di root workspace."
      missing=$((missing + 1))
    fi
    echo "================================================================="
    if [[ $missing -eq 0 ]]; then
      echo " ✨ Seluruh ${#SKILLS[@]} modul skill Pero SEHAT 100%!"
      echo ""
      exit 0
    else
      echo " ⚠️  Ditemukan ${missing} masalah integritas. Jalankan 'install.sh ${target_dir}' untuk memperbaiki."
      echo ""
      exit 1
    fi
  fi

  # Resolusi Sumber Paket (Lokal vs GitHub Clone)
  local script_dir
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo "")"
  local source_skills=""
  local source_agents_md=""

  if [[ -n "$script_dir" && -d "${script_dir}/skills" && -f "${script_dir}/AGENTS.md" ]]; then
    echo "-> Menggunakan paket lokal (${script_dir})..."
    source_skills="${script_dir}/skills"
    source_agents_md="${script_dir}/AGENTS.md"
  else
    echo "-> Mengunduh paket resmi dari GitHub (${REPO_URL})..."
    TEMP_DIR="$(mktemp -d)"
    local downloaded=false
    if command -v git >/dev/null 2>&1; then
      if git clone --depth 1 "$REPO_URL" "${TEMP_DIR}/repo" 2>/dev/null; then
        source_skills="${TEMP_DIR}/repo/skills"
        source_agents_md="${TEMP_DIR}/repo/AGENTS.md"
        downloaded=true
      fi
    fi

    if [[ "$downloaded" == false ]]; then
      echo "   [ℹ️ ] git clone tidak tersedia atau gagal, mencoba unduhan tarball via curl..."
      local tarball_url="https://github.com/okyFaishal/pero-agent-skills/archive/refs/heads/main.tar.gz"
      if command -v curl >/dev/null 2>&1 && command -v tar >/dev/null 2>&1; then
        rm -rf "${TEMP_DIR}/repo"
        mkdir -p "${TEMP_DIR}/repo"
        if curl -fsSL "$tarball_url" 2>/dev/null | tar -xzf - -C "${TEMP_DIR}/repo" --strip-components=1 2>/dev/null; then
          source_skills="${TEMP_DIR}/repo/skills"
          source_agents_md="${TEMP_DIR}/repo/AGENTS.md"
          downloaded=true
        fi
      fi
    fi

    if [[ "$downloaded" == false ]]; then
      echo "❌ Gagal mengunduh repositori. Pastikan koneksi internet, git, atau curl+tar tersedia." >&2
      exit 1
    fi
  fi

  # Banner Pemasangan
  echo "================================================================="
  echo " 🚀 Pero Agent Skills Universal Installer (v3.1 Standalone)"
  echo " 📂 Target Workspace: ${target_dir}"
  echo "================================================================="

  if [[ "$dry_run" == false ]]; then
    mkdir -p "${target_dir}/.agents"
  fi

  # Deteksi Apakah Target Instalasi Adalah Repo Pero Itu Sendiri (Self-Aware SSOT Mode)
  local is_self_repo=false
  if [[ -d "${target_dir}/skills" && -f "${target_dir}/install.sh" && -f "${target_dir}/AGENTS.md" ]]; then
    is_self_repo=true
  fi

  if [[ "$is_self_repo" == true ]]; then
    echo "-> [SSOT] Terdeteksi repositori sumber pero-agent-skills."
    if [[ "$dry_run" == true ]]; then
      echo "   [🔍 DRY-RUN] Akan menautkan virtual link: ${target_skills_dir} -> ../skills"
    else
      if [[ ! -L "${target_skills_dir}" ]]; then
        rm -rf "${target_skills_dir}"
        ln -s ../skills "${target_skills_dir}"
      fi
      echo "   [✓] Virtual link Single Source of Truth aktif (.agents/skills -> ../skills)."
    fi
  else
    if [[ "$dry_run" == true ]]; then
      echo "-> [DRY-RUN] Akan membuat direktori: ${target_skills_dir}"
    else
      mkdir -p "${target_skills_dir}"
    fi

    # Salin 30 Skill Universal
    echo "-> Menyebarkan ${#SKILLS[@]} modul skill ke ${target_skills_dir}..."
    for skill in "${SKILLS[@]}"; do
      if [[ -d "${source_skills}/${skill}" ]]; then
        if [[ "$dry_run" == true ]]; then
          echo "   [🔍 DRY-RUN] Akan memasang: ${skill}"
        else
          mkdir -p "${target_skills_dir}/${skill}"
          cp -R "${source_skills}/${skill}/." "${target_skills_dir}/${skill}/"
          if [[ -d "${target_skills_dir}/${skill}/scripts" ]]; then
            chmod +x "${target_skills_dir}/${skill}/scripts/"* 2>/dev/null || true
          fi
          echo "   [✓] ${skill} terpasang."
        fi
      else
        echo "   [⚠️ ] Warning: Modul ${skill} tidak ditemukan di sumber."
      fi
    done
  fi

  # Salin AGENTS.md jika belum ada atau perbarui dengan backup ber-timestamp
  echo "-> Menyiapkan aturan tata kelola AGENTS.md..."
  if [[ "$source_agents_md" != "$target_agents_md" ]]; then
    if [[ -f "$target_agents_md" ]]; then
      local timestamp
      timestamp="$(date +%Y%m%d_%H%M%S)"
      local backup_file="${target_dir}/AGENTS.md.bak_${timestamp}"
      if [[ "$dry_run" == true ]]; then
        echo "   [🔍 DRY-RUN] Akan membuat cadangan: ${backup_file}"
      else
        echo "   [i] AGENTS.md sudah ada. Membuat cadangan ${backup_file}..."
        cp "$target_agents_md" "$backup_file"
      fi
    fi
    if [[ "$dry_run" == true ]]; then
      echo "   [🔍 DRY-RUN] Akan memperbarui: ${target_agents_md}"
    else
      cp "$source_agents_md" "$target_agents_md"
      echo "   [✓] AGENTS.md aktif di root workspace."
    fi
  else
    echo "   [✓] AGENTS.md sudah berada di root sumber."
  fi

  # Pasang Harness Adapters Sesuai Pilihan
  echo "-> Menyiapkan adapter asisten pengkodean (Harness: ${harness_arg})..."
  local enable_claude=false
  local enable_cursor=false
  local enable_windsurf=false
  local enable_cline=false

  if [[ "$harness_arg" == "all" ]]; then
    enable_claude=true
    enable_cursor=true
    enable_windsurf=true
    enable_cline=true
  else
    IFS=',' read -r -a selected_harnesses <<< "$harness_arg"
    for h in "${selected_harnesses[@]}"; do
      case "$h" in
        claude) enable_claude=true ;;
        cursor) enable_cursor=true ;;
        windsurf) enable_windsurf=true ;;
        cline) enable_cline=true ;;
        antigravity) ;;
        *) echo "   [⚠️ ] Harness tidak dikenal: $h (Dilewati)" ;;
      esac
    done
  fi

  if [[ "$enable_claude" == true ]]; then
    setup_single_adapter "${target_dir}/CLAUDE.md" "Claude Code" "$dry_run" "$target_agents_md"
  fi
  if [[ "$enable_cursor" == true ]]; then
    setup_single_adapter "${target_dir}/.cursorrules" "Cursor (.cursorrules)" "$dry_run" "$target_agents_md"
    if [[ "$dry_run" == false ]]; then
      mkdir -p "${target_dir}/.cursor/rules"
    fi
    setup_single_adapter "${target_dir}/.cursor/rules/pero-agent-skills.mdc" "Cursor Modern (.cursor/rules)" "$dry_run" "$target_agents_md"
  fi
  if [[ "$enable_windsurf" == true ]]; then
    setup_single_adapter "${target_dir}/.windsurfrules" "Windsurf" "$dry_run" "$target_agents_md"
  fi
  if [[ "$enable_cline" == true ]]; then
    setup_single_adapter "${target_dir}/.clinerules" "Cline / Roo Code" "$dry_run" "$target_agents_md"
  fi

  # Proteksi .gitignore Otomatis (Termasuk .pero/)
  echo "-> Memeriksa perlindungan keamanan di .gitignore..."
  local touched_gitignore=false

  local security_rules=(
    ".env"
    ".env.*"
    "*.pem"
    "*.key"
    "*.cert"
    "credentials.json"
    ".pero/"
  )

  if [[ "$dry_run" == true ]]; then
    for rule in "${security_rules[@]}"; do
      if [[ ! -f "$target_gitignore" ]] || ! grep -Fxq "$rule" "$target_gitignore" 2>/dev/null; then
        echo "   [🔍 DRY-RUN] Aturan proteksi akan ditambahkan ke .gitignore: ${rule}"
        touched_gitignore=true
      fi
    done
    if [[ "$touched_gitignore" == false ]]; then
      echo "   [✓] .gitignore sudah terlindungi aman."
    fi
  else
    if [[ ! -f "$target_gitignore" ]]; then
      touch "$target_gitignore"
    fi
    for rule in "${security_rules[@]}"; do
      if ! grep -Fxq "$rule" "$target_gitignore" 2>/dev/null; then
        echo "$rule" >> "$target_gitignore"
        touched_gitignore=true
      fi
    done
    if [[ "$touched_gitignore" == true ]]; then
      echo "   [🛡️ ] Menambahkan aturan proteksi file rahasia ke .gitignore."
    else
      echo "   [✓] .gitignore sudah terlindungi aman."
    fi
  fi

  # ------------------------------------------------------------------------------
  # Deteksi Stack Proyek & Penyiapan MCP Dinamis
  # ------------------------------------------------------------------------------
  echo "-> Memeriksa manifest proyek untuk penyelarasan MCP spesifik stack..."
  local detected_stacks=()

  if [[ -f "${target_dir}/Package.swift" ]] || compgen -G "${target_dir}/*.xcodeproj" > /dev/null 2>&1 || compgen -G "${target_dir}/*.xcworkspace" > /dev/null 2>&1; then
    detected_stacks+=("Swift/Apple (xcodebuild-mcp)")
  fi

  if [[ -f "${target_dir}/pyproject.toml" ]] || [[ -f "${target_dir}/requirements.txt" ]] || [[ -f "${target_dir}/Pipfile" ]]; then
    detected_stacks+=("Python (Environment & Linter MCP)")
  fi

  if [[ -f "${target_dir}/Cargo.toml" ]]; then
    detected_stacks+=("Rust (Cargo & Analyzer MCP)")
  fi

  if [[ -f "${target_dir}/go.mod" ]]; then
    detected_stacks+=("Go (gopls Toolchain MCP)")
  fi

  if [[ -f "${target_dir}/package.json" ]]; then
    detected_stacks+=("Node.js/Web (Chrome DevTools, Web APIs & Google Stitch MCP)")
  fi

  if [[ ${#detected_stacks[@]} -gt 0 ]]; then
    for stack in "${detected_stacks[@]}"; do
      echo "   [⚡] Terdeteksi stack: ${stack} (Siap disinkronkan otomatis)"
    done
  else
    echo "   [✓] Repositori universal (Polyglot core aktif tanpa dependensi khusus)."
  fi

  echo "================================================================="
  if [[ "$dry_run" == true ]]; then
    echo " 🔍 Simulasi Selesai! Tidak ada berkas yang diubah pada workspace."
  else
    echo " ✨ Berhasil! ${#SKILLS[@]} Skill Pero & AGENTS.md siap digunakan di:"
    echo " 📂 ${target_dir}"
  fi
  echo "================================================================="
}

# Eksekusi fungsi utama
main "$@"


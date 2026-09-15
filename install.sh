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
# 🚀 Pero Agent Skills - Antigravity Single-Harness Installer & Updater (v4.0)
# Creator: Pero (https://github.com/okyFaishal/pero-agent-skills)
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/okyFaishal/pero-agent-skills/main/install.sh | bash
#   Or: bash install.sh [TARGET_DIR] [--check] [--dry-run]
# ==============================================================================
set -euo pipefail

REPO_URL="https://github.com/okyFaishal/pero-agent-skills.git"

# 32 Universal Engineering & SDLC Skills
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
  "scientific-research"
  "pdf-reader"
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
# 2. MCP JSON Configuration Merger for Antigravity (Non-Destructive)
# ------------------------------------------------------------------------------
merge_mcp_json_file() {
  local target_json="$1"
  local servers_payload="$2"
  local dry_run="$3"

  if [[ "$dry_run" == true ]]; then
    echo "   [🔍 DRY-RUN] Akan menulis/menggabungkan konfigurasi MCP: ${target_json}"
    return 0
  fi

  local target_parent
  target_parent="$(dirname "$target_json")"
  mkdir -p "$target_parent"

  # Cadangkan jika berkas sudah ada sebelumnya
  if [[ -f "$target_json" ]]; then
    local timestamp
    timestamp="$(date +%Y%m%d_%H%M%S)"
    cp "$target_json" "${target_json}.bak_${timestamp}"
  fi

  if command -v python3 >/dev/null 2>&1; then
    python3 -c '
import json, sys, os

target_file = sys.argv[1]
new_servers = json.loads(sys.argv[2])

data = {}
if os.path.exists(target_file):
    try:
        with open(target_file, "r", encoding="utf-8") as f:
            content = f.read().strip()
            if content:
                data = json.loads(content)
    except Exception:
        data = {}

if not isinstance(data, dict):
    data = {}
if "mcpServers" not in data or not isinstance(data["mcpServers"], dict):
    data["mcpServers"] = {}

for s_name, s_cfg in new_servers.items():
    if s_name not in data["mcpServers"]:
        data["mcpServers"][s_name] = s_cfg
    else:
        existing_s = data["mcpServers"][s_name]
        if isinstance(existing_s, dict) and "env" in s_cfg:
            if "env" not in existing_s or not isinstance(existing_s["env"], dict):
                existing_s["env"] = s_cfg["env"]
            else:
                for env_k, env_v in s_cfg["env"].items():
                    if env_k not in existing_s["env"] or not existing_s["env"][env_k]:
                        existing_s["env"][env_k] = env_v

with open(target_file, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2)
' "$target_json" "$servers_payload"
  elif command -v node >/dev/null 2>&1; then
    node -e '
const fs = require("fs");
const targetFile = process.argv[1];
const newServers = JSON.parse(process.argv[2]);

let data = {};
if (fs.existsSync(targetFile)) {
  try {
    const raw = fs.readFileSync(targetFile, "utf8").trim();
    if (raw) data = JSON.parse(raw);
  } catch (e) {}
}

if (typeof data !== "object" || data === null || Array.isArray(data)) data = {};
if (!data.mcpServers || typeof data.mcpServers !== "object") data.mcpServers = {};

for (const [sName, sCfg] of Object.entries(newServers)) {
  if (!data.mcpServers[sName]) {
    data.mcpServers[sName] = sCfg;
  }
}
fs.writeFileSync(targetFile, JSON.stringify(data, null, 2));
' "$target_json" "$servers_payload"
  else
    if [[ ! -f "$target_json" ]]; then
      printf '{\n  "mcpServers": %s\n}\n' "$servers_payload" > "$target_json"
    fi
  fi
  echo "   [✓] Konfigurasi MCP aktif: ${target_json}"
}

setup_mcp_servers() {
  local target_dir="$1"
  local dry_run="$2"
  local source_dir="$3"

  echo "-> Menyiapkan konfigurasi Model Context Protocol (MCP) untuk Antigravity..."

  local has_npx=false
  if command -v npx >/dev/null 2>&1; then
    has_npx=true
    echo "   [✓] Runtime Node.js / npx terdeteksi (Siap menjalankan server MCP)."
  else
    echo "   [⚠️ ] Warning: npx tidak ditemukan di PATH. Pastikan Node.js terpasang untuk menjalankan MCP."
  fi

  local context7_key="${CONTEXT7_API_KEY:-}"
  local tavily_key="${TAVILY_API_KEY:-}"
  local stitch_key="${STITCH_API_KEY:-}"
  local semantic_scholar_key="${SEMANTIC_SCHOLAR_API_KEY:-}"

  if [[ -f "${target_dir}/.env" ]]; then
    [[ -z "$context7_key" ]] && context7_key=$(grep -E '^[[:space:]]*CONTEXT7_API_KEY=' "${target_dir}/.env" 2>/dev/null | head -n 1 | cut -d= -f2- | tr -d '"'\'' ' || echo "")
    [[ -z "$tavily_key" ]] && tavily_key=$(grep -E '^[[:space:]]*TAVILY_API_KEY=' "${target_dir}/.env" 2>/dev/null | head -n 1 | cut -d= -f2- | tr -d '"'\'' ' || echo "")
    [[ -z "$stitch_key" ]] && stitch_key=$(grep -E '^[[:space:]]*STITCH_API_KEY=' "${target_dir}/.env" 2>/dev/null | head -n 1 | cut -d= -f2- | tr -d '"'\'' ' || echo "")
    [[ -z "$semantic_scholar_key" ]] && semantic_scholar_key=$(grep -E '^[[:space:]]*SEMANTIC_SCHOLAR_API_KEY=' "${target_dir}/.env" 2>/dev/null | head -n 1 | cut -d= -f2- | tr -d '"'\'' ' || echo "")
  fi

  local target_env_example="${target_dir}/.env.pero.example"
  if [[ ! -f "$target_env_example" && -f "${source_dir}/.env.pero.example" ]]; then
    if [[ "$dry_run" == false ]]; then
      cp "${source_dir}/.env.pero.example" "$target_env_example"
      echo "   [🛡️ ] Berkas templat kunci API dibuat: ${target_env_example}"
    fi
  fi

  local has_graphify=false
  if command -v graphify >/dev/null 2>&1 || [[ -d "${target_dir}/graphify-out" ]]; then
    has_graphify=true
    echo "   [✓] Server MCP Graphify aktif (Peta relasi kode terdeteksi)."
  fi

  local servers_payload
  servers_payload=$(python3 -c '
import json, sys

context7_key = sys.argv[1]
tavily_key = sys.argv[2]
stitch_key = sys.argv[3]
semantic_scholar_key = sys.argv[4]
has_graphify = (sys.argv[5] == "true")

servers = {
  "context7": {
    "command": "npx",
    "args": ["-y", "@upstash/context7-mcp"],
    "env": {"CONTEXT7_API_KEY": context7_key or "${CONTEXT7_API_KEY}"}
  },
  "chrome-devtools": {
    "command": "npx",
    "args": ["-y", "chrome-devtools-mcp"]
  },
  "tavily": {
    "command": "npx",
    "args": ["-y", "@tavily/mcp-server"],
    "env": {"TAVILY_API_KEY": tavily_key or "${TAVILY_API_KEY}"}
  },
  "google-stitch": {
    "command": "npx",
    "args": ["-y", "@_davideast/stitch-mcp"],
    "env": {"STITCH_API_KEY": stitch_key or "${STITCH_API_KEY}"}
  },
  "semantic-scholar": {
    "command": "npx",
    "args": ["-y", "@xbghc/semanticscholar-mcp"],
    "env": {"SEMANTIC_SCHOLAR_API_KEY": semantic_scholar_key or "${SEMANTIC_SCHOLAR_API_KEY}"}
  }
}

if has_graphify:
  servers["graphify"] = {
    "command": "graphify",
    "args": [".", "--mcp"]
  }

print(json.dumps(servers))
' "$context7_key" "$tavily_key" "$stitch_key" "$semantic_scholar_key" "$has_graphify" 2>/dev/null || echo '{}')

  merge_mcp_json_file "${target_dir}/.mcp.json" "$servers_payload" "$dry_run"
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# 3. Main Operational Logic
# ------------------------------------------------------------------------------
main() {
  local target_dir=""
  local check_only=false
  local dry_run=false
  local is_update=false

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -u|--update)
        is_update=true
        shift
        ;;
      -y|--yes|--non-interactive)
        # Dipertahankan untuk kompatibilitas skrip otomasi/CI
        shift
        ;;
      --check)
        check_only=true
        shift
        ;;
      --dry-run)
        dry_run=true
        shift
        ;;
      --version|-v)
        echo "pero-agent-skills installer v4.0.0 (antigravity single-harness)"
        exit 0
        ;;
      --help|-h)
        echo "Penggunaan:"
        echo "  curl -fsSL https://raw.githubusercontent.com/okyFaishal/pero-agent-skills/main/install.sh | bash"
        echo "  Atau: bash install.sh [TARGET_DIR] [OPTIONS]"
        echo ""
        echo "Opsi:"
        echo "  --update, -u          Pembaruan instan modul skill & MCP ke versi terbaru"
        echo "  --check               Memeriksa integritas 32 modul skill, AGENTS.md, dan .mcp.json"
        echo "  --dry-run             Menampilkan simulasi tindakan tanpa menyalin atau mengubah berkas"
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
    echo " 🚀 Pero Agent Skills Health Check (v4.0 Antigravity)"
    echo " 📂 Target Workspace: ${target_dir}"
    echo "================================================================="
    echo "-> Memeriksa status kesehatan ${#SKILLS[@]} modul skill di target workspace..."
    local missing=0
    for skill in "${SKILLS[@]}"; do
      if [[ -d "${target_skills_dir}/${skill}" && -f "${target_skills_dir}/${skill}/SKILL.md" ]]; then
        echo "   [✓] ${skill}: Sehat & aktif."
      elif [[ -d "${target_dir}/skills/${skill}" && -f "${target_dir}/skills/${skill}/SKILL.md" ]]; then
        echo "   [✓] ${skill}: Sehat & aktif (repositori sumber SSOT)."
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

    echo "-> Memeriksa runtime pendukung & server MCP..."
    if command -v node >/dev/null 2>&1 && command -v npx >/dev/null 2>&1; then
      local node_v
      node_v="$(node -v 2>/dev/null || echo "ok")"
      echo "   [✓] Node.js / npx: Tersedia (${node_v})."
    else
      echo "   [⚠️ ] Node.js / npx: Tidak ditemukan di PATH (Dibutuhkan untuk server MCP npx)."
    fi

    if command -v python3 >/dev/null 2>&1; then
      echo "   [✓] Python 3: Tersedia (Engine JSON Merger aktif)."
    fi

    if [[ -f "${target_dir}/.mcp.json" ]]; then
      echo "   [✓] Konfigurasi MCP aktif: .mcp.json (Antigravity)."
    else
      echo "   [ℹ️ ] Belum ada .mcp.json di target. Jalankan 'install.sh ${target_dir}' untuk membuat otomatis."
    fi

    if [[ -n "${CONTEXT7_API_KEY:-}" ]]; then
      echo "   [🔑] CONTEXT7_API_KEY: Terdeteksi di environment."
    fi
    if [[ -n "${TAVILY_API_KEY:-}" ]]; then
      echo "   [🔑] TAVILY_API_KEY: Terdeteksi di environment."
    fi
    if [[ -n "${STITCH_API_KEY:-}" ]]; then
      echo "   [🔑] STITCH_API_KEY: Terdeteksi di environment."
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
  local source_root=""

  if [[ -n "$script_dir" && -d "${script_dir}/skills" && -f "${script_dir}/AGENTS.md" ]]; then
    echo "-> Menggunakan paket lokal (${script_dir})..."
    source_skills="${script_dir}/skills"
    source_agents_md="${script_dir}/AGENTS.md"
    source_root="${script_dir}"
  else
    echo "-> Mengunduh paket resmi dari GitHub (${REPO_URL})..."
    TEMP_DIR="$(mktemp -d)"
    local downloaded=false
    if command -v git >/dev/null 2>&1; then
      if git clone --depth 1 "$REPO_URL" "${TEMP_DIR}/repo" 2>/dev/null; then
        source_skills="${TEMP_DIR}/repo/skills"
        source_agents_md="${TEMP_DIR}/repo/AGENTS.md"
        source_root="${TEMP_DIR}/repo"
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
          source_root="${TEMP_DIR}/repo"
          downloaded=true
        fi
      fi
    fi

    if [[ "$downloaded" == false ]]; then
      echo "❌ Gagal mengunduh repositori. Pastikan koneksi internet, git, atau curl+tar tersedia." >&2
      exit 1
    fi
  fi

  # Banner Pemasangan / Pembaruan
  echo "================================================================="
  if [[ "$is_update" == true ]]; then
    echo " 🔄 Pero Agent Skills Updater (v4.0 Antigravity Single-Harness)"
  else
    echo " 🚀 Pero Agent Skills Installer (v4.0 Antigravity Single-Harness)"
  fi
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

    # Salin 32 Skill Universal
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

  # Proteksi .gitignore Otomatis (Termasuk .pero/)
  echo "-> Memeriksa perlindungan keamanan di .gitignore..."
  local touched_gitignore=false

  local security_rules=(
    ".env"
    ".env.*"
    "!.env.example"
    "!.env.*.example"
    "!.env.pero.example"
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

  # Penyiapan Server MCP untuk Antigravity (.mcp.json)
  setup_mcp_servers "$target_dir" "$dry_run" "$source_root"

  # Deteksi Stack Proyek & Informasi Ekstensi
  echo "-> Memeriksa manifest proyek untuk penyelarasan toolchain spesifik stack..."
  local detected_stacks=()

  if [[ -f "${target_dir}/Package.swift" ]] || compgen -G "${target_dir}/*.xcodeproj" > /dev/null 2>&1 || compgen -G "${target_dir}/*.xcworkspace" > /dev/null 2>&1; then
    detected_stacks+=("Swift/Apple (xcodebuild-mcp)")
  fi

  if [[ -f "${target_dir}/pyproject.toml" ]] || [[ -f "${target_dir}/requirements.txt" ]] || [[ -f "${target_dir}/Pipfile" ]]; then
    detected_stacks+=("Python (Environment & Linter)")
  fi

  if [[ -f "${target_dir}/Cargo.toml" ]]; then
    detected_stacks+=("Rust (Cargo & Analyzer)")
  fi

  if [[ -f "${target_dir}/go.mod" ]]; then
    detected_stacks+=("Go (gopls Toolchain)")
  fi

  if [[ -f "${target_dir}/package.json" ]]; then
    detected_stacks+=("Node.js/Web (Chrome DevTools, Web APIs & Google Stitch MCP)")
  fi

  if [[ ${#detected_stacks[@]} -gt 0 ]]; then
    for stack in "${detected_stacks[@]}"; do
      echo "   [⚡] Terdeteksi stack: ${stack} (Diselaraskan otomatis)"
    done
  else
    echo "   [✓] Repositori universal (Polyglot core aktif tanpa dependensi khusus)."
  fi

  echo "================================================================="
  if [[ "$dry_run" == true ]]; then
    echo " 🔍 Simulasi Selesai! Tidak ada berkas yang diubah pada workspace."
  elif [[ "$is_update" == true ]]; then
    echo " ✨ Pembaruan Berhasil! 32 Skill Pero, AGENTS.md, & .mcp.json terbarui di:"
    echo " 📂 ${target_dir}"
    echo " 💡 Antigravity siap melanjutkan pekerjaan dengan skill mutakhir."
  else
    echo " ✨ Berhasil! 32 Skill Pero, AGENTS.md, & .mcp.json siap digunakan di:"
    echo " 📂 ${target_dir}"
    echo " 💡 Antigravity otomatis membaca skill di .agents/skills/ & aturan di AGENTS.md"
  fi
  echo "================================================================="
}

# Eksekusi fungsi utama
main "$@"


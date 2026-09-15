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
# 🚀 Pero Agent Skills Universal Installer (Standalone v3.2)
# Creator: Pero (https://github.com/okyFaishal/pero-agent-skills)
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/okyFaishal/pero-agent-skills/main/install.sh | bash
#   Or: bash install.sh [TARGET_DIR] [-i|--interactive] [-y|--yes] [--with-graphify] [--check] [--dry-run]
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
  if ( true < /dev/tty && true > /dev/tty ) 2>/dev/null; then
    printf "\033[?25h" > /dev/tty 2>/dev/null || true
    stty echo icanon < /dev/tty 2>/dev/null || true
  fi
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
# 2.1. Universal MCP Provisioning & Non-Destructive JSON Merger
# ------------------------------------------------------------------------------
merge_mcp_json_file() {
  local target_json="$1"
  local servers_payload="$2"
  local dry_run="$3"

  if [[ "$dry_run" == true ]]; then
    echo "   [🔍 DRY-RUN] Akan menulis/menggabungkan konfigurasi MCP: ${target_json}"
    return 0
  fi

  local target_dir
  target_dir="$(dirname "$target_json")"
  mkdir -p "$target_dir"

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
new_servers_str = sys.argv[2]

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

try:
    new_servers = json.loads(new_servers_str)
except Exception:
    new_servers = {}

for s_name, s_cfg in new_servers.items():
    if s_name not in data["mcpServers"]:
        data["mcpServers"][s_name] = s_cfg
    else:
        # Jika server sudah ada, gabungkan env tanpa menimpa konfigurasi custom pengguna
        if isinstance(s_cfg, dict) and "env" in s_cfg:
            existing_s = data["mcpServers"][s_name]
            if isinstance(existing_s, dict) and "env" in existing_s:
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
const newServersStr = process.argv[2];

let data = {};
if (fs.existsSync(targetFile)) {
  try {
    const raw = fs.readFileSync(targetFile, "utf8").trim();
    if (raw) data = JSON.parse(raw);
  } catch (e) {}
}

if (typeof data !== "object" || data === null || Array.isArray(data)) data = {};
if (!data.mcpServers || typeof data.mcpServers !== "object") data.mcpServers = {};

let newServers = {};
try {
  newServers = JSON.parse(newServersStr);
} catch (e) {}

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
  local enable_claude="$3"
  local enable_cursor="$4"
  local enable_windsurf="$5"
  local enable_cline="$6"
  local source_dir="$7"
  local mcp_selection="${8:-all}"

  if [[ "$mcp_selection" == "none" ]]; then
    echo "-> Melewati konfigurasi Model Context Protocol (MCP) sesuai pilihan (none)..."
    return 0
  fi

  echo "-> Menyiapkan konfigurasi Model Context Protocol (MCP) terintegrasi..."

  # Periksa runtime npx / node
  local has_npx=false
  if command -v npx >/dev/null 2>&1; then
    has_npx=true
    echo "   [✓] Runtime Node.js / npx terdeteksi (Siap menjalankan server MCP)."
  else
    echo "   [⚠️ ] Warning: npx tidak ditemukan di PATH. Pastikan Node.js terpasang untuk menjalankan MCP."
  fi

  # Baca API Key dari environment atau .env lokal jika ada
  local context7_key="${CONTEXT7_API_KEY:-}"
  local brave_key="${BRAVE_API_KEY:-}"
  local tavily_key="${TAVILY_API_KEY:-}"
  local stitch_key="${STITCH_API_KEY:-}"

  if [[ -f "${target_dir}/.env" ]]; then
    if [[ -z "$context7_key" ]]; then
      context7_key=$(grep -E '^[[:space:]]*CONTEXT7_API_KEY=' "${target_dir}/.env" 2>/dev/null | head -n 1 | cut -d= -f2- | tr -d '"'\'' ' || echo "")
    fi
    if [[ -z "$brave_key" ]]; then
      brave_key=$(grep -E '^[[:space:]]*BRAVE_API_KEY=' "${target_dir}/.env" 2>/dev/null | head -n 1 | cut -d= -f2- | tr -d '"'\'' ' || echo "")
    fi
    if [[ -z "$tavily_key" ]]; then
      tavily_key=$(grep -E '^[[:space:]]*TAVILY_API_KEY=' "${target_dir}/.env" 2>/dev/null | head -n 1 | cut -d= -f2- | tr -d '"'\'' ' || echo "")
      if [[ -z "$tavily_key" ]]; then
        tavily_key=$(grep -E '^[[:space:]]*API_TAVILY=' "${target_dir}/.env" 2>/dev/null | head -n 1 | cut -d= -f2- | tr -d '"'\'' ' || echo "")
      fi
    fi
    if [[ -z "$stitch_key" ]]; then
      stitch_key=$(grep -E '^[[:space:]]*STITCH_API_KEY=' "${target_dir}/.env" 2>/dev/null | head -n 1 | cut -d= -f2- | tr -d '"'\'' ' || echo "")
    fi
  fi

  # Salin template .env.pero.example jika belum ada
  local target_env_example="${target_dir}/.env.pero.example"
  if [[ ! -f "$target_env_example" && -f "${source_dir}/.env.pero.example" ]]; then
    if [[ "$dry_run" == false ]]; then
      cp "${source_dir}/.env.pero.example" "$target_env_example"
      echo "   [🛡️ ] Berkas templat kunci API dibuat: ${target_env_example}"
    fi
  fi

  # Deteksi stack spesifik proyek
  local is_swift=false
  if [[ -f "${target_dir}/Package.swift" ]] || compgen -G "${target_dir}/*.xcodeproj" > /dev/null 2>&1 || compgen -G "${target_dir}/*.xcworkspace" > /dev/null 2>&1; then
    is_swift=true
  fi

  # Deteksi ketersediaan graphify
  local has_graphify=false
  if command -v graphify >/dev/null 2>&1 || [[ -d "${target_dir}/graphify-out" ]]; then
    has_graphify=true
    echo "   [✓] Server MCP Graphify aktif (Peta relasi kode terdeteksi)."
  else
    echo "   [ℹ️ ] Server MCP Graphify dilewati (Belum terpasang di PATH)."
    echo "       💡 Tips: Pasang terisolasi dengan: uv tool install graphifyy"
  fi

  # Tentukan server MCP yang aktif
  local enable_mcp_devtools=false
  local enable_mcp_context7=false
  local enable_mcp_tavily=false
  local enable_mcp_stitch=false

  case "$mcp_selection" in
    all|standard)
      enable_mcp_devtools=true
      enable_mcp_context7=true
      enable_mcp_tavily=true
      enable_mcp_stitch=true
      ;;
    minimal|zero-key)
      enable_mcp_devtools=true
      enable_mcp_context7=true
      enable_mcp_tavily=false
      enable_mcp_stitch=false
      ;;
    *)
      IFS=',' read -r -a selected_mcps <<< "$mcp_selection"
      for m in "${selected_mcps[@]}"; do
        case "$m" in
          devtools|chrome-devtools) enable_mcp_devtools=true ;;
          context7) enable_mcp_context7=true ;;
          tavily) enable_mcp_tavily=true ;;
          stitch|google-stitch) enable_mcp_stitch=true ;;
        esac
      done
      ;;
  esac

  local active_list=()
  [[ "$enable_mcp_devtools" == true ]] && active_list+=("Chrome DevTools")
  [[ "$enable_mcp_context7" == true ]] && active_list+=("Context7")
  [[ "$enable_mcp_tavily" == true ]] && active_list+=("Tavily")
  [[ "$enable_mcp_stitch" == true ]] && active_list+=("Google Stitch")
  [[ "$has_graphify" == true ]] && active_list+=("Graphify")
  [[ "$is_swift" == true ]] && active_list+=("Xcodebuild")

  if [[ ${#active_list[@]} -gt 0 ]]; then
    local old_ifs="$IFS"
    IFS=', '
    echo "   [✓] Server MCP yang dikonfigurasi: ${active_list[*]}"
    IFS="$old_ifs"
  else
    echo "   [ℹ️ ] Tidak ada server MCP yang diaktifkan."
  fi

  # Bangun payload JSON menggunakan python3 atau node
  local servers_payload
  servers_payload=$(python3 -c '
import json, sys

context7_key = sys.argv[1]
brave_key = sys.argv[2]
tavily_key = sys.argv[3]
stitch_key = sys.argv[4]
is_swift = (sys.argv[5] == "true")
has_graphify = (sys.argv[6] == "true")
enable_devtools = (sys.argv[7] == "true")
enable_context7 = (sys.argv[8] == "true")
enable_tavily = (sys.argv[9] == "true")
enable_stitch = (sys.argv[10] == "true")

servers = {}

if enable_devtools:
  servers["chrome-devtools"] = {
    "command": "npx",
    "args": ["-y", "chrome-devtools-mcp"]
  }

# Context7 MCP
if enable_context7:
  if context7_key:
    servers["context7"] = {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"],
      "env": {"CONTEXT7_API_KEY": context7_key}
    }
  else:
    servers["context7"] = {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"],
      "env": {"CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}"}
    }

# Tavily Search MCP
if enable_tavily:
  if tavily_key:
    servers["tavily"] = {
      "command": "npx",
      "args": ["-y", "@tavily/mcp-server"],
      "env": {"TAVILY_API_KEY": tavily_key}
    }
  else:
    servers["tavily"] = {
      "command": "npx",
      "args": ["-y", "@tavily/mcp-server"],
      "env": {"TAVILY_API_KEY": "${TAVILY_API_KEY}"}
    }

# Brave Search MCP (Ditambahkan jika kunci tersedia)
if brave_key:
  servers["brave-search"] = {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-brave-search"],
    "env": {"BRAVE_API_KEY": brave_key}
  }

# Google Stitch MCP
if enable_stitch:
  if stitch_key:
    servers["google-stitch"] = {
      "command": "npx",
      "args": ["-y", "@_davideast/stitch-mcp"],
      "env": {"STITCH_API_KEY": stitch_key}
    }
  else:
    servers["google-stitch"] = {
      "command": "npx",
      "args": ["-y", "@_davideast/stitch-mcp"],
      "env": {"STITCH_API_KEY": "${STITCH_API_KEY}"}
    }

# Graphify MCP
if has_graphify:
  servers["graphify"] = {
    "command": "graphify",
    "args": [".", "--mcp"]
  }

# Stack-specific (Swift)
if is_swift:
  servers["xcodebuild"] = {
    "command": "npx",
    "args": ["-y", "xcodebuild-mcp"]
  }

print(json.dumps(servers))
' "$context7_key" "$brave_key" "$tavily_key" "$stitch_key" "$is_swift" "$has_graphify" "$enable_mcp_devtools" "$enable_mcp_context7" "$enable_mcp_tavily" "$enable_mcp_stitch" 2>/dev/null || echo '{}')

  # 1. Selalu terapkan Universal MCP (.mcp.json di root proyek)
  merge_mcp_json_file "${target_dir}/.mcp.json" "$servers_payload" "$dry_run"

  # 2. Terapkan pada Cursor jika aktif
  if [[ "$enable_cursor" == true ]]; then
    merge_mcp_json_file "${target_dir}/.cursor/mcp.json" "$servers_payload" "$dry_run"
  fi

  # 3. Terapkan pada Windsurf jika aktif
  if [[ "$enable_windsurf" == true ]]; then
    merge_mcp_json_file "${target_dir}/.codeium/windsurf/mcp_config.json" "$servers_payload" "$dry_run"
    merge_mcp_json_file "${target_dir}/mcp_config.json" "$servers_payload" "$dry_run"
  fi

  # 4. Terapkan pada Claude Code jika aktif
  if [[ "$enable_claude" == true ]]; then
    merge_mcp_json_file "${target_dir}/.claude/mcp.json" "$servers_payload" "$dry_run"
  fi

  # 5. Terapkan pada Cline / Roo Code jika aktif
  if [[ "$enable_cline" == true ]]; then
    merge_mcp_json_file "${target_dir}/.vscode/cline_mcp_settings.json" "$servers_payload" "$dry_run"
  fi
}

# ------------------------------------------------------------------------------
# 2.5. Isolated Package Provisioning & Interactive Setup Wizard
# ------------------------------------------------------------------------------
install_graphify_safe() {
  local dry_run="$1"

  if command -v graphify >/dev/null 2>&1; then
    echo "   [✓] Graphify CLI sudah terpasang di sistem ($(command -v graphify))."
    return 0
  fi

  echo "-> Memasang Graphify CLI secara terisolasi (Anti-PEP 668)..."
  if [[ "$dry_run" == true ]]; then
    echo "   [🔍 DRY-RUN] Akan memasang Graphify via 'uv tool install graphifyy' atau 'pipx install graphifyy'"
    return 0
  fi

  if command -v uv >/dev/null 2>&1; then
    echo "   [⚡] Menjalankan: uv tool install graphifyy"
    if ( uv tool install graphifyy 2>&1 ); then
      echo "   [✓] Graphify berhasil dipasang via uv tool."
    else
      echo "   [⚠️ ] Warning: Gagal memasang graphify via uv tool. Pemasangan skill Pero tetap dilanjutkan."
    fi
  elif command -v pipx >/dev/null 2>&1; then
    echo "   [⚡] Menjalankan: pipx install graphifyy"
    if ( pipx install graphifyy 2>&1 ); then
      echo "   [✓] Graphify berhasil dipasang via pipx."
    else
      echo "   [⚠️ ] Warning: Gagal memasang graphify via pipx. Pemasangan skill Pero tetap dilanjutkan."
    fi
  else
    echo "   [⚠️ ] Warning: 'uv' atau 'pipx' tidak ditemukan di PATH."
    echo "       Untuk melindungi Python sistem (PEP 668), Graphify tidak dipasang via pip global."
    echo "       Rekomendasi: Pasang uv (https://astral.sh/uv) lalu jalankan: uv tool install graphifyy"
  fi
}

prompt_read() {
  local prompt_text="$1"
  local default_val="$2"
  local input_val=""

  if ! ( true < /dev/tty && true > /dev/tty ) 2>/dev/null; then
    echo "$default_val"
    return 0
  fi

  printf "\033[36m?\033[0m \033[1m%s\033[0m \033[90m(Default: %s)\033[0m: " "$prompt_text" > /dev/tty
  read -r input_val < /dev/tty || input_val=""
  if [[ -z "$input_val" ]]; then
    printf "\033[1A\r\033[K\033[32m✔\033[0m \033[1m%s\033[0m \033[90m›\033[0m \033[36m%s\033[0m\n" "$prompt_text" "$default_val" > /dev/tty
    echo "$default_val"
  else
    printf "\033[1A\r\033[K\033[32m✔\033[0m \033[1m%s\033[0m \033[90m›\033[0m \033[36m%s\033[0m\n" "$prompt_text" "$input_val" > /dev/tty
    echo "$input_val"
  fi
}

prompt_choice() {
  local prompt_title="$1"
  local default_idx="${2:-1}"
  shift 2
  local options=("$@")
  local num=${#options[@]}

  # Jika terminal bukan TTY interaktif, langsung gunakan opsi default
  if ! ( true < /dev/tty && true > /dev/tty ) 2>/dev/null; then
    echo "$default_idx"
    return 0
  fi

  local cur=$((default_idx - 1))
  if (( cur < 0 || cur >= num )); then
    cur=0
  fi

  # Simpan state terminal saat ini
  local old_stty
  old_stty=$(stty -g < /dev/tty 2>/dev/null) || old_stty=""

  restore_menu_tty() {
    printf "\033[?25h" > /dev/tty 2>/dev/null
    if [[ -n "$old_stty" ]]; then
      stty "$old_stty" < /dev/tty 2>/dev/null
    else
      stty echo icanon < /dev/tty 2>/dev/null
    fi
  }

  # Masuk ke raw mode (-echo cegah bocor ^[[B ke layar, -icanon baca instan per-karakter)
  if ! stty -echo -icanon min 1 time 0 < /dev/tty 2>/dev/null; then
    echo "$default_idx"
    return 0
  fi

  trap 'restore_menu_tty; exit 130' INT TERM
  printf "\033[?25l" > /dev/tty

  echo "" > /dev/tty
  printf "\033[36m?\033[0m \033[1m%s\033[0m \033[90m(Gunakan ↑/↓ lalu Enter)\033[0m\n" "$prompt_title" > /dev/tty
  for i in "${!options[@]}"; do
    if [[ "$i" -eq "$cur" ]]; then
      printf "  \033[36m› ◉  %s\033[0m\n" "${options[$i]}" > /dev/tty
    else
      printf "    \033[90m○  %s\033[0m\n" "${options[$i]}" > /dev/tty
    fi
  done

  while true; do
    local key=""
    IFS= read -r -s -n 1 key < /dev/tty || key=""

    # Enter (konfirmasi pilihan saat ini)
    if [[ -z "$key" || "$key" == $'\n' || "$key" == $'\r' ]]; then
      break
    fi

    # Spasi (konfirmasi pilihan saat ini)
    if [[ "$key" == " " ]]; then
      break
    fi

    # Shortcut angka 1..num
    if [[ "$key" =~ ^[1-9]$ ]]; then
      local n=$((key - 1))
      if (( n >= 0 && n < num )); then
        cur=$n
        break
      fi
    fi

    # Vim keys: k (up), j (down)
    if [[ "$key" == "k" || "$key" == "K" ]]; then
      if (( cur > 0 )); then
        cur=$((cur - 1))
      else
        cur=$((num - 1))
      fi
    elif [[ "$key" == "j" || "$key" == "J" ]]; then
      if (( cur < num - 1 )); then
        cur=$((cur + 1))
      else
        cur=0
      fi
    elif [[ "$key" == $'\x1b' ]]; then
      local rest=""
      read -r -s -n 2 -t 1 rest < /dev/tty || rest=""
      case "$rest" in
        "[A"|"OA") # Panah Atas
          if (( cur > 0 )); then
            cur=$((cur - 1))
          else
            cur=$((num - 1))
          fi
          ;;
        "[B"|"OB") # Panah Bawah
          if (( cur < num - 1 )); then
            cur=$((cur + 1))
          else
            cur=0
          fi
          ;;
        *)
          continue
          ;;
      esac
    else
      continue
    fi

    # Gambar ulang opsi pilihan dengan penunjuk baru
    printf "\033[%dA" "$num" > /dev/tty
    for i in "${!options[@]}"; do
      if [[ "$i" -eq "$cur" ]]; then
        printf "\r\033[K  \033[36m› ◉  %s\033[0m\n" "${options[$i]}" > /dev/tty
      else
        printf "\r\033[K    \033[90m○  %s\033[0m\n" "${options[$i]}" > /dev/tty
      fi
    done
  done

  # Bersihkan daftar opsi & judul pertanyaan menjadi satu baris konfirmasi ringkas
  for ((i = 0; i < num; i++)); do
    printf "\033[1A\r\033[K" > /dev/tty
  done
  printf "\033[1A\r\033[K" > /dev/tty

  local selected_text="${options[$cur]}"
  printf "\033[32m✔\033[0m \033[1m%s\033[0m \033[90m›\033[0m \033[36m%s\033[0m\n" "$prompt_title" "$selected_text" > /dev/tty

  restore_menu_tty
  trap - INT TERM

  echo "$((cur + 1))"
}

run_interactive_wizard() {
  echo "" > /dev/tty
  echo "=================================================================" > /dev/tty
  echo " 🧙 Pero Agent Skills Setup Wizard" > /dev/tty
  echo " Pemandu pemasangan 30 Universal SDLC Skills ke proyek Anda." > /dev/tty
  echo " Gunakan tombol [↑/↓] lalu [Enter] untuk memilih." > /dev/tty
  echo "=================================================================" > /dev/tty
  echo "" > /dev/tty

  # 1. Target Workspace Directory
  local default_dir="${target_dir:-.}"
  local dir_choice
  dir_choice="$(prompt_read "Direktori target proyek" "${default_dir}")"
  target_dir="${dir_choice:-$default_dir}"

  # 2. Fast-Track Gate: Gunakan Rekomendasi (Ala create-next-app)
  local rec_choice
  rec_choice="$(prompt_choice "Ingin menggunakan konfigurasi rekomendasi Pero?" 1 \
    "Ya, gunakan rekomendasi (Auto-detect IDE + Standar MCP)" \
    "Tidak, kustomisasi pengaturan manual (Pilih IDE & MCP)")"

  if [[ "$rec_choice" == "1" ]]; then
    harness_explicit=false
    mcp_arg="all"
    mcp_explicit=false
    with_graphify=false
    echo "" > /dev/tty
    echo "✨ Pengaturan rekomendasi aktif: Auto-Detect IDE & Standar MCP." > /dev/tty
    echo "" > /dev/tty
    return 0
  fi

  # 3. Kustomisasi: AI Coding Harness
  local harness_choice
  harness_choice="$(prompt_choice "Pilih integrasi asisten koding (AI Coding Harness):" 1 \
    "Auto-Detect: Deteksi otomatis sesuai folder IDE di proyek (Rekomendasi)" \
    "Universal All: Pasang untuk semua IDE (Cursor, Claude Code, Windsurf, Cline)" \
    "Kustom: Pilih asisten koding tertentu satu per satu")"

  case "$harness_choice" in
    2)
      harness_arg="all"
      harness_explicit=true
      ;;
    3)
      local chosen_harness=()
      local c_cursor
      c_cursor="$(prompt_choice "Pasang adapter Cursor (.cursorrules & .cursor/rules)?" 1 "Ya" "Tidak")"
      [[ "$c_cursor" == "1" ]] && chosen_harness+=("cursor")

      local c_claude
      c_claude="$(prompt_choice "Pasang adapter Claude Code (CLAUDE.md)?" 1 "Ya" "Tidak")"
      [[ "$c_claude" == "1" ]] && chosen_harness+=("claude")

      local c_windsurf
      c_windsurf="$(prompt_choice "Pasang adapter Windsurf (.windsurfrules)?" 1 "Ya" "Tidak")"
      [[ "$c_windsurf" == "1" ]] && chosen_harness+=("windsurf")

      local c_cline
      c_cline="$(prompt_choice "Pasang adapter Cline / Roo Code (.clinerules)?" 1 "Ya" "Tidak")"
      [[ "$c_cline" == "1" ]] && chosen_harness+=("cline")

      if [[ ${#chosen_harness[@]} -eq 0 ]]; then
        harness_arg="antigravity"
      else
        local old_ifs="$IFS"
        IFS=','
        harness_arg="${chosen_harness[*]}"
        IFS="$old_ifs"
      fi
      harness_explicit=true
      ;;
    *)
      harness_explicit=false
      ;;
  esac

  # 4. Kustomisasi: Model Context Protocol (MCP)
  local mcp_choice
  mcp_choice="$(prompt_choice "Pilih konfigurasi Model Context Protocol (MCP):" 1 \
    "Standar Pero: Context7, Chrome DevTools, Tavily, Google Stitch (Rekomendasi)" \
    "Minimal / Zero-Key: Context7 & Chrome DevTools saja (Bebas API Key)" \
    "Kustom: Tentukan server MCP secara manual satu per satu" \
    "Lewati: Jangan pasang konfigurasi server MCP (.mcp.json)")"

  case "$mcp_choice" in
    2)
      mcp_arg="minimal"
      mcp_explicit=true
      ;;
    3)
      local chosen_mcps=()
      local m_context7
      m_context7="$(prompt_choice "Pasang Context7 MCP (Dokumentasi resmi library/API)?" 1 "Ya" "Tidak")"
      [[ "$m_context7" == "1" ]] && chosen_mcps+=("context7")

      local m_devtools
      m_devtools="$(prompt_choice "Pasang Chrome DevTools MCP (Debugging browser/frontend)?" 1 "Ya" "Tidak")"
      [[ "$m_devtools" == "1" ]] && chosen_mcps+=("chrome-devtools")

      local m_tavily
      m_tavily="$(prompt_choice "Pasang Tavily Search MCP (Riset web mendalam)?" 1 "Ya" "Tidak")"
      [[ "$m_tavily" == "1" ]] && chosen_mcps+=("tavily")

      local m_stitch
      m_stitch="$(prompt_choice "Pasang Google Stitch MCP (Desain prototipe UI/UX visual)?" 1 "Ya" "Tidak")"
      [[ "$m_stitch" == "1" ]] && chosen_mcps+=("stitch")

      if [[ ${#chosen_mcps[@]} -eq 0 ]]; then
        mcp_arg="none"
      else
        local old_ifs="$IFS"
        IFS=','
        mcp_arg="${chosen_mcps[*]}"
        IFS="$old_ifs"
      fi
      mcp_explicit=true
      ;;
    4)
      mcp_arg="none"
      mcp_explicit=true
      ;;
    *)
      mcp_arg="all"
      mcp_explicit=false
      ;;
  esac

  # 5. Peta Graf Kode (Graphify CLI)
  if command -v graphify >/dev/null 2>&1; then
    with_graphify=false
  else
    local g_choice
    g_choice="$(prompt_choice "Peta Graf Kode (Graphify CLI untuk X-ray arsitektur):" 1 \
      "Lewati untuk sekarang (Rekomendasi)" \
      "Pasang Graphify secara terisolasi via uv/pipx")"
    if [[ "$g_choice" == "2" ]]; then
      with_graphify=true
    else
      with_graphify=false
    fi
  fi

  # 6. Ringkasan & Konfirmasi
  echo "" > /dev/tty
  echo "-----------------------------------------------------------------" > /dev/tty
  echo "📋 Ringkasan Rencana Pemasangan:" > /dev/tty
  echo "   - Target Direktori : ${target_dir}" > /dev/tty
  if [[ "$harness_explicit" == true ]]; then
    echo "   - Harness Adapter  : ${harness_arg}" > /dev/tty
  else
    echo "   - Harness Adapter  : Auto-Detect (Cerdas)" > /dev/tty
  fi
  case "$mcp_arg" in
    none)
      echo "   - Konfigurasi MCP  : Dilewati (Tanpa .mcp.json)" > /dev/tty
      ;;
    minimal)
      echo "   - Konfigurasi MCP  : Minimal (Context7 & Chrome DevTools)" > /dev/tty
      ;;
    all)
      echo "   - Konfigurasi MCP  : Standar Pero (Context7, DevTools, Tavily, Stitch)" > /dev/tty
      ;;
    *)
      echo "   - Konfigurasi MCP  : Kustom (${mcp_arg})" > /dev/tty
      ;;
  esac
  if [[ "$with_graphify" == true ]]; then
    echo "   - Pasang Graphify  : Ya (Terisolasi via uv/pipx)" > /dev/tty
  else
    echo "   - Pasang Graphify  : Tidak (Bawaan)" > /dev/tty
  fi
  echo "-----------------------------------------------------------------" > /dev/tty

  local confirm_choice
  confirm_choice="$(prompt_choice "Mulai proses instalasi sekarang?" 1 \
    "Ya, mulai proses pemasangan" \
    "Batal")"
  if [[ "$confirm_choice" != "1" ]]; then
    echo "" > /dev/tty
    echo "❌ Pemasangan dibatalkan oleh pengguna." > /dev/tty
    exit 0
  fi
  echo "" > /dev/tty
}

# ------------------------------------------------------------------------------
# 3. Main Operational Logic
# ------------------------------------------------------------------------------
main() {
  local target_dir=""
  local check_only=false
  local dry_run=false
  local harness_arg="antigravity"
  local harness_explicit=false
  local mcp_arg="all"
  local mcp_explicit=false
  local force_interactive=false
  local force_non_interactive=false
  local with_graphify=false
  local is_update=false
  local original_argc=$#

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -u|--update)
        is_update=true
        force_non_interactive=true
        shift
        ;;
      -i|--interactive)
        force_interactive=true
        shift
        ;;
      -y|--yes|--non-interactive)
        force_non_interactive=true
        shift
        ;;
      --with-graphify)
        with_graphify=true
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
      --harness=*)
        harness_arg="${1#*=}"
        harness_explicit=true
        shift
        ;;
      -H|--harness)
        harness_arg="$2"
        harness_explicit=true
        shift 2
        ;;
      --mcp=*)
        mcp_arg="${1#*=}"
        mcp_explicit=true
        shift
        ;;
      --no-mcp)
        mcp_arg="none"
        mcp_explicit=true
        shift
        ;;
      --version|-v)
        echo "pero-agent-skills installer v3.2.0 (standalone)"
        exit 0
        ;;
      --help|-h)
        echo "Penggunaan: install.sh [TARGET_DIR] [OPTIONS]"
        echo ""
        echo "Opsi:"
        echo "  --interactive, -i     Menjalankan wizard interaktif step-by-step"
        echo "  --yes, -y             Mode otomatis tanpa prompt (gunakan deteksi cerdas)"
        echo "  --update, -u          Pembaruan instan modul skill & MCP ke versi terbaru"
        echo "  --with-graphify       Pasang Graphify CLI secara terisolasi (via uv/pipx)"
        echo "  --check               Memeriksa integritas 30 modul skill dan AGENTS.md"
        echo "  --dry-run             Menampilkan simulasi tindakan tanpa menyalin berkas"
        echo "  --harness=<list>      Pasang adapter harness (antigravity, claude, cursor, windsurf, cline, all)"
        echo "  --mcp=<list>          Pilih server MCP (all, minimal, none, atau daftar: context7,chrome-devtools,tavily,stitch)"
        echo "  --no-mcp              Lewati pembuatan konfigurasi server MCP"
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

  # Tentukan apakah wizard interaktif harus dijalankan:
  # 1. Jika --check aktif -> Jangan jalankan wizard.
  # 2. Jika --yes / -y / --non-interactive -> Jangan jalankan wizard.
  # 3. Jika --interactive / -i -> Wajib jalankan wizard (jika /dev/tty ada).
  # 4. Jika dijalankan tanpa argumen (original_argc == 0) dan terminal interaktif fisik tersedia:
  #    ([ -r /dev/tty ] && [ -w /dev/tty ]) -> Jalankan wizard interaktif ramah (termasuk via curl | bash).
  local should_run_wizard=false
  if [[ "$check_only" == false && "$force_non_interactive" == false ]]; then
    if [[ "$force_interactive" == true ]]; then
      if ! ( true < /dev/tty && true > /dev/tty ) 2>/dev/null; then
        echo "❌ Error: Opsi --interactive memerlukan terminal interaktif fisik (/dev/tty tidak tersedia)." >&2
        exit 1
      fi
      should_run_wizard=true
    elif [[ "$original_argc" -eq 0 ]] && ( true < /dev/tty && true > /dev/tty ) 2>/dev/null; then
      should_run_wizard=true
    fi
  fi

  if [[ "$should_run_wizard" == true ]]; then
    run_interactive_wizard
  fi

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
    echo " 🚀 Pero Agent Skills Universal Installer (v3.2 Standalone)"
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

    # Audit Berkas Konfigurasi MCP
    local mcp_configs=()
    [[ -f "${target_dir}/.mcp.json" ]] && mcp_configs+=(".mcp.json (Universal)")
    [[ -f "${target_dir}/.cursor/mcp.json" ]] && mcp_configs+=(".cursor/mcp.json (Cursor)")
    [[ -f "${target_dir}/.codeium/windsurf/mcp_config.json" ]] && mcp_configs+=(".codeium/windsurf/mcp_config.json (Windsurf)")
    [[ -f "${target_dir}/mcp_config.json" ]] && mcp_configs+=("mcp_config.json (Windsurf Root)")
    [[ -f "${target_dir}/.claude/mcp.json" ]] && mcp_configs+=(".claude/mcp.json (Claude Code)")
    [[ -f "${target_dir}/.vscode/cline_mcp_settings.json" ]] && mcp_configs+=(".vscode/cline_mcp_settings.json (Cline / Roo Code)")

    if [[ ${#mcp_configs[@]} -gt 0 ]]; then
      echo "   [✓] Berkas konfigurasi MCP aktif:"
      for cfg in "${mcp_configs[@]}"; do
        echo "       - ${cfg}"
      done
    else
      echo "   [ℹ️ ] Belum ada berkas konfigurasi MCP di target. Jalankan 'install.sh ${target_dir}' untuk membuat otomatis."
    fi

    # Cek kunci pencarian opsional
    if [[ -n "${BRAVE_API_KEY:-}" ]]; then
      echo "   [🔑] BRAVE_API_KEY: Terdeteksi di environment."
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
    echo " 🔄 Pero Agent Skills Universal Updater (v3.2 Standalone)"
  else
    echo " 🚀 Pero Agent Skills Universal Installer (v3.2 Standalone)"
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

  # Pasang Harness Adapters Sesuai Pilihan & Deteksi Otomatis
  local enable_claude=false
  local enable_cursor=false
  local enable_windsurf=false
  local enable_cline=false

  if [[ "$harness_explicit" == true ]]; then
    echo "-> Menyiapkan adapter asisten pengkodean (Harness ditentukan: ${harness_arg})..."
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
  else
    echo "-> Mendeteksi lingkungan asisten pengkodean (Harness Auto-Detection)..."
    local any_detected=false
    if [[ -d "${target_dir}/.cursor" || -f "${target_dir}/.cursorrules" ]]; then
      enable_cursor=true
      any_detected=true
      echo "   [🔍] Terdeteksi konfigurasi Cursor."
    fi
    if [[ -d "${target_dir}/.codeium" || -d "${target_dir}/.windsurf" || -f "${target_dir}/.windsurfrules" ]]; then
      enable_windsurf=true
      any_detected=true
      echo "   [🔍] Terdeteksi konfigurasi Windsurf."
    fi
    if [[ -d "${target_dir}/.claude" || -f "${target_dir}/CLAUDE.md" ]]; then
      enable_claude=true
      any_detected=true
      echo "   [🔍] Terdeteksi konfigurasi Claude Code."
    fi
    if [[ -d "${target_dir}/.vscode" || -f "${target_dir}/.clinerules" ]]; then
      enable_cline=true
      any_detected=true
      echo "   [🔍] Terdeteksi konfigurasi Cline / Roo Code."
    fi

    # Jika proyek baru tanpa folder harness khusus, aktifkan Cursor & Universal sebagai standar terpopuler
    if [[ "$any_detected" == false ]]; then
      enable_cursor=true
      echo "   [ℹ️ ] Tidak terdeteksi folder IDE khusus, mengaktifkan adapter standar Cursor & Universal."
    fi
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

  # ------------------------------------------------------------------------------
  # Penyiapan Server MCP Universal & Otomatis (MCP Auto-Provisioning)
  # ------------------------------------------------------------------------------
  if [[ "$with_graphify" == true ]]; then
    install_graphify_safe "$dry_run"
  fi

  setup_mcp_servers "$target_dir" "$dry_run" "$enable_claude" "$enable_cursor" "$enable_windsurf" "$enable_cline" "$source_root" "$mcp_arg"

  # ------------------------------------------------------------------------------
  # Deteksi Stack Proyek & Informasi Ekstensi
  # ------------------------------------------------------------------------------
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
    echo " ✨ Pembaruan Berhasil! Seluruh ${#SKILLS[@]} Skill Pero & AGENTS.md terbarui di:"
    echo " 📂 ${target_dir}"
  else
    echo " ✨ Berhasil! ${#SKILLS[@]} Skill Pero & AGENTS.md siap digunakan di:"
    echo " 📂 ${target_dir}"
  fi
  echo "================================================================="
}

# Eksekusi fungsi utama
main "$@"


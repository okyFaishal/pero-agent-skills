#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." 2>/dev/null && pwd || exit 1)"
TEST_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "$TEST_DIR"
}
trap cleanup EXIT INT TERM

echo "-> Testing Cursor adapter symlink resolution..."
TARGET_WORKSPACE="${TEST_DIR}/nested/test_app"

# Jalankan install.sh dengan harness cursor ke workspace yang belum ada
bash "${REPO_ROOT}/install.sh" "$TARGET_WORKSPACE" --harness cursor

MDC_FILE="${TARGET_WORKSPACE}/.cursor/rules/pero-agent-skills.mdc"
if [[ ! -L "$MDC_FILE" ]]; then
  echo "❌ FAIL: $MDC_FILE bukan symlink"
  exit 1
fi

LINK_TARGET="$(readlink "$MDC_FILE")"
echo "   Link target: $LINK_TARGET"

if [[ "$LINK_TARGET" != "../../AGENTS.md" ]]; then
  echo "❌ FAIL: Target symlink salah! Diharapkan '../../AGENTS.md', diperoleh '$LINK_TARGET'"
  exit 1
fi

if ! cat "$MDC_FILE" >/dev/null 2>&1; then
  echo "❌ FAIL: Symlink broken, tidak dapat membaca AGENTS.md melalui $MDC_FILE"
  exit 1
fi

echo "-> Testing --dry-run disk immutability..."
DRY_RUN_DIR="${TEST_DIR}/dry_run_target"
bash "${REPO_ROOT}/install.sh" "$DRY_RUN_DIR" --dry-run >/dev/null 2>&1
if [[ -d "$DRY_RUN_DIR" ]]; then
  echo "❌ FAIL: --dry-run membuat folder fisik di disk!"
  exit 1
fi

echo "✓ PASS: Cursor adapter symlink and dry-run verified successfully"

echo "-> Testing remote fallback download logic..."
grep -q "tarball_url" "${REPO_ROOT}/install.sh"
grep -q "tar -xzf -" "${REPO_ROOT}/install.sh"
echo "✓ PASS: Tarball fallback logic is in place"

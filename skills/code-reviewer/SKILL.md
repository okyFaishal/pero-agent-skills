---
name: code-reviewer
description: Use when completing tasks, implementing major features, or before merging to verify work meets requirements and quality standards
---

# Universal Two-Stage Code Reviewer

## Core Principles

1. **Retrieval Over Pre-Training**: Jangan mengasumsikan signature fungsi atau tipe data dari ingatan AI. Selalu buka dan baca file tipe lokal (`.d.ts`, `.proto`, DTO, atau schema definitions) di workspace.
2. **Full File Context**: Baca berkas secara utuh, bukan hanya potongan *diff*. Kode yang tampak janggal dalam isolasi sering kali valid jika dilihat bersama alur penanganannya.
3. **Tool Output as Evidence**: Opini subjektif wajib dibuktikan dengan eksekusi nyata dari *compiler*, *linter*, dan *type-checker* lokal.

---

## 4-Step Review Workflow

### Step 1: Build Context & Grounding
- [ ] Baca berkas target secara utuh di sekitar area perubahan.
- [ ] Buka file kontrak/skema lokal yang menjadi rujukan untuk memvalidasi tipe data & signature.
- [ ] Periksa konteks riwayat perubahan jika diperlukan: `git log --oneline -5 -- <file>`.

### Step 2: Categorize the Code
Tentukan kategori kode yang sedang ditinjau untuk menetapkan standar toleransi:
- **Illustrative (Contoh/Snippet Konsep)**: Wajib memiliki penamaan API yang realistis dan penjelasan logika yang benar.
- **Demonstrative (Cuplikan Fungsional)**: Wajib valid secara sintaksis dan sesuai dengan kontrak antarmuka.
- **Executable (Kode Produksi)**: Wajib 100% *compile*, lulus *linter*, memiliki *unit test*, dan aman dari celah keamanan.

### Step 3: Run Polyglot Tooling Checks
Jalankan alat validasi statis sesuai ekosistem bahasa proyek sebelum memberikan penilaian:
- **TypeScript/JS**: `npx tsc --noEmit` & `npx eslint <files>`
- **Python**: `mypy <files>` & `ruff check <files>`
- **Go**: `go vet ./...` & `golangci-lint run`
- **Rust**: `cargo check` & `cargo clippy`
- **Swift / Mobile / Lainnya**: Eksekusi *linter* atau *build check* lokal yang relevan.

### Step 4: Two-Stage Gatekeeper Audit

#### Gate 1: Spec & Interface Compliance
- [ ] **Acceptance Criteria**: Apakah seluruh kriteria penerimaan pada PRD/Story terpenuhi?
- [ ] **Anti-Bloat (YAGNI)**: Tidak ada kode ekstra atau fitur sampingan yang tidak diminta.
- [ ] **Contract Alignment**: Payload dan antarmuka publik sesuai kontrak yang disepakati.

#### Gate 2: Code Quality, Concurrency & Security
- [ ] **Concurrency & Race Conditions**: Aman dari benturan data bersama (thread-safety, async locking).
- [ ] **Resource Management**: Tidak ada kebocoran memori (*memory leak*), koneksi database yang menggantung, atau file descriptor yang tidak ditutup.
- [ ] **Error Handling**: Tidak ada error yang ditelan tanpa log (*no silent empty catch/except*).
- [ ] **Security Guardrails**: Input disanitasi (bebas SQLi, XSS, Path Traversal) dan nol kebocoran *secret/API key*.
- [ ] **Test Coverage**: Memiliki pengujian otomatis untuk kasus positif (*happy path*), kasus gagal (*edge cases*), dan nilai batas (*boundary*).

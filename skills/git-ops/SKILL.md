---
name: git-ops
description: Master Git and GitHub operations guide. Use when creating branches, managing git worktrees, crafting ultra-compressed semantic commits (caveman style), configuring .github templates, or running gh CLI commands.
---

# Universal Git & GitHub Operations (`git-ops`)

## Overview
**Origin**: *Conventional Commits + Caveman Commit Pattern + GitHub Enterprise Standards*.  
Skill ini adalah **"Manajer Gedung Arsip & Pengendali Sistem GitHub"**. Mengatur alur kerja kontrol versi (*version control*), isolasi meja kerja agen (*worktrees*), standar penulisan pesan commit ultra-padat, template tata kelola repositori (`.github/`), dan operasi terminal via `gh` CLI.

> **Analogi Sederhana ("Bahasa Bayi" / ELI5):**  
> - **Git** seperti **buku catatan riwayat proyek**: mencatat setiap perubahan, siapa yang mengubah, dan kapan diubah agar tidak ada halaman yang hilang.  
> - **GitHub** seperti **gedung pusat penyimpanan buku arsip online**: tempat tim bekerja bersama dan membuat formulir kerja (*PR & Issue templates*).  
> - **Skill `git-ops`** adalah **buku aturan satpam gedung**: memastikan meja kerja rapi, tidak ada sampah yang masuk, pesan catatan ditulis singkat padat (tanpa dongeng), dan brankas utama (`main`) selalu digembok aman.

---

## When to Use
- Menyimpan perubahan kode dengan pesan commit terstruktur (*semantic commit*).
- Membuat cabang kerja terisolasi (*branch*) atau meja kerja paralel (*git worktrees*) untuk pengerjaan fitur besar.
- Menyiapkan berkas tata kelola repositori di `.github/` (Issue Templates, PR Template, `CODEOWNERS`, `dependabot.yml`).
- Mengoperasikan GitHub dari terminal menggunakan `gh` CLI (membuat PR, merilis versi, mengelola issue).
- Menegakkan perlindungan cabang dan kebersihan repositori.

---

## 1. Protokol Pesan Commit Ultra-Padat (*Caveman Commit Protocol*)

Prinsip utama: **Mengutamakan Alasan (*Why over What*) & Tanpa Basa-Basi (*Zero Fluff*)**. Kode diff sudah menunjukkan apa yang berubah, pesan commit menjelaskan mengapa perubahan itu diperlukan.

### A. Format Baris Subjek (*Subject Line*)
```text
<type>(<scope>): <ringkasan imperatif pendek>
```
* **Panjang**: Idealnya ≤50 karakter (batas keras 72 karakter), tanpa titik di akhir kalimat.
* **Kata Kerja Imperatif**: Gunakan kata perintah waktu sekarang (contoh: `add`, `fix`, `refactor`, `remove` — **DILARANG**: `added`, `adds`, `fixing`).
* **Tipe Baku (*Conventional Types*)**:
  - `feat`: Fungsionalitas atau fitur baru bagi pengguna.
  - `fix`: Perbaikan bug atau penambalan celah error.
  - `refactor`: Perapian kode internal tanpa mengubah perilaku luar.
  - `perf`: Peningkatan performa dan optimasi kecepatan.
  - `test`: Penambahan atau perbaikan unit test / integration test.
  - `docs`: Pembaruan dokumentasi, README, atau spesifikasi PRD.
  - `chore`: Pemeliharaan dependensi, konfigurasi build, atau tooling.

### B. Isi Pesan (*Body - Hanya Jika Diperlukan*)
* **Lewatkan Body** jika baris subjek sudah sangat jelas sendiri.
* **Wajib Tambahkan Body** HANYA untuk:
  1. Alasan bisnis/teknis yang tidak terlihat dari kode (*non-obvious why*).
  2. Perubahan yang merusak kompatibilitas (*Breaking Changes* diawali tanda `!` atau blok `BREAKING CHANGE:`).
  3. Catatan migrasi data atau perbaikan isu keamanan sensitif.
  4. Penutupan tiket issue (`Closes #42`).
* Gunakan poin `-` (bukan `*`), bungkus baris maksimal pada 72 karakter.

### C. Daftar Pantangan Pesan Commit (*What NEVER Goes In*)
- ❌ Kata-kata dongeng bertele-tele: *"This commit does X"*, *"I fixed"*, *"We now changed"*.
- ❌ Watermark atau atribusi AI: *"Generated with Claude Code / Antigravity"* (kecuali aturan tim mewajibkan trailer khusus).
- ❌ Mengulang nama file jika sudah ditulis di bagian `<scope>`.

### D. Contoh Nyata:
```text
# Contoh 1: Fitur baru dengan alasan bandwidth
feat(auth): add google one-tap login

Mobile client needs one-tap to reduce friction on onboarding screen.

Closes #88

# Contoh 2: Perubahan yang merusak kompatibilitas (Breaking Change)
feat(api)!: rename /v1/orders to /v1/checkout

BREAKING CHANGE: clients must migrate to /v1/checkout before 2026-09-01.
Old route will return 410 Gone after that date.
```

---

## 2. Manajemen Cabang & Meja Gandeng (*Branching & Worktrees*)

### A. Pola Penamaan Cabang (*Branch Naming*)
- `feat/<nama-fitur-singkat>` (contoh: `feat/payment-gateway`)
- `fix/<nama-bug-singkat>` (contoh: `fix/token-expiry`)
- `refactor/<nama-komponen>` (contoh: `refactor/user-service`)

### B. Isolasi Meja Kerja Agen (*Git Worktrees*)
Saat agen AI mengerjakan fitur besar atau eksplorasi terpisah tanpa mengganggu cabang aktif saat ini:
```bash
# Membuat meja kerja terpisah di folder tetangga
git worktree add ../fitur-baru feat/fitur-baru

# Setelah selesai dan digabung, bersihkan meja kerja
git worktree remove ../fitur-baru
```

---

## 3. Tata Kelola & Template Repositori (`.github/`)

Untuk memastikan proyek berstandar profesional, siapkan berkas berikut di folder `.github/`:

### A. Template Pull Request (`.github/PULL_REQUEST_TEMPLATE.md`)
```markdown
## 📝 Ringkasan Perubahan
<!-- Jelaskan secara singkat perubahan apa yang dilakukan dan mengapa -->

## 🔗 Tiket Terkait
Closes #

## ✅ Checklist Pengujian
- [ ] Failing test telah dibuat sebelum koding (TDD)
- [ ] Seluruh unit test lulus 100% di terminal lokal
- [ ] Tidak ada kredensial/rahasia yang terekspos (.env)
- [ ] Dokumentasi & spesifikasi SystemSpec telah disinkronkan
```

### B. Template Laporan Bug (`.github/ISSUE_TEMPLATE/bug_report.md`)
```markdown
---
name: Laporan Bug
about: Laporkan kesalahan atau perilaku sistem yang tidak diharapkan
title: '[BUG] '
labels: bug
---

**Perilaku yang Terjadi:**
<!-- Jelaskan error yang dialami -->

**Langkah Membuat Ulang Masalah (Steps to Reproduce):**
1. Buka '...'
2. Klik '...'
3. Lihat error '...'

**Bukti Error / Screenshot:**
<!-- Lampirkan teks pesan error atau gambar -->
```

### C. Penanggung Jawab Berkas (`.github/CODEOWNERS`)
```text
# Aturan penanggung jawab review otomatis
*                   @tech-lead
/src/backend/       @backend-team
/docs/              @product-owner
```

### D. Otomasi Update Dependensi (`.github/dependabot.yml`)
```yaml
version: 2
updates:
  - package-ecosystem: "npm" # atau pip, gomod, cargo
    directory: "/"
    schedule:
      interval: "weekly"
```

---

## 4. Lembar Contekan Cepat Terminal (*GitHub CLI / `gh` Cheat Sheet*)

| Operasi | Perintah `gh` CLI | Keterangan |
|---|---|---|
| **Buat PR Cepat** | `gh pr create --title "feat: ..." --body "..."` | Membuat Pull Request langsung dari terminal |
| **Review PR** | `gh pr checkout <nomor-pr>` | Mengunduh branch PR rekan kerja untuk diuji lokal |
| **Cek Status CI** | `gh pr checks` | Melihat status kelulusan pengujian otomatis pada PR |
| **Merge PR** | `gh pr merge --squash --delete-branch` | Menggabungkan PR dan menghapus branch fitur |
| **Buat Rilis** | `gh release create v1.0.0 --generate-notes` | Membuat rilis resmi dengan catatan otomatis |
| **Daftar Issue** | `gh issue list --label bug` | Melihat daftar bug yang masih terbuka |

---

## 5. Aturan Besi Keselamatan Repositori (*Safety Iron Rules*)

1. **Dilarang Force Push pada Branch Utama**:
   - `git push -f origin main` atau `master` **DILARANG KERAS**. Gunakan branch fitur dan jalur Pull Request.
2. **Bersihkan Meja Sebelum Menyimpan (*Clean Working Tree*)**:
   - Pastikan tidak ada berkas sementara, cache compiler, atau token rahasia (`.env`) yang ikut ter-stage (`git status` wajib diperiksa sebelum `git commit`).
3. **Evidence Before Commit**:
   - Pastikan seluruh tes lokal lulus (`verification-before-completion`) sebelum membuat commit fungsional.

---

## ✅ Checklist Verifikasi Operasi Git

Sebelum menyatakan tugas Git selesai:
- [ ] Pesan commit mematuhi format Caveman/Conventional (Subjek ≤50 karakter, *imperative mood*).
- [ ] Tidak ada kata-kata basa-basi atau watermark AI di dalam commit.
- [ ] Perubahan sensitif/breaking change memiliki blok penjelasan `BREAKING CHANGE:`.
- [ ] Branch fitur memiliki nama yang jelas (`feat/`, `fix/`, `refactor/`).
- [ ] Status meja kerja bersih (`nothing to commit, working tree clean`).

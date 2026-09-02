---
name: pero-quality-governance
description: Use when establishing project governance, coding standards, security guardrails, concurrency boundaries, and quality gate policies
---

# Pero Quality & Security Governance (`pero:quality-governance`)

## Overview
**Origin**: *Pero Custom SDLC Pipeline - Stage 5 (Universal)*.
Skill ini bertindak sebagai **"Papan Tata Tertib Satpam & Polisi Mutu di Pabrik Mainan"** (Memastikan semua pekerja memakai helm keselamatan, kabel listrik tidak korslet, bahan mainan aman tidak beracun, dan setiap barang lolos uji mutu sebelum keluar pabrik). Tugasnya adalah menerjemahkan kebutuhan produk dari `docs/PRD.md`, spesifikasi sistem dari `docs/SystemSpec.md`, dan cetak biru arsitektur dari `docs/Architecture.md` menjadi pedoman tata kelola kualitas, standar koding, pagar pembatas keamanan (*security guardrails*), aturan konkurensi (*thread-safety*), dan gerbang rilis (*quality gates*) terstandarisasi di dalam dokumen **`docs/Governance.md`** yang berlaku untuk semua bahasa dan framework (Universal / Polyglot).

## Sub-Skill Integration (Perkakas Pendukung)
Dalam menjalankan tahapan tata kelola kualitas, agent WAJIB mengorkestrasi sub-skill berikut:
- **Upstream Context Reader**: **`MANDATORY`**: Wajib membaca `docs/PRD.md`, `docs/SystemSpec.md`, dan `docs/Architecture.md` untuk memastikan seluruh aturan tata kelola, kebijakan keamanan, dan gerbang mutu selaras dengan kebutuhan produk dan rancangan teknis yang telah disepakati.
- **Dekomposisi Riset Tata Kelola Paralel**: **`REQUIRED SUB-SKILL`**: Gunakan `dispatching-parallel-agents` untuk mendelegasikan 3 sub-agen spesialis tata kelola secara paralel (*Sub-agen 1: Security, Privacy & Secret Protection via env-guard, Sub-agen 2: Concurrency, Thread-Safety & Performance Standards, Sub-agen 3: Testing Quality Gates & Review Standards*) guna memperluas cakupan regulasi dan mencegah celah kepatuhan.
- **Penegak Siklus Pengujian TDD**: **`REQUIRED SUB-SKILL`**: Gunakan `test-driven-development` untuk menegakkan hukum besi TDD (*Red-Green-Refactor*): tidak ada baris kode implementasi sebelum failing test ditulis.
- **Validasi Bukti Terminal Sebelum Selesai**: **`REQUIRED SUB-SKILL`**: Gunakan `verification-before-completion` untuk mewajibkan bukti eksekusi terminal nyata (exit code 0 dan 0 failure threshold) sebelum pekerjaan diklaim selesai.
- **Gerbang Pemeriksaan Kode 2 Lapis**: **`REQUIRED SUB-SKILL`**: Gunakan `code-reviewer` untuk menetapkan inspeksi gerbang ganda (*Stage 1: Spec Compliance* dan *Stage 2: Code Quality, Concurrency & Security*).
- **Proteksi Variabel Rahasia & Perintah Destruktif**: **`SUPPORTING SUB-SKILL`**: Gunakan `env-guard` untuk isolasi kunci rahasia (*zero hardcoded credentials*) dan penyaringan perintah terminal berbahaya.
- **Audit Konsistensi Tata Kelola**: **`SUPPORTING SUB-SKILL`**: Gunakan `pero-context-validation` untuk memastikan aturan kualitas dan keamanan selaras dengan arsitektur dan spesifikasi hulu.
- **Pencatatan Keputusan Tata Kelola**: **`SUPPORTING SUB-SKILL`**: Gunakan `decision-recorder` untuk membukukan keputusan tata kelola ke `docs/decisions/GDR-[YYYYMMDDHHmm].md`.

## Protokol Eksekusi Riset Tata Kelola Multi-Agen (*Mandatory Governance Protocol*)
Sebelum menyusun dokumen `docs/Governance.md`, agen **WAJIB mendelegasikan 3 sub-agen spesialis paralel** untuk memperluas cakupan konteks:

```
[Pendelegasian 3 Sub-Agen Tata Kelola Paralel (dispatching-parallel-agents)]
   │
   ├──> Sub-Agen 1: Security, Privacy & Secret Protection (env-guard & OWASP)
   ├──> Sub-Agen 2: Concurrency, Thread-Safety & Mutex/Lock Isolation Rules
   └──> Sub-Agen 3: Testing Standards, 0-Failure Gate & 2-Stage Review Protocols
   │
[Sintesis Konsensus Standar & Penyusunan docs/Governance.md]
```

1. **Sub-Agen 1 — Security, Privacy & Secret Guard Specialist**:
   * Menetapkan perimeter isolasi rahasia (*zero plaintext credentials*), aturan `.gitignore` otomatis, mitigasi OWASP Top-10, sanitasi input, dan prinsip *Least Privilege*.
2. **Sub-Agen 2 — Concurrency & State Isolation Specialist**:
   * Menetapkan aturan thread-safety universal (Actor Model, Mutex/Locks, Immutable state, Channels), penanganan deadlock/race condition, dan operasi non-blocking I/O.
3. **Sub-Agen 3 — Quality Gates & Review Specialist**:
   * Menetapkan hukum besi TDD (*Red -> Green -> Refactor*), ambang batas kegagalan nol (*0 failure threshold* terminal exit code 0), checklist review 2 lapis (`code-reviewer`), dan standar semantic git flow.

## When to Use
- Menetapkan standar kualitas kode (*Coding Standards & Linting*) sebelum penulisan kode atau dekomposisi tugas dimulai.
- Merumuskan aturan isolasi konkurensi (*Thread-Safety, Race-Condition Prevention*) dan batas akses state bersama.
- Menentukan pagar keamanan (*Security & Privacy Guardrails*), proteksi rahasia (*Secret Management*), dan sanitasi input.
- Menyusun kriteria gerbang kualitas (*Quality Gates & Definition of Done*) dengan ambang batas kegagalan nol (*0 failure threshold*).
- Menstandarisasi alur kerja Git (*Git Workflow, Semantic Commits*) serta protokol pencatatan keputusan (*Governance Decision Records*).

## The 5-Pillar Quality Governance Framework

```
[1. Concurrency & Thread-Safety] ──> [2. Clean Coding & Naming Standards]
                                                     │
[4. Testing Standards & Gates]   <── [3. Security, Privacy & Secret Guard]
              │
[5. Git Flow & Decision Records]
```

### 1. Concurrency, State Safety & Thread Isolation Rules
- **Non-Blocking Asynchronous**: Mewajibkan pemrosesan non-blocking untuk operasi I/O, network, dan database (mencegah UI hang atau thread pool starvation).
- **State Mutability Isolation**: Mengisolasi state bersama (*shared state*) menggunakan mekanisme thread-safe (Actor model, Mutex/Locks, Immutable structures, atau Channel message-passing).
- **Race Condition & Deadlock Prevention**: Melarang akses paralel tanpa mekanisme sinkronisasi dan mencegah siklus penguncian bertingkat (*lock ordering deadlock*).

### 2. Coding Standards, Naming & Documentation Integrity
- **Prinsip Clean Code Universal**: Menerapkan prinsip KISS (*Keep It Simple, Stupid*), DRY (*Don't Repeat Yourself*), dan YAGNI (*You Aren't Gonna Need It*).
- **Konvensi Penamaan Simbol**: Standar penamaan yang konsisten dan bermakna untuk file, kelas, fungsi, konstanta, dan variabel.
- **Integritas Dokumentasi**: Menjaga komentar kode yang ada, melengkapi docstring/JSDoc/GoDoc/RustDoc pada public API, dan melarang penghapusan komentar tanpa instruksi eksplisit.

### 3. Security, Privacy & Secret Protection Guardrails
- **Zero Hardcoded Secrets**: Mematuhi `env-guard`—tidak boleh ada API key, token, private key, atau password di source code atau commit history.
- **Perimeter Input Sanitization**: Seluruh input dari pengguna/jaringan eksternal wajib divalidasi dan disanitasi di lapisan terluar (anti SQL Injection, XSS, Path Traversal, Command Injection).
- **Principle of Least Privilege & Sandboxing**: Batasi hak akses data, token, dan peran sistem ke tingkat paling minimum yang diperlukan, serta batasi durasi eksekusi proses latar belakang.

### 4. Testing Standards, Coverage & Quality Gates
- **Hukum Besi TDD**: Mematuhi `test-driven-development`—siklus Red (failing test) -> Green (minimal code) -> Refactor (clean code).
- **Ambang Batas 0 Kegagalan (*0 Failure Threshold*)**: Mematuhi `verification-before-completion`—setiap pekerjaan harus dibuktikan dengan eksekusi terminal nyata (exit code 0, 0 failing tests).
- **Two-Stage Code Review Gate**: Mematuhi `code-reviewer`—Lapis 1 (Spec Compliance) dan Lapis 2 (Code Quality, Concurrency & Security).

### 5. Git Workflow & Decision Record Protocol
- **Semantic Branching & Commits**: Format branch terstruktur (`feature/*`, `fix/*`, `refactor/*`) dan semantic commit message (`feat:`, `fix:`, `test:`, `docs:`, `refactor:`, `chore:`).
- **Governance Decision Records (GDR)**: Mematuhi `decision-recorder`—setiap perubahan aturan standar atau keamanan wajib dibukukan ke `docs/decisions/GDR-[YYYYMMDDHHmm].md`.

## Deliverables & Output Artifacts

1. **Living Document**: `docs/Governance.md`
2. **Decision Record**: `docs/decisions/GDR-[YYYYMMDDHHmm].md`

---

## Template: `docs/Governance.md`

````markdown
# Quality & Security Governance: [Nama Sistem / Proyek]

- **Versi**: 1.0
- **Status**: Disetujui (Approved)
- **Tanggal**: [YYYY-MM-DD]
- **Dokumen Induk**: [docs/PRD.md](docs/PRD.md), [docs/SystemSpec.md](docs/SystemSpec.md), & [docs/Architecture.md](docs/Architecture.md)
- **Decision Record**: [docs/decisions/GDR-[YYYYMMDDHHmm].md](docs/decisions/GDR-[YYYYMMDDHHmm].md)

## 1. Concurrency, State Safety & Thread Isolation Rules
[Jelaskan aturan persimpangan jalan agar tidak ada tabrakan data dalam analogi sederhana seperti lampu lalu lintas dan loket kasir satu pintu].

- **Model Eksekusi Asinkron**: Seluruh operasi I/O (akses database, HTTP call, pembacaan file) wajib menggunakan non-blocking async/await atau thread pool terkelola. Dilarang memblokir main thread / event loop.
- **Isolasi Mutasi State**:
  - Variabel global yang dapat dimutasi (*mutable global state*) **DILARANG KERAS**.
  - Shared state wajib dilindungi dengan salah satu mekanisme: Actor Model, Mutex/RwLock, Atomic Primitives, atau Immutable Data Structures.
- **Pencegahan Race Condition**: Setiap modifikasi data bersama yang melibatkan lebih dari satu tahap wajib dibungkus dalam blok atomik atau serial queue.
- **Manajemen Resource & Memory**: File stream, koneksi socket, dan database client wajib selalu ditutup setelah digunakan (menggunakan pola `defer`, `using`, `try-with-resources`, atau `try-finally`).

## 2. Coding Standards & Naming Conventions

### 2.1. Standar Gaya Koding (Polyglot)
- **Keterbacaan Utama**: Kode ditulis untuk dibaca oleh manusia terlebih dahulu, baru kemudian dieksekusi mesin.
- **Batasan Kompleksitas**: Fungsi atau metode maksimal [misal: 30-50 baris] dan fokus hanya pada satu tanggung jawab (*Single Responsibility Principle*).
- **Integritas Dokumentasi**: Seluruh interface dan fungsi publik wajib memiliki deskripsi ringkas. Jangan menghapus komentar penjelas yang sudah ada tanpa alasan teknis yang kuat.

### 2.2. Konvensi Penamaan Simbol
| Elemen | Konvensi | Contoh | Keterangan |
|---|---|---|---|
| **File / Direktori** | `kebab-case` / `snake_case` | `user-repository.ts`, `auth_service.go` | Konsisten sesuai standar platform |
| **Kelas / Interface / Tipe** | `PascalCase` | `PaymentProcessor`, `UserSession` | Menunjukkan entitas atau kontrak tipe |
| **Fungsi / Metode** | `camelCase` / `snake_case` | `validateToken()`, `calculate_total()` | Berupa kata kerja aktif |
| **Variabel / Properti** | `camelCase` / `snake_case` | `retryCount`, `is_authenticated` | Deskriptif, hindari singkatan ambigu |
| **Konstanta / Enum Keys** | `UPPER_SNAKE_CASE` | `MAX_RETRY_ATTEMPTS`, `STATUS_ACTIVE` | Nilai tetap (*immutable constants*) |

## 3. Security, Privacy & Secret Protection Guardrails

### 3.1. Secret Protection (`env-guard`)
- **Zero Hardcoded Credentials**: API key, database password, JWT secret, dan sertifikat privat DILARANG KERAS ditulis langsung di kode sumber atau dicatat dalam log terminal.
- **Environment Isolation**: Semua nilai rahasia wajib dimuat via environment variable (`.env`) yang selalu terdaftar di `.gitignore`.
- **Credential Sanitization**: Jangan pernah mencetak objek konfigurasi penuh yang mengandung field rahasia ke stdout/stderr.

### 3.2. Perimeter Input Sanitization & Data Privacy
- **Sanitasi Input**: Semua input dari pengguna/jaringan eksternal wajib divalidasi skemanya dan disanitasi sebelum diproses (mencegah SQLi, XSS, Command Injection, Path Traversal).
- **Prinsip Hak Akses Minimum**: Operasi sistem dan service account hanya diberi izin akses terkecil yang dibutuhkan (*Principle of Least Privilege*).
- **Perlindungan Data Pribadi (PII)**: Password pengguna wajib di-hash menggunakan algoritma modern (Argon2 / bcrypt). Dilarang menyimpan password dalam bentuk teks polos (*plaintext*).

## 4. Testing Standards & Quality Gates (Definition of Done)

### 4.1. Kewajiban Mutlak TDD (`test-driven-development`)
- Setiap fitur atau perbaikan bug **WAJIB** mengikuti siklus **Red -> Green -> Refactor**.
- Dilarang membuat kode implementasi sebelum failing test dibuat dan diverifikasi gagal di terminal.

### 4.2. Matriks Pengujian & Cakupan Kasus
Setiap unit/komponen minimal harus memiliki pengujian untuk 3 skenario:
1. **Happy Path**: Uji skenario sukses dengan data normal yang diharapkan.
2. **Negative Path**: Uji kegagalan validasi, payload tidak lengkap, otentikasi ditolak, atau resource tidak ditemukan.
3. **Edge Cases**: Uji batas nilai ekstrem (string kosong, angka 0, nilai maksimum, timeout jaringan, koneksi terputus).

### 4.3. Gerbang Kualitas Rilis (0 Failure Threshold & `verification-before-completion`)
Sebelum task/PR dinyatakan selesai, WAJIB memenuhi gerbang kelulusan:
- [ ] **Test Suite**: 100% test lulus (`0 failures`, `0 errors`).
- [ ] **Linter & Static Analysis**: Tidak ada lint error atau warning yang diabaikan.
- [ ] **Build Check**: Kompilasi/build sukses dengan exit code `0`.
- [ ] **Evidence**: Bukti eksekusi nyata dari terminal dilampirkan dalam ringkasan penyelesaian.

### 4.4. Gerbang Review 2 Lapis (`code-reviewer`)
- **Lapis 1: Kesesuaian Spesifikasi (Spec Compliance)**: Memastikan kode memenuhi 100% kriteria penerimaan di PRD/SystemSpec tanpa fitur siluman (*anti-YAGNI*).
- **Lapis 2: Kualitas Kode & Keamanan (Quality & Security)**: Memeriksa bebas race conditions, tidak ada memory leak, error handling lengkap (*no empty catch*), dan tidak ada kebocoran secret.

## 5. Git Workflow & Decision Record Protocol

### 5.1. Format Penamaan Branch
- Fitur baru: `feature/[nama-fitur]`
- Perbaikan bug: `fix/[nama-bug]`
- Refaktor / Performa: `refactor/[nama-modul]`
- Pengujian: `test/[cakupan-test]`

### 5.2. Format Semantic Commit
Setiap commit wajib menggunakan format Conventional Commits:
- `feat(scope): deskripsi singkat fitur baru`
- `fix(scope): deskripsi perbaikan bug`
- `test(scope): penambahan atau perbaikan unit/integration test`
- `refactor(scope): perubahan struktur kode tanpa mengubah fungsionalitas`
- `docs(scope): pembaruan dokumentasi atau living document`
- `chore(scope): pembaruan build script, dependensi, atau konfigurasi`

### 5.3. Tata Kelola Keputusan Proyek (`decision-recorder`)
Setiap keputusan penting yang mengubah arah arsitektur, keamanan, atau standar tata kelola wajib dicatat ke dalam:
```
docs/decisions/GDR-[YYYYMMDDHHmm].md
```
````

## Anti-Patterns & Common Mistakes
- **Mengabaikan Race Conditions & Data Race**: Menulis kode paralel yang memutasi variabel bersama tanpa pengunci (*lock/mutex/actor*), mengandalkan keberuntungan bahwa eksekusi tidak akan bertabrakan.
- **Menganggap Uji Manual Cukup (Skipping TDD & Automated Tests)**: Menulis kode tanpa automated test dengan alasan "sudah dicoba manual di layar", yang pasti memicu regresi di kemudian hari.
- **Persetujuan Palsu & Kepatuhan Buta (Performative Agreement & Sycophancy)**: Menyetujui usulan teknis yang berbahaya atau melanggar prinsip arsitektur hanya demi menyenangkan pihak lain tanpa menyuarakan risiko teknis (*pushback* berbasis bukti).
- **Membocorkan Kunci Rahasia (Leaking Secrets in Code or Commits)**: Menyimpan API key atau token langsung di file kode atau meng-commit file `.env` ke repositori Git.
- **Menelan Error Mentah-Mentah (Swallowing Errors / Empty Catch Blocks)**: Menangkap exception atau error dengan blok kosong (`catch {}` / `except: pass`) sehingga sistem gagal tanpa jejak diagnosa.
- **Mengklaim Selesai Tanpa Bukti Terminal (Assertions Without Terminal Proof)**: Mengatakan "semua sudah bekerja dengan baik" tanpa bukti nyata eksekusi test runner dan build exit code 0.
- **Merusak Integritas Komentar & Dokumentasi**: Menghapus komentar atau penjelasan kontekstual yang sudah ada saat mengedit kode sumber.

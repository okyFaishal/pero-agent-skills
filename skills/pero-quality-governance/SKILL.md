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
- **Dekomposisi Riset 5 Spesialis Tata Kelola Tetap (*Fixed Governance Squad*)**: **`REQUIRED SUB-SKILL`**: Gunakan `dispatching-parallel-agents` untuk mendelegasikan tim beranggotakan **5 Agen Spesialis Tata Kelola Tetap** secara paralel yang masing-masing dibekali alat `context-7` dan `web-search`. Setiap spesialis wajib melakukan evaluasi relevansi awal (*Relevance Pre-Flight Check*). Jika domain relevan, agen dibatasi **minimal 2 dan maksimal 5 pencarian terarah**. Jika domain tidak relevan, agen wajib mendeklarasikan *Early-Exit* (`N/A: Not Applicable`) dan dilarang melakukan pencarian.
- **Verifikasi Tooling & Standar Linter Resmi**: **`REQUIRED SUB-SKILL`**: Gunakan `context-7` dan `web-search` untuk memeriksa standar linter modern (Biome/ESLint, Ruff, golangci-lint, Clippy), aturan compiler strict, dan konfigurasi test runner terkini sesuai tumpukan teknologi yang dipilih di `Architecture.md`.
- **Penegakan Kode Bersih Tanpa Basa-Basi**: **`REQUIRED SUB-SKILL`**: Gunakan `anti-slop` untuk melarang over-engineering (YAGNI), mengeliminasi komentar sepele yang menjelaskan apa yang sudah jelas dilakukan kode, dan melarang mock tiruan palsu.
- **Standarisasi Alur Git & Otomatisasi Hook**: **`REQUIRED SUB-SKILL`**: Gunakan `git-ops` untuk menetapkan format semantic commit (Conventional Commits atau Caveman Commits), strategi percabangan, serta konfigurasi pagar otomatis (*Pre-commit & Pre-push Git Hooks*).
- **Penegak Siklus Pengujian TDD**: **`REQUIRED SUB-SKILL`**: Gunakan `test-driven-development` untuk menegakkan hukum besi TDD (*Red-Green-Refactor*): tidak ada baris kode implementasi sebelum failing test ditulis.
- **Validasi Bukti Terminal Sebelum Selesai**: **`REQUIRED SUB-SKILL`**: Gunakan `verification-before-completion` untuk mewajibkan bukti eksekusi terminal nyata (exit code 0 dan 0 failure threshold) sebelum pekerjaan diklaim selesai.
- **Gerbang Pemeriksaan Kode 2 Lapis**: **`REQUIRED SUB-SKILL`**: Gunakan `code-reviewer` untuk menetapkan inspeksi gerbang ganda (*Stage 1: Spec Compliance* dan *Stage 2: Code Quality, Concurrency & Security*).
- **Musyawarah Dewan Pagar Mutu & Keamanan**: **`REQUIRED / STRATEGIC SUB-SKILL`**: Gunakan `llm-council` untuk menyidangkan dilema kebijakan mutu (misal: strict linter blocking build vs warn-only, target cakupan tes 80% vs 100%, Trunk-based development vs GitFlow) melalui 5 persona AI.
- **Wawancara Penguncian Tata Kelola di Chat**: **`REQUIRED SUB-SKILL`**: Gunakan `grilling` secara interaktif langsung kepada pengguna di chat dengan batas **minimal 5 dan maksimal 10 pertanyaan** bertahap (1–2 pertanyaan per putaran) untuk mengunci target cakupan tes, gaya commit, dan otomatisasi git hook. Agent WAJIB menghentikan eksekusi (*pause*) dan menunggu respon pengguna. DILARANG menentukan kebijakan mutu sepihak.
- **Proteksi Variabel Rahasia & Perintah Destruktif**: **`SUPPORTING SUB-SKILL`**: Gunakan `env-guard` untuk isolasi kunci rahasia (*zero hardcoded credentials*) dan penyaringan perintah terminal berbahaya.
- **Audit Konsistensi Tata Kelola**: **`SUPPORTING SUB-SKILL`**: Gunakan `pero-context-validation` untuk memastikan aturan kualitas dan keamanan selaras dengan arsitektur dan spesifikasi hulu.
- **Pencatatan Keputusan Tata Kelola**: **`SUPPORTING SUB-SKILL`**: Gunakan `decision-recorder` untuk membukukan keputusan tata kelola ke `docs/decisions/GDR-[YYYYMMDDHHmm].md` menggunakan template standar.

## The 5-Stage Quality Governance Framework

```
[0. Ingestion docs/PRD.md, docs/SystemSpec.md, & docs/Architecture.md]
                                   │
                                   ▼
[1. Riset 5 Spesialis Tata Kelola + Context7 & Web Search]
    (Security, Concurrency, Linter Tooling, TDD, Git-Ops dengan Early-Exit N/A)
                                   │
                                   ▼
[2. Sidang Pagar Mutu & Keamanan Kritis (LLM Council)]
    (5 Persona AI menguji trade-off: Strict Linting, Branch Strategy, Coverage Target)
                                   │
                                   ▼
[3. Wawancara Penguncian Tata Kelola di Chat (Grilling Rambu Henti)]
    (Min 5, Max 10 Tanya: kunci ambang batas coverage, commit style, hook automation)
                                   │
                                   ▼
[4. Penyusunan Dokumen Governance.md (Coding Rules, Linter Matrix, Hooks & Gates)]
                                   │
                                   ▼
[5. Pembukuan Rekam Keputusan GDR Formal & Audit Konsistensi Hulu-Hilir]
```

### 1. Dekomposisi Riset Paralel Berbasis 5 Spesialis Tata Kelola Tetap
Mendelegasikan tim 5 agen spesialis tata kelola tetap via `dispatching-parallel-agents` yang masing-masing dibekali alat `context-7` dan `web-search`:

#### A. 5 Peran Spesialis Tata Kelola Tetap (*Fixed Governance Roles*):
1. **Spesialis 1: Keamanan, Privasi & Proteksi Rahasia (*Security, Privacy & Secrets Specialist*)**:
   - *Fokus*: Meneliti mitigasi OWASP API Security Top 10, aturan hashing PII pengguna (Argon2 / bcrypt), perimeter sanitasi input, isolasi credential via `env-guard`, serta protokol penyensoran otomatis data sensitif di log (*Automated Log Redaction / Masking*).
2. **Spesialis 2: Konkurensi, Thread-Safety & Manajemen Resource (*Concurrency & Resource Specialist*)**:
   - *Fokus*: Meneliti aturan isolasi state bersama (Actor, Mutex, Channels), flag deteksi race condition (`-race`), dan protokol pelepasan resource memori/socket (`defer`, `using`, `try-finally`).
3. **Spesialis 3: Kualitas Kode, Linter & Keamanan Pustaka (*Linters, Formatters & Supply Chain Specialist*)**:
   - *Fokus*: Memeriksa toolchain linter & formatter resmi modern via `context-7` dan `web-search`, compiler strict flags, serta audit keamanan rantai pasok dependensi (*Supply Chain Security & Lockfile Discipline*).
4. **Spesialis 4: Standar TDD, Piramida Tes & Uji Mutasi (*TDD, Mutation Testing & Gates Specialist*)**:
   - *Fokus*: Meneliti test runner resmi, piramida tes, hukum besi TDD, ambang batas kegagalan nol (`verification-before-completion`), serta efektivitas pengujian melalui uji mutasi (*Mutation Testing*).
5. **Spesialis 5: Git-Ops, Otomatisasi CI & Strategi Rilis (*Git-Ops, CI Automation & Release Specialist*)**:
   - *Fokus*: Meneliti alur percabangan (*Trunk-based vs Gitflow*), format pesan commit (Conventional vs Caveman via `git-ops`), otomatisasi Git hooks, serta kesiapan saklar darurat (*Feature Flags*) dan prosedur rollback cepat.

#### B. Mekanisme Evaluasi Relevansi Awal & Pintu Keluar Dini (*Relevance Pre-Flight Check & Early Exit*):
- Setiap spesialis membaca dokumen upstream sebelum menjalankan riset.
- Jika domain spesialis tersebut **sama sekali tidak relevan** (misalnya: Spesialis 2 pada skrip CLI lokal sekuensial murni tanpa proses paralel):
  - Spesialis **WAJIB** mendeklarasikan: `Status: Not Applicable (N/A). Alasan: [Penjelasan mengapa domain ini tidak dibutuhkan]`.
  - Agen berstatus `N/A` **DILARANG melakukan pencarian (0 search)** dan **DILARANG mengarang regulasi palsu**.

#### C. Pagar Batas Riset & Pencarian (*Guardrails*):
- Untuk domain yang relevan: **Minimal 2 pencarian terarah** (wajib merujuk dokumentasi resmi Context7 atau standar industri) dan **Maksimal 5 pencarian terarah** per agen.
- Untuk domain `N/A`: **0 pencarian**.
- Setiap agen spesialis aktif wajib menyertakan minimal 1 tautan URL / rujukan resmi dalam laporannya.

### 2. Musyawarah Dewan Mutu & Keamanan (via `llm-council`)
- Menyidangkan perdebatan tata kelola berisiko tinggi ke 5 persona dewan AI (*Product Strategist, Skeptic Auditor, Domain Specialist, Tech Feasibility, User Advocate*).
- Topik sidang: Strict Linting (memblokir build vs warn-only), Target Cakupan Pengujian (80% vs 90% vs 100% domain core), Strategi Git (Trunk-Based vs GitFlow).
- Dewan menghasilkan sintesis konsensus dan opsi kompromi teknis (Opsi A vs Opsi B) untuk diserahkan ke sesi wawancara chat.

### 3. Wawancara Penguncian Tata Kelola di Chat (via `grilling`)
- **RAMBU HENTI WAJIB (MANDATORY PAUSE GATE)**:
  - Agent **DILARANG** langsung membuat berkas `docs/Governance.md` sebelum menyepakati kebijakan mutu, gaya commit, target cakupan tes, dan otomatisasi git hook bersama pengguna di obrolan (*chat*).
  - Dilarang keras menentukan standar mutu atau alur kerja Git secara sepihak.
- **Pagar Batas Pertanyaan (Volume & Delivery Guardrails)**:
  - **Batas Kuantitas**: Sesi wawancara dibatasi **minimal 5 pertanyaan** (untuk menguji seluruh kebijakan mutu) dan **maksimal 10 pertanyaan** (mencegah kelelahan pengguna).
  - **Penyampaian Bertahap (*Anti-Question Avalanche*)**: DILARANG memberondong pertanyaan sekaligus. Ajukan 1–2 pertanyaan per putaran chat dengan opsi konkret (Opsi A vs Opsi B) dan rekomendasi teknis AI.
- **Fokus Topik Wawancara**:
  1. Target Cakupan Tes (*Test Coverage Target*: 80% vs 90% vs 100% pada logika domain).
  2. Kebijakan Linter & Compiler Strictness (Gagal seketika pada warning vs peringatan saja).
  3. Alur Kerja Git & Strategi Percabangan (*Trunk-Based Development* vs *GitHub Flow* vs *GitFlow*).
  4. Format Pesan Commit (*Conventional Commits* vs *Caveman Commits* ringkas via `git-ops`).
  5. Kebijakan Pagar Otomatis Git Hooks (*Pre-commit formatting & Pre-push test execution*).
  6. Disiplin Kuncian Dependensi & Audit Kerentanan (*Lockfile strictness & High/Critical vulnerability gating*).
  7. Kesiapan Saklar Fitur & Prosedur Mundur Cepat (*Feature Flags untuk rilis berisiko & 1-command rollback*).
- **Hentikan pemanggilan tools (STOP)** dan tunggu keputusan pengguna di chat pada setiap putaran.

### 4. Penyusunan Dokumen Governance.md Formal
- Menyusun dokumen lengkap `docs/Governance.md` mematuhi 5 pilar tata kelola kualitas, standar anti-slop, matriks linter terverifikasi, keamanan rantai pasok dependensi, protokol sensor log, dan gerbang kelulusan otomatis.

### 5. Pembukuan Rekam Keputusan GDR Formal & Audit Konsistensi
- Membukukan seluruh keputusan tata kelola ke `docs/decisions/GDR-[YYYYMMDDHHmm].md` menggunakan template standar resmi.
- Menjalankan audit konsistensi hulu-hilir via `pero-context-validation` untuk memastikan zero governance drift terhadap PRD, SystemSpec, dan Architecture.

## When to Use
- Menetapkan standar kualitas kode (*Coding Standards, Linters & Formatters*) sebelum koding atau pemecahan tugas dimulai.
- Merumuskan aturan isolasi konkurensi (*Thread-Safety, Race-Condition Prevention*) dan penutupan resource memori/socket.
- Menentukan pagar keamanan (*Security & Privacy Guardrails*), proteksi rahasia (*Secret Management*), dan sanitasi input.
- Menyusun kriteria gerbang kualitas (*Quality Gates & Definition of Done*) dengan ambang batas kegagalan nol (*0 failure threshold*).
- Menstandarisasi alur kerja Git (*Git Workflow, Commit Styles, Pre-commit Hooks*) serta protokol pencatatan keputusan (*Governance Decision Records*).

## The 5-Pillar Quality Governance Framework

```
[1. Concurrency & Resource Safety] ──> [2. Clean Coding, Anti-Slop & Linters]
                                                          │
[4. Testing, Mutation & Git Hooks]  <── [3. Security, Supply Chain & Log Masking]
               │
[5. Git Flow, Flags & Rollback Plan]
```

### 1. Concurrency, State Safety & Resource Management
- **Non-Blocking Asynchronous**: Mewajibkan pemrosesan non-blocking untuk operasi I/O, network, dan database (mencegah thread starvation).
- **State Mutability Isolation**: Mengisolasi state bersama (*shared state*) menggunakan mekanisme thread-safe (Actor model, Mutex/Locks, Immutable structures, atau Channels).
- **Pencegahan Race Condition & Kebocoran Resource**: Penggunaan flag deteksi race condition dan pelepasan memori/koneksi terjamin (`defer`, `using`, `try-finally`).

### 2. Clean Coding Standards, Anti-Slop Protocols & Linters
- **Prinsip Clean Code & Anti-Slop**: Menerapkan prinsip KISS, DRY, dan YAGNI. Melarang over-engineering, melarang komentar sepele yang redundan, dan melarang mock tiruan palsu.
- **Konvensi Penamaan Simbol**: Standar penamaan konsisten untuk file, kelas, fungsi, konstanta, dan variabel.
- **Matriks Linter & Compiler Strict Flags**: Menetapkan perkakas linter resmi terverifikasi dan flag compiler strict sesuai tumpukan teknologi di `Architecture.md`.

### 3. Security, Supply Chain & Log Masking Guardrails
- **Zero Hardcoded Secrets & Log Scrubbing**: Mematuhi `env-guard`—tidak boleh ada rahasia di kode atau commit, serta wajib memfilter dan menyensor otomatis data sensitif di log (`password`, `token`, `secret` $\rightarrow$ `***REDACTED***`).
- **Perimeter Input Sanitization & PII Hashing**: Validasi skema input terluar dan enkripsi kata sandi menggunakan Argon2 atau bcrypt.
- **Supply Chain Security & Lockfile Discipline**: Mengunci seluruh versi pustaka via lockfile mutlak (`package-lock.json`, `go.sum`, `Cargo.lock`, `uv.lock`) dan memblokir dependensi bervulnerabilitas *High / Critical*.

### 4. Testing Standards, Mutation Testing & Automated Git Hooks
- **Hukum Besi TDD**: Mematuhi `test-driven-development`—siklus Red (failing test) -> Green (minimal code) -> Refactor (clean code).
- **Ambang Batas 0 Kegagalan (*0 Failure Threshold*)**: Mematuhi `verification-before-completion`—setiap pekerjaan harus dibuktikan dengan eksekusi terminal nyata (exit code 0, 0 failing tests).
- **Uji Mutasi Kode (*Mutation Testing*)**: Memverifikasi ketajaman assertion test suite dengan sengaja merusak kode (menghindari cakupan semu / *vanity coverage*).
- **Pagar Otomatis Lokal (*Pre-commit & Pre-push Git Hooks*)**: Format dan linter otomatis pada pre-commit, uji tes unit otomatis pada pre-push.
- **Two-Stage Code Review Gate**: Mematuhi `code-reviewer`—Lapis 1 (Spec Compliance) dan Lapis 2 (Code Quality, Concurrency & Security).

### 5. Git Workflow, Feature Flags & Rollback Protocol
- **Branching Strategy & Semantic Commits**: Alur percabangan yang disepakati (Trunk-based / Feature branch) dan format commit terstandarisasi (Conventional Commits atau Caveman Commits via `git-ops`).
- **Feature Flags & 1-Command Rollback**: Perlindungan fitur berisiko tinggi dengan saklar darurat konfigurasi dan prosedur pembatalan rilis instan.
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

## 2. Coding Standards, Anti-Slop Protocols & Naming Conventions

### 2.1. Standar Gaya Koding & Protokol Anti-Slop (`anti-slop`)
- **Prinsip Anti-Overengineering (KISS & YAGNI)**: Tulis kode paling sederhana yang memenuhi kriteria pengujian. Dilarang membuat lapisan abstraksi berlebih (seperti membuat factory-of-factories untuk logika 3 baris) sebelum ada kebutuhan nyata.
- **Eliminasi Komentar Basa-Basi (Zero Trivial Comments)**: Dilarang menulis komentar yang hanya mengulangi apa yang sudah jelas terbaca dari nama fungsi atau variabel (contoh sampah: `// memanggil fungsi get user` di atas baris `getUser()`). Komentar HANYA boleh ditulis untuk menjelaskan *alasan non-intuitif* (alasan bisnis di balik logika aneh atau workaround bug pihak ketiga).
- **Larangan Mock Tiruan Palsu (No Fake Mock Slop)**: Dilarang membuat mock data palsu yang selalu mengembalikan respon sukses tanpa menguji batas kegagalan nyata.
- **Batasan Kompleksitas**: Fungsi atau metode maksimal [misal: 30-50 baris] dan fokus hanya pada satu tanggung jawab (*Single Responsibility Principle*).

### 2.2. Konvensi Penamaan Simbol
| Elemen | Konvensi | Contoh | Keterangan |
|---|---|---|---|
| **File / Direktori** | `kebab-case` / `snake_case` | `user-repository.ts`, `auth_service.go` | Konsisten sesuai standar platform |
| **Kelas / Interface / Tipe** | `PascalCase` | `PaymentProcessor`, `UserSession` | Menunjukkan entitas atau kontrak tipe |
| **Fungsi / Metode** | `camelCase` / `snake_case` | `validateToken()`, `calculate_total()` | Berupa kata kerja aktif |
| **Variabel / Properti** | `camelCase` / `snake_case` | `retryCount`, `is_authenticated` | Deskriptif, hindari singkatan ambigu |
| **Konstanta / Enum Keys** | `UPPER_SNAKE_CASE` | `MAX_RETRY_ATTEMPTS`, `STATUS_ACTIVE` | Nilai tetap (*immutable constants*) |

### 2.3. Matriks Linter, Formatter & Compiler Strict Flags (Terverifikasi Context7)
| Lapisan / Bahasa | Perkakas Linter & Formatter | Perintah / Compiler Flags | Tindakan Pelanggaran |
|:---|:---|:---|:---|
| [e.g. TypeScript / Web] | `Biome` v1.9 / `ESLint` | `biome check --write` / `tsc --noEmit` | Blokir commit jika error / warning strict |
| [e.g. Go Backend] | `golangci-lint` | `golangci-lint run` & `go test -race` | Blokir PR jika ada issue atau data race |
| [e.g. Python Core] | `Ruff` + `mypy` | `ruff check .` & `mypy --strict .` | Blokir push jika type checking gagal |

## 3. Security, Privacy & Supply Chain Guardrails

### 3.1. Secret Protection & Automated Log Redaction (`env-guard`)
- **Zero Hardcoded Credentials**: API key, database password, JWT secret, dan sertifikat privat DILARANG KERAS ditulis langsung di kode sumber atau dicatat dalam log terminal.
- **Environment Isolation**: Semua nilai rahasia wajib dimuat via environment variable (`.env`) yang selalu terdaftar di `.gitignore`.
- **Penyensoran Log Otomatis (*Automated Log Scrubbing / Masking*)**:
  - Logger terpusat wajib mengonfigurasi filter masker data.
  - Setiap field dengan kata kunci sensitif (seperti `password`, `token`, `secret`, `authorization`, `credit_card`, `api_key`) **wajib otomatis disamarkan menjadi `***REDACTED***`** sebelum dicetak ke terminal atau berkas log.
  - Dilarang keras mencetak objek request/response mentah (`req.body` atau payload pengguna) tanpa sanitasi.

### 3.2. Perimeter Input Sanitization & Data Privacy
- **Sanitasi Input**: Semua input dari pengguna/jaringan eksternal wajib divalidasi skemanya dan disanitasi sebelum diproses (mencegah SQLi, XSS, Command Injection, Path Traversal).
- **Prinsip Hak Akses Minimum**: Operasi sistem dan service account hanya diberi izin akses terkecil yang dibutuhkan (*Principle of Least Privilege*).
- **Perlindungan Data Pribadi (PII)**: Password pengguna wajib di-hash menggunakan algoritma modern (Argon2 / bcrypt). Dilarang menyimpan password dalam bentuk teks polos (*plaintext*).

### 3.3. Keamanan Rantai Pasok Pustaka & Disiplin Lockfile (*Supply Chain Security*)
- **Disiplin Kunci Versi Mutlak (*Lockfile Enforcement*)**:
  - Berkas lockfile (`package-lock.json`, `pnpm-lock.yaml`, `go.sum`, `Cargo.lock`, `uv.lock`) **wajib di-commit ke Git**.
  - Dilarang memasang paket baru menggunakan wildcard (`*` atau rentang terbuka tanpa lockfile) untuk mencegah serangan penyusupan pustaka (*dependency confusion / supply chain attack*).
- **Audit Kerentanan Berkala (*Vulnerability Scanning Gate*)**:
  - Wajib menjalankan pemindaian berkala: `npm audit --audit-level=high`, `govulncheck ./...`, `cargo audit`, atau `pip-audit`.
  - Jika ditemukan kerentanan dengan tingkat keparahan **High** atau **Critical**, commit/build **wajib dibatalkan otomatis** sampai dependensi diperbarui.

## 4. Testing Standards, Quality Gates & Automated Git Hooks

### 4.1. Kewajiban Mutlak TDD (`test-driven-development`)
- Setiap fitur atau perbaikan bug **WAJIB** mengikuti siklus **Red -> Green -> Refactor**.
- Dilarang membuat kode implementasi sebelum failing test dibuat dan diverifikasi gagal di terminal.

### 4.2. Matriks Piramida Pengujian & Uji Mutasi (*Mutation Testing*)
| Tingkatan Tes | Cakupan Skenario | Porsi Piramida | Target Cakupan (Coverage) | Uji Mutasi (Mutation Score) |
|:---|:---|:---|:---|:---|
| **Unit Tests** | Logika domain murni, entity validations, edge cases | ~70% dari seluruh tes | Minimal 85–90% domain core | Minimal 70% mutan tertangkap |
| **Integration Tests** | Query database, integrasi API, routing & middleware | ~20% dari seluruh tes | Minimal 75% endpoint API | - |
| **End-to-End Tests** | Alur transaksi kritis pengguna hulu-ke-hilir | ~10% dari seluruh tes | 100% skenario P0 sukses | - |

- **Uji Mutasi Kode (*Mutation Testing Gate*)**:
  - Menjalankan tool uji mutasi (*Stryker* / *mutmut* / *cargo-mutants*) pada modul logika bisnis utama untuk menguji keefektifan baris `assert`.
  - Jika mutan sengaja disuntikkan (misal operator `>` diubah jadi `<`) tetapi test suite tetap hijau (*survived mutant*), developer wajib menambahkan kriteria uji sampai mutan tersebut terdeteksi gagal (*killed mutant*).

### 4.3. Kebijakan Pagar Otomatis Lokal (Pre-commit & Pre-push Git Hooks via `git-ops`)
Untuk mencegah pelanggaran manual, pagar otomatis wajib dikonfigurasi di repositori lokal (*Lefthook / Husky / Git native*):
- **Pre-Commit Hook**:
  ```bash
  # Otomatis memformat kode dan memvalidasi linting hanya pada file yang di-stage
  npx lint-staged # atau lefthook run pre-commit
  ```
  *Jika linter menemukan error, proses commit dibatalkan seketika.*
- **Pre-Push Hook**:
  ```bash
  # Menjalankan unit test suite lokal sebelum kode dikirim ke remote repository
  npm test # atau go test -v ./... / pytest
  ```
  *Jika ada 1 tes yang gagal, pengiriman branch (git push) ditolak otomatis oleh terminal.*

### 4.4. Gerbang Kualitas Rilis (0 Failure Threshold & `verification-before-completion`)
Sebelum task/PR dinyatakan selesai, WAJIB memenuhi gerbang kelulusan:
- [ ] **Test Suite**: 100% test lulus (`0 failures`, `0 errors`).
- [ ] **Linter & Static Analysis**: Tidak ada lint error atau warning yang diabaikan.
- [ ] **Dependency Audit**: 0 kerentanan High atau Critical.
- [ ] **Build Check**: Kompilasi/build sukses dengan exit code `0`.
- [ ] **Evidence**: Bukti eksekusi nyata dari terminal dilampirkan dalam ringkasan penyelesaian.

### 4.5. Gerbang Review 2 Lapis (`code-reviewer`)
- **Lapis 1: Kesesuaian Spesifikasi (Spec Compliance)**: Memastikan kode memenuhi 100% kriteria penerimaan di PRD/SystemSpec tanpa fitur siluman (*anti-YAGNI*).
- **Lapis 2: Kualitas Kode & Keamanan (Quality & Security)**: Memeriksa bebas race conditions, tidak ada memory leak, error handling lengkap (*no empty catch*), dan tidak ada kebocoran secret.

## 5. Git Workflow, Feature Flags & Decision Records

### 5.1. Alur Percabangan (Branching Strategy)
- Strategi Utama: [Trunk-Based Development / GitHub Flow / GitFlow]
- Pola branch kerja:
  - Fitur baru: `feature/[nama-fitur]`
  - Perbaikan bug: `fix/[nama-bug]`
  - Refaktor / Performa: `refactor/[nama-modul]`
  - Pengujian: `test/[cakupan-test]`

### 5.2. Format Pesan Commit (`git-ops`)
Gaya Commit yang disepakati: **[Conventional Commits / Caveman Commits via `git-ops`]**
- Format Conventional Commits:
  - `feat(scope): deskripsi singkat fitur baru`
  - `fix(scope): deskripsi perbaikan bug`
  - `test(scope): penambahan atau perbaikan unit/integration test`
  - `refactor(scope): perubahan struktur kode tanpa mengubah fungsionalitas`
  - `docs(scope): pembaruan dokumentasi atau living document`
  - `chore(scope): pembaruan build script, dependensi, atau konfigurasi`
- Format Caveman Commits (Ultra-kompresi hemat token untuk efisiensi agen AI):
  - `FEAT: add user auth token validation`
  - `FIX: race condition in order counter lock`

### 5.3. Saklar Fitur (Feature Flags) & Protokol Rollback Cepat
- **Perlindungan Rilis Berisiko Tinggi (*Feature Flags*)**:
  - Fitur mutasi data kritis atau integrasi pihak ketiga baru wajib dibungkus konfigurasi saklar (misal: `FEATURE_FLAG_PAYMENT_V2=true/false`).
  - Jika terjadi anomali di produksi, fitur dapat dimatikan seketika dalam 1 detik tanpa perlu deploy ulang.
- **Prosedur Mundur 1 Perintah (*1-Command Rollback*)**:
  - Setiap rilis wajib mencatat perintah rollback darurat yang teruji:
    ```bash
    git revert --no-edit HEAD && git push origin main # atau redeploy tag rilis sebelumnya
    ```

### 5.4. Tata Kelola Keputusan Proyek (`decision-recorder`)
Setiap keputusan penting yang mengubah arah arsitektur, keamanan, atau standar tata kelola wajib dicatat ke dalam:
```
docs/decisions/GDR-[YYYYMMDDHHmm].md
```
````

---

## Template: `docs/decisions/GDR-[YYYYMMDDHHmm].md`

````markdown
# GDR-[Nomor]: [Judul Keputusan Tata Kelola, misal: Penetapan Standar Linter Biome & Ambang Batas 85% Test Coverage]

- **Status**: Diterima (Accepted) / Ditinjau (Proposed) / Digantikan (Superseded)
- **Tanggal**: [YYYY-MM-DD]
- **Pengambil Keputusan**: Pengguna & Tim Tata Kelola Kualitas AI
- **Dokumen Terkait**: [docs/Governance.md](../Governance.md)

## 1. Konteks & Masalah Tata Kelola
[Jelaskan latar belakang mengapa aturan tata kelola, kebijakan keamanan, atau standar koding baru ini perlu diresmikan].

## 2. Aturan / Kebijakan yang Ditetapkan
[Jelaskan rincian kebijakan atau standar kualitas yang disepakati secara tegas].

## 3. Alternatif Kebijakan yang Ditolak
| Alternatif Aturan | Alasan Penolakan |
|:---|:---|
| [Alternatif Aturan 1] | [Mengapa tidak dipilih / risiko yang tidak dapat ditoleransi] |
| [Alternatif Aturan 2] | [Kelemahan teknis / beban operasional tim yang tidak realistis] |

## 4. Konsekuensi Positif & Beban Operasional (Trade-offs)
- **Konsekuensi Positif**: [Peningkatan stabilitas, keamanan, atau konsistensi kode tim]
- **Beban Operasional**: [Beban waktu atau proses tambahan yang harus dijalankan pengembang]
- **Strategi Mitigasi / Otomatisasi**: [Bagaimana beban tersebut diringankan via alat otomatis seperti Git hooks atau CI pipeline]

## 5. Kebijakan Dispensasi / Pengecualian (Exception Policy)
[Kondisi khusus di mana aturan ini boleh dikecualikan sementara, dan prosedur persetujuannya].
````

## Anti-Patterns & Common Mistakes
- **Simulated Governance Deciding**: Menentukan sendiri target cakupan pengujian, aturan linter, gaya commit, atau alur Git tanpa pernah melakukan wawancara grilling di chat bersama pengguna.
- **Paper-Only Governance (Wishful Thinking)**: Menulis daftar aturan kualitas dan keamanan di dokumen tetapi tidak pernah mengonfigurasi skrip linter, compiler flags, atau Git hooks otomatis di repositori.
- **Slop-Infested Boilerplate**: Menghasilkan kode over-engineered (melanggar prinsip YAGNI), komentar sepele yang menjelaskan baris kode yang sudah jelas, atau mock tiruan palsu (melanggar protokol `anti-slop`).
- **Unverified Vanity Coverage (Skipping Mutation Testing)**: Berpuas diri dengan angka cakupan tes 90% tanpa uji mutasi, menyembunyikan tes kosong tanpa assertion yang gagal menangkap bug saat kode sengaja dirusak.
- **Unpinned Dependency Drift (Missing Lockfiles)**: Mengabaikan lockfile atau membiarkan celah dependensi tingkat High/Critical lolos ke branch utama tanpa perbaikan.
- **Sensitive Data Log Leaks**: Mencetak objek mentah ke log tanpa penyensoran otomatis (*unredacted PII/secrets*).
- **No-Rollback Suicidal Releases**: Merilis fitur berisiko tanpa saklar darurat (*feature flags*) atau prosedur mundur yang teruji.
- **Question Avalanche or Premature Cessation**: Mengirimkan lebih dari 2 pertanyaan sekaligus dalam satu balon chat, bertanya kurang dari 5 pertanyaan (terlalu malas/dangkal), atau melampaui batas 10 pertanyaan pada Tahap 3 (memicu kelelahan pengguna dan *analysis paralysis*).
- **Forced Irrelevant Specialization**: Memaksakan riset tata kelola yang tidak dibutuhkan proyek (misalnya memaksakan aturan konkurensi rumit pada skrip batch sekuensial sederhana), alih-alih mendeklarasikan status `N/A`.
- **Unbounded Web Search Avalanche**: Melakukan kurang dari 2 pencarian terarah pada domain yang relevan (riset dangkal tanpa dasar standar), melampaui batas 5 pencarian per agen, atau tetap mencari pada domain `N/A`.
- **Mengabaikan Race Conditions & Data Race**: Menulis kode paralel yang memutasi variabel bersama tanpa pengunci (*lock/mutex/actor*), mengandalkan keberuntungan bahwa eksekusi tidak akan bertabrakan.
- **Menganggap Uji Manual Cukup (Skipping TDD & Automated Tests)**: Menulis kode tanpa automated test dengan alasan "sudah dicoba manual di layar", yang pasti memicu regresi di kemudian hari.
- **Persetujuan Palsu & Kepatuhan Buta (Performative Agreement & Sycophancy)**: Menyetujui usulan teknis yang berbahaya atau melanggar prinsip arsitektur hanya demi menyenangkan pihak lain tanpa menyuarakan risiko teknis (*pushback* berbasis bukti).
- **Membocorkan Kunci Rahasia (Leaking Secrets in Code or Commits)**: Menyimpan API key atau token langsung di file kode atau meng-commit file `.env` ke repositori Git.
- **Menelan Error Mentah-Mentah (Swallowing Errors / Empty Catch Blocks)**: Menangkap exception atau error dengan blok kosong (`catch {}` / `except: pass`) sehingga sistem gagal tanpa jejak diagnosa.
- **Mengklaim Selesai Tanpa Bukti Terminal (Assertions Without Terminal Proof)**: Mengatakan "semua sudah bekerja dengan baik" tanpa bukti nyata eksekusi test runner dan build exit code 0.
- **Merusak Integritas Komentar & Dokumentasi**: Menghapus komentar atau penjelasan kontekstual yang sudah ada saat mengedit kode sumber.

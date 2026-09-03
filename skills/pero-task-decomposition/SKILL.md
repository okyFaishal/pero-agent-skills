---
name: pero-task-decomposition
description: Use when breaking down system specifications and architecture into a phased, granular task backlog across domains
---

# Pero Task Decomposition (`pero:task-decomposition`)

## Overview
**Origin**: *Pero Custom SDLC Pipeline - Stage 6 (Universal)*.
Skill ini bertindak sebagai **"Buku Agenda Kerja & Daftar Ceklis Mandor Bangunan"** (Memecah proyek raksasa menjadi potongan-potongan tugas kecil harian yang berurutan, jelas siapa yang mengerjakan, bagian mana yang dipotong dulu, dan kapan tangga boleh dipasang setelah pondasi kering). Tugasnya adalah menerjemahkan kebutuhan produk dari `docs/PRD.md`, spesifikasi fungsional & user stories dari `docs/SystemSpec.md`, cetak biru arsitektur dari `docs/Architecture.md`, dan standar tata kelola kualitas dari `docs/Governance.md` menjadi rencana kerja bertahap (*Phased Execution Plan*) dan daftar tugas terperinci per domain di dalam dokumen **`docs/TaskBacklog.md`** yang berlaku universal untuk semua bahasa dan framework (Universal / Polyglot).

## Sub-Skill Integration (Perkakas Pendukung)
Dalam menjalankan tahapan dekomposisi tugas, agent WAJIB mengorkestrasi sub-skill berikut:
- **Upstream Context Reader**: **`MANDATORY`**: Wajib membaca seluruh dokumen hulu (`docs/PRD.md`, `docs/SystemSpec.md`, `docs/Architecture.md`, dan `docs/Governance.md`) sebelum memecah tugas, untuk memastikan tidak ada fitur MVP, entitas data, kontrak API, aturan konkurensi, atau pagar keamanan yang terlewat tanpa alokasi tugas.
- **Dekomposisi Riset 5 Spesialis Backlog Tetap (*Fixed Task Decomposition Squad*)**: **`REQUIRED SUB-SKILL`**: Gunakan `dispatching-parallel-agents` untuk mendelegasikan tim beranggotakan **5 Agen Spesialis Dekomposisi Backlog Tetap** secara paralel yang masing-masing dibekali alat `context-7` dan `web-search`. Setiap spesialis wajib melakukan evaluasi relevansi awal (*Relevance Pre-Flight Check*). Jika domain relevan, agen dibatasi **minimal 2 dan maksimal 5 pencarian terarah**. Jika domain tidak relevan (misal domain UI pada proyek backend headless), agen wajib mendeklarasikan *Early-Exit* (`N/A: Not Applicable`) dan dilarang melakukan pencarian.
- **Verifikasi Tooling & Struktur File Resmi**: **`REQUIRED SUB-SKILL`**: Gunakan `context-7` dan `web-search` untuk memastikan konvensi penamaan berkas, pola modularisasi paket, dan skrip runner pengujian sesuai dengan standar resmi framework yang dipilih di `Architecture.md`.
- **Penegakan Kode Bersih & Efisiensi Backlog**: **`REQUIRED SUB-SKILL`**: Gunakan `anti-slop` untuk mencegah kartu tugas menghasilkan boilerplate berlebih, melarang tugas pembuatan komentar sepele, dan melarang pembuatan mock palsu tanpa assertions.
- **Klasifikasi Backlog UI & Dial Estetika**: **`CONDITIONAL SUB-SKILL`**: Jika backlog mencakup tugas antarmuka pengguna (Domain Web / Mobile UI), gunakan `taste-skill` untuk menyematkan parameter estetika (*UI Variance, Motion, Density*) pada kartu tugas terkait di `docs/TaskBacklog.md`. Jika tugas tidak menyentuh UI, sub-skill ini tidak digunakan.
- **Penegak Siklus Pengujian TDD**: **`REQUIRED SUB-SKILL`**: Gunakan `test-driven-development` untuk memastikan setiap kartu tugas teknis secara eksplisit memisahkan berkas tes (`Target Files (Test)`) dan berkas implementasi (`Target Files (Implementation)`).
- **Verifikasi Bukti Eksekusi Terminal**: **`REQUIRED SUB-SKILL`**: Gunakan `verification-before-completion` untuk menetapkan perintah verifikasi CLI presisi (*exact verification commands*) dengan ambang batas `exit code 0` dan `0 failure`.
- **Musyawarah Dewan Strategi Eksekusi**: **`REQUIRED / STRATEGIC SUB-SKILL`**: Gunakan `llm-council` untuk menyidangkan dilema strategi backlog (Vertical Feature Slices vs Horizontal Layers, granularitas tugas S/M/L, dan paralelisasi sub-agen) melalui 5 persona AI.
- **Wawancara Penguncian Strategi Backlog di Chat**: **`REQUIRED SUB-SKILL`**: Gunakan `grilling` secara interaktif langsung kepada pengguna di chat dengan batas **minimal 5 dan maksimal 10 pertanyaan** bertahap (1–2 pertanyaan per putaran) untuk mengunci strategi pemotongan backlog, prioritas milestone MVP, dan batas eksekusi paralel. Agent WAJIB menghentikan eksekusi (*pause*) dan menunggu respon pengguna. DILARANG menentukan backlog sepihak.
- **Proteksi Variabel Rahasia & Lingkungan**: **`SUPPORTING SUB-SKILL`**: Gunakan `env-guard` untuk mengawal tugas-tugas konfigurasi infrastruktur dan memastikan kredensial terisolasi aman di `.env`.
- **Mesin Eksekusi Backlog Otonom**: **`SUPPORTING SUB-SKILL`**: Gunakan `subagent-driven-development` untuk mengeksekusi seluruh urutan kartu tugas secara berkesinambungan menggunakan sub-agen segar per tugas tanpa interupsi.
- **Pencatatan Keputusan Dekomposisi Tugas**: **`SUPPORTING SUB-SKILL`**: Gunakan `decision-recorder` untuk membukukan keputusan pemisahan fase, strategi backlog, dan mitigasi dependensi ke `docs/decisions/TDR-[YYYYMMDDHHmm].md` menggunakan template standar resmi.
- **Audit Konsistensi Dekomposisi Tugas**: **`SUPPORTING SUB-SKILL`**: Gunakan `pero-context-validation` untuk memastikan seluruh fitur PRD, kontrak endpoint, dan batasan arsitektur teralokasi ke dalam kartu tugas tanpa ada yang terlewat (*100% Backlog Coverage*).

## The 5-Stage Task Decomposition Framework

```
[0. Ingestion docs/PRD.md, docs/SystemSpec.md, docs/Architecture.md, & docs/Governance.md]
                                   │
                                   ▼
[1. Riset 5 Spesialis Dekomposisi Tetap + Context7 & Web Search]
    (Infra/Types, Database, Logic/API, UI/State, E2E/Audit dengan Early-Exit N/A)
                                   │
                                   ▼
[2. Sidang Dewan Strategi Eksekusi (LLM Council)]
    (5 Persona AI menguji: Vertical Slice vs Horizontal, Granularitas S/M/L, Paralelisasi)
                                   │
                                   ▼
[3. Wawancara Penguncian Strategi Backlog di Chat (Grilling Rambu Henti)]
    (Min 5, Max 10 Tanya: kunci irisan fitur, ukuran tugas, batas paralel, gerbang fase)
                                   │
                                   ▼
[4. Penyusunan Dokumen TaskBacklog.md (5 Fase, 6 Domain, Kartu Tugas S/M)]
                                   │
                                   ▼
[5. Pembukuan Rekam Keputusan TDR Formal & Audit Konsistensi Hulu-Hilir]
```

### 1. Dekomposisi Riset Paralel Berbasis 5 Spesialis Backlog Tetap
Mendelegasikan tim 5 agen spesialis backlog tetap via `dispatching-parallel-agents` yang masing-masing dibekali alat `context-7` dan `web-search`:

#### A. 5 Peran Spesialis Dekomposisi Backlog Tetap (*Fixed Task Decomposition Roles*):
1. **Spesialis 1: Fondasi, Infrastruktur & Kontrak Tipe Bersama (*Infra, Tooling & Shared Core Contracts Specialist*)**:
   - *Fokus*: Membedah struktur direktori, konfigurasi tooling (`.env`, linter, git hooks), shared interfaces, data transfer objects (DTO), dan error types dasar.
2. **Spesialis 2: Database, Skema DDL & Lapisan Akses Data (*Database, Schemas & Repositories Specialist*)**:
   - *Fokus*: Membedah urutan migrasi skema tabel/koleksi, foreign key constraints, indeks query, repository interfaces, serta data seed/fixtures untuk pengujian.
3. **Spesialis 3: Logika Bisnis, API/IPC Controllers & Keamanan (*Business Logic, API & Security Specialist*)**:
   - *Fokus*: Membedah domain use-cases, route handlers, error matrix mapping, rate limiters, auth middleware, dan perimeter input sanitizers.
4. **Spesialis 4: Antarmuka Klien, State Store & Alur Pengguna (*Client UI, State Stores & Taste Specialist*)**:
   - *Fokus*: Membedah komponen UI, state store klien, API fetcher, form validations, responsive design, dan arahan visual `taste-skill`.
5. **Spesialis 5: Integrasi E2E, Audit Kerentanan & Gerbang Rilis (*E2E Integration, Vulnerability Audit & Release Gates Specialist*)**:
   - *Fokus*: Membedah pengujian integrasi hulu-ke-hilir (*End-to-End*), pemindaian audit keamanan dependensi, audit kebocoran secret, dan verifikasi kompilasi build rilis.

#### B. Mekanisme Evaluasi Relevansi Awal & Pintu Keluar Dini (*Relevance Pre-Flight Check & Early Exit*):
- Setiap spesialis membaca dokumen hulu sebelum menjalankan riset.
- Jika domain spesialis tersebut **sama sekali tidak relevan** (misalnya: Spesialis 4 pada proyek backend headless API tanpa antarmuka pengguna):
  - Spesialis **WAJIB** mendeklarasikan: `Status: Not Applicable (N/A). Alasan: [Penjelasan mengapa domain ini tidak dibutuhkan]`.
  - Agen berstatus `N/A` **DILARANG melakukan pencarian (0 search)** dan **DILARANG membuat kartu tugas kosong/palsu**.

#### C. Pagar Batas Riset & Pencarian (*Guardrails*):
- Untuk domain yang relevan: **Minimal 2 pencarian terarah** (wajib merujuk konvensi modularisasi atau framework resmi) dan **Maksimal 5 pencarian terarah** per agen.
- Untuk domain `N/A`: **0 pencarian**.
- Setiap agen spesialis aktif wajib menyertakan minimal 1 tautan URL / rujukan resmi dalam laporannya.

### 2. Musyawarah Dewan Strategi Eksekusi (via `llm-council`)
- Menyidangkan perdebatan strategi backlog ke 5 persona dewan AI (*Product Strategist, Skeptic Auditor, Domain Specialist, Tech Feasibility, User Advocate*).
- Topik sidang:
  - *Vertical Feature Slices* (mengerjakan 1 fitur utuh dari database sampai UI) vs *Horizontal Architectural Layers* (menyelesaikan seluruh database dulu, baru backend, lalu UI).
  - *Granularity Sizing*: Batasan ukuran kartu tugas agar aman dieksekusi oleh sub-agen mandiri tanpa kehabisan context memory (*context window starvation*).
  - *Paralelisasi Eksekusi*: Menentukan tugas mana yang aman dieksekusi secara paralel tanpa tabrakan file (*shared-file conflict*).
- Dewan menghasilkan sintesis konsensus dan opsi kompromi teknis (Opsi A vs Opsi B) untuk diserahkan ke sesi wawancara chat.

### 3. Wawancara Penguncian Strategi Backlog di Chat (via `grilling`)
- **RAMBU HENTI WAJIB (MANDATORY PAUSE GATE)**:
  - Agent **DILARANG** langsung membuat berkas `docs/TaskBacklog.md` sebelum menyepakati strategi pemotongan backlog, prioritas milestone MVP, dan batas eksekusi paralel bersama pengguna di obrolan (*chat*).
  - Dilarang keras menyusun backlog raksasa atau menentukan urutan rilis secara sepihak.
- **Pagar Batas Pertanyaan (Volume & Delivery Guardrails)**:
  - **Batas Kuantitas**: Sesi wawancara dibatasi **minimal 5 pertanyaan** (untuk menguji seluruh aspek strategi backlog) dan **maksimal 10 pertanyaan** (mencegah kelelahan pengguna).
  - **Penyampaian Bertahap (*Anti-Question Avalanche*)**: DILARANG memberondong pertanyaan sekaligus. Ajukan 1–2 pertanyaan per putaran chat dengan opsi konkret (Opsi A vs Opsi B) dan rekomendasi teknis AI.
- **Fokus Topik Wawancara**:
  1. Strategi Pemotongan Backlog (*Vertical Feature Slices* vs *Horizontal Architectural Layers*).
  2. Batasan Granularitas & Ukuran Tugas (*Ukuran S [1-2 file] vs M [3-4 file]* untuk membatasi konsumsi context sub-agen).
  3. Mode Eksekusi Sub-Agen (*Paralel via dispatching-parallel-agents* vs *Sekuensial via subagent-driven-development*).
  4. Prioritas Milestone MVP (*Fitur P0 yang harus selesai di Fase 3-4 vs Fitur P1 di fase penyempurnaan*).
  5. Kebijakan Gerbang Persetujuan per Fase (*Phase Checkpoints: apakah tiap fase perlu review pengguna sebelum melangkah ke fase berikutnya*).
- **Hentikan pemanggilan tools (STOP)** dan tunggu keputusan pengguna di chat pada setiap putaran.

### 4. Penyusunan Dokumen TaskBacklog.md Formal
- Menyusun dokumen lengkap `docs/TaskBacklog.md` mematuhi 5 fase, 6 lintasan domain, format kartu tugas berukuran S/M, target files eksplisit, dan perintah verifikasi terminal 0-failure.

### 5. Pembukuan Rekam Keputusan TDR Formal & Audit Konsistensi
- Membukukan seluruh keputusan strategi backlog ke `docs/decisions/TDR-[YYYYMMDDHHmm].md` menggunakan template standar resmi.
- Menjalankan audit konsistensi hulu-hilir via `pero-context-validation` untuk memastikan 100% Backlog Coverage (setiap user story PRD dan batasan arsitektur teralokasi ke kartu tugas).

## When to Use
- Memecah cetak biru arsitektur dan spesifikasi fungsional menjadi daftar tugas teknis harian yang berurutan dan terukur.
- Mengelompokkan pekerjaan ke dalam 6 lintasan domain (*Web, Mobile, Backend, Database, Security, Core / Cross-Cutting*).
- Menentukan urutan ketergantungan antar komponen (*phased pipeline structure*) dari fondasi hingga pengujian akhir.
- Mendefinisikan target file (test dan implementasi) secara presisi untuk setiap butir tugas sebelum koding dimulai.
- Menyusun perintah verifikasi CLI otomatis untuk setiap tugas guna menegakkan gerbang kualitas.

## The 6 Universal Domain Tracks
Pekerjaan didekomposisikan ke dalam lintasan domain teknis yang universal:
1. **`Web`**: Antarmuka web pengguna (UI/UX), komponen browser, manajemen state klien (Zustand, Redux, React Context, Pinia), styling/CSS, responsive layout, integrasi client-side HTTP/WebSocket.
2. **`Mobile`**: Antarmuka aplikasi mobile native/cross-platform (SwiftUI, Jetpack Compose, Flutter, React Native), lifecycle aplikasi, gesture/touch, integrasi device API, penyimpanan lokal offline.
3. **`Backend`**: Server HTTP routing, controller/handler, business services, application use-cases, background workers/job queues, middleware, event dispatching.
4. **`Database`**: Migrasi skema DDL, repository pattern, SQL/NoSQL queries, indexing, database seeds/fixtures untuk unit & integration test, transaction boundary management.
5. **`Security`**: Otentikasi & otorisasi (JWT, OAuth, Session), middleware RBAC/ABAC, perimeter input sanitizers, proteksi CSRF/CORS/CSP, secret isolation via `env-guard`, hashing password & enkripsi payload.
6. **`Core / Cross-Cutting`**: Shared types/interfaces, domain entities, konfigurasi terpusat, logging & telemetry, custom error classes, utility helpers, IPC/protocol message schemas.

## The 5-Phase Pipeline Framework

```
[Phase 1: Foundation, Infra & Shared Types] ──> [Phase 2: Core Domain Entities & Data Layer]
                                                                     │
[Phase 4: Feature Modules & Client UI]      <── [Phase 3: Business Logic & API/IPC Engines]
               │
[Phase 5: E2E Verification & Release Polish]
```

### Phase 1: Foundation, Infrastructure & Shared Types
- Menyiapkan pondasi proyek: instalasi dependensi dasar, setup linter/formatter, konfigurasi environment `.env` (`env-guard`), scaffolding struktur direktori, dan definisi tipe data bersama (*shared types / interfaces*).

### Phase 2: Core Domain Entities, Schemas & Data Layer
- Membangun entitas domain murni, migrasi skema database (DDL), model data / ORM, repository layer, skema validasi, serta database seed untuk pengujian.

### Phase 3: Core Business Logic, IPC/API & Service Engines
- Mengembangkan use cases, service engines, route controllers, middleware, implementasi kontrak API/IPC, dan translasi matriks error menggunakan pendekatan TDD (*Red-Green-Refactor*).

### Phase 4: Feature Modules, UI/Client Workflows & Integration
- Membangun komponen UI (Web/Mobile), integrasi API/IPC ke antarmuka pengguna, manajemen state klien, navigasi alur perjalanan pengguna (User Journeys), dan validasi interaksi form.

### Phase 5: E2E Verification, Security Audit & Release Polish
- Melakukan pengujian integrasi menyeluruh (*End-to-End Test*), audit keamanan & isolasi rahasia, verifikasi beban/kinerja (*NFR validation*), pembersihan kode (*code polish*), dan pemenuhan kriteria rilis 100% (*Definition of Done*).

## Checklist Format Standard
Setiap butir tugas dalam backlog **WAJIB** mengikuti format standar berikut:

```markdown
- [ ] **Task X.Y: [Judul Tugas Singkat & Jelas]** (Domain: [Web|Mobile|Backend|Database|Security|Core])
  - **Complexity / Size**: `[S (1-2 files, ~100 lines) | M (3-4 files, ~200-300 lines)]` *(Catatan: Tugas L WAJIB dipecah)*
  - **Depends On**: `[Task ID, misal: Task 1.1, Task 2.1 | None]`
  - **Parallel Safe?**: `[Yes (bebas konflik file dengan tugas lain di fase ini) | No (wajib sekuensial)]`
  - **Target Files**:
    - `[path/to/test_file.ext]` (Test)
    - `[path/to/source_file.ext]` (Implementation)
  - **Technical Requirements**: [Penjelasan teknis mendalam tentang apa yang harus diimplementasikan, interface mana yang dihubungkan, batasan anti-slop, dan guardrail arsitektur].
  - **Acceptance Criteria & Verification**:
    - [ ] [Kriteria 1 - spesifikasi fungsionalitas]
    - [ ] [Kriteria 2 - penanganan edge case / error matrix]
    - [ ] [Kriteria 3 - bebas lint error dan bebas mock palsu]
    - **Verification Command**: `[perintah terminal konkret]` (Harus menghasilkan exit code 0 dan 0 failure)
```

## Deliverables & Output Artifacts

1. **Living Document**: `docs/TaskBacklog.md`
2. **Decision Record**: `docs/decisions/TDR-[YYYYMMDDHHmm].md`

---

## Template: `docs/TaskBacklog.md`

````markdown
# Task Backlog & Phased Execution Plan: [Nama Sistem / Proyek]

- **Versi**: 1.0
- **Status**: Disetujui (Approved)
- **Tanggal**: [YYYY-MM-DD]
- **Dokumen Induk**:
  - [docs/PRD.md](docs/PRD.md)
  - [docs/SystemSpec.md](docs/SystemSpec.md)
  - [docs/Architecture.md](docs/Architecture.md)
  - [docs/Governance.md](docs/Governance.md)
- **Decision Record**: [docs/decisions/TDR-[YYYYMMDDHHmm].md](docs/decisions/TDR-[YYYYMMDDHHmm].md)

## 1. Executive Summary & Strategy
[Jelaskan strategi urutan pengerjaan proyek dalam 1-2 paragraf dengan analogi sederhana seperti mandor yang mengatur tukang batu, tukang pipa, dan tukang cat secara bergiliran agar tidak saling bertabrakan].

### Domain Breakdown Tracks:
- 🌐 **Web**: Antarmuka browser, styling, state management klien.
- 📱 **Mobile**: Antarmuka mobile, gestures, device APIs.
- ⚙️ **Backend**: Server routing, controllers, application services.
- 🗄️ **Database**: Migrasi skema, repositories, queries, fixtures.
- 🛡️ **Security**: Autentikasi, sanitasi input, isolasi rahasia.
- 🧩 **Core / Cross-Cutting**: Shared types, konfigurasi, error handling, logging.

---

## Phase 1: Foundation, Infrastructure & Shared Types
*Tujuan: Menyiapkan pondasi kokoh, konfigurasi lingkungan aman, linter, dan definisi kontrak tipe data bersama sebelum komponen lain dibangun.*

- [ ] **Task 1.1: Project Scaffolding, Tooling & Environment Guard** (Domain: Core)
  - **Complexity / Size**: `S (2 files, ~60 lines)`
  - **Depends On**: `None`
  - **Parallel Safe?**: `No (fondasi repositori utama)`
  - **Target Files**:
    - `.gitignore` (Config)
    - `.env.example` (Config)
    - `package.json` / `Cargo.toml` / `go.mod` (Dependencies)
  - **Technical Requirements**: Inisialisasi struktur direktori modular sesuai `docs/Architecture.md`, pasang dependensi linter/formatter, dan amankan file `.env` mematuhi `env-guard`.
  - **Acceptance Criteria & Verification**:
    - [ ] File konfigurasi terpasang dengan benar dan linter aktif.
    - [ ] Aturan `.gitignore` mencegah kebocoran file credential.
    - **Verification Command**: `npm run lint` / `cargo clippy` / `golangci-lint run` (Exit Code 0)

- [ ] **Task 1.2: Shared Domain Types & Interface Contracts** (Domain: Core)
  - **Complexity / Size**: `S (3 files, ~100 lines)`
  - **Depends On**: `Task 1.1`
  - **Parallel Safe?**: `Yes (berkas terisolasi di domain Core)`
  - **Target Files**:
    - `src/core/types/user.ts` (Shared Type)
    - `src/core/types/response.ts` (API Envelope)
    - `tests/core/types.test.ts` (Type Verification Test)
  - **Technical Requirements**: Definisikan tipe data entitas domain inti dan amplop respons standar (`success`, `error`, `meta`) sesuai `docs/SystemSpec.md` dan `docs/Architecture.md`.
  - **Acceptance Criteria & Verification**:
    - [ ] Seluruh atribut entitas domain memiliki tipe data konkret dan batasan nullability.
    - [ ] Type check lulus 100% tanpa tipe `any` atau unsafe type casting.
    - **Verification Command**: `npm run typecheck` / `cargo check` / `go vet ./...` (Exit Code 0)

---

## Phase 2: Core Domain Entities, Schemas & Data Layer
*Tujuan: Membangun skema database, migrasi DDL berulang, repository data access, dan data validator murni.*

- [ ] **Task 2.1: Database Schema Migrations & Data DDL** (Domain: Database)
  - **Complexity / Size**: `M (2 files, ~180 lines)`
  - **Depends On**: `Task 1.2`
  - **Parallel Safe?**: `No (skema database pondasi)`
  - **Target Files**:
    - `src/infra/db/migrations/001_initial_schema.sql` (Migration)
    - `tests/infra/db/migration.test.ts` (Migration Test)
  - **Technical Requirements**: Buat skrip migrasi tabel relasional / koleksi dokumen lengkap dengan primary key, foreign keys, indeks query utama, dan constraint unik sesuai `docs/SystemSpec.md`.
  - **Acceptance Criteria & Verification**:
    - [ ] Migrasi berhasil dieksekusi maju (*up*) dan mundur (*down / rollback*) tanpa error.
    - [ ] Indeks tabel terpasang pada field yang sering di-query.
    - **Verification Command**: `npm run test:db-migration` / `go test -v ./src/infra/db/...` (Exit Code 0)

- [ ] **Task 2.2: Domain Repository & Data Access Layer** (Domain: Database)
  - **Complexity / Size**: `M (2 files, ~220 lines)`
  - **Depends On**: `Task 2.1`
  - **Parallel Safe?**: `Yes (terisolasi pada domain repository)`
  - **Target Files**:
    - `tests/infra/repositories/user_repository.test.ts` (Test)
    - `src/infra/repositories/user_repository.ts` (Implementation)
  - **Technical Requirements**: Implementasikan interface repository port menggunakan query database terisolasi, menangani transaksi ACID, dan menerapkan pemetaan entitas domain.
  - **Acceptance Criteria & Verification**:
    - [ ] Unit test mencakup skenario Create, Read, Update, Delete, dan NotFound.
    - [ ] Koneksi database selalu dilepaskan setelah transaksi selesai.
    - **Verification Command**: `npm test src/infra/repositories/user_repository.test.ts` (Exit Code 0)

---

## Phase 3: Core Business Logic, IPC/API & Service Engines
*Tujuan: Mengimplementasikan logika bisnis use-cases, route handlers, error matrix mapping, dan security guards dengan siklus TDD.*

- [ ] **Task 3.1: Security & Authentication Guard Middleware** (Domain: Security)
  - **Complexity / Size**: `S (2 files, ~120 lines)`
  - **Depends On**: `Task 1.2`
  - **Parallel Safe?**: `Yes (independen dari use-cases bisnis)`
  - **Target Files**:
    - `tests/core/security/auth_middleware.test.ts` (Test)
    - `src/core/security/auth_middleware.ts` (Implementation)
  - **Technical Requirements**: Bangun middleware verifikasi token JWT / session, validasi header authorization, proteksi rate-limiting, dan sanitasi payload dari karakter berbahaya.
  - **Acceptance Criteria & Verification**:
    - [ ] Request tanpa token atau token kadaluarsa ditolak dengan error 401.
    - [ ] Request dengan token valid menyematkan context user ke request handler.
    - **Verification Command**: `npm test tests/core/security/auth_middleware.test.ts` (Exit Code 0)

- [ ] **Task 3.2: Domain Business Use-Cases & Service Engine** (Domain: Backend)
  - **Complexity / Size**: `M (2 files, ~240 lines)`
  - **Depends On**: `Task 2.2`
  - **Parallel Safe?**: `Yes (hanya bergantung pada interface repository)`
  - **Target Files**:
    - `tests/core/services/order_service.test.ts` (Test)
    - `src/core/services/order_service.ts` (Implementation)
  - **Technical Requirements**: Terapkan logika bisnis murni untuk use-cases sesuai PRD dan SystemSpec, mencakup validasi aturan bisnis, kalkulasi nilai, dan pemanggilan repository interface.
  - **Acceptance Criteria & Verification**:
    - [ ] Siklus TDD diterapkan: failing tests dibuat terlebih dahulu dan lolos pasca implementasi.
    - [ ] Menangani seluruh edge cases (stok habis, duplikasi order, timeout data).
    - **Verification Command**: `npm test tests/core/services/order_service.test.ts` (Exit Code 0)

- [ ] **Task 3.3: API Route Handlers & Standard Response Mapping** (Domain: Backend)
  - **Complexity / Size**: `M (2 files, ~160 lines)`
  - **Depends On**: `Task 3.1, Task 3.2`
  - **Parallel Safe?**: `No (merangkai auth middleware dan order service)`
  - **Target Files**:
    - `tests/api/routes/order_routes.test.ts` (Test)
    - `src/api/routes/order_routes.ts` (Implementation)
  - **Technical Requirements**: Sambungkan HTTP controller/route handler ke domain service, validasi input payload dengan schema validator, dan petakan respons ke envelope standar atau matriks error.
  - **Acceptance Criteria & Verification**:
    - [ ] Endpoint mengembalikan format sukses 200/201 dan format error 400/404/422/500 sesuai `docs/SystemSpec.md`.
    - **Verification Command**: `npm test tests/api/routes/order_routes.test.ts` (Exit Code 0)

---

## Phase 4: Feature Modules, UI/Client Workflows & Integration
*Tujuan: Membangun komponen UI web/mobile, menyambungkan state management ke API/IPC, dan merealisasikan alur pengguna PRD.*

- [ ] **Task 4.1: Client State Management & API Data Client** (Domain: Web / Mobile)
  - **Complexity / Size**: `M (2 files, ~150 lines)`
  - **Depends On**: `Task 3.3`
  - **Parallel Safe?**: `Yes (layer klien terisolasi)`
  - **Target Files**:
    - `tests/client/state/order_store.test.ts` (Test)
    - `src/client/state/order_store.ts` (Implementation)
  - **Technical Requirements**: Buat modul manajemen state klien untuk menangani request asinkron, status loading, penyimpanan cache lokal, dan translasi error ramah pengguna.
  - **Acceptance Criteria & Verification**:
    - [ ] State menangani transisi state: `idle` -> `loading` -> `success` / `error`.
    - **Verification Command**: `npm test tests/client/state/order_store.test.ts` (Exit Code 0)

- [ ] **Task 4.2: User Journey Interface Components & Form Views** (Domain: Web / Mobile)
  - **Complexity / Size**: `M (2 files, ~200 lines)`
  - **Depends On**: `Task 4.1`
  - **Parallel Safe?**: `Yes (komponen visual murni)`
  - **Target Files**:
    - `tests/client/components/OrderForm.test.tsx` (Test)
    - `src/client/components/OrderForm.tsx` (Implementation)
  - **Technical Requirements**: Kembangkan komponen UI interaktif sesuai User Story PRD, lengkap dengan validasi visual, feedback error inline, aksesibilitas keyboard, dan parameter estetika `taste-skill`.
  - **Acceptance Criteria & Verification**:
    - [ ] Komponen me-render formulir, memvalidasi input secara reaktif, dan memanggil aksi store saat submit.
    - **Verification Command**: `npm test tests/client/components/OrderForm.test.tsx` (Exit Code 0)

---

## Phase 5: E2E Verification, Security Audit & Release Polish
*Tujuan: Pengujian integrasi end-to-end menyeluruh, audit keamanan bebas rahasia, validasi NFR, dan penyelesaian Definition of Done.*

- [ ] **Task 5.1: End-to-End (E2E) Integration Flow Verification** (Domain: Core)
  - **Complexity / Size**: `M (1 file, ~180 lines)`
  - **Depends On**: `Task 4.2`
  - **Parallel Safe?**: `No (menguji seluruh alur end-to-end)`
  - **Target Files**:
    - `tests/e2e/order_flow.e2e.test.ts` (E2E Test)
  - **Technical Requirements**: Eksekusi pengujian alur pengguna penuh dari UI / HTTP entrypoint, melalui domain service, hingga database persistence dan verifikasi respons akhir.
  - **Acceptance Criteria & Verification**:
    - [ ] Seluruh skenario Happy Path, Negative Path, dan Edge Cases teruji lulus 100%.
    - **Verification Command**: `npm run test:e2e` / `pytest tests/e2e/` (Exit Code 0, 0 failures)

- [ ] **Task 5.2: Security Vulnerability Scan & Secret Leak Audit** (Domain: Security)
  - **Complexity / Size**: `S (1 file, ~50 lines report)`
  - **Depends On**: `Task 1.1`
  - **Parallel Safe?**: `Yes (audit read-only independen)`
  - **Target Files**:
    - `audit-report.log` (Report Output)
  - **Technical Requirements**: Jalankan pemeriksaan kerentanan dependensi (*dependency vulnerability audit*) dan pemindaian kode sumber untuk memastikan tidak ada kunci rahasia yang bocor.
  - **Acceptance Criteria & Verification**:
    - [ ] 0 kerentanan tingkat High/Critical ditemukan.
    - [ ] Tidak ada hardcoded credentials di kode sumber mematuhi `env-guard`.
    - **Verification Command**: `npm audit --audit-level=high` / `cargo audit` (Exit Code 0)

- [ ] **Task 5.3: Final Quality Gate & Build Verification** (Domain: Core)
  - **Complexity / Size**: `S (Build Artifact)`
  - **Depends On**: `Task 5.1, Task 5.2`
  - **Parallel Safe?**: `No (gerbang kompilasi rilis final)`
  - **Target Files**:
    - `dist/` atau artifact build release
  - **Technical Requirements**: Jalankan seluruh test suite, linter, type-check, dan build kompilasi release penuh untuk memastikan produk siap rilis.
  - **Acceptance Criteria & Verification**:
    - [ ] 100% test passing (`0 failures`, `0 errors`).
    - [ ] Linter lolos dengan `0 warnings`, `0 errors`.
    - [ ] Build release sukses dengan exit code 0.
    - **Verification Command**: `npm run test && npm run build` (Exit Code 0)

---

## Progress Tracker & Domain Matrix

| Domain | Phase 1 (Infra) | Phase 2 (Data) | Phase 3 (Logic/API) | Phase 4 (UI/Client) | Phase 5 (E2E/Audit) | Total Tasks |
|---|---|---|---|---|---|---|
| **Core** | Task 1.1, 1.2 | - | - | - | Task 5.1, 5.3 | 4 |
| **Database** | - | Task 2.1, 2.2 | - | - | - | 2 |
| **Security** | - | - | Task 3.1 | - | Task 5.2 | 2 |
| **Backend** | - | - | Task 3.2, 3.3 | - | - | 2 |
| **Web / Mobile**| - | - | - | Task 4.1, 4.2 | - | 2 |
| **Total** | 2 | 2 | 3 | 2 | 3 | **12** |
````

---

## Template: `docs/decisions/TDR-[YYYYMMDDHHmm].md`

````markdown
# TDR-[Nomor]: [Judul Keputusan Dekomposisi Tugas, misal: Strategi Pemotongan Vertical Feature Slices & Pembatasan Ukuran Tugas Maksimal M]

- **Status**: Diterima (Accepted) / Ditinjau (Proposed) / Digantikan (Superseded)
- **Tanggal**: [YYYY-MM-DD]
- **Pengambil Keputusan**: Pengguna & Tim Dekomposisi Backlog AI
- **Dokumen Terkait**: [docs/TaskBacklog.md](../TaskBacklog.md)

## 1. Konteks & Masalah Strategi Eksekusi
[Jelaskan alasan mengapa arsitektur dan spesifikasi perlu dipotong menggunakan strategi tertentu, serta pertimbangan kompleksitas atau dependensi antar komponen].

## 2. Strategi Backlog & Pemotongan yang Ditetapkan
[Jelaskan strategi pemotongan yang disepakati (Vertical Slices vs Horizontal Layers), alokasi fase, dan aturan pembatasan ukuran tugas (S/M)].

## 3. Alternatif Strategi yang Ditolak
| Alternatif Strategi | Alasan Penolakan |
|:---|:---|
| [Alternatif Strategi 1] | [Mengapa tidak dipilih / risiko kehabisan memory agen / tabrakan file] |
| [Alternatif Strategi 2] | [Kelemahan teknis / waktu tunggu dependensi yang terlalu lama] |

## 4. Konsekuensi Positif & Beban Operasional (Trade-offs)
- **Konsekuensi Positif**: [Kemudahan pengujian per fitur, paralelisasi bebas tabrakan, isolasi konteks sub-agen]
- **Beban Operasional**: [Kebutuhan sinkronisasi kontrak data lebih sering di awal fase]
- **Strategi Mitigasi / Otomatisasi**: [Bagaimana risiko ditekan via TDD dan verifikasi terminal otomatis]

## 5. Kebijakan Mitigasi & Rollback Tugas Gagal
[Prosedur jika sub-agen gagal menyelesaikan suatu tugas tanpa merusak hasil kerja tugas lain yang sudah selesai].
````

## Anti-Patterns & Common Mistakes
- **Simulated Backlog Deciding**: Menentukan sendiri strategi backlog, urutan slice, prioritas MVP, atau ukuran tugas tanpa pernah melakukan wawancara grilling di chat bersama pengguna.
- **Giant Context-Overflowing Tasks (Unsized Tasks)**: Membuat tugas raksasa berukuran L (lebih dari 4 berkas atau >300 baris) tanpa dipecah menjadi unit S/M, yang menyebabkan sub-agen AI mandiri kehabisan memori konteks (*context window starvation*) atau berhalusinasi.
- **Phantom Dependencies (Implicit Blockers)**: Membiarkan ketergantungan tugas tersembunyi tanpa mencatatnya di field `Depends On`, sehingga sub-agen paralel mencoba mengeksekusi use-case sebelum tabel database atau skema tipe datanya dibuat.
- **Shared-File Collision in Parallel Tasks**: Menugaskan 2 sub-agen paralel untuk mengedit berkas yang sama pada fase yang sama tanpa isolasi modular (*file lock conflict*), yang merusak riwayat Git.
- **Question Avalanche or Premature Cessation**: Mengirimkan lebih dari 2 pertanyaan sekaligus dalam satu balon chat, bertanya kurang dari 5 pertanyaan (terlalu malas/dangkal), atau melampaui batas 10 pertanyaan pada Tahap 3 (memicu kelelahan pengguna).
- **Forced Irrelevant Specialization**: Memaksakan riset tugas UI pada sistem backend headless alih-alih mendeklarasikan status `N/A`.
- **Unbounded Web Search Avalanche**: Melakukan kurang dari 2 pencarian terarah pada domain yang relevan, melampaui batas 5 pencarian per agen, atau tetap mencari pada domain `N/A`.
- **Tugas Raksasa Monolitik (Giant Monolithic Tasks)**: Membuat satu butir tugas mencakup seluruh sistem ("Buat fitur Checkout lengkap") tanpa membedah ke tabel database, logic service, API handler, dan komponen UI secara terpisah.
- **Daftar Tugas Tanpa Target File (Vague Checklists with No Target Files)**: Menulis petunjuk abstrak seperti "Perbaiki validasi form" tanpa mencantumkan path file test dan file implementasi yang harus dibuat/dimodifikasi.
- **Ketergantungan Fase Terbalik atau Melingkar (Circular & Inverted Dependencies)**: Memulai pengerjaan UI (Phase 4) sebelum model data dan kontrak endpoint (Phase 1-3) dirancang, sehingga memicu perombakan kode berulang.
- **Hilangnya Perintah Verifikasi Terminal (Missing Verification Commands)**: Mengganti bukti terminal otomatis dengan klaim subjektif ("sudah dites manual di browser"), yang melanggar prinsip `verification-before-completion`.
- **Backlog Tanpa Jangkar Hulu (Unanchored Backlog Drift)**: Menambahkan tugas-tugas acak yang tidak bersumber dari `docs/PRD.md`, `docs/SystemSpec.md`, `docs/Architecture.md`, atau `docs/Governance.md`.
- **Melewatkan Penulisan Test (Skipping TDD Tasks)**: Menyusun checklist tanpa menyertakan tugas pembuatan unit/integration test, yang melanggar hukum besi TDD.

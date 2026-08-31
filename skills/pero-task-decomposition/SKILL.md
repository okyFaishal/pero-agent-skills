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
- **Mesin Eksekusi Backlog Otonom**: **`SUPPORTING SUB-SKILL`**: Gunakan `subagent-driven-development` untuk mengeksekusi seluruh urutan kartu tugas secara berkesinambungan menggunakan sub-agen segar per tugas tanpa interupsi.
- **Orkestrasi Eksekusi Backlog Paralel**: **`SUPPORTING SUB-SKILL`**: Gunakan `dispatching-parallel-agents` untuk mengelompokkan tugas-tugas independen lintas domain dalam fase yang sama agar dapat dieksekusi secara serentak oleh sub-agen tanpa konflik berkas.
- **Pencatatan Keputusan Dekomposisi Tugas**: **`SUPPORTING SUB-SKILL`**: Gunakan `decision-recorder` untuk membukukan keputusan pemisahan fase dan strategi backlog ke `docs/decisions/TDR-[YYYYMMDDHHmm].md`.
- **Penegak Siklus Pengujian TDD**: **`REQUIRED SUB-SKILL`**: Gunakan `test-driven-development` untuk memastikan setiap butir tugas teknis mewajibkan penulisan failing test terlebih dahulu sebelum kode implementasi.
- **Verifikasi Bukti Eksekusi Terminal**: **`REQUIRED SUB-SKILL`**: Gunakan `verification-before-completion` untuk menetapkan perintah verifikasi terminal yang presisi (*exact verification commands*) dengan ambang batas `exit code 0` dan `0 failure`.
- **Proteksi Variabel Rahasia & Lingkungan**: **`SUPPORTING SUB-SKILL`**: Gunakan `env-guard` untuk mengawal tugas-tugas konfigurasi infrastruktur dan memastikan kredensial terisolasi aman di `.env`.

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
  - **Target Files**:
    - `[path/to/test_file.ext]` (Test)
    - `[path/to/source_file.ext]` (Implementation)
  - **Technical Requirements**: [Penjelasan teknis mendalam tentang apa yang harus diimplementasikan, interface mana yang dihubungkan, batasan apa yang harus dipatuhi].
  - **Acceptance Criteria & Verification**:
    - [ ] [Kriteria 1 - spesifikasi fungsionalitas]
    - [ ] [Kriteria 2 - penanganan edge case / error]
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
  - [docs/PRD.md](file:///docs/PRD.md)
  - [docs/SystemSpec.md](file:///docs/SystemSpec.md)
  - [docs/Architecture.md](file:///docs/Architecture.md)
  - [docs/Governance.md](file:///docs/Governance.md)
- **Decision Record**: [docs/decisions/TDR-[YYYYMMDDHHmm].md](file:///docs/decisions/TDR-[YYYYMMDDHHmm].md)

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
  - **Target Files**:
    - `src/infra/db/migrations/001_initial_schema.sql` (Migration)
    - `tests/infra/db/migration.test.ts` (Migration Test)
  - **Technical Requirements**: Buat skrip migrasi tabel relasional / koleksi dokumen lengkap dengan primary key, foreign keys, indeks query utama, dan constraint unik sesuai `docs/SystemSpec.md`.
  - **Acceptance Criteria & Verification**:
    - [ ] Migrasi berhasil dieksekusi maju (*up*) dan mundur (*down / rollback*) tanpa error.
    - [ ] Indeks tabel terpasang pada field yang sering di-query.
    - **Verification Command**: `npm run test:db-migration` / `go test -v ./src/infra/db/...` (Exit Code 0)

- [ ] **Task 2.2: Domain Repository & Data Access Layer** (Domain: Database)
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
  - **Target Files**:
    - `tests/core/security/auth_middleware.test.ts` (Test)
    - `src/core/security/auth_middleware.ts` (Implementation)
  - **Technical Requirements**: Bangun middleware verifikasi token JWT / session, validasi header authorization, proteksi rate-limiting, dan sanitasi payload dari karakter berbahaya.
  - **Acceptance Criteria & Verification**:
    - [ ] Request tanpa token atau token kadaluarsa ditolak dengan error 401.
    - [ ] Request dengan token valid menyematkan context user ke request handler.
    - **Verification Command**: `npm test tests/core/security/auth_middleware.test.ts` (Exit Code 0)

- [ ] **Task 3.2: Domain Business Use-Cases & Service Engine** (Domain: Backend)
  - **Target Files**:
    - `tests/core/services/order_service.test.ts` (Test)
    - `src/core/services/order_service.ts` (Implementation)
  - **Technical Requirements**: Terapkan logika bisnis murni untuk use-cases sesuai PRD dan SystemSpec, mencakup validasi aturan bisnis, kalkulasi nilai, dan pemanggilan repository interface.
  - **Acceptance Criteria & Verification**:
    - [ ] Siklus TDD diterapkan: failing tests dibuat terlebih dahulu dan lolos pasca implementasi.
    - [ ] Menangani seluruh edge cases (stok habis, duplikasi order, timeout data).
    - **Verification Command**: `npm test tests/core/services/order_service.test.ts` (Exit Code 0)

- [ ] **Task 3.3: API Route Handlers & Standard Response Mapping** (Domain: Backend)
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
  - **Target Files**:
    - `tests/client/state/order_store.test.ts` (Test)
    - `src/client/state/order_store.ts` (Implementation)
  - **Technical Requirements**: Buat modul manajemen state klien untuk menangani request asinkron, status loading, penyimpanan cache lokal, dan translasi error ramah pengguna.
  - **Acceptance Criteria & Verification**:
    - [ ] State menangani transisi state: `idle` -> `loading` -> `success` / `error`.
    - **Verification Command**: `npm test tests/client/state/order_store.test.ts` (Exit Code 0)

- [ ] **Task 4.2: User Journey Interface Components & Form Views** (Domain: Web / Mobile)
  - **Target Files**:
    - `tests/client/components/OrderForm.test.tsx` (Test)
    - `src/client/components/OrderForm.tsx` (Implementation)
  - **Technical Requirements**: Kembangkan komponen UI interaktif sesuai User Story PRD, lengkap dengan validasi visual, feedback error inline, dan aksesibilitas keyboard.
  - **Acceptance Criteria & Verification**:
    - [ ] Komponen me-render formulir, memvalidasi input secara reaktif, dan memanggil aksi store saat submit.
    - **Verification Command**: `npm test tests/client/components/OrderForm.test.tsx` (Exit Code 0)

---

## Phase 5: E2E Verification, Security Audit & Release Polish
*Tujuan: Pengujian integrasi end-to-end menyeluruh, audit keamanan bebas rahasia, validasi NFR, dan penyelesaian Definition of Done.*

- [ ] **Task 5.1: End-to-End (E2E) Integration Flow Verification** (Domain: Core)
  - **Target Files**:
    - `tests/e2e/order_flow.e2e.test.ts` (E2E Test)
  - **Technical Requirements**: Eksekusi pengujian alur pengguna penuh dari UI / HTTP entrypoint, melalui domain service, hingga database persistence dan verifikasi respons akhir.
  - **Acceptance Criteria & Verification**:
    - [ ] Seluruh skenario Happy Path, Negative Path, dan Edge Cases teruji lulus 100%.
    - **Verification Command**: `npm run test:e2e` / `pytest tests/e2e/` (Exit Code 0, 0 failures)

- [ ] **Task 5.2: Security Vulnerability Scan & Secret Leak Audit** (Domain: Security)
  - **Target Files**:
    - `audit-report.log` (Report Output)
  - **Technical Requirements**: Jalankan pemeriksaan kerentanan dependensi (*dependency vulnerability audit*) dan pemindaian kode sumber untuk memastikan tidak ada kunci rahasia yang bocor.
  - **Acceptance Criteria & Verification**:
    - [ ] 0 kerentanan tingkat High/Critical ditemukan.
    - [ ] Tidak ada hardcoded credentials di kode sumber mematuhi `env-guard`.
    - **Verification Command**: `npm audit --audit-level=high` / `cargo audit` (Exit Code 0)

- [ ] **Task 5.3: Final Quality Gate & Build Verification** (Domain: Core)
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

## Anti-Patterns & Common Mistakes
- **Tugas Raksasa Monolitik (Giant Monolithic Tasks)**: Membuat satu butir tugas mencakup seluruh sistem ("Buat fitur Checkout lengkap") tanpa membedah ke tabel database, logic service, API handler, dan komponen UI secara terpisah.
- **Daftar Tugas Tanpa Target File (Vague Checklists with No Target Files)**: Menulis petunjuk abstrak seperti "Perbaiki validasi form" tanpa mencantumkan path file test dan file implementasi yang harus dibuat/dimodifikasi.
- **Ketergantungan Fase Terbalik atau Melingkar (Circular & Inverted Dependencies)**: Memulai pengerjaan UI (Phase 4) sebelum model data dan kontrak endpoint (Phase 1-3) dirancang, sehingga memicu perombakan kode berulang.
- **Hilangnya Perintah Verifikasi Terminal (Missing Verification Commands)**: Mengganti bukti terminal otomatis dengan klaim subjektif ("sudah dites manual di browser"), yang melanggar prinsip `verification-before-completion`.
- **Backlog Tanpa Jangkar Hulu (Unanchored Backlog Drift)**: Menambahkan tugas-tugas acak yang tidak bersumber dari `docs/PRD.md`, `docs/SystemSpec.md`, `docs/Architecture.md`, atau `docs/Governance.md`.
- **Melewatkan Penulisan Test (Skipping TDD Tasks)**: Menyusun checklist tanpa menyertakan tugas pembuatan unit/integration test, yang melanggar hukum besi TDD.

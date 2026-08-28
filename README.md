# Pero Agent Skills (`pero-agent-skills`)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Skills: 22 Universal](https://img.shields.io/badge/Skills-22%20Universal-brightgreen.svg)](#katalog-lengkap-22-skill-universal)
[![Architecture: Polyglot](https://img.shields.io/badge/Architecture-Polyglot-orange.svg)](#)

> **Ekosistem Standar SDLC & Rekayasa Agen AI Universal (Polyglot) yang Disiplin, Anti-Sycophancy, dan Berbahasa Ramah (ELI5).**

---

## Penjelasan Sederhana (ELI5)

> Bayangkan **Pero Agent Skills** ini seperti **Kotak Perkakas Robot Insinyur Ajaib**:
> - Ketika dipasang di proyek apa pun (Web, Mobile, Backend, AI, Database), asisten AI Anda otomatis bertransformasi menjadi **Insinyur Senior yang Sangat Disiplin**:
> - **Tidak Asal Tebak**: Selalu mendiagnosa akar masalah terlebih dahulu sebelum meresepkan solusi (*Problem Framing & Systematic Debugging*).
> - **Membangun dengan Denah Matang**: Menyusun fondasi dan aturan kualitas sebelum menyuruh tukang bekerja (*SDLC Pipeline*).
> - **Anti-Pujian Palsu (*Anti-Sycophancy*)**: Jujur berbasis bukti teknis dan berani menolak ide yang berisiko merusak sistem.
> - **Wajib Bukti Nyata (*Evidence Before Assertions*)**: Dilarang mengklaim selesai sebelum ada bukti tes terminal yang 100% lulus.
> - **Bahasa Ramah**: Menjelaskan konsep rumit dengan analogi sehari-hari yang mudah dimengerti siapa saja.

---

## Instalasi Cepat (1-Line Command)

Pasang seluruh 22 skill dan aturan tata kelola ke proyek Anda cukup dengan **satu baris perintah**:

```bash
curl -fsSL https://raw.githubusercontent.com/okyFaishal/pero-agent-skills/main/install.sh | bash
```

Atau jika ingin mengarahkan ke folder proyek tertentu:

```bash
curl -fsSL https://raw.githubusercontent.com/okyFaishal/pero-agent-skills/main/install.sh | bash -s -- /path/ke/proyek-anda
```

---

## Peta Navigasi Ekosistem Pero

Diagram di bawah menggambarkan bagaimana ke-22 skill saling berinteraksi dan mengalir dari tahap ide mentah hingga kode siap rilis:

```mermaid
flowchart TB
    %% STYLING
    classDef sdlc fill:#e1f5fe,stroke:#0288d1,stroke-width:2px,color:#01579b;
    classDef engine fill:#e8f5e9,stroke:#388e3c,stroke-width:2px,color:#1b5e20;
    classDef govern fill:#fff3e0,stroke:#f57c00,stroke-width:2px,color:#e65100;
    classDef tool fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px,color:#4a148c;
    classDef guard fill:#ffebee,stroke:#d32f2f,stroke-width:2px,color:#b71c1c;

    subgraph TOOLING [1. Universal Tooling and Research]
        FS["find-skill (Pencari Skill)"]:::tool
        C7["context-7 (Docs API Resmi)"]:::tool
        WS["web-search (Riset Eksternal)"]:::tool
        GRL["grilling (Stress-Test Ide)"]:::tool
    end

    subgraph SDLC [2. Pero SDLC Planning Pipeline]
        S1["1. pero-problem-framing"]:::sdlc
        S2["2. pero-prd-writing"]:::sdlc
        S3["3. pero-user-stories"]:::sdlc
        S4["4. pero-system-architecture"]:::sdlc
        S5["5. pero-quality-governance"]:::sdlc
        S6["6. pero-task-decomposition"]:::sdlc
        S7["7. pero-granular-refinement"]:::sdlc
        S8["8. pero-context-validation"]:::sdlc
    end

    subgraph CONTRACTS [3. Governance, Contracts and Data]
        API["api-contract-design"]:::govern
        SCH["schema-validator"]:::govern
        ADR["decision-recorder"]:::govern
        DOC["living-doc-sync"]:::govern
        ENV["env-guard"]:::guard
    end

    subgraph ENGINE [4. Core Engineering Inner Loop]
        GIT["git-ops"]:::engine
        TDD["test-driven-development"]:::engine
        DBG["systematic-debugging"]:::engine
        VBC["verification-before-completion"]:::engine
        REV["code-reviewer"]:::engine
    end

    %% Connections
    FS -.-> S1
    FS -.-> TDD
    
    GRL --- S1
    GRL --- S4
    
    S1 --> S2
    S2 --> S3
    S3 --> S4
    S4 --> S5
    S5 --> S6
    S6 --> S7
    S7 --> S8
    
    S3 -.-> API
    API -.-> SCH
    S4 -.-> C7
    S4 -.-> ADR
    
    S8 ==> GIT
    
    GIT --> TDD
    TDD --> DBG
    DBG --> TDD
    TDD --> VBC
    VBC --> REV
    REV --> DOC
    DOC --> GIT

    ENV -.-> TDD
    ENV -.-> S1
```

---

## Pohon Keputusan: Kapan Menggunakan Skill Apa

Gunakan diagram alur keputusan (*Decision Flowchart*) berikut untuk menentukan skill yang tepat sesuai situasi yang dihadapi:

```mermaid
flowchart TD
    START["Kondisi atau Kebutuhan Tugas"] --> Q1{Kategori Tugas}

    %% Cabang 1: Ide Baru / Problem
    Q1 -->|Mulai ide baru / Eksplorasi fitur| A1["Pahami akar masalah & batasan non-goals"]
    A1 --> SK_PF["pero-problem-framing"]
    SK_PF -->|Ide masih ambigu?| SK_GRL["grilling (Wawancara mendalam)"]

    %% Cabang 2: Menyusun Spesifikasi & Cerita
    Q1 -->|Menyusun spek MVP & Prioritas| SK_PRD["pero-prd-writing"]
    SK_PRD --> SK_US["pero-user-stories (Gherkin & Entity)"]

    %% Cabang 3: Arsitektur & Kontrak
    Q1 -->|Rancang arsitektur & pilih library| SK_ARCH["pero-system-architecture"]
    SK_ARCH --> SK_C7["context-7 (Dokumentasi resmi API)"]
    SK_ARCH --> SK_API["api-contract-design & schema-validator"]
    SK_ARCH --> SK_ADR["decision-recorder (Catat ADR)"]

    %% Cabang 4: Menambah Fitur di Arsitektur
    Q1 -->|Mau tambah fitur saat di Arsitektur?| Q_FEAT{Skala Perubahan Fitur?}
    Q_FEAT -->|Fitur Besar / Ubah Masalah| SK_PF
    Q_FEAT -->|Fitur Tambahan / MVP Baru| SK_PRD

    %% Cabang 5: Pemecahan Tugas & Refinement
    Q1 -->|Pecah arsitektur jadi backlog| SK_DECOMP["pero-task-decomposition"]
    SK_DECOMP --> SK_GRAN["pero-granular-refinement (File paths & Failing tests)"]
    SK_GRAN --> SK_VALID["pero-context-validation (Audit dokumen)"]

    %% Cabang 6: Eksekusi Koding & TDD
    Q1 -->|Mulai ngoding tugas| SK_GIT1["git-ops (Buat branch fitur)"]
    SK_GIT1 --> SK_TDD["test-driven-development (Red -> Green -> Refactor)"]

    %% Cabang 7: Troubleshooting / Bug
    Q1 -->|Ketemu bug / Tes error| SK_DBG["systematic-debugging (Reproduksi -> Isolasi -> Fix)"]
    SK_DBG --> SK_TDD

    %% Cabang 8: Selesai & Review
    Q1 -->|Mau klaim selesai / Buka PR| SK_VBC["verification-before-completion (Bukti terminal)"]
    SK_VBC --> SK_REV["code-reviewer (Audit 2-Lapis)"]
    SK_REV --> SK_SYNC["living-doc-sync (Update diagram docs)"]
    SK_SYNC --> SK_GIT2["git-ops (Commit Caveman & PR)"]

    style START fill:#f9f,stroke:#333,stroke-width:2px
    style SK_PF fill:#e1f5fe,stroke:#0288d1,stroke-width:2px
    style SK_PRD fill:#e1f5fe,stroke:#0288d1,stroke-width:2px
    style SK_ARCH fill:#e1f5fe,stroke:#0288d1,stroke-width:2px
    style SK_TDD fill:#e8f5e9,stroke:#388e3c,stroke-width:2px
    style SK_DBG fill:#ffebee,stroke:#d32f2f,stroke-width:2px
    style SK_VBC fill:#e8f5e9,stroke:#388e3c,stroke-width:2px
```

---

## Alur 8 Tahap Pero SDLC Pipeline & Siklus Umpan Balik

Pipeline perencanaan Pero mengalir secara bertahap dari tahap hulu ke hilir. Jika terdapat perubahan kebutuhan atau penambahan fitur di tengah jalan, alur kembali ke tahap spesifikasi yang relevan:

```mermaid
flowchart LR
    subgraph PHASE1 [Tahap 1 - 4: Perumusan Konsep & Desain]
        P1["1. problem-framing"] --> P2["2. prd-writing"]
        P2 --> P3["3. user-stories"]
        P3 --> P4["4. system-architecture"]
    end

    subgraph PHASE2 [Tahap 5 - 8: Tata Kelola & Dekomposisi]
        P4 --> P5["5. quality-governance"]
        P5 --> P6["6. task-decomposition"]
        P6 --> P7["7. granular-refinement"]
        P7 --> P8["8. context-validation"]
    end

    %% Feedback loops
    P4 -.->|Ingin Tambah Fitur Baru| P2
    P4 -.->|Masalah Dasar Berubah| P1
    P8 -.->|Ditemukan Inkonsistensi| P4

    style P1 fill:#e1f5fe,stroke:#0288d1,stroke-width:2px
    style P2 fill:#e1f5fe,stroke:#0288d1,stroke-width:2px
    style P3 fill:#e1f5fe,stroke:#0288d1,stroke-width:2px
    style P4 fill:#e1f5fe,stroke:#0288d1,stroke-width:2px
    style P5 fill:#e1f5fe,stroke:#0288d1,stroke-width:2px
    style P6 fill:#e1f5fe,stroke:#0288d1,stroke-width:2px
    style P7 fill:#e1f5fe,stroke:#0288d1,stroke-width:2px
    style P8 fill:#e1f5fe,stroke:#0288d1,stroke-width:2px
```

> **Catatan Mengenai Umpan Balik (*Feedback Loop*)**:
> Jangan melompat langsung ke `pero-granular-refinement` saat ingin menambahkan fitur baru di tahap arsitektur. Kembalilah ke `pero-prd-writing` atau `pero-problem-framing` agar cakupan (*scope*) dan kontrak sistem tetap selaras.

---

## Siklus Koding Disiplin (The Inner Engineering Loop)

Setelah perencanaan selesai, setiap tugas dieksekusi melalui siklus koding teruji (*Test-Driven Development*) dan gerbang pembuktian terminal:

```mermaid
sequenceDiagram
    autonumber
    actor Dev as Agent / Developer
    participant Git as git-ops
    participant TDD as test-driven-dev
    participant DBG as systematic-debugging
    participant VBC as verification-before-completion
    participant Rev as code-reviewer

    Dev->>Git: Buat feature branch baru
    Dev->>TDD: Tulis Failing Test (RED)
    Note over TDD: Jalankan test -> Wajib Gagal
    Dev->>TDD: Tulis Kode Implementasi Minimal (GREEN)
    Note over TDD: Jalankan test -> Wajib Lulus
    Dev->>TDD: Refactor Kode (REFACTOR)
    
    opt Jika Muncul Bug / Regresi Tak Terduga
        Dev->>DBG: Investigasi Akar Masalah (4-Fase Ilmiah)
        DBG-->>TDD: Tulis regression test baru
    end

    Dev->>VBC: Jalankan Full Suite Test di Terminal
    Note over VBC: Verifikasi bukti nyata (Exit code 0)
    Dev->>Rev: Audit 2-Lapis (Spec Match & Clean Code)
    Rev-->>Git: Kode disetujui -> Commit Caveman & Buat PR
```

---

## Katalog Lengkap 22 Skill Universal

| No | Skill | Kategori | Kapan Digunakan (*Trigger*) | Input ➡️ Output Utama |
|---|---|---|---|---|
| 1 | `pero-problem-framing` | Pero SDLC | Memulai proyek baru, eksplorasi ide mentah pengguna | Ide mentah ➡️ `docs/ProblemFraming.md` |
| 2 | `pero-prd-writing` | Pero SDLC | Menyusun PRD formal, prioritas fitur MVP (P0/P1/P2) & NFR | Problem Framing ➡️ `docs/PRD.md` |
| 3 | `pero-user-stories` | Pero SDLC | Menulis skenario uji Gherkin (`Given/When/Then`) & model data | PRD ➡️ `docs/SystemSpec.md` |
| 4 | `pero-system-architecture` | Pero SDLC | Merancang denah arsitektur sistem, komponen, & diagram Mermaid | System Spec ➡️ `docs/Architecture.md` |
| 5 | `pero-quality-governance` | Pero SDLC | Menetapkan aturan thread-safety, batas kualitas & review gate | Architecture ➡️ `docs/Governance.md` |
| 6 | `pero-task-decomposition` | Pero SDLC | Memecah spesifikasi sistem menjadi backlog 6 domain | Arsitektur & Spek ➡️ `docs/TaskBacklog.md` |
| 7 | `pero-granular-refinement` | Pero SDLC | Menajamkan kartu tugas dengan file path, signature, & failing test | Task Backlog ➡️ Kartu Tugas Siap Koding |
| 8 | `pero-context-validation` | Pero SDLC | Mengaudit konsistensi antar seluruh dokumen & diagram Mermaid | Seluruh `docs/*.md` ➡️ Laporan Validasi Silang |
| 9 | `find-skill` | Tooling | Mencari skill yang relevan di folder `.agents/skills/` | Kata kunci tugas ➡️ Rekomendasi Skill |
| 10 | `context-7` | Tooling | Membaca dokumentasi resmi library/API via Context7 MCP | Nama paket/library ➡️ Dokumentasi Resmi Terverifikasi |
| 11 | `web-search` | Tooling | Riset internet terarah untuk pemecahan masalah & fakta rilis | Query pencarian ➡️ Fakta & Solusi Teruji |
| 12 | `grilling` | Discipline | Wawancara mendalam pohon keputusan & stress-test ide/desain | Ide/Rancangan ambigu ➡️ Kesepakatan Desain Solid |
| 13 | `test-driven-development` | Discipline | Menulis kode fitur/bugfix (Siklus Red-Green-Refactor) | Kartu Tugas ➡️ Failing Test + Implementasi Lulus |
| 14 | `systematic-debugging` | Discipline | Menemukan bug atau kegagalan tes tanpa trial-and-error | Bug/Error ➡️ Root Cause + Fix Terisolasi |
| 15 | `verification-before-completion` | Discipline | Sebelum mengklaim tugas selesai atau membuat PR | Hasil kerja ➡️ Bukti Log Terminal Nyata |
| 16 | `code-reviewer` | Discipline | Review 2-lapis sebelum merge: Kesesuaian spek & kode bersih | Diff Kode ➡️ Checklist Audit Kualitas |
| 17 | `api-contract-design` | Architecture | Merancang kontrak antarmuka data REST, GraphQL, atau gRPC | Kebutuhan API ➡️ Dokumen Kontrak & Endpoint |
| 18 | `schema-validator` | Data | Memvalidasi integritas skema JSON, DTO, dan serialisasi | Data Payload ➡️ Status Validasi Skema |
| 19 | `decision-recorder` | Governance | Mencatat riwayat keputusan arsitektur/teknis (`ADR`/`PDR`) | Keputusan Desain ➡️ `docs/decisions/*.md` |
| 20 | `living-doc-sync` | Docs | Menyinkronkan diagram & dokumentasi saat kode berubah | Perubahan Kode ➡️ Update Diagram Arsitektur |
| 21 | `git-ops` | Operations | Operasi branching, commit Caveman, template PR, dan gh CLI | Perubahan Kode ➡️ Git Branch & PR Bersih |
| 22 | `env-guard` | Security | Melindungi file `.env`, kredensial, & filter perintah bahaya | Seluruh Operasi ➡️ Proteksi Rahasia & Keamanan |

---

## Tiga Pilar Tata Kelola Inti

1. **Skill-First Protocol**: Agent wajib mengecek `.agents/skills/` sebelum mengambil tindakan apa pun.
2. **Anti-Sycophancy & Technical Rigor**: Kebenaran teknis di atas menyenangkan pengguna. Dilarang menggunakan pujian kosong (*"Ide hebat!"*).
3. **Bahasa Sederhana (ELI5)**: Setiap konsep teknis wajib dijelaskan dengan analogi konkret sehari-hari tanpa menimbun jargon membingungkan.

---

## Lisensi
Distributed under the MIT License. Created by **Pero**.


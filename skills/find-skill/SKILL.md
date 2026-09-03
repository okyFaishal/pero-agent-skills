---
name: find-skill
description: Use when starting a new task, uncertain which skill applies, or needing to discover relevant local skills in .agents/skills/
---

# Universal Skill Discovery & Dispatch Engine (`find-skill`)

## Overview
**Origin**: *Model Context Protocol (MCP) Tool Discovery Architecture + W3C WoT Discovery Specification + Agentic Intent Routing Patterns*.  
Skill ini adalah **"Mesin Pencari Cerdas & Pemandu Navigasi Keterampilan Agen"**. Bertanggung jawab memindai, mencocokkan, dan mengaktifkan modul skill lokal yang paling relevan di `.agents/skills/` berdasarkan konteks tugas yang diberikan pengguna, menjamin kepatuhan mutlak terhadap *Skill-First Protocol*.

> **Analogi Sederhana (ELI5):**  
> Bayangkan **Resepsionis Navigasi Cerdas di Rumah Sakit Raksasa**:
> - **AI Tanpa Find-Skill (Tersesat & Salah Kamar)**: Pasien datang dengan keluhan patah tulang, tetapi diarahkan ke dokter gigi hanya karena dokter gigi sedang menganggur.
> - **Dengan Find-Skill (Pemandu Tepat Sasaran)**: Resepsionis mendengarkan gejala pasien, memeriksa direktori seluruh 28 dokter spesialis yang bertugas (*katalog skill*), mencocokkan jadwal keahlian (*trigger condition*), lalu langsung mengantarkan pasien ke ruang bedah ortopedi yang tepat.

---

## Landasan Teori & Referensi Industri Nyata

Skill ini dibangun di atas 3 pilar rekayasa penemuan kapabilitas dan perutean agen cerdas (*agentic routing*):

### 1. Agentic Intent Routing & Semantic Dispatching
Arsitektur perutean berbasis maksud (*intent routing*) yang memetakan masukan pengguna ke modul kapabilitas terisolasi.
*   **Referensi 1 (Standar Anthropic MCP)**: *Anthropic*, "Model Context Protocol (MCP) Specification - Dynamic Tool & Resource Discovery Architecture" ([modelcontextprotocol.io](https://modelcontextprotocol.io)).
*   **Referensi 2 (Pola Framework AI)**: *LlamaIndex & LangChain Architecture Guides*, "Router Query Engine & Multi-Agent Routing Patterns".
*   **Referensi 3 (Buku Klasik AI)**: *Stuart Russell & Peter Norvig*, "Artificial Intelligence: A Modern Approach - Goal-Based and Utility-Based Agent Routing" (4th Edition, Pearson).

### 2. Explicit Capability Matching & Service Registry
Protokol pencocokan deklaratif berbasis kontrak antarmuka dan metadata kemampuan sistem.
*   **Referensi 1 (Standar W3C WoT)**: *W3C Recommendation*, "Web of Things (WoT) Discovery Architecture Specification" ([w3.org/TR/wot-discovery/](https://www.w3.org/TR/wot-discovery/)).
*   **Referensi 2 (Standar OpenAPI)**: *OpenAPI Initiative*, "OpenAPI Specification v3.1.0 - Endpoint Operation & Tag-Based Capability Discovery" ([openapis.org](https://www.openapis.org)).
*   **Referensi 3 (Arsitektur Layanan SOA)**: *Thomas Erl*, "Service-Oriented Architecture: Concepts, Technology, and Design - Dynamic Service Broker Pattern" (Prentice Hall).

### 3. Deterministic Fallback & Decision Tree Taxonomy
Penanganan percabangan menggunakan pohon taksonomi terstruktur dan mekanisme pengalihan (*fallback*) yang deterministik.
*   **Referensi 1 (Algoritma Knuth)**: *Donald E. Knuth*, "The Art of Computer Programming, Volume 3: Sorting and Searching - Trie Search & Prefix Trees" (Addison-Wesley).
*   **Referensi 2 (Standar Pengujian Sistem)**: *IEEE Standard 829*, "IEEE Standard for Software and System Test Documentation - Decision Tables & State Transitions".
*   **Referensi 3 (Pencocokan Pola Rete)**: *Charles L. Forgy*, "Rete: A Fast Algorithm for the Many Pattern/Many Object Pattern Match Problem" (Artificial Intelligence Journal, Vol. 19, No. 1).

---

## Matriks Pemetaan Pemicu 28 Skill (*Trigger-to-Skill Dispatch Matrix*)

Gunakan tabel pemetaan di bawah ini untuk menentukan skill yang wajib dibuka dan dipatuhi:

| Kategori Tugas | Kata Kunci Masukan Pengguna (*Triggers*) | Modul Skill yang Wajib Diaktifkan |
|---|---|---|
| **Eksplorasi Ide** | "Saya punya ide", "fitur baru", "pain points", "masalah pengguna" | [`pero-problem-framing`](../pero-problem-framing/SKILL.md) |
| **Penyusunan Spek** | "Tulis PRD", "MVP scope", "prioritas fitur P0/P1/P2", "NFR" | [`pero-prd-writing`](../pero-prd-writing/SKILL.md) |
| **Skenario Uji** | "User story", "Gherkin", "Given When Then", "model entity" | [`pero-user-stories`](../pero-user-stories/SKILL.md) |
| **Desain Sistem** | "Rancang arsitektur", "diagram Mermaid", "pilih tech stack", "monolith vs microservice" | [`pero-system-architecture`](../pero-system-architecture/SKILL.md) |
| **Tata Kelola** | "Standar kualitas", "aturan thread-safety", "review gate", "concurrency rules" | [`pero-quality-governance`](../pero-quality-governance/SKILL.md) |
| **Pecah Backlog** | "Pecah tugas", "breakdown backlog", "estimasi fase", "task decomposition" | [`pero-task-decomposition`](../pero-task-decomposition/SKILL.md) |
| **Detail Kartu Tugas** | "Detailkan task", "file paths", "method signatures", "failing test spec" | [`pero-granular-refinement`](../pero-granular-refinement/SKILL.md) |
| **Audit Dokumen** | "Validasi dokumen", "cek konsistensi spec", "audit diagram Mermaid" | [`pero-context-validation`](../pero-context-validation/SKILL.md) |
| **Riset Docs Resmi** | "Dokumentasi resmi", "API library", "Context7", "package specs" | [`context-7`](../context-7/SKILL.md) |
| **Riset Web/Error** | "Cari solusi web", "error di internet", "changelog release", "search" | [`web-search`](../web-search/SKILL.md) |
| **Stress-Test Ide** | "Grill me", "uji ide ini", "trade-off arsitektur", "bedah keputusan" | [`grilling`](../grilling/SKILL.md) |
| **Musyawarah Dewan** | "Council this", "run the council", "dewan AI", "war room", "multi-perspektif", "debatkan opsi", "trade-off besar" | [`llm-council`](../llm-council/SKILL.md) |
| **Eksekusi Otonom** | "Jalankan seluruh task", "subagent driven development", "eksekusi otonom", "hands-free execution", "sdd", "continuous execution" | [`subagent-driven-development`](../subagent-driven-development/SKILL.md) |
| **Delegasi Paralel** | "Dispatch parallel", "agen paralel", "parallel subagents", "kerjakan bersamaan", "tugas independen", "mass debugging" | [`dispatching-parallel-agents`](../dispatching-parallel-agents/SKILL.md) |
| **Koding Fitur/Fix** | "Mulai ngoding", "tulis fungsi", "implementasi fitur", "TDD" | [`test-driven-development`](../test-driven-development/SKILL.md) |
| **Investigasi Bug** | "Ada bug", "tes gagal", "aplikasi crash", "investigasi error" | [`systematic-debugging`](../systematic-debugging/SKILL.md) |
| **Klaim Selesai** | "Sudah selesai", "semua beres", "cek hasil kerja", "siap commit" | [`verification-before-completion`](../verification-before-completion/SKILL.md) |
| **Peninjauan Kode** | "Review kode", "audit PR", "cek kualitas", "pre-merge audit" | [`code-reviewer`](../code-reviewer/SKILL.md) |
| **Kontrak API** | "Desain API", "endpoint REST/GraphQL/gRPC", "API envelope" | [`api-contract-design`](../api-contract-design/SKILL.md) |
| **Validasi Skema** | "Validasi JSON schema", "DTO", "model serialisasi", "payload validator" | [`schema-validator`](../schema-validator/SKILL.md) |
| **Catat Keputusan** | "Catat ADR", "arsip keputusan", "PDR", "PFDR", "SDR", "GDR", "TDR", "RDR", "VDR", "decision log", "catat keputusan" | [`decision-recorder`](../decision-recorder/SKILL.md) |
| **Sinkronisasi Dok** | "Update diagram", "sync arsitektur", "perbarui docs saat kode berubah", "cegah documentation drift", "sync living docs" | [`living-doc-sync`](../living-doc-sync/SKILL.md) |
| **Operasi Git** | "Buat branch", "commit Caveman", "buat PR", "git worktree", "gh CLI" | [`git-ops`](../git-ops/SKILL.md) |
| **Keamanan & Env** | ".env file", "kunci rahasia", "perintah terminal destruktif", "credentials" | [`env-guard`](../env-guard/SKILL.md) |
| **Bahasa Awam** | "Jelaskan dengan sederhana", "analogi awam", "ELI5", "bahasa manusia" | [`eli5`](../eli5/SKILL.md) |
| **Pembersih Slop** | "Hapus kode sampah", "anti-slop", "YAGNI", "bersihkan komentar sepele" | [`anti-slop`](../anti-slop/SKILL.md) |
| **Estetika UI Visual** | "Desain landing page", "taste-skill", "frontend estetis", "portofolio styling", "anti-slop UI", "motion UI" | [`taste-skill`](../taste-skill/SKILL.md) |
| **Pencarian Skill** | "Skill apa yang cocok?", "cari instruksi", "panduan kerja" | [`find-skill`](../find-skill/SKILL.md) |

---

## Hirarki Prioritas & Resolusi Konflik Skill (*Conflict Resolution*)

Ketika sebuah tugas menyentuh beberapa domain sekaligus, ikuti hierarki aktivasi berurutan berikut:

```
┌─────────────────────────────────────────────────────────────┐
│                 HIERARKI RESOLUSI MULTI-SKILL               │
├─────────────────────────────────────────────────────────────┤
│ 1. Security & Safety (env-guard)                            │
│ 2. Tooling & Research (find-skill, context-7, web-search)   │
│ 3. SDLC Planning Phase (problem-framing s/d refinement)     │
│ 4. Governance & Contracts (api-contract, schema-validator)  │
│ 5. Execution Loop (git-ops -> tdd -> anti-slop -> debug)    │
│ 6. Gatekeeper & Delivery (verification-before-comp -> rev)  │
└─────────────────────────────────────────────────────────────┘
```

---

## Protokol Fallback (Saat Tidak Ada Skill yang 100% Cocok)

Jika sebuah permintaan tidak memiliki padanan langsung dalam matriks:
1. **Analisis Tahap Rekayasa**: Apakah tugas tergolong *Perencanaan (SDLC)*, *Implementasi (Koding)*, atau *Verifikasi (Audit)*?
2. **Pilih Induk Terdekat**: Gunakan `test-driven-development` untuk koding umum, `systematic-debugging` untuk investigasi masalah umum, atau `pero-problem-framing` untuk permintaan ide baru.
3. **Patuhi 4 Pilar Tata Kelola Inti di AGENTS.md**: Selalu terapkan *Skill-First*, *Anti-Sycophancy*, *ELI5*, dan *Anti-Slop*.

---

## Dynamic Tech-Stack Fingerprinting & JIT Skill/MCP Auto-Provisioning

Selain mencocokkan kata kunci tugas, `find-skill` bertindak sebagai **Mesin Penyedia Otomatis (*Just-In-Time Provisioning Engine*)** yang memindai berkas manifest repositori untuk mendeteksi kebutuhan perkakas dan server MCP (*Model Context Protocol*) spesifik domain:

1. **Pemindaian Manifest Otomatis**:
   - `Package.swift` / `*.xcodeproj` / `*.xcworkspace` ➡️ Menyiapkan toolchain **Apple/Swift** & server MCP `xcodebuild-mcp`.
   - `pyproject.toml` / `requirements.txt` / `Pipfile` ➡️ Menyiapkan toolchain **Python** (linter, pytest, database MCP).
   - `Cargo.toml` ➡️ Menyiapkan toolchain **Rust** (cargo & analyzer MCP).
   - `go.mod` ➡️ Menyiapkan toolchain **Go** (gopls toolchain MCP).
   - `package.json` ➡️ Menyiapkan toolchain **Node.js/Web** (Chrome DevTools & modern web guidelines).

2. **Prinsip Nol Penghapusan (*Zero Deletion of Universal Skills*)**:
   - Seluruh 28 skill universal Pero tetap utuh dan aktif sebagai pondasi utama repositori.
   - Skill dan konfigurasi MCP spesifik stack ditambahkan sebagai ekstensi pelengkap (*dynamic overlay*) tanpa menimpa konfigurasi universal yang sudah ada.

3. **Penyelarasan Runtime MCP (.mcp_config.json)**:
   - Jika proyek membutuhkan interaksi langsung dengan compiler/simulator native (seperti Xcode atau Chrome), `find-skill` menyelaraskan konfigurasi MCP ke `.mcp_config.json` lokal atau file konfigurasi agen terkait agar tools langsung tersedia di sesi kerja.

---

## Tabel Anti-Pola Penemuan Skill (*Find-Skill Anti-Patterns*)

| Pola Terlarang | Mengapa Dilarang Keras? | Solusi Wajib |
|---|---|---|
| **Blind Assumption Execution** | Langsung membuat kode tanpa pernah mengecek apakah ada skill lokal yang mengatur domain tersebut. | Wajib panggil `find-skill` dan baca `SKILL.md` sebelum menulis satu baris kode pun. |
| **Surface-Level Scanning** | Hanya membaca judul skill tanpa membaca detail aturan dan checklist di dalam `SKILL.md`. | Baca seluruh berkas `SKILL.md` yang relevan sebelum mengeksekusi tugas. |
| **Skipping Upstream SDLC** | Langsung melompat ke koding saat pengguna memberikan ide baru yang belum memiliki PRD atau arsitektur. | Arahkan kembali ke alur SDLC Pero hulu (`problem-framing` -> `prd-writing`). |
| **Ignoring Project Manifest** | Menggunakan tool generic tanpa memeriksa apakah proyek memiliki manifest spesifik (Swift, Rust, Python, Go) yang membutuhkan MCP khusus. | Jalankan deteksi manifest via `find-skill` untuk mengaktifkan MCP yang sesuai. |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum memulai eksekusi tugas baru dari pengguna:
- [ ] Memeriksa folder `.agents/skills/` untuk menemukan skill yang cocok dengan kata kunci tugas.
- [ ] Membaca berkas `SKILL.md` yang sesuai secara lengkap.
- [ ] Menyelesaikan urutan hierarki multi-skill jika tugas menyentuh beberapa domain.
- [ ] Mematuhi batasan dan aturan khusus yang tertulis di dalam `SKILL.md` terpilih.


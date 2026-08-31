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
> - **Dengan Find-Skill (Pemandu Tepat Sasaran)**: Resepsionis mendengarkan gejala pasien, memeriksa direktori seluruh 26 dokter spesialis yang bertugas (*katalog skill*), mencocokkan jadwal keahlian (*trigger condition*), lalu langsung mengantarkan pasien ke ruang bedah ortopedi yang tepat.

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

## Matriks Pemetaan Pemicu 26 Skill (*Trigger-to-Skill Dispatch Matrix*)

Gunakan tabel pemetaan di bawah ini untuk menentukan skill yang wajib dibuka dan dipatuhi:

| Kategori Tugas | Kata Kunci Masukan Pengguna (*Triggers*) | Modul Skill yang Wajib Diaktifkan |
|---|---|---|
| **Eksplorasi Ide** | "Saya punya ide", "fitur baru", "pain points", "masalah pengguna" | [pero-problem-framing](file:///Users/okyfaishal/project/pero-agent-skills/skills/pero-problem-framing/SKILL.md) |
| **Penyusunan Spek** | "Tulis PRD", "MVP scope", "prioritas fitur P0/P1/P2", "NFR" | [pero-prd-writing](file:///Users/okyfaishal/project/pero-agent-skills/skills/pero-prd-writing/SKILL.md) |
| **Skenario Uji** | "User story", "Gherkin", "Given When Then", "model entity" | [pero-user-stories](file:///Users/okyfaishal/project/pero-agent-skills/skills/pero-user-stories/SKILL.md) |
| **Desain Sistem** | "Rancang arsitektur", "diagram Mermaid", "pilih tech stack", "monolith vs microservice" | [pero-system-architecture](file:///Users/okyfaishal/project/pero-agent-skills/skills/pero-system-architecture/SKILL.md) |
| **Tata Kelola** | "Standar kualitas", "aturan thread-safety", "review gate", "concurrency rules" | [pero-quality-governance](file:///Users/okyfaishal/project/pero-agent-skills/skills/pero-quality-governance/SKILL.md) |
| **Pecah Backlog** | "Pecah tugas", "breakdown backlog", "estimasi fase", "task decomposition" | [pero-task-decomposition](file:///Users/okyfaishal/project/pero-agent-skills/skills/pero-task-decomposition/SKILL.md) |
| **Detail Kartu Tugas** | "Detailkan task", "file paths", "method signatures", "failing test spec" | [pero-granular-refinement](file:///Users/okyfaishal/project/pero-agent-skills/skills/pero-granular-refinement/SKILL.md) |
| **Audit Dokumen** | "Validasi dokumen", "cek konsistensi spec", "audit diagram Mermaid" | [pero-context-validation](file:///Users/okyfaishal/project/pero-agent-skills/skills/pero-context-validation/SKILL.md) |
| **Riset Docs Resmi** | "Dokumentasi resmi", "API library", "Context7", "package specs" | [context-7](file:///Users/okyfaishal/project/pero-agent-skills/skills/context-7/SKILL.md) |
| **Riset Web/Error** | "Cari solusi web", "error di internet", "changelog release", "search" | [web-search](file:///Users/okyfaishal/project/pero-agent-skills/skills/web-search/SKILL.md) |
| **Stress-Test Ide** | "Grill me", "uji ide ini", "trade-off arsitektur", "bedah keputusan" | [grilling](file:///Users/okyfaishal/project/pero-agent-skills/skills/grilling/SKILL.md) |
| **Musyawarah Dewan** | "Council this", "run the council", "dewan AI", "war room", "multi-perspektif", "debatkan opsi", "trade-off besar" | [llm-council](file:///Users/okyfaishal/project/pero-agent-skills/skills/llm-council/SKILL.md) |
| **Delegasi Paralel** | "Dispatch parallel", "agen paralel", "parallel subagents", "kerjakan bersamaan", "tugas independen", "mass debugging" | [dispatching-parallel-agents](file:///Users/okyfaishal/project/pero-agent-skills/skills/dispatching-parallel-agents/SKILL.md) |
| **Koding Fitur/Fix** | "Mulai ngoding", "tulis fungsi", "implementasi fitur", "TDD" | [test-driven-development](file:///Users/okyfaishal/project/pero-agent-skills/skills/test-driven-development/SKILL.md) |
| **Investigasi Bug** | "Ada bug", "tes gagal", "aplikasi crash", "investigasi error" | [systematic-debugging](file:///Users/okyfaishal/project/pero-agent-skills/skills/systematic-debugging/SKILL.md) |
| **Klaim Selesai** | "Sudah selesai", "semua beres", "cek hasil kerja", "siap commit" | [verification-before-completion](file:///Users/okyfaishal/project/pero-agent-skills/skills/verification-before-completion/SKILL.md) |
| **Peninjauan Kode** | "Review kode", "audit PR", "cek kualitas", "pre-merge audit" | [code-reviewer](file:///Users/okyfaishal/project/pero-agent-skills/skills/code-reviewer/SKILL.md) |
| **Kontrak API** | "Desain API", "endpoint REST/GraphQL/gRPC", "API envelope" | [api-contract-design](file:///Users/okyfaishal/project/pero-agent-skills/skills/api-contract-design/SKILL.md) |
| **Validasi Skema** | "Validasi JSON schema", "DTO", "model serialisasi", "payload validator" | [schema-validator](file:///Users/okyfaishal/project/pero-agent-skills/skills/schema-validator/SKILL.md) |
| **Catat Keputusan** | "Catat ADR", "arsip keputusan", "PDR", "decision log" | [decision-recorder](file:///Users/okyfaishal/project/pero-agent-skills/skills/decision-recorder/SKILL.md) |
| **Sinkronisasi Dok** | "Update diagram", "sync arsitektur", "perbarui docs saat kode berubah" | [living-doc-sync](file:///Users/okyfaishal/project/pero-agent-skills/skills/living-doc-sync/SKILL.md) |
| **Operasi Git** | "Buat branch", "commit Caveman", "buat PR", "git worktree", "gh CLI" | [git-ops](file:///Users/okyfaishal/project/pero-agent-skills/skills/git-ops/SKILL.md) |
| **Keamanan & Env** | ".env file", "kunci rahasia", "perintah terminal destruktif", "credentials" | [env-guard](file:///Users/okyfaishal/project/pero-agent-skills/skills/env-guard/SKILL.md) |
| **Bahasa Awam** | "Jelaskan dengan sederhana", "analogi awam", "ELI5", "bahasa manusia" | [eli5](file:///Users/okyfaishal/project/pero-agent-skills/skills/eli5/SKILL.md) |
| **Pembersih Slop** | "Hapus kode sampah", "anti-slop", "YAGNI", "bersihkan komentar sepele" | [anti-slop](file:///Users/okyfaishal/project/pero-agent-skills/skills/anti-slop/SKILL.md) |
| **Pencarian Skill** | "Skill apa yang cocok?", "cari instruksi", "panduan kerja" | [find-skill](file:///Users/okyfaishal/project/pero-agent-skills/skills/find-skill/SKILL.md) |

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

## Tabel Anti-Pola Penemuan Skill (*Find-Skill Anti-Patterns*)

| Pola Terlarang | Mengapa Dilarang Keras? | Solusi Wajib |
|---|---|---|
| **Blind Assumption Execution** | Langsung membuat kode tanpa pernah mengecek apakah ada skill lokal yang mengatur domain tersebut. | Wajib panggil `find-skill` dan baca `SKILL.md` sebelum menulis satu baris kode pun. |
| **Surface-Level Scanning** | Hanya membaca judul skill tanpa membaca detail aturan dan checklist di dalam `SKILL.md`. | Baca seluruh berkas `SKILL.md` yang relevan sebelum mengeksekusi tugas. |
| **Skipping Upstream SDLC** | Langsung melompat ke koding saat pengguna memberikan ide baru yang belum memiliki PRD atau arsitektur. | Arahkan kembali ke alur SDLC Pero hulu (`problem-framing` -> `prd-writing`). |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum memulai eksekusi tugas baru dari pengguna:
- [ ] Memeriksa folder `.agents/skills/` untuk menemukan skill yang cocok dengan kata kunci tugas.
- [ ] Membaca berkas `SKILL.md` yang sesuai secara lengkap.
- [ ] Menyelesaikan urutan hierarki multi-skill jika tugas menyentuh beberapa domain.
- [ ] Mematuhi batasan dan aturan khusus yang tertulis di dalam `SKILL.md` terpilih.


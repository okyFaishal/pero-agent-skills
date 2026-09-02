---
name: subagent-driven-development
description: Use when executing implementation plans or task backlogs autonomously with fresh subagents per task, task-level review gates, and continuous execution.
---

# Subagent-Driven Development (`subagent-driven-development`)

## Overview
**Origin**: *obra/superpowers Subagent-Driven Development (SDD) Pattern + Autonomous Multi-Agent Orchestration*.  
Skill ini adalah **"Mesin Konveyor Eksekusi Otonom & Orkestrator Sub-Agen Terisolasi"**. Bertanggung jawab mengeksekusi seluruh daftar rencana tugas dari `docs/TaskBacklog.md` atau dokumen rencana implementasi secara berkesinambungan (*continuous autonomous execution*) tanpa interupsi, dengan meluncurkan sub-agen baru per tugas (*fresh context subagent*), mengawal siklus TDD, dan melakukan audit mutu sebelum tugas berikutnya dimulai.

> **Analogi Sederhana (ELI5):**  
> Bayangkan sebuah **Pabrik Mobil Otomatis Modern**:
> - **Koding Manual AI Biasa (Pekerja Kelelahan & Lupa)**: Satu pekerja disuruh merakit 10 mobil sendirian dari pagi sampai malam di satu ruangan yang sama. Pada mobil ke-7, pekerja mulai pusing, lupa baut mana yang sudah dipasang, dan melakukan banyak kesalahan fatal karena otaknya kepenuhan (*context bloat*).
> - **Subagent-Driven Development (Ban Konveyor Otomatis)**: Mandor utama (*Controller*) menyalakan ban konveyor.
>   1. Ban konveyor membawa **Rangka Mobil #1** (Tugas 1).
>   2. Mandor memanggil **Teknisi Segar #1** (*Fresh Implementer*) yang masih berenergi penuh untuk merakit dan mengetes mesinnya dengan TDD.
>   3. Setelah selesai, **Pengawas Mutu #1** (*Task Reviewer*) memeriksa apakah mobil sesuai pesanan dan tidak ada baut yang longgar.
>   4. Begitu lolos uji, mandor memberi tanda centang `[x]`, ban konveyor otomatis berjalan ke **Rangka Mobil #2**, memanggil teknisi baru yang segar, dan mengulanginya sampai seluruh mobil selesai dirakit tanpa perlu kita tungguin atau beri perintah berulang kali.

---

## Landasan Teori & Referensi Industri Nyata

Skill ini dibangun di atas 3 pilar rekayasa kecerdasan agen otonom dan arsitektur alur kerja multi-agen:

### 1. Context Window Preservation & Attention Decay Mitigation
Mitigasi penurunan kualitas penalaran model LLM akibat akumulasi riwayat percakapan panjang (*needle-in-a-haystack attention degradation*).
*   **Referensi 1 (Fenomena Lost-in-the-Middle)**: *Nelson F. Liu et al.*, "Lost in the Middle: How Language Models Use Long Contexts" (Transactions of the Association for Computational Linguistics, MIT Press).
*   **Referensi 2 (Arsitektur Model Context Protocol)**: *Anthropic*, "Model Context Protocol (MCP) & Context Isolation Design Patterns" ([modelcontextprotocol.io](https://modelcontextprotocol.io)).
*   **Referensi 3 (Framework Superpowers)**: *Jesse Vincent (obra)*, "Superpowers: Subagent-Driven Development for Autonomous Coding" ([github.com/obra/superpowers](https://github.com/obra/superpowers)).

### 2. Dual-Agent Verification Loop (Actor-Critic & Separation of Concerns)
Pemisahan peran mutlak antara agen pelaksana (*implementer*) dan agen penguji (*reviewer*) untuk mengeliminasi bias konfirmasi (*self-grading bias*).
*   **Referensi 1 (Arsitektur Actor-Critic)**: *Richard S. Sutton & Andrew G. Barto*, "Reinforcement Learning: An Introduction - Policy Gradient & Actor-Critic Methods" (MIT Press).
*   **Referensi 2 (Pola Pengujian Software Klasik)**: *Glenford J. Myers*, "The Art of Software Testing - The Principle of Independent Testing" (John Wiley & Sons).
*   **Referensi 3 (Prinsip Clean Code & Review)**: *Robert C. Martin (Uncle Bob)*, "Clean Code: A Handbook of Agile Software Craftsmanship - Two-Phase Review Gates" (Prentice Hall).

### 3. Continuous Autonomous Execution & Deterministic Stop Conditions
Prinsip bahwa sistem otonom harus mengeksekusi alur secara berkesinambungan tanpa menanyakan izin sepele, dan hanya berhenti pada kondisi pembatas yang deterministik (*deterministic halting*).
*   **Referensi 1 (Teori Automata & Mesin Turing)**: *Michael Sipser*, "Introduction to the Theory of Computation - Decidability and Halting Conditions" (Cengage Learning).
*   **Referensi 2 (Standar Industri DevOps)**: *Gene Kim, Jez Humble, Patrick Debois*, "The DevOps Handbook: How to Create World-Class Agility, Reliability, and Security in Technology Organizations" (IT Revolution Press).

---

## Pohon Keputusan: Kapan Menggunakan SDD

```mermaid
flowchart TD
    START["Menerima Daftar Tugas / Task Backlog"] --> Q1{Apakah ada rencana tugas bertahap?}
    
    Q1 -->|TIDAK| PLAN["Susun PRD -> Architecture -> TaskBacklog dulu"]
    Q1 -->|YA| Q2{Apakah ingin dieksekusi otonom?}
    
    Q2 -->|YA - Eksekusi Hands-Free| SDD["🚀 AKTIFKAN SUBAGENT-DRIVEN-DEVELOPMENT\n(Jalankan loop kontinu sub-agen per task)"]
    Q2 -->|TIDAK - Ingin inspeksi tiap 1 task| MANUAL["Eksekusi Manual Task per Task"]
```

---

## 5 Siklus Eksekusi Otonom (*The 5-Step Continuous Execution Cycle*)

```
┌─────────────────────────────────────────────────────────────┐
│          ALUR EKSEKUSI OTONOM SUBAGENT-DRIVEN DEV           │
├─────────────────────────────────────────────────────────────┤
│ 1. Pre-Flight Backlog Scan  : Cek konflik & dependensi      │
│ 2. Dispatch Fresh Implementer: Sub-agen TDD & Anti-Slop     │
│ 3. Dispatch Task Reviewer   : Audit Spec & Kualitas Kode    │
│ 4. Update Progress Ledger   : Centang [x] di TaskBacklog.md │
│ 5. Final Whole-Branch Polish: Full Suite Test & Buat PR     │
└─────────────────────────────────────────────────────────────┘
```

### 1. Pre-Flight Backlog Scan (Pindai Awal Sebelum Mulai)
Sebelum meluncurkan Tugas #1:
- Pindai seluruh isi `docs/TaskBacklog.md` atau `implementation_plan.md`.
- Pastikan urutan fase (Phase 1 ➡️ Phase 2 ➡️ dst.) logis dan tidak ada instruksi yang saling bertentangan.
- Jika ada kontradiksi nyata di awal, ajukan 1 pertanyaan klarifikasi kepada pengguna sebelum mulai. Jika aman, **langsung mulai eksekusi tanpa menunggu persetujuan lanjutan**.

### 2. Dispatch Fresh Implementer (Kirim Pekerja Segar)
- Koordinator mengekstrak kartu tugas ke file ringkasan via skrip:
  ```bash
  ./skills/subagent-driven-development/scripts/task-brief docs/TaskBacklog.md "1.1"
  ```
- Koordinator meluncurkan Implementer Subagent menggunakan templat [`implementer-prompt.md`](./implementer-prompt.md).
- Sub-agen menjalankan siklus TDD terisolasi ([`test-driven-development`](../test-driven-development/SKILL.md)), membersihkan kode ([`anti-slop`](../anti-slop/SKILL.md)), dan membuat commit Caveman ([`git-ops`](../git-ops/SKILL.md)).
- Implementer menulis laporannya ke berkas `.pero/sdd/task-1.1-report.md`.

### 3. Dispatch Task Reviewer & Re-Review Loop (Audit Kualitas Dua Lapis)
- Koordinator membungkus paket diff perubahan tugas via skrip:
  ```bash
  ./skills/subagent-driven-development/scripts/review-package [BASE_SHA] [HEAD_SHA]
  ```
- Koordinator meluncurkan Task Reviewer Subagent menggunakan templat [`task-reviewer-prompt.md`](./task-reviewer-prompt.md).
- Peninjau memeriksa perbedaan kode (*git diff*):
  1. **Spec Compliance**: Apakah semua kriteria kartu tugas terpenuhi? Apakah ada fitur berlebih di luar spek?
  2. **Code Quality**: Apakah ada celah error, penanganan boundary case yang bocor, atau pelanggaran anti-slop?
- Jika ada temuan kritis (*Critical/Important*), panggil *Fix Subagent*, lalu luncurkan Re-Reviewer Subagent menggunakan templat [`re-review-prompt.md`](./re-review-prompt.md) sampai peninjau memberikan status *Approved*.

### 4. Update Progress Ledger (Catat Kemajuan)
- Perbarui centang di `docs/TaskBacklog.md` dari `- [ ]` menjadi `- [x]`.
- Tanpa berhenti atau menanyakan *"Bolehkah saya lanjut?"*, koordinator otomatis mengambil kartu tugas berikutnya dan kembali ke Langkah 2.

### 5. Final Whole-Branch Polish & PR (Penyelesaian Akhir)
Setelah seluruh tugas selesai 100%:
- Jalankan seluruh suite tes proyek di terminal untuk membuktikan nol regresi (*exit code 0* via [`verification-before-completion`](../verification-before-completion/SKILL.md)).
- Jalankan audit review menyeluruh tingkat cabang ([`code-reviewer`](../code-reviewer/SKILL.md)).
- Sinkronkan diagram dokumentasi ([`living-doc-sync`](../living-doc-sync/SKILL.md)).
- Buat Pull Request resmi menggunakan [`git-ops`](../git-ops/SKILL.md).

---

## Struktur Berkas Modular Skill (`subagent-driven-development`)

```
skills/subagent-driven-development/
├── SKILL.md                   # Panduan orkestrasi alur kerja agen utama (file ini)
├── implementer-prompt.md      # Templat prompt mandiri untuk Implementer Subagent
├── task-reviewer-prompt.md    # Templat prompt mandiri untuk Task Reviewer Subagent
├── re-review-prompt.md        # Templat prompt mandiri untuk Re-Reviewer Subagent
└── scripts/
    ├── sdd-workspace          # Menyiapkan direktori kerja sementara .pero/sdd
    ├── task-brief             # Mengekstrak kartu tugas spesifik dari backlog ke berkas terpisah
    └── review-package         # Menghasilkan berkas git diff BASE..HEAD untuk direview
```

---

## Integrasi dengan Skill Lain di Repositori

*   **[`pero-task-decomposition`](../pero-task-decomposition/SKILL.md)**: Menyediakan urutan backlog tugas 5-fase yang siap dieksekusi oleh SDD.
*   **[`pero-granular-refinement`](../pero-granular-refinement/SKILL.md)**: Menyediakan kartu tugas presisi (path file, signatures, boundary cases) yang langsung menjadi prompt bagi Implementer.
*   **[`test-driven-development`](../test-driven-development/SKILL.md)**: Standar koding mutlak yang wajib dipatuhi oleh Implementer Subagent.
*   **[`anti-slop`](../anti-slop/SKILL.md)**: Filter kualitas agar sub-agen tidak menghasilkan kode atau komentar sampah.
*   **[`dispatching-parallel-agents`](../dispatching-parallel-agents/SKILL.md)**: Dipanggil oleh SDD ketika menemukan tugas-tugas di dalam fase yang sama yang sepenuhnya independen dan dapat dijalankan serentak.
*   **[`verification-before-completion`](../verification-before-completion/SKILL.md)**: Penegak bukti eksekusi terminal sebelum cabang dianggap tuntas.
*   **[`code-reviewer`](../code-reviewer/SKILL.md)**: Digunakan untuk Task Reviewer dan Final Merge Reviewer.

---

## Anti-Patterns & Hal yang Dilarang

*   ❌ **Interupsi Basa-Basi (*Premature Asking*)**: Berhenti di setiap akhir tugas untuk bertanya *"Apakah saya boleh melanjutkan ke task 2?"*. (Jika tidak ada eror yang memblokir, **lanjutkan otomatis!**).
*   ❌ **Pikiran Menumpuk (*Context Leakage*)**: Mengerjakan semua 10 tugas dalam satu sub-agen panjang tanpa memanggil sub-agen baru.
*   ❌ **Penilai Diri Sendiri (*Self-Grading*)**: Menganggap tugas selesai tanpa melalui verifikasi sub-agen peninjau (*task reviewer*).
*   ❌ **Menembus Larangan TDD**: Menulis kode implementasi sebelum membuat failing test.


---
name: dispatching-parallel-agents
description: Use when facing 2+ independent tasks, distinct failing test files, or isolated modules that can be worked on concurrently without shared state or sequential dependencies.
---

# Universal Parallel Agent Dispatching Protocol (`dispatching-parallel-agents`)

## Overview
**Origin**: *obra/superpowers Multi-Agent Parallel Dispatch Pattern + Actor Model Distributed Task Coordination*.  
Skill ini adalah **"Protokol Orkestrasi & Pendelegasian Sub-Agen Paralel"**. Bertindak sebagai panduan bagi agen koordinator untuk memecah dan mendelegasikan 2 atau lebih tugas yang sepenuhnya independen ke beberapa sub-agen secara serentak (*parallel execution*) dalam satu putaran alat, menghemat waktu eksekusi secara drastis serta menjaga memori (*context window*) agen utama tetap bersih.

> **Analogi Sederhana (ELI5):**  
> Bayangkan seorang **Mandor Utama Proyek Bangunan**:
> - **Pekerjaan Sekuensial (Lambat)**: Ada 3 lampu putus di Lantai 1, Lantai 2, dan Lantai 3. Mandor menyuruh satu teknisi mengganti lampu di Lantai 1, menunggu sampai selesai, baru naik ke Lantai 2, lalu ke Lantai 3. Waktunya terbuang 3 kali lebih lama.
> - **Parallel Dispatch (Cepat & Rapi)**: Karena ketiga lampu tidak saling terhubung, mandor langsung memanggil **3 teknisi sekaligus secara bersamaan**:
>   - Teknisi A: *"Ganti bohlam di Lantai 1."*
>   - Teknisi B: *"Ganti bohlam di Lantai 2."*
>   - Teknisi C: *"Ganti bohlam di Lantai 3."*
> 
> Ketiganya bekerja bersamaan di lantai masing-masing tanpa saling senggol. Setelah semuanya melapor selesai, mandor menyalakan saklar utama untuk memastikan seluruh gedung menyala terang (*integrasi akhir*).

---

## Landasan Teori & Referensi Industri Nyata

Skill ini dibangun di atas 3 pilar rekayasa sistem terdistribusi dan koordinasi multi-agen:

### 1. Actor Model & Shared-Nothing Isolation
Model komputasi terdistribusi di mana setiap unit kerja (*actor/sub-agent*) memiliki memori mandiri dan berkomunikasi murni melalui pertukaran pesan tanpa status bersama (*no shared state*).
*   **Referensi 1 (Fondasi Aktor)**: *Carl Hewitt, Peter Bishop, & Richard Steiger*, "A Universal Modular ACTOR Formalism for Artificial Intelligence" (IJCAI).
*   **Referensi 2 (Arsitektur Aktor Modern)**: *Gul Agha*, "Actors: A Model of Concurrent Computation in Distributed Systems" (MIT Press).
*   **Referensi 3 (Erlang/OTP Design Principles)**: *Joe Armstrong*, "Programming Erlang: Software for a Concurrent World" (Pragmatic Bookshelf).

### 2. Fork-Join & Embarrassingly Parallel Task Decomposition
Pola pemrosesan konkurensi di mana pekerjaan yang tidak memiliki ketergantungan dipecah (*fork*), dieksekusi bersamaan, lalu hasilnya digabungkan kembali (*join*).
*   **Referensi 1 (Pola Fork-Join)**: *Doug Lea*, "A Java Fork/Join Framework" (ACM Conference on Java Grande).
*   **Referensi 2 (Map-Reduce Distributed Execution)**: *Jeffrey Dean & Sanjay Ghemawat*, "MapReduce: Simplified Data Processing on Large Clusters" (Google, OSDI).

### 3. Context Window Preservation & Cognitive Load Optimization
Optimasi efisiensi agen AI dengan membatasi ruang lingkup informasi yang diterima tiap pekerja agar tidak terjadi halusinasi akibat kelebihan beban konteks.
*   **Referensi 1 (Model Context Protocol)**: *Anthropic*, "Model Context Protocol (MCP) & Subagent Orchestration Patterns".
*   **Referensi 2 (Superpowers Framework)**: *Jesse Vincent (obra)*, "Superpowers: Parallel Agent Dispatching for Coding Assistants".

---

## Kapan Menggunakan Paralel vs Sekuensial (*Decision Flowchart*)

```mermaid
flowchart TD
    START["Mendeteksi 2+ Butir Tugas / Kegagalan Tes"] --> Q1{Apakah tugas independen 100%?}
    
    Q1 -->|TIDAK - Saling bergantung| SEQ1["Eksekusi Sekuensial (Satu per Satu)"]
    Q1 -->|YA| Q2{Apakah menyentuh file yang sama?}
    
    Q2 -->|YA - Berisiko konflik teks| SEQ2["Eksekusi Berurutan (Cegah Race Condition)"]
    Q2 -->|TIDAK - File terpisah| Q3{Dapat dikerjakan bersamaan?}
    
    Q3 -->|YA| PARALLEL["🚀 DISPATCH SUB-AGEN PARALEL\n(Luncurkan serentak dalam 1 turn)"]
    Q3 -->|TIDAK| SEQ1
```

### ✅ Kondisi yang WAJIB Dijalankan Secara Paralel:
1. **Kegagalan Banyak Berkas Tes (*Mass Debugging*)**: 2 atau lebih berkas pengujian (`*.test.ts`, `test_*.py`) gagal di subsistem berbeda dengan akar masalah terisolasi.
2. **Eksekusi Kartu Tugas Lintas Domain**: Pengerjaan kartu tugas dari `docs/TaskBacklog.md` pada fase yang sama yang menyentuh direktori terpisah (misal: modul utilitas Core vs komponen UI Web vs handler API Backend).
3. **Riset & Benchmark Pustaka**: Membandingkan 2 atau lebih alternatif library/framework secara bersamaan sebelum merancang arsitektur.

### ❌ DILARANG Menggunakan Paralel Untuk:
1. **Mengedit Berkas yang Sama**: Dua sub-agen dilarang memodifikasi file target yang sama (akan memicu penimpaan kode / *merge conflict*).
2. **Ketergantungan Alur Berurutan (*Sequential Dependencies*)**: Tugas B membutuhkan hasil atau kode keluaran dari Tugas A.
3. **Kegagalan Berantai (*Cascade Failures*)**: Banyak tes gagal akibat satu kesalahan konfigurasi dasar (cukup perbaiki akar utamanya sekali).

---

## 4 Langkah Siklus Kerja Paralel (*The 4-Step Parallel Pattern*)

```
┌─────────────────────────────────────────────────────────────┐
│             SIKLUS EKSEKUSI MULTI-AGEN PARALEL              │
├─────────────────────────────────────────────────────────────┤
│ 1. Identify Independent Domains  : Petakan batas isolasi    │
│ 2. Create Focused Agent Prompts : Rancang instruksi mandiri │
│ 3. Dispatch in Parallel          : Panggil subagent serentak│
│ 4. Review, Integrate & Verify    : Validasi suite tes penuh │
└─────────────────────────────────────────────────────────────┘
```

### 1. Identifikasi Domain Independen (*Identify Independent Domains*)
Petakan berkas yang akan disentuh oleh masing-masing tugas:
* Sub-tugas A: Hanya memodifikasi `src/utils/date.ts` dan `tests/utils/date.test.ts`.
* Sub-tugas B: Hanya memodifikasi `src/schemas/user.ts` dan `tests/schemas/user.test.ts`.
* Pastikan tidak ada berkas iris/bersama yang diedit secara bersamaan.

### 2. Buat Prompt Sub-Agen yang Mandiri & Terfokus (*Focused Agent Tasks*)
Setiap sub-agen harus menerima instruksi yang mandiri tanpa perlu membaca seluruh riwayat obrolan panjang agen utama:
* **Ruang Lingkup Spesifik**: Satu target berkas atau subsistem.
* **Tujuan Jelas**: Buat tes spesifik lulus 100% (*Green*).
* **Batasan Ketat**: Dilarang mengubah berkas di luar ruang lingkup yang ditentukan.
* **Ekspektasi Output**: Ringkasan singkat berkas apa yang diubah dan bukti kelulusan tes.

### 3. Luncurkan Bersamaan dalam Satu Putaran (*Dispatch in Parallel*)
Luncurkan seluruh sub-agen secara serentak dalam satu putaran pemanggilan alat:

```text
invoke_subagent(
  Subagents: [
    { TypeName: "self", Role: "Date Util Engineer", Prompt: "Implementasikan format fungsi tanggal di src/utils/date.ts..." },
    { TypeName: "self", Role: "Schema Engineer", Prompt: "Implementasikan validasi skema user di src/schemas/user.ts..." }
  ]
)
```

### 4. Tinjau Hasil & Integrasikan (*Review, Integrate & Verify*)
Setelah seluruh sub-agen menyelesaikan tugasnya dan melaporkan hasilnya:
1. Baca ringkasan perubahan dari masing-masing sub-agen.
2. Pastikan tidak ada modifikasi berkas yang saling bertabrakan.
3. Jalankan pengujian penuh di terminal ([`verification-before-completion`](file:///Users/okyfaishal/project/pero-agent-skills/skills/verification-before-completion/SKILL.md)) untuk membuktikan bahwa seluruh sistem bekerja harmonis (Exit code 0).

---

## Contoh Struktur Prompt Sub-Agen yang Baik

```markdown
Perbaiki 2 tes yang gagal di tests/auth/token_verifier.test.ts:

1. "should reject expired token" - mengharapkan error TokenExpiredError tapi menerima null.
2. "should handle malformed signature" - mengharapkan status 401.

Batasan:
- Hanya modifikasi src/auth/token_verifier.ts dan tests/auth/token_verifier.test.ts.
- Jangan mengubah file konfigurasi atau modul auth lainnya.
- Terapkan TDD: jalankan tes, perbaiki hingga lulus, dan pastikan anti-slop.

Kembalikan:
- Ringkasan akar masalah singkat.
- Baris kode yang diperbaiki.
- Konfirmasi bahwa tes tests/auth/token_verifier.test.ts lulus 100%.
```

---

## Integrasi dengan Skill Lain di Repositori

*   **[`subagent-driven-development`](file:///Users/okyfaishal/project/pero-agent-skills/skills/subagent-driven-development/SKILL.md)**: Mesin konveyor eksekusi sekuensial yang dapat memanggil `dispatching-parallel-agents` saat mendeteksi tugas-tugas independen dalam satu fase.
*   **[`pero-task-decomposition`](file:///Users/okyfaishal/project/pero-agent-skills/skills/pero-task-decomposition/SKILL.md)**: Mengelompokkan backlog tugas ke dalam kelompok-kelompok fase independen yang siap dieksekusi secara paralel.
*   **[`pero-granular-refinement`](file:///Users/okyfaishal/project/pero-agent-skills/skills/pero-granular-refinement/SKILL.md)**: Menyusun kartu tugas dengan batasan file path presisi sehingga langsung siap menjadi prompt sub-agen terisolasi.
*   **[`systematic-debugging`](file:///Users/okyfaishal/project/pero-agent-skills/skills/systematic-debugging/SKILL.md)**: Menerjunkan sub-agen terpisah untuk mengisolasi dan memperbaiki kegagalan tes di berbagai subsistem secara serentak (*Mass Debugging*).
*   **[`pero-system-architecture`](file:///Users/okyfaishal/project/pero-agent-skills/skills/pero-system-architecture/SKILL.md)**: Melakukan riset komparasi pustaka atau pembuatan prototipe komponen arsitektur secara paralel.

---

## Anti-Patterns & Hal yang Dilarang

*   ❌ **Pekerja Saling Bertabrakan (*File Collision*)**: Mengirim 2 sub-agen untuk mengedit berkas yang sama pada saat bersamaan.
*   ❌ **Instruksi Mengambang**: Memberikan instruksi umum seperti *"Tolong bantu perbaiki bug di proyek"* tanpa menyebutkan berkas spesifik.
*   ❌ **Lupa Verifikasi Integrasi Akhir**: Menganggap pekerjaan selesai begitu sub-agen melapor tanpa menjalankan verifikasi menyeluruh (*full suite test*) di agen utama.


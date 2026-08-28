---
name: grilling
description: Grill the user relentlessly about a plan, decision, or idea. Use when requirements are ambiguous, architectural trade-offs exist, before finalizing specifications, or when stress-testing ideas.
---

# Universal Grilling & Stress-Testing Protocol (`grilling`)

## Overview
**Origin**: *Matt Pocock's Grilling Pattern + SEI Carnegie Mellon ATAM (Architecture Tradeoff Analysis Method) + Socratic Active Inquiry*.  
Skill ini adalah **"Protokol Wawancara Mendalam & Penguji Ketahanan Ide/Arsitektur"**. Menyelaraskan pemahaman antara pengguna dan AI hingga 100%, membedah kompromi teknis (*trade-offs*), dan mengeksekusi pohon keputusan (*Design Tree*) secara bertahap tanpa menyisakan asumsi liar.

> **Analogi Sederhana (ELI5):**  
> Bayangkan seorang **Arsitek Senior & Penguji Ketahanan Gempa**:
> - **AI Tanpa Grilling (Asal Mengangguk)**: Pemilik rumah berkata, *"Saya ingin kolam renang di lantai 5!"*. AI langsung menyetujui dan menggambar tanpa bertanya apakah pondasi beton mampu menahan beban ribuan liter air.
> - **Dengan Grilling (Audit Ketahanan Disiplin)**: Arsitek mengajukan pertanyaan berantai terstruktur: *"Jika kolam di lantai 5, kita punya 2 pilihan: A) Mempertebal tiang baja utama (lebih mahal tapi aman), atau B) Menggeser kolam ke taman belakang (biaya hemat). Rekomendasi saya adalah opsi B karena sesuai anggaran awal."*

---

## Landasan Teori & Referensi Industri Nyata

Skill ini dibangun di atas 3 pilar rekayasa keputusan arsitektur tingkat lanjut:

### 1. Decision Frontier Exploration & Active Socratic Inquiry
Eksplorasi cabang keputusan secara bertingkat di mana pertanyaan hanya diajukan pada batas terbuka (*frontier*) yang sudah memenuhi syarat logika sebelumnya.
*   **Referensi 1 (Pola AI Agent)**: *Matt Pocock*, "The Grilling Protocol for AI Agent Alignment & Design Tree Exploration".
*   **Referensi 2 (Metode Kritis)**: *The Foundation for Critical Thinking*, "Paul-Elder Critical Thinking Framework & Socratic Questioning Taxonomy" ([criticalthinking.org](https://www.criticalthinking.org)).
*   **Referensi 3 (Standar Rekayasa Sistem)**: *ISO/IEC/IEEE 15288*, "Systems and Software Engineering - System Life Cycle Processes (Stakeholder Needs & Requirements Definition)".

### 2. Architecture Tradeoff Analysis & Multi-Criteria Evaluation
Metodologi evaluasi formal untuk menimbang atribut kualitas yang saling bertentangan (misal: performa vs kemudahan modifikasi).
*   **Referensi 1 (Standar SEI CMU)**: *Software Engineering Institute (SEI) at Carnegie Mellon University*, "Architecture Tradeoff Analysis Method (ATAM)" (Kazman, Klein, Clements, CMU/SEI-2000-TR-004).
*   **Referensi 2 (Arsitektur Evolusioner)**: *Neal Ford, Mark Richards, Pramod Sadalage, & Zhamak Dehghani*, "Software Architecture: The Hard Parts (Analyzing Evolutionary Architecture Trade-offs)" (O'Reilly Media).
*   **Referensi 3 (Fondasi Arsitektur)**: *Mark Richards & Neal Ford*, "Fundamentals of Software Architecture: An Engineering Approach" (O'Reilly Media).

### 3. Bounded Inquiry & Anti-Analysis Paralysis
Pencegahan kebuntuan diskusi tanpa akhir dengan menetapkan batas henti rasional (*satisficing*) saat konsensus fungsional tercapai.
*   **Referensi 1 (Rasionalitas Terbatas)**: *Herbert A. Simon*, "Administrative Behavior: A Study of Decision-Making Processes in Administrative Organization" (Nobel Memorial Prize - Bounded Rationality & Satisficing Principle).
*   **Referensi 2 (Kerangka Pengambilan Keputusan)**: *Dave Snowden*, "The Cynefin Framework - A Leader's Framework for Decision Making" (Harvard Business Review).
*   **Referensi 3 (Manajemen Risiko Perangkat Lunak)**: *Barry Boehm*, "Software Risk Management: Principles and Practices" (IEEE Software, Vol. 8, No. 1).

---

## Siklus Hidup Manajemen Frontier (*The Design Tree Lifecycle*)

```
┌─────────────────────────────────────────────────────────────┐
│             SIKLUS FRONTIER GRILING BERTAHAP                │
├─────────────────────────────────────────────────────────────┤
│ 1. Map Root Decisions   : Identifikasi keputusan pangkal    │
│ 2. Extract Frontier     : Pilih opsi yang siap ditanyakan   │
│ 3. Dispatch Round       : Ajukan ronde terstruktur (ELI5)   │
│ 4. Prune or Branch      : Perbarui pohon berdasarkan jawaban│
│ 5. Completion Gate      : Frontier kosong -> Kesepahaman    │
└─────────────────────────────────────────────────────────────┘
```

1. **Frontier Definitif**: Himpunan keputusan yang seluruh prasyaratnya sudah terjawab. Jangan menanyakan anak cabang jika induknya belum disepakati.
2. **AI Mencari Fakta, Pengguna Mengambil Keputusan**:
   - Dilarang bertanya hal-hal yang bisa dicek sendiri oleh AI (seperti versi bahasa di `package.json` atau daftar tabel database lokal).
   - AI wajib menyajikan pilihan konkret (A/B/C) beserta analisis untung-rugi (*trade-offs*) dan rekomendasi teknis terbaik.

---

## Format Standar Ronde Pertanyaan

Setiap ronde wajib disusun dengan format yang konsisten dan mudah dipahami:

```markdown
### 🎯 Ronde X: [Fokus Area / Domain Keputusan]

❓ **Q1 - [Judul Keputusan / Fitur]**
- **Konteks & Masalah**: [Jelaskan masalah dengan analogi sederhana dunia nyata (ELI5)]
- **Pilihan Opsi**:
  - **A. [Opsi A]**: [Penjelasan mekanisme] — *Kelebihan*: [...], *Trade-off*: [...]
  - **B. [Opsi B]**: [Penjelasan mekanisme] — *Kelebihan*: [...], *Trade-off*: [...]
- ➡️ **Rekomendasi AI**: Dipilih **Opsi B** karena [berikan alasan teknis terukur dan relevan].

---

❓ **Q2 - [Judul Keputusan Berikutnya]**
- **Konteks & Masalah**: [Penjelasan masalah dan opsi terstruktur]
- ➡️ **Rekomendasi AI**: [Rekomendasi dan alasannya]
```

---

## Cetak Biru Pertanyaan Siap Pakai per Domain (*Domain Blueprints*)

### 1. Domain Backend & API
*   *Protokol Komunikasi*: REST vs GraphQL vs gRPC vs WebSocket.
*   *Skema Sinkronisasi*: Request-Response Sinkron vs Message Queue Asinkron (Event-Driven).
*   *Strategi Caching*: In-Memory Cache (Redis) vs HTTP Gateway Caching vs No-Cache.

### 2. Domain Database & State Persistence
*   *Model Data*: Relational (PostgreSQL/MySQL/SQLite) vs Document/Key-Value vs Embedded.
*   *Konsistensi Data*: ACID Strict vs Eventual Consistency.
*   *Strategi Migrasi*: Otomatis saat startup vs Skrip migrasi terisolasi manual.

### 3. Domain Frontend & Antarmuka
*   *Rendering Strategy*: Client-Side Rendering (CSR) vs Server-Side Rendering (SSR) vs Static (SSG).
*   *Manajemen State*: Local Component State vs Global Store vs URL Query State.
*   *Feedback Pengguna*: Optimistic UI Updates vs Spinner Loading Gate.

### 4. Domain Keamanan & Autentikasi
*   *Mekanisme Sesi*: JWT Stateless vs Server-Side Session Cookies vs API Keys.
*   *Kontrol Akses*: Role-Based Access Control (RBAC) vs Attribute-Based Access Control (ABAC).

---

## Batas Selesai (*Completion Criteria*) & Anti-Analysis Paralysis

Sesi grilling dinyatakan **SELESAI** jika:
1. Seluruh cabang pohon keputusan pada tingkat MVP telah disepakati oleh pengguna (*frontier kosong*).
2. Tidak ada lagi asumsi arsitektur kritis yang menggantung.
3. **Anti-Paralysis Gate**: Dilarang memperpanjang wawancara untuk detail implementasi sepele yang sudah memiliki konvensi standar (seperti nama variabel lokal atau format penulisan kurung kurawal).

---

## Tabel Anti-Pola Grilling (*Grilling Anti-Patterns*)

| Pola Terlarang | Mengapa Dilarang Keras? | Solusi Wajib |
|---|---|---|
| **The Lazy Inquirer** | Menanyakan *"Kamu mau pakai library apa?"* tanpa memberikan pilihan atau rekomendasi. | Riset alternatif terbaik; berikan opsi A/B beserta rekomendasi dan alasannya. |
| **Fact Interrogation** | Menanyakan *"Apakah proyekmu pakai TypeScript?"* padahal bisa membaca `package.json`. | Periksa berkas proyek secara mandiri. Jangan bebani pengguna dengan pertanyaan fakta dasar. |
| **Question Avalanche** | Memberondong 15 pertanyaan sekaligus yang melompat-lompat antar cabang pohon. | Batasi 2–4 pertanyaan per ronde pada batas terbuka (*frontier*) yang terfokus. |
| **Assumption Hallucination** | Memutuskan pilihan arsitektur besar secara diam-diam tanpa konfirmasi pengguna. | Ajukan opsi pada sesi grilling saat menemukan trade-off kritis. |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum menutup sesi grilling dan memulai penulisan kode/spesifikasi:
- [ ] Seluruh fakta proyek telah diperiksa secara mandiri melalui pembaca berkas/terminal.
- [ ] Setiap pertanyaan memiliki 2–3 opsi konkret dengan analisis untung-rugi (*trade-offs*).
- [ ] Menyertakan rekomendasi AI yang jelas beserta alasan teknisnya.
- [ ] Seluruh istilah teknis dijelaskan dengan analogi sederhana yang ramah (ELI5).
- [ ] Pengguna telah memberikan persetujuan eksplisit atas opsi yang dipilih pada frontier.



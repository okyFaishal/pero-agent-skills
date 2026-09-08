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
> - **Dengan Grilling (Audit Ketahanan Disiplin & Pilihan Interaktif)**: Alih-alih menyuruh pemilik rumah menulis esai rumit, arsitek menyodorkan tablet berisi angket pilihan interaktif:
>   - *Opsi 1 (Recommended)*: Menggeser kolam ke taman belakang (biaya hemat, struktur aman, perawatan mudah).
>   - *Opsi 2*: Mempertebal tiang baja lantai 1-5 (struktur aman, tetapi biaya naik 60%).
>   - *Opsi 3*: Kolam mini hidroterapi di lantai 5 dengan beban terdistribusi (kompromi ukuran vs biaya).
>   Pemilik rumah cukup mengklik opsi yang diinginkan dengan satu sentuhan jari.

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
│ 3. Dispatch Round (UI)  : Panggil perkakas ask_question     │
│ 4. Prune or Branch      : Perbarui pohon berdasarkan pilihan│
│ 5. Completion Gate      : Frontier kosong -> Kesepahaman    │
└─────────────────────────────────────────────────────────────┘
```

1. **Frontier Definitif**: Himpunan keputusan yang seluruh prasyaratnya sudah terjawab. Jangan menanyakan anak cabang jika induknya belum disepakati.
2. **AI Mencari Fakta, Pengguna Mengambil Keputusan**:
   - Dilarang bertanya hal-hal yang bisa dicek sendiri oleh AI (seperti versi bahasa di `package.json` atau daftar tabel database lokal).
   - AI wajib menyajikan pilihan konkret yang menyeluruh (2 hingga 5 alternatif realistis) beserta analisis untung-rugi (*trade-offs*) dan rekomendasi teknis terbaik.

---

## Standar Pemanggilan Interaktif (via `ask_question`)

Untuk menghilangkan friksi pengetikan manual dan menyajikan antarmuka pemilihan yang elegan, Agent **WAJIB menggunakan perkakas `ask_question`** pada setiap sesi wawancara keputusan.

### 1. Struktur Pemanggilan Perkakas
Setiap pemanggilan `ask_question` wajib mematuhi aturan berikut:
- **Fleksibilitas Jumlah Pertanyaan**:
  - **1 Pertanyaan**: Jika keputusan berdiri sendiri secara terisolasi (misal: penentuan batas toleransi downtime sistem).
  - **2 hingga 4 Pertanyaan Sekaligus**: Jika keputusan berada dalam satu klaster domain yang saling bergantung (misal: paket keputusan runtime bahasa, web framework, ORM, dan driver database).
- **Opsi Maksimal & Komprehensif**:
  - Sajikan **2 hingga 5 opsi realistis** yang mencakup spektrum solusi terbaik (jangan batasi hanya 2 opsi biner jika terdapat alternatif lain yang layak).
  - Format teks opsi sebagai respons langsung dari sudut pandang pengguna.
- **Rekomendasi Utama `(Recommended)`**:
  - Opsi terbaik menurut pertimbangan teknis AI **WAJIB diletakkan di urutan nomor 1** dan diawali dengan label `(Recommended)`.
- **Dukungan Multi-Select**:
  - Gunakan `is_multi_select: true` jika pengguna diizinkan memilih kombinasi lebih dari satu fitur (misalnya: memilih fitur P0 MVP atau middleware keamanan).
  - Gunakan `is_multi_select: false` untuk keputusan eksklusif tunggal (misalnya: memilih jenis basis data utama).

### 2. Contoh Pemanggilan `ask_question`

```json
{
  "questions": [
    {
      "question": "Strategi basis data apa yang paling sesuai untuk kebutuhan transaksi dan pencarian konten proyek ini?",
      "options": [
        "(Recommended) PostgreSQL dengan pgvector (ACID ketat, relasi kuat, dan siap pencarian semantik bawaan)",
        "SQLite lokal mandiri (Operasional tanpa server, biaya nol, cocok untuk volume baca tinggi dan tulis tunggal)",
        "PostgreSQL terkelola + Redis Caching (Performa throughput tinggi dengan pemisahan beban query berat)",
        "Document Store / MongoDB (Skema fleksibel untuk dokumen bersarang tanpa skema kaku)"
      ],
      "is_multi_select": false
    },
    {
      "question": "Bagaimana kebijakan mitigasi duplikasi data pada proses mutasi transaksi?",
      "options": [
        "(Recommended) Wajib Idempotency Key via header HTTP X-Idempotency-Key dengan Redis lock 60 detik",
        "Unique Constraint di level basis data dengan penanganan error duplikasi di service layer",
        "Pemberian peringatan konfirmasi ganda di sisi antarmuka pengguna tanpa kunci di backend"
      ],
      "is_multi_select": false
    }
  ],
  "toolAction": "Wawancara keputusan arsitektur",
  "toolSummary": "Sesi wawancara arsitektur database"
}
```

---

## Cetak Biru Pertanyaan Siap Pakai per Domain (*Domain Blueprints*)

### 1. Domain Backend & API
*   *Protokol Komunikasi*: REST vs GraphQL vs gRPC vs WebSocket.
*   *Skema Sinkronisasi*: Request-Response Sinkron vs Message Queue Asinkron (Event-Driven) vs Hybrid Webhook.
*   *Strategi Caching*: In-Memory Cache (Redis) vs HTTP Gateway Caching vs Client-side Cache vs No-Cache.

### 2. Domain Database & State Persistence
*   *Model Data*: Relational (PostgreSQL/MySQL) vs Embedded (SQLite) vs Document (MongoDB) vs Key-Value (Redis).
*   *Konsistensi Data*: ACID Strict vs Eventual Consistency vs Read-Replica Lag Tolerant.
*   *Strategi Migrasi*: Skrip migrasi terisolasi manual vs Migrasi otomatis saat CI/CD deployment vs In-app startup auto-migrate.

### 3. Domain Frontend & Antarmuka
*   *Rendering Strategy*: Client-Side Rendering (CSR) vs Server-Side Rendering (SSR) vs Static (SSG) vs Incremental Static (ISR).
*   *Manajemen State*: Local Component State vs Global Store (Pinia/Zustand) vs Server State (TanStack Query) vs URL Query State.
*   *Feedback Pengguna*: Optimistic UI Updates vs Skeleton Loader vs Blocking Modal Gate.

### 4. Domain Keamanan & Autentikasi
*   *Mekanisme Sesi*: JWT Stateless vs Encrypted Session Cookies (Better Auth / Lucia) vs API Key Perimeter.
*   *Kontrol Akses*: Role-Based Access Control (RBAC) vs Attribute-Based Access Control (ABAC) vs Simple Admin Flag.

---

## Batas Selesai (*Completion Criteria*) & Anti-Analysis Paralysis

Sesi grilling dinyatakan **SELESAI** jika:
1. Seluruh cabang pohon keputusan pada tingkat MVP telah disepakati oleh pengguna (*frontier kosong*).
2. Tidak ada lagi asumsi arsitektur kritis yang menggantung.
3. **Volume Batas Sesi**: Total akumulasi pertanyaan dalam satu tahapan SDLC berkisar antara **5 hingga 10 pertanyaan terarah** untuk menjaga kedalaman tanpa memicu kejenuhan pengguna.
4. **Anti-Paralysis Gate**: Dilarang memperpanjang wawancara untuk detail implementasi sepele yang sudah memiliki konvensi standar (seperti nama variabel lokal atau format penulisan kurung kurawal).

---

## Tabel Anti-Pola Grilling (*Grilling Anti-Patterns*)

| Pola Terlarang | Mengapa Dilarang Keras? | Solusi Wajib |
|---|---|---|
| **The Lazy Inquirer** | Menanyakan *"Kamu mau bagaimana?"* tanpa memberikan pilihan terstruktur atau rekomendasi. | Riset alternatif terbaik; berikan 2–5 opsi konkret via `ask_question` dengan opsi rekomendasi di urutan pertama. |
| **Fact Interrogation** | Menanyakan *"Apakah proyekmu pakai TypeScript?"* padahal bisa membaca berkas repositori. | Periksa berkas proyek secara mandiri. Jangan bebani pengguna dengan pertanyaan fakta dasar. |
| **Question Avalanche / Rigid Batches** | Memberondong 15 pertanyaan acak, atau sebaliknya memaksakan selalu 1–2 pertanyaan ketika topiknya butuh serentak. | Kelompokkan secara fleksibel: 1 pertanyaan jika terisolasi, atau 2–4 pertanyaan via `ask_question` jika berada dalam satu rumpun topik terikat. |
| **Binary Forcing** | Memaksa pilihan hanya Opsi A vs B padahal dunia nyata memiliki 3-4 alternatif layak. | Sajikan seluruh opsi realistis (2 hingga 5 opsi) agar pengguna memiliki cakupan solusi lengkap. |
| **Assumption Hallucination** | Memutuskan pilihan arsitektur besar secara diam-diam tanpa konfirmasi pengguna. | Ajukan opsi pada sesi grilling via `ask_question` saat menemukan trade-off kritis. |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum menutup sesi grilling dan memulai penulisan kode/spesifikasi:
- [ ] Seluruh fakta proyek telah diperiksa secara mandiri melalui pembaca berkas/terminal.
- [ ] Sesi keputusan dipanggil menggunakan perkakas interaktif `ask_question` (bukan meminta ketikan teks bebas).
- [ ] Setiap pertanyaan menyajikan 2 hingga 5 opsi konkret yang realistis.
- [ ] Opsi rekomendasi terbaik AI ditempatkan di nomor 1 dengan label `(Recommended)`.
- [ ] Pengelompokan pertanyaan fleksibel (1 mandiri atau 2-4 serentak) sesuai keterikatan topik.
- [ ] Seluruh istilah teknis dijelaskan dengan bahasa sederhana dan ramah (ELI5).
- [ ] Pengguna telah memilih dan menyetujui opsi yang diajukan.



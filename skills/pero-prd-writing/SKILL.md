---
name: pero-prd-writing
description: Use when converting framed problems into a formal Product Requirements Document (PRD), defining MVP feature scope, success metrics, and user workflows
---

# Pero PRD Writing (`pero:prd-writing`)

## Overview
**Origin**: *Pero Custom SDLC Pipeline - Stage 2 (Universal)*.
Skill ini bertindak sebagai **"Buku Cetak Biru & Resep Utama Produk"**. Tugasnya adalah mengubah rumusan masalah yang telah disepakati di `docs/ProblemFraming.md` menjadi dokumen **Product Requirements Document (PRD)** formal yang komprehensif, menetapkan batasan fitur MVP (P0) vs fitur masa depan (P1/P2), dan menggambarkan alur perjalanan pengguna secara jelas.

## Sub-Skill Integration (Perkakas Pendukung)
Dalam menjalankan tahapan ini, agent WAJIB mengorkestrasi sub-skill berikut:
- **Upstream Context Alignment**: **`MANDATORY`**: Wajib membaca dan memverifikasi `docs/ProblemFraming.md` agar seluruh fitur selaras dengan akar masalah dan tidak melanggar batasan *Non-Goals*.
- **Dekomposisi Riset Paralel & Benchmark Web**: **`REQUIRED SUB-SKILL`**: Gunakan `dispatching-parallel-agents` untuk mendelegasikan 3 sub-agen spesialis secara paralel yang masing-masing dibekali alat `web-search` (*Sub-agen 1: Alur Kerja Pengguna & Standar UX Industri, Sub-agen 2: Non-Functional Requirements & Tolok Ukur Kinerja, Sub-agen 3: Matriks Fitur P0/P1/P2 & Komparasi Pasar*). Setiap sub-agen dibatasi 1–2 pencarian web terarah dan wajib menyertakan URL referensi valid.
- **Musyawarah Pemangkasan Scope & Trade-offs**: **`REQUIRED / STRATEGIC SUB-SKILL`**: Gunakan `llm-council` untuk menguji ketahanan matriks prioritas fitur P0 (Must-Have) vs P1 (Should-Have) vs P2 (Nice-to-Have) melalui sidang 5 persona AI guna mencegah pembengkakan cakupan (*scope bloat*).
- **Wawancara Penguncian Scope & Edge Cases**: **`REQUIRED SUB-SKILL`**: Gunakan `grilling` secara interaktif langsung kepada pengguna di chat dengan batas **minimal 5 dan maksimal 10 pertanyaan** bertahap (1–2 pertanyaan per putaran) untuk mengunci prioritas P0 dan skenario pemulihan error (*error recovery*). Agent WAJIB menghentikan eksekusi (*pause*) dan menunggu respon pengguna. DILARANG mengarang keputusan sepihak.
- **Audit Konsistensi Hulu-Hilir**: **`REQUIRED SUB-SKILL`**: Gunakan `pero-context-validation` untuk memverifikasi bahwa PRD 100% konsisten dan tidak melanggar batasan *Non-Goals* di `docs/ProblemFraming.md`.
- **Pencatatan Keputusan PRD**: **`SUPPORTING SUB-SKILL`**: Gunakan `decision-recorder` untuk membukukan kesepakatan cakupan fitur ke `docs/decisions/PDR-[YYYYMMDDHHmm].md`.

## When to Use
- Mengubah ide masalah yang sudah tervalidasi di `docs/ProblemFraming.md` menjadi spesifikasi kebutuhan produk yang terstruktur dan terukur.
- Menetapkan batas fitur minimum layak rilis (P0 MVP) secara ketat dan bebas dari pembengkakan (*anti-bloat*).
- Memetakan alur navigasi lengkap mencakup skenario sukses (*Happy Path*) dan skenario penanganan error (*Unhappy Path*).
- Menentukan spesifikasi non-fungsional (NFR) performa, reliabilitas, keamanan, dan kompatibilitas multi-device.

## The 5-Stage PRD Framework

```
[0. Ingestion docs/ProblemFraming.md]
                  │
                  ▼
[1. 3-Track Research + Web Search (DPA)] ──> Workflow UX & Tolok Ukur NFR
                  │
                  ▼
[2. Scope Pruning Council (LLM Council)] ──> 5 Persona AI memangkas P0 vs P1
                  │
                  ▼
[3. Scope & Edge-Case Grilling (User)]   ──> Rambu Henti Wajib di chat (5-10 pertanyaan)
                  │
                  ▼
[4. PRD Synthesis & PDR Record]          ──> Penulisan docs/PRD.md & PDR decision
                  │
                  ▼
[5. Cross-Doc Consistency Audit]         ──> pero-context-validation (Audit vs Non-Goals)
```

### 1. Dekomposisi Riset Paralel Berbasis Web (via `dispatching-parallel-agents` + `web-search`)
- Mengutus 3 sub-agen riset mandiri yang masing-masing dibekali alat `web-search` untuk membedah standar teknis dan UX industri:
  - *Sub-agen 1 (Alur Pengguna & Standar UX)*: Meneliti pola navigasi standar industri, alur onboarding, penanganan sesi login, dan praktik terbaik UX untuk alur kerja serupa.
  - *Sub-agen 2 (Non-Functional Requirements & Tolok Ukur Kinerja)*: Meneliti standar industri untuk batas latency API, target uptime, kepatuhan keamanan data, dan sanitasi input OWASP.
  - *Sub-agen 3 (Draf Matriks Fitur P0/P1/P2)*: Meneliti fitur minimum kompetitor di segmen serupa untuk membedakan mana fitur dasar mutlak (*table stakes*) dan mana fitur pelengkap.
- **Pagar Pencarian**: Setiap sub-agen dibatasi maksimal 1–2 pencarian terarah dan wajib menyertakan URL referensi valid dalam laporannya.

### 2. Musyawarah Pemangkasan Scope oleh Dewan 5 AI (via `llm-council`)
- Menyidangkan draf matriks fitur ke 5 persona dewan AI (*Product Strategist, Skeptic Auditor, Domain Specialist, Tech Feasibility, User Advocate*) melalui *blind peer-review*.
- Dewan bertugas secara agresif membedah: *"Apakah fitur ini mutlak wajib ada di rilis pertama (P0), ataukah hanya fitur impian yang memicu pembengkakan scope (P1/P2)?"*.
- Menghasilkan daftar rekomendasi pemangkasan (*scope pruning*) dan daftar dilema kompromi fitur untuk diuji ke pengguna.

### 3. Wawancara Penguncian Scope & Edge Cases di Chat (via `grilling`)
- **RAMBU HENTI WAJIB (MANDATORY PAUSE GATE)**:
  - Agent **DILARANG** langsung membuat berkas `docs/PRD.md` sebelum menyepakati cakupan fitur P0 dan kebijakan skenario gagal dengan pengguna di obrolan (*chat*).
  - Dilarang keras menentukan garis batas P0 vs P1/P2 secara sepihak.
- **Pagar Batas Pertanyaan (Volume & Delivery Guardrails)**:
  - **Batas Kuantitas**: Sesi wawancara PRD dibatasi **minimal 5 pertanyaan** (untuk memastikan seluruh fitur P0 dan skenario kegagalan teruji) dan **maksimal 10 pertanyaan** (mencegah kelelahan pengguna).
  - **Penyampaian Bertahap (*Anti-Question Avalanche*)**: DILARANG memberondong pertanyaan sekaligus. Pertanyaan wajib diajukan secara bertahap (1–2 pertanyaan per putaran chat) lengkap dengan opsi konkret (Opsi A vs Opsi B) dan rekomendasi teknis AI.
- **Protokol Wawancara Chat (Interaktif)**:
  1. Sajikan intisari rekomendasi pemangkasan fitur P0 dari sidang dewan AI.
  2. Hadapkan pertanyaan secara bertahap mengenai:
     - Validasi batas P0 vs P1 (fitur mana yang wajib rilis di versi pertama vs ditunda ke fase berikutnya).
     - Kebijakan penanganan skenario gagal (*unhappy path*, batas timeout, penanganan koneksi putus, pemulihan data).
  3. **Hentikan pemanggilan tools (STOP)** dan tunggu jawaban pengguna pada setiap putaran chat.
  4. Lanjutkan hingga rentang 5–10 pertanyaan terpenuhi dan kesepakatan cakupan MVP terkunci rapat.

### 4. Penyusunan Dokumen PRD Formal & Rekam Keputusan PDR
- Menyusun dokumen lengkap `docs/PRD.md` berdasarkan hasil kesepakatan chat, memetakan alur normal vs gagal secara terperinci, dan mendefinisikan target NFR kuantitatif.
- Membukukan alasan di balik prioritas fitur dan kompromi arsitektur ke `docs/decisions/PDR-[YYYYMMDDHHmm].md` via `decision-recorder`.

### 5. Audit Konsistensi Hulu-Hilir (via `pero-context-validation`)
- Mengaudit dokumen secara otomatis sebelum diserahkan:
  - Memverifikasi bahwa 100% fitur P0 menjawab akar masalah di `docs/ProblemFraming.md`.
  - Memverifikasi bahwa 0% fitur P0 melanggar daftar *Non-Goals* yang telah ditetapkan di Tahap 1.

## Deliverables & Output Artifacts

1. **Living Document**: `docs/PRD.md`
2. **Decision Record**: `docs/decisions/PDR-[YYYYMMDDHHmm].md`

---

## Template: `docs/PRD.md`

````markdown
# Product Requirements Document (PRD): [Nama Produk]

- **Versi**: 1.0 (MVP)
- **Status**: Disetujui (Approved)
- **Tanggal**: [YYYY-MM-DD]
- **Dokumen Induk**: [docs/ProblemFraming.md](docs/ProblemFraming.md)
- **Decision Record**: [docs/decisions/PDR-[YYYYMMDDHHmm].md](docs/decisions/PDR-[YYYYMMDDHHmm].md)

## 1. Executive Summary & Visi Produk
[Jelaskan visi produk dalam 1 paragraf dengan analogi sederhana (ELI5)]

## 2. Latar Belakang Masalah & Target Pengguna
- **Masalah Utama**: [Mengutip langsung dari ProblemFraming.md]
- **Target Persona**: [Profil pengguna utama dan cara kerja saat ini]

## 3. Matriks Cakupan Fitur (Feature Scope Matrix)
### 3.1. P0 — MVP (Wajib Ada di Rilis Pertama)
| ID | Fitur P0 | Deskripsi Singkat | Masalah yang Dijawab (Traceability) | Kriteria Penerimaan Terukur (Definition of Done) | Batasan Fitur (Feature Non-Goals) |
|:---|:---|:---|:---|:---|:---|
| F-01 | [Nama Fitur 1] | [Fungsi inti] | [Kaitan ke ProblemFraming] | [Kondisi sukses terukur & lulus uji] | [Hal yang sengaja tidak dibuat di F-01] |
| F-02 | [Nama Fitur 2] | [Fungsi inti] | [Kaitan ke ProblemFraming] | [Kondisi sukses terukur & lulus uji] | [Hal yang sengaja tidak dibuat di F-02] |

### 3.2. P1 — Fase Berikutnya (Should-Have)
- [ ] **[Fitur 3]**: [Deskripsi + Target rilis fase 2]

### 3.3. P2 — Masa Depan (Nice-to-Have / Backlog Panjang)
- [ ] **[Fitur 4]**: [Deskripsi fitur eksperimental]

## 4. Matriks Alur Perjalanan Pengguna (Happy Path vs Edge Cases)
| Tahap Alur | Skenario Normal (Happy Path) | Skenario Gagal / Edge Case (Unhappy Path) | Strategi Pemulihan (Error Recovery) |
|:---|:---|:---|:---|
| 1. Onboarding / Masuk | [Pengguna berhasil login/buka] | [Kredensial salah / Sesi expired] | [Pesan error ramah + opsi reset] |
| 2. Eksekusi Aksi Utama | [Pengguna memproses data sukses] | [Koneksi putus / Data input korup] | [Simpan draf lokal + retry otomatis] |
| 3. Output & Penyelesaian | [Hasil tampil instan & tersimpan] | [Penyimpanan penuh / Server timeout] | [Notifikasi fallback + unduh offline] |

## 5. Kebutuhan Non-Fungsional Multi-Dimensi (NFR)
| Dimensi NFR | Spesifikasi & Target Terukur | Strategi Pengujian / Mitigasi |
|:---|:---|:---|
| **Kecepatan (Performance)** | Latency API < 200ms, UI Load < 1s | Benchmark load testing di pipeline |
| **Kestabilan (Reliability)** | Uptime 99.9%, Graceful degradation | Circuit breaker & offline storage |
| **Dukungan Platform** | Web responsive (Mobile & Desktop) | Browser compatibility matrix |
| **Keamanan (Security)** | Zero plaintext secrets, input sanitization | Env-guard & OWASP top-10 check |

## 6. Metrik Keberhasilan (KPIs) & Mitigasi Risiko
| Metrik / KPI | Target Kuantitatif | Cara Mengukur |
|:---|:---|:---|
| [Nama Metrik] | [Target Angka, misal: 95% kepuasan] | [Alat Ukur / Analytics] |

| Potensi Risiko | Tingkat Dampak | Rencana Mitigasi Konkret |
|:---|:---|:---|
| [Risiko Teknis / Produk] | Tinggi / Sedang | [Langkah pencegahan konkret] |

## 7. Hasil Validasi Konsistensi Hulu & Kesepakatan Dewan (Context Alignment Gate)
- **Kesesuaian Masalah Inti**: [✓] 100% Fitur P0 menjawab akar masalah di `ProblemFraming.md`.
- **Kepatuhan Batasan Non-Goals**: [✓] Tidak ada fitur yang melanggar daftar *Non-Goals* Tahap 1.
- **Konsensus Sidang Dewan AI**: [Ringkasan pemangkasan fitur P0 vs P1 oleh 5 persona dewan].
- **Keputusan Strategis Pengguna**: [Pilihan keputusan yang disepakati pengguna pada sesi Grilling Tahap 3].
````

## Anti-Patterns & Common Mistakes
- **Simulated Scope Deciding**: Menentukan sendiri fitur mana yang masuk P0 vs P1/P2 di dalam berkas dokumen tanpa pernah melakukan wawancara grilling dengan pengguna di chat.
- **Question Avalanche or Premature Cessation**: Mengirimkan lebih dari 2 pertanyaan sekaligus dalam satu balon chat, mengajukan kurang dari 5 pertanyaan (terlalu malas dan dangkal), atau melampaui batas 10 pertanyaan pada sesi wawancara Tahap 3 (memicu kelelahan pengguna dan *analysis paralysis*).
- **Scope Overload / P0 Bloat**: Memasukkan terlalu banyak fitur ke dalam P0 tanpa sidang pemangkasan dewan, sehingga MVP gagal rilis tepat waktu.
- **Mengabaikan Batasan Non-Goals**: Menyelipkan fitur yang sudah secara eksplisit dilarang di `ProblemFraming.md`.
- **Happy Path Bias (Dead-End Workflows)**: Hanya merancang alur sukses tanpa memetakan skenario gagal, timeout, koneksi terputus, atau pemulihan error.
- **NFR Mengambang Tanpa Angka**: Menulis "sistem harus cepat dan aman" tanpa target kuantitatif (angka latency dalam milidetik atau standar enkripsi industri).

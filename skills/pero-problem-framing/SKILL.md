---
name: pero-problem-framing
description: Use when starting a new project, exploring raw user ideas, defining core user pain points, or separating root problems from symptoms before writing specifications
---

# Pero Problem Framing (`pero:problem-framing`)

## Overview
**Origin**: *Pero Custom SDLC Pipeline - Stage 1 (Universal)*.
Skill ini bertindak sebagai **"Dokter Diagnosa Masalah yang Bijak"**. Tugasnya adalah membedah ide mentah pengguna menjadi rumusan masalah yang tervalidasi secara mendalam, memisahkan antara "gejala luar" dan "akar masalah asli", serta menentukan batas ruang lingkup secara tegas sebelum buru-buru membuat dokumen PRD atau menulis kode.

## Sub-Skill Integration (Perkakas Pendukung)
Dalam menjalankan tahapan ini, agent WAJIB mengorkestrasi sub-skill berikut:
- **Riset Multi-Dimensi Paralel & Bukti Empiris Web (Adaptive Squad: 3 Wajib + 1–3 Spesialis)**: **`REQUIRED SUB-SKILL`**: Gunakan `dispatching-parallel-agents` untuk mendelegasikan tim agen riset independen secara paralel yang masing-masing dibekali alat `web-search`.
  - **3 Agen Wajib**: *Persona & Pain Points*, *Pasar & Benchmark Kompetitor*, *Kelayakan Arsitektur Teknis*.
  - **1–3 Agen Spesialis Dinamis (Wajib pilih min. 1, maks. 3)**: Dipilih secara kontekstual sesuai karakteristik ide dari katalog spesialis (*Kepatuhan Regulasi/Privasi, Nilai Finansial/Kesediaan Membayar, Benteng Pertahanan/Moat, atau Inersia Adopsi/Kebiasaan Lama*).
  - **Pagar Pencarian**: Setiap agen dibatasi 1–2 pencarian web terarah dan wajib menyertakan minimal 1 tautan URL resmi aktif dengan data empiris konkret (total menghasilkan minimal 4 hingga 6 bukti valid).
- **Musyawarah 5 Sudut Pandang AI**: **`REQUIRED / STRATEGIC SUB-SKILL`**: Gunakan `llm-council` untuk menguji rumusan masalah dari 5 perspektif ahli (*Product Strategist, Skeptic Auditor, Domain Specialist, Tech Feasibility, User Advocate*) melalui *blind peer-review* untuk membasmi bias sudut pandang sempit.
- **Wawancara Socratic & Stress-Test 2-Tahap**: **`REQUIRED SUB-SKILL`**: Gunakan `grilling` secara interaktif langsung kepada pengguna di chat dalam **2 ronde terpisah**:
  1. *Ronde 1 (Tahap 2)*: Membedah 5-Whys hingga ke akar terdalam (*root cause*) dengan batas **minimal 5 dan maksimal 10 pertanyaan** yang diajukan secara bertahap.
  2. *Ronde 2 (Tahap 4)*: Menguji titik buta (*blind spots*), kritik tajam, dan dilema kompromi (*trade-offs*) hasil sidang Dewan AI (`llm-council`) dengan batas **minimal 5 dan maksimal 10 pertanyaan** yang diajukan secara bertahap.
  Agent WAJIB menghentikan eksekusi (*pause*) pada setiap ronde dan menunggu respon pengguna. DILARANG mengarang atau mensimulasikan jawaban secara mandiri.
- **Audit Konsistensi Masalah Hulu**: **`SUPPORTING SUB-SKILL`**: Gunakan `pero-context-validation` untuk memastikan rumusan masalah tidak kontradiktif dengan batasan *Non-Goals* atau metrik dampak.
- **Pencatatan Keputusan Produk**: **`SUPPORTING SUB-SKILL`**: Gunakan `decision-recorder` untuk membukukan kesepakatan ruang lingkup ke `docs/decisions/PFDR-[YYYYMMDDHHmm].md`.

## When to Use
- Memulai proyek baru atau merancang fitur/kemampuan baru berskala besar.
- Pengguna memiliki ide konseptual yang masih samar, terlalu sempit, atau terlalu luas.
- Ingin membedah apakah keluhan pengguna adalah akar masalah atau hanya gejala permukaan dengan dukungan bukti empiris.
- Menghilangkan bias asumsi dan inkonsistensi sebelum masuk ke tahap pembuatan PRD (`pero-prd-writing`).

## The 5-Stage Problem Framing Framework

```
[1. Adaptive Squad Discovery (DPA + Web Search)]
    (3 Agen Wajib + 1–3 Agen Spesialis Dinamis -> Terkumpul 4–6 bukti URL valid)
                         │
                         ▼
[2. 5-Whys Root Cause Grilling (User R1)] ──> Rambu Henti Wajib di chat
                         │
                         ▼
[3. Multi-Perspective Council (LLM Council)]──> Sidang 5 persona AI & blind peer-review
                         │
                         ▼
[4. Council-Driven Grilling (User R2)]   ──> Rambu Henti Wajib (uji titik buta dewan)
                         │
                         ▼
[5. Boundaries (Non-Goals) & Metrics]    ──> Kunci ruang lingkup & tulis dokumen
```

### 1. Pembedahan Riset Paralel Berbasis Web (Adaptive Squad: 3 Wajib + 1–3 Spesialis)
Mendelegasikan tim agen riset independen via `dispatching-parallel-agents` yang masing-masing dibekali alat `web-search` untuk menambang bukti empiris langsung dari internet:

#### A. 3 Agen Inti (Wajib Berjalan di Setiap Proyek):
1. **Agen 1 (Persona & Masalah Pengguna)**: Menyelidiki keluhan pengguna nyata, forum diskusi komunitas (Reddit/komunitas profesional), dan kesulitan utama persona target.
2. **Agen 2 (Riset Pasar & Benchmark Kompetitor)**: Menyelidiki alternatif solusi di pasar, fitur unggulan kompetitor, model harga, dan studi kasus kegagalan produk serupa.
3. **Agen 3 (Kelayakan Teknis & Arsitektur)**: Menyelidiki dokumentasi resmi framework/library, batasan API pihak ketiga, dan kompleksitas implementasi kode.

#### B. 1–3 Agen Spesialis Dinamis (Wajib Memilih Minimal 1, Maksimal 3):
Agent utama **WAJIB memilih minimal 1 dan maksimal 3** peran spesialis berikut sesuai karakteristik ide proyek:
- **Spesialis Legal, Kepatuhan & Privasi (*Compliance & Privacy Auditor*)**:
  - *Kapan Dipilih*: Ide mengelola data pribadi pengguna (UU PDP/GDPR), transaksi keuangan, rekam medis kesehatan, atau scraping data publik berbasis AI.
  - *Fokus Riset*: Regulasi resmi, kebijakan privasi, kepatuhan lisensi data, dan potensi sanksi hukum industri.
- **Spesialis Nilai Finansial & Kesediaan Membayar (*Willingness-to-Pay Analyst*)**:
  - *Kapan Dipilih*: Ide berupa produk komersial, SaaS berbayar, marketplace, atau fitur yang membutuhkan kalkulasi ROI dan anggaran pelanggan.
  - *Fokus Riset*: Bukti transaksi pasar, patokan harga wajar industri, kalkulasi kerugian finansial jika masalah diabaikan, dan kesediaan membayar (*willingness to pay*).
- **Spesialis Benteng Pertahanan (*Defensibility & Moat Analyst*)**:
  - *Kapan Dipilih*: Ide berada di pasar yang padat, mudah ditiru (misal: AI wrapper biasa), atau berisiko ditelan oleh pembaruan fitur raksasa teknologi.
  - *Fokus Riset*: Analisis diferensiasi unik, hambatan masuk (*barriers to entry*), efek jaringan (*network effects*), dan biaya berpindah (*switching costs*).
- **Spesialis Inersia Kebiasaan & Resistensi Alur Kerja (*Adoption Inertia Analyst*)**:
  - *Kapan Dipilih*: Ide menggantikan kebiasaan manual lama yang sudah mengakar (misal: menggantikan Excel, buku catatan, atau chat WhatsApp kerja).
  - *Fokus Riset*: Beban gesekan psikologis saat migrasi, tingkat kegagalan adopsi sistem sejenis, dan strategi transisi alur kerja tanpa penolakan tim.

#### C. Pagar Batas Pencarian & Integritas Bukti (*Guardrails*):
- **Batas Beban**: Total agen yang berjalan paralel adalah **4 hingga 6 agen** (3 wajib + 1 hingga 3 spesialis). DILARANG menjalankan 0 spesialis atau lebih dari 3 spesialis.
- **Batas Kuota Pencarian**: Setiap agen dibatasi maksimal **1–2 pencarian web terarah** untuk mencegah pemborosan kuota dan risiko *rate limit*.
- **Integritas Bukti Empiris**: Setiap agen wajib menyertakan **minimal 1 tautan URL resmi dan aktif** dengan temuan konkret, sehingga total menghasilkan **minimal 4 hingga 6 bukti empiris tervalidasi** untuk dokumen akhir.

### 2. Diagnosa Akar Masalah (5-Whys & `grilling` - Ronde 1 Chat)
- **RAMBU HENTI WAJIB (MANDATORY PAUSE GATE - RONDE 1)**:
  - Agent **DILARANG** langsung membuat atau mengisi berkas `docs/ProblemFraming.md` sebelum melakukan wawancara langsung dengan pengguna di obrolan (*chat*).
  - Dilarang keras melakukan *self-answering* (mengarang dan mengisi sendiri jawaban 5-Whys tanpa dialog nyata dengan pengguna).
- **Pagar Batas Pertanyaan (Volume & Delivery Guardrails)**:
  - **Batas Kuantitas**: Sesi wawancara akar masalah dibatasi **minimal 5 pertanyaan** (untuk memastikan kedalaman 5-Whys tidak terpotong kompas) dan **maksimal 10 pertanyaan** (untuk mencegah kelelahan pengguna dan kebuntuan analisis/*analysis paralysis*).
  - **Penyampaian Bertahap (*Anti-Question Avalanche*)**: DILARANG memberondong 5–10 pertanyaan sekaligus dalam satu kali kirim chat. Pertanyaan wajib diajukan secara bertahap (1–2 pertanyaan per putaran chat) mengalir mengikuti respon pengguna sebelumnya.
- **Protokol Wawancara Chat Ronde 1 (Interaktif)**:
  1. Sajikan intisari temuan empiris dan bukti URL dari tim agen riset sebagai pengantar konteks awal.
  2. Ajukan pertanyaan terarah 5-Whys secara bertahap kepada pengguna dengan menyertakan opsi konkret (A/B) dan rekomendasi teknis terbaik sesuai prinsip `grilling`.
  3. **Hentikan pemanggilan tools (STOP)** dan tunggu balasan dari pengguna di chat pada setiap putaran pertanyaan.
  4. Lanjutkan penggalian secara berantai hingga mencapai rentang 5–10 pertanyaan dan akar terdalam (*root cause*) disepakati bersama oleh pengguna, bukan hasil tebakan sepihak AI.

### 3. Multi-Perspective Peer Review (via `llm-council`)
- Menyidangkan rumusan akar masalah ke 5 penasihat AI (*Product Strategist, Skeptic Auditor, Domain Specialist, Tech Feasibility, User Advocate*) melalui *blind peer-review* untuk membedah titik buta (*blind spots*), kontradiksi asumsi, risiko tersembunyi, dan argumen bantahan dari masing-masing persona ahli.

### 4. Stress-Test Hasil Dewan AI (Council-Driven Grilling via `grilling` - Ronde 2 Chat)
- **RAMBU HENTI WAJIB (MANDATORY PAUSE GATE - RONDE 2)**:
  - Agent **DILARANG** langsung mengunci batasan (*Non-Goals*) atau membuat dokumen akhir sebelum menghadapkan hasil kritik Dewan AI kepada pengguna di obrolan (*chat*).
  - Dilarang keras memutuskan kompromi (*trade-offs*) strategis secara sepihak tanpa mandat pengguna.
- **Pagar Batas Pertanyaan Dewan (Volume & Delivery Guardrails)**:
  - **Batas Kuantitas**: Sesi wawancara pasca-dewan dibatasi **minimal 5 pertanyaan** (untuk memastikan titik buta dari 5 persona dewan diuji tuntas) dan **maksimal 10 pertanyaan** (untuk mencegah analisis berlarut-larut/*analysis paralysis*).
  - **Penyampaian Bertahap (*Anti-Question Avalanche*)**: DILARANG memberondong 5–10 pertanyaan sekaligus dalam satu kali kirim chat. Pertanyaan wajib diajukan secara bertahap (1–2 dilema per putaran chat) lengkap dengan opsi pilihan konkret (A/B), analisis trade-off, dan rekomendasi teknis AI.
- **Protokol Wawancara Chat Ronde 2 (Interaktif)**:
  1. Rangkum kritik terpedas, risiko paling krusial, dan titik buta (*blind spots*) yang diangkat oleh 5 penasihat AI (terutama dari *Skeptic Auditor* dan *Tech Feasibility*).
  2. Hadapkan dilema tersebut secara bertahap (1–2 pertanyaan per putaran chat) kepada pengguna dalam format opsi konkret (Opsi A vs Opsi B) beserta rekomendasi teknis AI terbaik.
  3. **Hentikan pemanggilan tools (STOP)** dan tunggu keputusan pengguna di chat pada setiap putaran.
  4. Lanjutkan penggalian secara berantai hingga mencapai rentang 5–10 pertanyaan strategis dan seluruh kompromi dewan disepakati bersama.
  5. Jadikan pilihan pengguna sebagai ketetapan mutlak dalam merumuskan ruang lingkup dan batasan (*Non-Goals*).

### 5. Pagar Batasan (Boundaries) & Metrik Keberhasilan
- Menetapkan daftar **Non-Goals (Out-of-Scope)** secara tegas berdasarkan hasil musyawarah dan keputusan pengguna pada Ronde 2 untuk mencegah pelebaran ruang lingkup (*scope creep*).
- Menentukan indikator keberhasilan terukur (kuantitatif & kualitatif).

## Deliverables & Output Artifacts

1. **Living Document**: `docs/ProblemFraming.md`
2. **Decision Record**: `docs/decisions/PFDR-[YYYYMMDDHHmm].md`

---

## Template: `docs/ProblemFraming.md`

````markdown
# Problem Framing: [Nama Proyek / Fitur]

- **Tanggal**: [YYYY-MM-DD]
- **Status**: Tervalidasi (Validated)
- **Author / Lead**: Pero & Architect
- **Decision Record**: [docs/decisions/PFDR-[YYYYMMDDHHmm].md](decisions/PFDR-[YYYYMMDDHHmm].md)

## 1. Executive Problem Statement
[Jelaskan masalah inti dalam 1-2 kalimat tajam dan jelas menggunakan analogi sederhana (ELI5)]

## 2. Target Persona & Pain Points
- **Target Pengguna**: [Siapa yang mengalami masalah ini]
- **Cara Lama yang Melelahkan (Workarounds)**: [Cara kerja saat ini dan letak kesulitannya]
- **Dampak Kerugian**: [Apa kerugian finansial/waktu jika masalah ini diabaikan]

## 3. Root Cause Analysis (5-Whys)
1. *Mengapa masalah ini terjadi?* -> [Jawaban 1]
2. *Mengapa [Jawaban 1] terjadi?* -> [Jawaban 2]
3. *Mengapa [Jawaban 2] terjadi?* -> [Jawaban 3]
4. *Mengapa [Jawaban 3] terjadi?* -> [Jawaban 4]
5. *Mengapa [Jawaban 4] terjadi?* -> [Akar Masalah Fundamental]

## 4. Boundaries & Scope Constraints
- **In-Scope (Fokus Utama)**:
  - [Ruang lingkup 1]
  - [Ruang lingkup 2]
- **Non-Goals (Dilarang Dibuat / Batasan Ketat)**:
  - [Non-Goal 1: Hal yang sengaja TIDAK akan dibuat sekarang]
  - [Non-Goal 2]

## 5. Bukti Empiris & Referensi Industri Terverifikasi
*(Terkumpul minimal 4 hingga 6 sumber dari 3 Agen Inti + 1–3 Agen Spesialis)*
| No | Domain Riset (Agen) | Sumber / Publikasi | URL Referensi | Temuan Kunci / Fakta Empiris |
|:---|:---|:---|:---|:---|
| 1 | Persona & User Pain | [Nama Studi Kasus / Sumber] | `https://...` | [Fakta / Statistik Konkret] |
| 2 | Market & Competitor | [Laporan Riset Pasar / Standar] | `https://...` | [Temuan Kunci] |
| 3 | Tech Feasibility | [Analisis Benchmark / Dokumentasi] | `https://...` | [Bukti Validasi] |
| 4 | [Spesialis Terpilih 1] | [Sumber Spesialis 1] | `https://...` | [Temuan Kunci Spesialis] |
| 5 | [Spesialis Terpilih 2 (opsional)] | [Sumber Spesialis 2] | `https://...` | [Temuan Kunci Spesialis] |
| 6 | [Spesialis Terpilih 3 (opsional)] | [Sumber Spesialis 3] | `https://...` | [Temuan Kunci Spesialis] |

## 6. Ukuran Keberhasilan (Success Metrics)
- **Metrik Utama**: [Angka / Target Terukur, misal: Reduksi waktu kerja 80%]
- **Kondisi Selesai**: [Kriteria konkret saat masalah ini resmi teratasi]

## 7. Hasil Musyawarah Dewan AI & Keputusan Pengguna
- **Konsensus Definisi Masalah**: [Ringkasan kesepakatan 5 persona AI]
- **Titik Buta & Kritik Tajam Dewan**: [Blind spot dan risiko kritis yang diangkat persona dewan]
- **Keputusan Strategis Pengguna (Hasil Grilling R2)**: [Pilihan opsi dan arahan pengguna atas kritik dewan]
````

---

## Template: `docs/decisions/PFDR-[YYYYMMDDHHmm].md`

````markdown
# PFDR-[YYYYMMDDHHmm]: [Judul Keputusan Definisi Masalah & Batasan Non-Goals]

- **Status**: Diterima (Accepted) / Ditinjau (Proposed) / Digantikan (Superseded)
- **Tanggal**: [YYYY-MM-DD]
- **Pengambil Keputusan**: Pengguna & Tim Problem Framing AI
- **Dokumen Terkait**: [docs/ProblemFraming.md](../ProblemFraming.md)

## 1. Konteks Masalah & Kebutuhan Penetapan Arah
[Jelaskan latar belakang masalah inti dan mengapa batas non-goals perlu dikunci di awal].

## 2. Batasan In-Scope vs Non-Goals yang Ditetapkan
[Rincian hal yang masuk cakupan dan hal yang secara sengaja ditolak / ditunda ke fase rilis mendatang].

## 3. Alternatif Pembingkaian Masalah yang Ditolak
| Alternatif Framing | Alasan Penolakan |
|:---|:---|
| [Alternatif 1] | [Mengapa ditolak / bias asumsi / tidak didukung bukti empiris] |
| [Alternatif 2] | [Kelemahan teknis / ruang lingkup terlalu luas / risiko YAGNI] |

## 4. Konsekuensi Positif & Beban Operasional (Trade-offs)
- **Konsekuensi Positif**: [Fokus tajam pada masalah inti, mencegah scope creep]
- **Beban Operasional**: [Fitur sekunder ditolak sementara waktu]
- **Strategi Mitigasi**: [Meninjau kembali non-goals setelah MVP divalidasi pengguna]
````

## Anti-Patterns & Common Mistakes
- **Question Avalanche or Premature Cessation**: Mengirimkan lebih dari 2 pertanyaan sekaligus dalam satu balon chat, mengajukan kurang dari 5 pertanyaan (terlalu dangkal dan malas), atau melampaui batas 10 pertanyaan pada sesi wawancara Tahap 2 maupun Tahap 4 (memicu kelelahan pengguna dan *analysis paralysis*).
- **Violating Specialist Squad Bounds**: Menjalankan 0 agen spesialis (hanya 3 agen inti tanpa spesialisasi) atau menjalankan lebih dari 3 agen spesialis (>6 total agen) yang mengakibatkan kebanjiran konteks (*context bloat*) dan pelanggaran batas kuota (*rate limit*).
- **Simulated Self-Interrogation (Wawancara Palsu / Halusinasi Mandiri)**: Mengisi sendiri tanya-jawab 5-Whys di dalam berkas dokumen tanpa pernah bertanya dan menunggu balasan pengguna di obrolan (*chat*).
- **Bypassing Council Grilling**: Menjalankan sidang dewan AI namun langsung menyimpulkan dan menulis dokumen sendiri tanpa membawa kritik dan titik buta dewan kepada pengguna di chat untuk diputuskan bersama.
- **Unbounded Web Search Avalanche**: Memberondong puluhan pencarian web tanpa batas yang memicu pemborosan token dan risiko rate limit, alih-alih memanfaatkan 1–2 pencarian terarah per sub-agen.
- **Unverified Hallucinated Problem**: Mengarang klaim masalah tanpa melampirkan bukti empiris atau riset web yang valid.
- **Narrow Tunnel Vision**: Merumuskan masalah hanya dari satu sudut pandang sempit tanpa validasi multi-agen paralel atau dewan AI.
- **Inconsistent Scope**: Menuliskan akar masalah yang bertentangan dengan daftar Non-Goals.
- **Langsung Melompat ke Solusi Koding**: Membicarakan stack database atau desain UI sebelum membuktikan bahwa masalah aslinya nyata.

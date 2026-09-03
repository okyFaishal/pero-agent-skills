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
- **Riset Multi-Dimensi Paralel**: **`REQUIRED SUB-SKILL`**: Gunakan `dispatching-parallel-agents` untuk mendelegasikan 3 sub-agen riset independen secara paralel (*Sub-agen 1: Analisis Pain Point Persona, Sub-agen 2: Studi Kasus Kompetitor & Industri, Sub-agen 3: Batasan Teknis & Regulasi*) guna memperluas cakupan konteks tanpa membebani context window tunggal.
- **Verifikasi Bukti Empiris & Sumber Valid**: **`REQUIRED SUB-SKILL`**: Gunakan `web-search` untuk menghimpun data statistik nyata, benchmark pasar, regulasi industri, dan studi kasus kegagalan/keberhasilan dengan sitasi URL valid (minimal 3 sumber resmi).
- **Musyawarah 5 Sudut Pandang AI**: **`REQUIRED / STRATEGIC SUB-SKILL`**: Gunakan `llm-council` untuk menguji rumusan masalah dari 5 perspektif ahli (*Product Strategist, Skeptic Auditor, Domain Specialist, Tech Feasibility, User Advocate*) melalui *blind peer-review* untuk membasmi bias sudut pandang sempit.
- **Wawancara Socratic & Stress-Test 2-Tahap**: **`REQUIRED SUB-SKILL`**: Gunakan `grilling` secara interaktif langsung kepada pengguna di chat dalam **2 ronde terpisah**:
  1. *Ronde 1 (Tahap 3)*: Membedah 5-Whys hingga ke akar terdalam (*root cause*).
  2. *Ronde 2 (Tahap 5)*: Menguji titik buta (*blind spots*), kritik tajam, dan dilema kompromi (*trade-offs*) hasil sidang Dewan AI (`llm-council`).
  Agent WAJIB menghentikan eksekusi (*pause*) pada setiap ronde dan menunggu respon pengguna. DILARANG mengarang atau mensimulasikan jawaban secara mandiri.
- **Audit Konsistensi Masalah Hulu**: **`SUPPORTING SUB-SKILL`**: Gunakan `pero-context-validation` untuk memastikan rumusan masalah tidak kontradiktif dengan batasan *Non-Goals* atau metrik dampak.
- **Pencatatan Keputusan Produk**: **`SUPPORTING SUB-SKILL`**: Gunakan `decision-recorder` untuk membukukan kesepakatan ruang lingkup ke `docs/decisions/PFDR-[YYYYMMDDHHmm].md`.

## When to Use
- Memulai proyek baru atau merancang fitur/kemampuan baru berskala besar.
- Pengguna memiliki ide konseptual yang masih samar, terlalu sempit, atau terlalu luas.
- Ingin membedah apakah keluhan pengguna adalah akar masalah atau hanya gejala permukaan dengan dukungan bukti empiris.
- Menghilangkan bias asumsi dan inkonsistensi sebelum masuk ke tahap pembuatan PRD (`pero-prd-writing`).

## The 6-Stage Problem Framing Framework

```
[1. 3-Track Discovery (DPA)] ──> [2. Empirical Evidence (Web Search)]
                                                  │
[4. AI Council Peer Review]  <── [3. 5-Whys Root Cause Grilling (User R1)]
              │
              ▼
[5. Council-Driven Grilling (User R2)] ──> [6. Boundaries (Non-Goals) & Metrics]
```

### 1. Pembedahan 3 Jalur Riset Paralel (via `dispatching-parallel-agents`)
- Mendelegasikan 3 sub-agen spesialis independen (*Sub-agen 1: Persona & Masalah Pengguna, Sub-agen 2: Riset Pasar & Kompetitor, Sub-agen 3: Batasan Kelayakan Teknis & Regulasi*) untuk mengumpulkan data multi-dimensi secara komprehensif.

### 2. Bukti Empiris Terverifikasi (via `web-search`)
- Menemukan minimal 3 sumber/referensi eksternal valid dengan URL aktif yang membuktikan bahwa masalah ini dialami oleh pengguna nyata di industri.

### 3. Diagnosa Akar Masalah (5-Whys & `grilling` - Ronde 1 Chat)
- **RAMBU HENTI WAJIB (MANDATORY PAUSE GATE - RONDE 1)**:
  - Agent **DILARANG** langsung membuat atau mengisi berkas `docs/ProblemFraming.md` sebelum melakukan wawancara langsung dengan pengguna di obrolan (*chat*).
  - Dilarang keras melakukan *self-answering* (mengarang dan mengisi sendiri jawaban 5-Whys tanpa dialog nyata dengan pengguna).
- **Protokol Wawancara Chat Ronde 1 (Interaktif)**:
  1. Sajikan 1–2 temuan awal dari riset web / bukti empiris sebagai pengantar konteks.
  2. Ajukan pertanyaan terarah 5-Whys kepada pengguna dengan menyertakan opsi konkret (A/B) dan rekomendasi teknis terbaik sesuai prinsip `grilling`.
  3. **Hentikan pemanggilan tools (STOP)** dan tunggu balasan dari pengguna di chat.
  4. Lanjutkan penggalian hingga akar terdalam (*root cause*) disepakati bersama oleh pengguna, bukan hasil tebakan AI.

### 4. Multi-Perspective Peer Review (via `llm-council`)
- Menyidangkan rumusan akar masalah ke 5 penasihat AI untuk membedah titik buta (*blind spots*), kontradiksi asumsi, risiko tersembunyi, dan argumen bantahan dari masing-masing persona ahli.

### 5. Stress-Test Hasil Dewan AI (Council-Driven Grilling via `grilling` - Ronde 2 Chat)
- **RAMBU HENTI WAJIB (MANDATORY PAUSE GATE - RONDE 2)**:
  - Agent **DILARANG** langsung mengunci batasan (*Non-Goals*) atau membuat dokumen akhir sebelum menghadapkan hasil kritik Dewan AI kepada pengguna di obrolan (*chat*).
  - Dilarang keras memutuskan kompromi (*trade-offs*) strategis secara sepihak tanpa mandat pengguna.
- **Protokol Wawancara Chat Ronde 2 (Interaktif)**:
  1. Rangkum kritik terpedas, risiko paling krusial, dan titik buta (*blind spots*) yang diangkat oleh 5 penasihat AI (terutama dari *Skeptic Auditor* dan *Tech Feasibility*).
  2. Hadapkan dilema tersebut kepada pengguna dalam format pertanyaan terstruktur:
     - Sajikan 2–3 opsi solusi/kompromi (Opsi A vs Opsi B) atas kritik dewan beserta trade-off masing-masing.
     - Berikan rekomendasi teknis AI yang paling kokoh.
  3. **Hentikan pemanggilan tools (STOP)** dan tunggu keputusan pengguna di chat.
  4. Jadikan pilihan pengguna sebagai ketetapan mutlak dalam merumuskan ruang lingkup dan batasan.

### 6. Pagar Batasan (Boundaries) & Metrik Keberhasilan
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
- **Decision Record**: [docs/decisions/PFDR-[YYYYMMDDHHmm].md](docs/decisions/PFDR-[YYYYMMDDHHmm].md)

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
5. *Mengapa [Jawaban 4] terjadi?* -> [Jawaban 5 (Akar Masalah Utama)]

## 4. Ruang Lingkup & Pagar Batasan (Boundaries)
- **Fokus Utama (In-Scope)**:
  - [Fokus 1]
  - [Fokus 2]
- **Bukan Sasaran / Dilarang (Non-Goals / Out-of-Scope)**:
  - [Non-Goal 1: Hal yang sengaja TIDAK akan dibuat sekarang]
  - [Non-Goal 2]

## 5. Bukti Empiris & Referensi Industri Terverifikasi
| No | Sumber / Publikasi | URL Referensi | Temuan Kunci / Fakta Empiris |
|:---|:---|:---|:---|
| 1 | [Nama Studi Kasus / Sumber] | `https://...` | [Fakta / Statistik Konkret] |
| 2 | [Laporan Riset Pasar / Standar] | `https://...` | [Temuan Kunci] |
| 3 | [Analisis Benchmark Kompetitor] | `https://...` | [Bukti Validasi] |

## 6. Ukuran Keberhasilan (Success Metrics)
- **Metrik Utama**: [Angka / Target Terukur, misal: Reduksi waktu kerja 80%]
- **Kondisi Selesai**: [Kriteria konkret saat masalah ini resmi teratasi]

## 7. Hasil Musyawarah Dewan AI & Keputusan Pengguna
- **Konsensus Definisi Masalah**: [Ringkasan kesepakatan 5 persona AI]
- **Titik Buta & Kritik Tajam Dewan**: [Blind spot dan risiko kritis yang diangkat persona dewan]
- **Keputusan Strategis Pengguna (Hasil Grilling R2)**: [Pilihan opsi dan arahan pengguna atas kritik dewan]
````

## Anti-Patterns & Common Mistakes
- **Simulated Self-Interrogation (Wawancara Palsu / Halusinasi Mandiri)**: Mengisi sendiri tanya-jawab 5-Whys di dalam berkas dokumen tanpa pernah bertanya dan menunggu balasan pengguna di obrolan (*chat*).
- **Bypassing Council Grilling**: Menjalankan sidang dewan AI namun langsung menyimpulkan dan menulis dokumen sendiri tanpa membawa kritik dan titik buta dewan kepada pengguna di chat untuk diputuskan bersama.
- **Unverified Hallucinated Problem**: Mengarang klaim masalah tanpa melampirkan bukti empiris atau riset web yang valid.
- **Narrow Tunnel Vision**: Merumuskan masalah hanya dari satu sudut pandang sempit tanpa validasi multi-agen paralel atau dewan AI.
- **Inconsistent Scope**: Menuliskan akar masalah yang bertentangan dengan daftar Non-Goals.
- **Langsung Melompat ke Solusi Koding**: Membicarakan stack database atau desain UI sebelum membuktikan bahwa masalah aslinya nyata.

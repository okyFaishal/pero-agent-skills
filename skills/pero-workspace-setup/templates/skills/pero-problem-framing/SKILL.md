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
- **Wawancara Terarah**: **`REQUIRED SUB-SKILL`**: Gunakan `grill-me` untuk memandu tanya-jawab satu per satu dengan opsi pilihan ganda dan analogi sederhana ("Bahasa Bayi").
- **Riset Pasar & Solusi Pembanding**: **`SUPPORTING SUB-SKILL`**: Gunakan `web-search` untuk memeriksa bagaimana masalah serupa diselesaikan di industri.
- **Pencatatan Keputusan Produk**: **`SUPPORTING SUB-SKILL`**: Gunakan `decision-recorder` untuk membukukan kesepakatan ruang lingkup ke `docs/decisions/PDR-[YYYYMMDDHHmm].md`.

## When to Use
- Memulai proyek baru atau merancang fitur/kemampuan baru berskala besar.
- Pengguna memiliki ide konseptual yang masih samar atau terlalu luas.
- Ingin membedah apakah keluhan pengguna adalah akar masalah atau hanya gejala permukaan.

## The 4-Pillar Problem Framing Workflow

```
[1. Deep Discovery & Pain Point] ──> [2. Root Cause Analysis (5-Whys)]
                                                    │
[4. Measurable Success Metrics]   <── [3. Boundary & Non-Goals] ────┘
```

### 1. Discovery & Pain Point Extraction (via `grill-me`)
- **Siapa yang Mengalami (Who)**: Target persona yang paling dirugikan jika masalah ini dibiarkan.
- **Kondisi Saat Ini (Current Workarounds)**: Bagaimana cara mereka mengakali masalah ini sekarang, dan kenapa cara lama tersebut melelahkan/tidak efisien?

### 2. Analisis Akar Masalah (5-Whys Root Cause)
- Tanyakan "Mengapa" berulang kali hingga menemukan sumber masalah utama, bukan hanya menambal gejala di permukaan.
- *Contoh Analogi*: Mobil mogok bukan karena "lampu indikator menyala" (gejala), tapi karena "oli mesin bocor dan habis" (akar masalah).

### 3. Pagar Batasan (In-Scope vs Out-of-Scope / Non-Goals)
- Tuliskan secara eksplisit apa yang **AKAN** dikerjakan (MVP problem) dan apa yang **DILARANG / TIDAK AKAN** disentuh pada tahap ini (mencegah *scope creep*).

### 4. Metrik Keberhasilan Terukur (Success Metrics)
- Tentukan indikator konkret kapan masalah ini dianggap berhasil diatasi (misal: "Waktu pencatatan data turun dari 15 menit ke 30 detik", "Tingkat error pengguna berkurang 90%").

## Deliverables & Output Artifacts

1. **Living Document**: `docs/ProblemFraming.md`
2. **Decision Record**: `docs/decisions/PDR-[YYYYMMDDHHmm].md`

---

## Template: `docs/ProblemFraming.md`

```markdown
# Problem Framing: [Nama Proyek / Fitur]

- **Tanggal**: [YYYY-MM-DD]
- **Status**: Tervalidasi (Validated)
- **Author / Lead**: Pero & Architect

## 1. Executive Problem Statement
[Jelaskan masalah inti dalam 1-2 kalimat tajam dan jelas menggunakan analogi sederhana]

## 2. Target Persona & Pain Points
- **Target Pengguna**: [Siapa yang mengalami masalah ini]
- **Cara Lama yang Melelahkan**: [Workaround saat ini dan letak kesulitannya]
- **Dampak Kerugian**: [Apa kerugian jika masalah ini diabaikan]

## 3. Root Cause Analysis (5-Whys)
1. *Mengapa masalah ini terjadi?* -> [Jawaban 1]
2. *Mengapa [Jawaban 1] terjadi?* -> [Jawaban 2]
3. *Mengapa [Jawaban 2] terjadi?* -> [Jawaban 3 (Akar Masalah Utama)]

## 4. Ruang Lingkup & Pagar Batasan (Boundaries)
- **Fokus Utama (In-Scope)**:
  - [Fokus 1]
  - [Fokus 2]
- **Bukan Sasaran / Dilarang (Non-Goals / Out-of-Scope)**:
  - [Non-Goal 1: Hal yang sengaja TIDAK akan dibuat sekarang]
  - [Non-Goal 2]

## 5. Ukuran Keberhasilan (Success Metrics)
- **Metrik Utama**: [Angka / Target Terukur]
- **Kondisi Selesai**: [Kriteria saat masalah ini resmi teratasi]
```

## Anti-Patterns & Common Mistakes
- **Langsung Melompat ke Solusi Koding**: Membicarakan database apa yang dipakai atau tombol warna apa yang dibuat sebelum membuktikan masalah aslinya.
- **Menganggap Gejala Sebagai Masalah**: Mengira user butuh tombol export Excel, padahal user cuma butuh ringkasan angka per minggu.
- **Lupa Menulis Non-Goals**: Tidak membuat daftar batasan, sehingga proyek melebar tanpa ujung.

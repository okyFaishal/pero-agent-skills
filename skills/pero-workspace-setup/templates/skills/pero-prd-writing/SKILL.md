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
- **Upstream Context Reader**: **`MANDATORY`**: Wajib membaca `docs/ProblemFraming.md` sebelum menyusun PRD agar ruang lingkup selaras dengan akar masalah.
- **Wawancara Prioritas Fitur**: **`REQUIRED SUB-SKILL`**: Gunakan `grill-me` untuk membedah prioritas fitur MVP (P0) vs Future (P1/P2) satu per satu dengan analogi ramah ("Bahasa Bayi").
- **Riset Standar Fungsionalitas**: **`SUPPORTING SUB-SKILL`**: Gunakan `web-search` jika perlu memvalidasi benchmark fitur sejenis di industri.
- **Pencatatan Keputusan PRD**: **`SUPPORTING SUB-SKILL`**: Gunakan `decision-recorder` untuk membukukan PRD ke `docs/decisions/PDR-[YYYYMMDDHHmm].md`.

## When to Use
- Mengubah ide masalah yang sudah tervalidasi di `ProblemFraming.md` menjadi spesifikasi kebutuhan produk.
- Menentukan daftar fitur minimum yang layak rilis (MVP) vs fitur tambahan.
- Merancang alur navigasi dan perjalanan pengguna (*user workflows / journey maps*).

## The 6-Section PRD Framework

```
[1. Vision & Executive Summary] ──> [2. Problem & Persona Baseline]
                                                   │
[4. User Journey & Workflows]   <── [3. Feature Scope Matrix (P0/P1/P2)]
              │
[5. Non-Functional Req (NFR)]   ──> [6. Measurable KPIs & Risk Matrix]
```

### 1. Vision & Executive Summary
- Rangkuman visi produk dalam 1-2 paragraf menggunakan analogi sederhana yang mudah dipahami orang awam.

### 2. Problem & Persona Baseline
- Mengutip pain point utama dan persona target dari `docs/ProblemFraming.md`.

### 3. Feature Scope Matrix (Piramida Prioritas)
- **P0 / MVP (Must-Have)**: Fitur wajib tanpa mana produk tidak ada gunanya.
- **P1 / Fast Follow (Should-Have)**: Fitur penting untuk rilis tahap kedua.
- **P2 / Future Enhancements (Nice-to-Have)**: Fitur impian jangka panjang.

### 4. Core User Workflows (Alur Perjalanan Pengguna)
- Langkah demi langkah dari pengguna membuka aplikasi hingga tujuannya tercapai.

### 5. Non-Functional Requirements (NFR Universal)
- **Performance**: Batas waktu respon (misal: `< 200ms` untuk API, `< 1s` untuk loading UI).
- **Reliability & Error Handling**: Penanganan offline, fallback, dan kestabilan.
- **Multi-Platform / Device**: Spesifikasi platform (Web responsive, iOS/Android, Desktop, Linux CLI).
- **Security & Privacy**: Proteksi data pengguna, enkripsi, dan sanitasi input.

### 6. Success Metrics & Risk Matrix
- Indikator keberhasilan kuantitatif (KPI) dan strategi mitigasi risiko produk/teknis.

## Deliverables & Output Artifacts

1. **Living Document**: `docs/PRD.md`
2. **Decision Record**: `docs/decisions/PDR-[YYYYMMDDHHmm].md`

---

## Template: `docs/PRD.md`

```markdown
# Product Requirements Document (PRD): [Nama Produk]

- **Versi**: 1.0 (MVP)
- **Status**: Disetujui (Approved)
- **Tanggal**: [YYYY-MM-DD]
- **Dokumen Induk**: [docs/ProblemFraming.md](file:///docs/ProblemFraming.md)

## 1. Executive Summary & Visi Produk
[Jelaskan visi produk dalam 1 paragraf dengan analogi sederhana]

## 2. Latar Belakang Masalah & Target Pengguna
- **Masalah Utama**: [Mengutip dari ProblemFraming.md]
- **Target Persona**: [Profil pengguna utama]

## 3. Matriks Cakupan Fitur (Feature Scope)
### 3.1. P0 — MVP (Wajib Ada di Rilis Pertama)
- [ ] **[Fitur 1]**: [Deskripsi singkat + Kriteria penerimaan dasar]
- [ ] **[Fitur 2]**: [Deskripsi singkat]

### 3.2. P1 — Fase Berikutnya (Should-Have)
- [ ] **[Fitur 3]**: [Deskripsi]

### 3.3. P2 — Masa Depan (Nice-to-Have)
- [ ] **[Fitur 4]**: [Deskripsi]

## 4. Alur Perjalanan Pengguna (User Workflows)
1. **Langkah 1 (Onboarding / Mulai)**: [Penjelasan alur]
2. **Langkah 2 (Aksi Utama)**: [Penjelasan alur]
3. **Langkah 3 (Penyelesaian & Output)**: [Penjelasan alur]

## 5. Kebutuhan Non-Fungsional (NFR)
- **Kecepatan (Performance)**: [Target latency / response time]
- **Kestabilan (Reliability)**: [Ketersediaan sistem, error handling]
- **Dukungan Platform**: [Web / Mobile / Backend / CLI]
- **Keamanan (Security)**: [Standar proteksi data]

## 6. Metrik Keberhasilan (KPIs) & Mitigasi Risiko
| Metrik / KPI | Target Kuantitatif | Cara Mengukur |
|---|---|---|
| [Nama Metrik] | [Target Angka] | [Alat Ukur] |

| Potensi Risiko | Dampak | Rencana Mitigasi / Pencegahan |
|---|---|---|
| [Risiko A] | Tinggi / Sedang | [Langkah pencegahan konkret] |
```

## Anti-Patterns & Common Mistakes
- **Memasukkan Semua Ide ke MVP (Scope Overload)**: Menjadikan 20 fitur sekaligus sebagai P0, sehingga MVP tidak pernah selesai.
- **Mengabaikan Problem Framing**: Menulis fitur yang tidak menjawab masalah inti di `ProblemFraming.md`.
- **Tidak Menyertakan Non-Functional Requirements**: Mengabaikan kecepatan, keamanan, dan error handling.

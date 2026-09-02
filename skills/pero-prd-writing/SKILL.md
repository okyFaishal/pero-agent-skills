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
- **Dekomposisi Riset Paralel Lintas Domain**: **`REQUIRED SUB-SKILL`**: Gunakan `dispatching-parallel-agents` untuk mendelegasikan 3 sub-agen spesialis secara paralel (*Sub-agen 1: User Workflows, Skenario & Edge Cases, Sub-agen 2: Non-Functional Requirements & Platform Standards, Sub-agen 3: MVP Feature Scope & P0/P1/P2 Matrix*) guna memperluas cakupan konteks dan mencegah titik buta spesifikasi.
- **Musyawarah Pemangkasan Scope & Trade-offs**: **`REQUIRED / STRATEGIC SUB-SKILL`**: Gunakan `llm-council` untuk menguji ketahanan matriks prioritas fitur P0 (Must-Have) vs P1 (Should-Have) vs P2 (Nice-to-Have) melalui sidang 5 persona AI, mencegah *scope creep*, dan memastikan MVP tetap ramping.
- **Wawancara Skenario Kritis & Edge Cases**: **`REQUIRED SUB-SKILL`**: Gunakan `grilling` untuk melakukan *stress-test* terhadap alur kerja pengguna (menggali skenario offline, error recovery, validasi input ekstrem, dan batas kegagalan sistem).
- **Audit Konsistensi Hulu-Hilir**: **`REQUIRED SUB-SKILL`**: Gunakan `pero-context-validation` untuk memverifikasi bahwa PRD 100% konsisten dengan `docs/ProblemFraming.md` sebelum disetujui.
- **Pencatatan Keputusan PRD**: **`SUPPORTING SUB-SKILL`**: Gunakan `decision-recorder` untuk membukukan kesepakatan PRD ke `docs/decisions/PDR-[YYYYMMDDHHmm].md`.

## When to Use
- Mengubah ide masalah yang sudah tervalidasi di `docs/ProblemFraming.md` menjadi spesifikasi kebutuhan produk yang terstruktur dan terukur.
- Menetapkan batas fitur minimum layak rilis (P0 MVP) secara ketat dan bebas dari pembengkakan (*anti-bloat*).
- Memetakan alur navigasi lengkap mencakup skenario sukses (*Happy Path*) dan skenario penanganan error (*Unhappy Path*).
- Menentukan spesifikasi non-fungsional (NFR) performa, reliabilitas, keamanan, dan kompatibilitas multi-device.

## The 6-Section PRD Framework

```
[1. Vision & Executive Summary] ──> [2. Problem & Persona Baseline (from ProblemFraming)]
                                                   │
[4. Workflows & Edge-Case Matrix] <── [3. Feature Scope Matrix (P0/P1/P2 via Council)]
              │
[5. Multi-Dimension NFR Matrix] ──> [6. KPIs, Risk Mitigation & Context Alignment Gate]
```

### 1. Vision & Executive Summary
- Rangkuman visi produk dalam 1-2 paragraf menggunakan bahasa sederhana (ELI5) yang mudah dipahami seluruh pemangku kepentingan.

### 2. Problem & Persona Baseline
- Mengutip pain point utama dan persona target dari `docs/ProblemFraming.md` sebagai landasan justifikasi setiap fitur.

### 3. Feature Scope Matrix (Piramida Prioritas via `llm-council`)
- **P0 / MVP (Must-Have)**: Fitur mutlak tanpa mana produk tidak dapat memecahkan akar masalah utama.
- **P1 / Fast Follow (Should-Have)**: Fitur penting untuk penyempurnaan di rilis tahap kedua.
- **P2 / Future Enhancements (Nice-to-Have)**: Fitur impian jangka panjang (tidak boleh menyandera rilis MVP).

### 4. Core User Workflows & Edge-Case Matrix
- Memetakan alur perjalanan pengguna secara komprehensif dari awal hingga akhir, mencakup skenario normal (*Happy Path*), skenario gagal (*Unhappy Path*), dan mekanisme pemulihan (*Error Recovery*).

### 5. Multi-Dimension Non-Functional Requirements (NFR)
- **Performance**: Batas waktu respon latency (misal: API `< 200ms`, rendering UI `< 1s`).
- **Reliability & Resilience**: Ketersediaan target (99.9%), penanganan mode offline, dan fallback sistem.
- **Multi-Platform & Responsive**: Batasan device (Web modern, iOS/Android, Desktop, atau CLI).
- **Security & Privacy**: Enkripsi at-rest/in-transit, proteksi privasi pengguna, dan sanitasi input.

### 6. KPIs, Risk Mitigation & Context Alignment Gate
- Indikator keberhasilan kuantitatif (KPI) yang sinkron dengan metrik sukses di Problem Framing, mitigasi risiko teknis/produk, serta hasil audit kepatuhan non-goals.

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
[Jelaskan visi produk dalam 1 paragraf dengan analogi sederhana (ELI5)]

## 2. Latar Belakang Masalah & Target Pengguna
- **Masalah Utama**: [Mengutip langsung dari ProblemFraming.md]
- **Target Persona**: [Profil pengguna utama dan cara kerja saat ini]

## 3. Matriks Cakupan Fitur (Feature Scope Matrix)
### 3.1. P0 — MVP (Wajib Ada di Rilis Pertama)
| ID | Fitur | Deskripsi Singkat | Kriteria Penerimaan Dasar (Acceptance Criteria) |
|:---|:---|:---|:---|
| F-01 | [Nama Fitur 1] | [Fungsi inti] | [Kondisi sukses minimal] |
| F-02 | [Nama Fitur 2] | [Fungsi inti] | [Kondisi sukses minimal] |

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

## 7. Hasil Validasi Konsistensi Hulu (Context Alignment Gate)
- **Kesesuaian Masalah Inti**: [✓] 100% Fitur P0 menjawab akar masalah di `ProblemFraming.md`.
- **Kepatuhan Batasan Non-Goals**: [✓] Tidak ada fitur yang melanggar daftar *Non-Goals* Tahap 1.
- **Konsensus Sidang Dewan AI**: [Ringkasan keputusan pemangkasan scope oleh llm-council].
```

## Anti-Patterns & Common Mistakes
- **Scope Overload / P0 Bloat**: Memasukkan terlalu banyak fitur ke dalam P0 tanpa sidang pemangkasan dewan, sehingga MVP gagal rilis tepat waktu.
- **Mengabaikan Batasan Non-Goals**: Menyelipkan fitur yang sudah secara eksplisit dilarang di `ProblemFraming.md`.
- **Happy Path Bias (Dead-End Workflows)**: Hanya merancang alur sukses tanpa memetakan skenario gagal, timeout, atau pemulihan error.
- **NFR Mengambang Tanpa Angka**: Menulis "sistem harus cepat dan aman" tanpa target kuantitatif (angka latency atau standar enkripsi).

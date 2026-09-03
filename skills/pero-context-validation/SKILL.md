---
name: pero-context-validation
description: Use when validating cross-document consistency, detecting documentation drift, verifying Mermaid diagrams, or preventing specification regressions across docs/
---

# Pero Context & Living Document Validation (`pero:context-validation`)

## Overview
**Origin**: *Pero Custom SDLC Pipeline - Stage 8 (Universal - Capstone)*.
Skill ini bertindak sebagai **"Petugas Sensor Alarm & Menara Pengawas Garis Start (*Pre-Flight Safety Officer*)"** (Mencocokkan seluruh baut dan kabel di buku manual pesawat terhadap mesin fisik di landasan sebelum izin terbang diberikan). 

Tugasnya adalah mengaudit dan memverifikasi konsistensi silang 100% di antara seluruh dokumen artefak proyek (`docs/ProblemFraming.md`, `docs/PRD.md`, `docs/SystemSpec.md`, `docs/Architecture.md`, `docs/Governance.md`, `docs/TaskBacklog.md`, `docs/tasks/`, dan `docs/decisions/`), mendeteksi dokumen usang (*documentation drift*), memvalidasi sintaksis diagram Mermaid, mengklasifikasikan tingkat keparahan anomali (*severity tiers*), dan memberikan gerbang keputusan akhir apakah proyek diizinkan melangkah ke tahap koding TDD massal (**Go / No-Go Decision**).

## Sub-Skill Integration (Perkakas Pendukung)
Dalam menjalankan validasi konteks dan dokumen hidup, agent WAJIB mengorkestrasi sub-skill berikut:
- **Upstream Context Reader**: **`MANDATORY`**: Wajib membaca seluruh dokumen artefak repositori (`docs/ProblemFraming.md`, `docs/PRD.md`, `docs/SystemSpec.md`, `docs/Architecture.md`, `docs/Governance.md`, `docs/TaskBacklog.md`, kartu tugas di `docs/tasks/`, dan seluruh rekam keputusan di `docs/decisions/`) untuk mendeteksi kontradiksi, celah kepatuhan, atau spesifikasi yang tertinggal.
- **Dekomposisi Riset 5 Spesialis Validasi Konteks Tetap (*Fixed Validation Squad*)**: **`REQUIRED SUB-SKILL`**: Gunakan `dispatching-parallel-agents` untuk mendelegasikan tim beranggotakan **5 Agen Spesialis Validasi Konteks Tetap** secara paralel yang masing-masing dibekali alat `context-7` dan `web-search`. Setiap spesialis wajib melakukan evaluasi relevansi awal (*Relevance Pre-Flight Check*). Jika ada validasi standar eksternal (misal sintaksis Mermaid modern atau parser Markdown), agen dibatasi **minimal 2 dan maksimal 5 pencarian terarah**. Jika audit murni internal terhadap file lokal, agen wajib mendeklarasikan *Early-Exit* (`N/A: Internal Audit Only`) dan dilarang melakukan pencarian web.
- **Musyawarah Dewan Audit Mutu & Keabsahan Sistem**: **`REQUIRED / STRATEGIC SUB-SKILL`**: Gunakan `llm-council` untuk menyidangkan anomali dokumen, klasifikasi keparahan drift (Critical Blocker vs Warning), dan kompromi rekonsiliasi spesifikasi melalui 5 persona AI.
- **Wawancara Penguncian Laporan Validasi di Chat**: **`REQUIRED SUB-SKILL`**: Gunakan `grilling` secara interaktif langsung kepada pengguna di chat dengan batas **minimal 5 dan maksimal 10 pertanyaan** bertahap (1–2 pertanyaan per putaran) untuk menyidangkan temuan anomali, rencana aksi perbaikan cascade, dan mengunci keputusan akhir **Go / No-Go**. Agent WAJIB menghentikan eksekusi (*pause*) dan menunggu respon pengguna. DILARANG menentukan kelulusan audit (*PASS*) secara sepihak (*anti-rubber-stamping*).
- **Sinkronisasi Dokumentasi Hidup**: **`REQUIRED SUB-SKILL`**: Gunakan `living-doc-sync` untuk menyelaraskan diagram Mermaid, denah sistem, dan struktur direktori saat terdeteksi drift minor atau setelah pemulihan cascade.
- **Audit Kualitas & Kepatuhan Spesifikasi**: **`REQUIRED SUB-SKILL`**: Gunakan `code-reviewer` untuk melakukan inspeksi kepatuhan spesifikasi tingkat tinggi (*spec compliance audit*) terhadap kartu tugas dan arsitektur.
- **Validasi Skema Data & Kontrak**: **`SUPPORTING SUB-SKILL`**: Gunakan `schema-validator` untuk memastikan struktur data payload, DTO, dan JSON schema selaras antara SystemSpec, Architecture, dan TaskBacklog.
- **Penegakan Kode Bersih & Efisiensi Spesifikasi**: **`SUPPORTING SUB-SKILL`**: Gunakan `anti-slop` untuk mendeteksi over-engineering (YAGNI), memangkas dokumentasi basa-basi, dan memastikan tidak ada mock palsu di spesifikasi.
- **Proteksi Perimeter Keamanan**: **`SUPPORTING SUB-SKILL`**: Gunakan `env-guard` untuk memvalidasi bahwa seluruh aturan perlindungan rahasia terdefinisi tanpa kebocoran kredensial di contoh payload atau fixtures.
- **Penegak Disiplin Pengujian TDD**: **`SUPPORTING SUB-SKILL`**: Gunakan `test-driven-development` untuk memvalidasi bahwa setiap tugas memiliki rancangan failing test (*Red spec*) yang terdefinisi.
- **Verifikasi Bukti Eksekusi Terminal**: **`SUPPORTING SUB-SKILL`**: Gunakan `verification-before-completion` untuk memverifikasi bahwa seluruh perintah pengujian terminal pada kartu tugas dapat dieksekusi dengan kriteria lulus `exit code 0`.
- **Pencatatan Keputusan Validasi Konteks**: **`SUPPORTING SUB-SKILL`**: Gunakan `decision-recorder` untuk membukukan keputusan audit, rekonsiliasi drift, dan status kelulusan ke `docs/decisions/VDR-[YYYYMMDDHHmm].md` menggunakan template standar resmi.

## The 5-Stage Context Validation Framework

```
[0. Ingestion seluruh berkas di docs/ & docs/decisions/]
                           │
                           ▼
[1. Audit Paralel 5 Spesialis Validasi Konteks Tetap]
    (Product/Phantom, Architecture/Mermaid, Governance, Backlog, Decisions)
                           │
                           ▼
[2. Sidang Dewan Audit Mutu & Keabsahan Sistem (LLM Council)]
    (5 Persona AI menguji: Severity Tiers, Blocker Reconciliation, Trade-offs)
                           │
                           ▼
[3. Wawancara Penguncian Validasi di Chat (Grilling Rambu Henti)]
    (Min 5, Max 10 Tanya: konfirmasi anomali, cascade update, Go/No-Go decision)
                           │
                           ▼
[4. Penyusunan Dokumen docs/ValidationReport.md Formal]
    (Matriks 7-Arah, Mermaid Health, Anomali Matrix, Verdict Status)
                           │
                           ▼
[5. Pembukuan Rekam Keputusan VDR Formal & Penyelarasan Dokumen Hidup]
```

### 1. Dekomposisi Audit Paralel Berbasis 5 Spesialis Validasi Tetap
Mendelegasikan tim 5 agen spesialis audit tetap via `dispatching-parallel-agents`:

#### A. 5 Peran Spesialis Validasi Konteks Tetap (*Fixed Validation Roles*):
1. **Spesialis 1: Audit Penyelarasan Kebutuhan & Fitur Siluman (*Product & Requirement Traceability Specialist*)**:
   - *Fokus*: Memeriksa alur `ProblemFraming.md` $\rightarrow$ `PRD.md` $\rightarrow$ `SystemSpec.md`.
   - *Misi*: Mendeteksi *Phantom Features* (fitur di PRD/Spec tanpa akar masalah di Framing) dan *Orphaned Pain Points* (masalah pengguna yang tidak tersentuh fitur P0/MVP).
2. **Spesialis 2: Audit Integritas Arsitektur & Denah Diagram (*Architecture, Contracts & Mermaid Specialist*)**:
   - *Fokus*: Memeriksa alur `SystemSpec.md` (Domain Entities & Contracts) $\rightarrow$ `Architecture.md` (C4 Models, Clean Architecture, Tech Stack).
   - *Misi*: Memvalidasi kelengkapan modul per entitas, kesesuaian envelope respons, serta audit sintaksis diagram Mermaid di seluruh repositori.
3. **Spesialis 3: Audit Kepatuhan Tata Kelola & Keamanan (*Governance, Concurrency & Security Specialist*)**:
   - *Fokus*: Memeriksa alur `Architecture.md` $\rightarrow$ `Governance.md`.
   - *Misi*: Memverifikasi model konkurensi (Actor/Mutex/Channel), aturan thread-safety, protokol proteksi kredensial `env-guard`, protokol anti-slop, dan aturan lockfile / supply chain security.
4. **Spesialis 4: Audit Kelengkapan Backlog & Cakupan Tugas (*Task Backlog & Coverage Specialist*)**:
   - *Fokus*: Memeriksa alur `PRD.md` (P0/P1) + `SystemSpec.md` (Gherkin stories) $\rightarrow$ `TaskBacklog.md` $\rightarrow$ `docs/tasks/`.
   - *Misi*: Menegakkan *100% Backlog Coverage* (tidak boleh ada user story yang tidak memiliki kartu tugas), memeriksa batasan ukuran tugas (S/M), `Depends On`, dan `Parallel Safe`.
5. **Spesialis 5: Audit Sinkronisasi Keputusan (*Decision Records & 8-Stage Integrity Specialist*)**:
   - *Fokus*: Memeriksa seluruh berkas di `docs/decisions/` (`PFDR`, `PDR`, `SDR`, `ADR`, `GDR`, `TDR`, `RDR`, `VDR`).
   - *Misi*: Memastikan setiap keputusan arsitektur/tata kelola terdokumentasi rapi, tidak ada kontradiksi antar keputusan, dan status keputusan (*Accepted vs Superseded*) konsisten.

#### B. Mekanisme Evaluasi Relevansi Awal & Pintu Keluar Dini (*Relevance Pre-Flight Check & Early Exit*):
- Setiap spesialis membaca dokumen target sebelum menjalankan audit.
- Jika dokumen atau domain tidak ada di repositori (misalnya: Spesialis 2 memeriksa diagram Mermaid pada proyek yang tidak menggunakan diagram visual sama sekali):
  - Spesialis **WAJIB** mendeklarasikan: `Status: Not Applicable (N/A). Alasan: [Penjelasan ketiadaan elemen visual]`.
  - Agen berstatus `N/A` **DILARANG melakukan pencarian (0 search)** dan **DILARANG mengarang laporan kelulusan palsu**.

#### C. Pagar Batas Audit & Pencarian (*Guardrails*):
- Untuk audit murni dokumen internal: **0 pencarian web** (cukup membaca file lokal).
- Jika memerlukan validasi spesifikasi Mermaid terbaru atau parser skema: **Minimal 2 dan Maksimal 5 pencarian terarah** per agen.

### 2. Musyawarah Dewan Audit Mutu & Keabsahan Sistem (via `llm-council`)
- Menyidangkan seluruh temuan anomali ke 5 persona dewan AI (*Product Strategist, Skeptic Auditor, Domain Specialist, Tech Feasibility, User Advocate*).
- Topik sidang:
  - Mengklasifikasikan anomali ke dalam 3 Tingkat Keparahan (*Critical Blocker*, *Warning*, atau *Info*).
  - Menyidangkan trade-off rekonsiliasi: jika PRD dan Arsitektur berselisih, dokumen mana yang harus disesuaikan?
  - Menilai kesiapan sistem untuk memulai tahap implementasi koding TDD massal.
- Dewan menghasilkan sintesis konsensus dan rekomendasi teknis (Opsi A vs Opsi B) untuk diserahkan ke sesi wawancara chat.

### 3. Wawancara Penguncian Laporan Validasi di Chat (via `grilling`)
- **RAMBU HENTI WAJIB (MANDATORY PAUSE GATE)**:
  - Agent **DILARANG** langsung menetapkan status kelulusan (*PASS*) atau mengizinkan fase koding dimulai sebelum menyidangkan temuan anomali, rencana aksi perbaikan cascade, dan mengunci keputusan **Go / No-Go** bersama pengguna di obrolan (*chat*).
  - Dilarang keras melakukan *rubber-stamping* (memberi stempel hijau tanpa konfirmasi pengguna).
- **Pagar Batas Pertanyaan (Volume & Delivery Guardrails)**:
  - **Batas Kuantitas**: Sesi wawancara dibatasi **minimal 5 pertanyaan** (untuk menguji seluruh temuan audit dan konsistensi) dan **maksimal 10 pertanyaan** (mencegah kelelahan pengguna).
  - **Penyampaian Bertahap (*Anti-Question Avalanche*)**: DILARANG memberondong pertanyaan sekaligus. Ajukan 1–2 pertanyaan per putaran chat dengan opsi konkret (Opsi A vs Opsi B) dan rekomendasi teknis AI.
- **Fokus Topik Wawancara**:
  1. Penanganan Fitur Siluman / Orphaned Features (Apakah dihapus dari backlog atau dimasukkan ke PRD).
  2. Tindakan terhadap Ketidakcocokan Model Data (SystemSpec vs Architecture DDL).
  3. Kebijakan terhadap Warning Tata Kelola (Apakah strict zero-warning atau toleransi bersyarat).
  4. Rencana Aksi Pemulihan Cascade Drift (*Cascade Update Plan*).
  5. Keputusan Akhir Kesiapan Eksekusi Koding (**Go / No-Go Decision**).
- **Hentikan pemanggilan tools (STOP)** dan tunggu keputusan pengguna di chat pada setiap putaran.

### 4. Penyusunan Dokumen ValidationReport.md Formal
- Menyusun laporan audit komprehensif di `docs/ValidationReport.md` mematuhi **Matriks Ketertelusuran 7-Arah**, audit diagram Mermaid, tabel matriks anomali dengan 3 tingkat keparahan, dan vonis akhir kelulusan.

### 5. Pembukuan Rekam Keputusan VDR Formal & Penyelarasan Dokumen Hidup
- Membukukan keputusan audit dan status kesiapan ke `docs/decisions/VDR-[YYYYMMDDHHmm].md` (*Validation Decision Record*) menggunakan template standar resmi.
- Menjalankan `living-doc-sync` untuk menyelaraskan dokumen jika ada perubahan minor yang disepakati pengguna.

## When to Use
- Setelah menyelesaikan penyusunan seluruh dokumen hulu sebelum tim mulai mengeksekusi koding massal.
- Setiap kali terjadi perubahan kebutuhan (*requirement change*) di PRD atau Arsitektur untuk memastikan perubahan merambat rapi (*cascade update*) ke daftar tugas.
- Sebelum perilisan milestone besar untuk memastikan tidak ada fitur siluman (*phantom features*) atau tugas yang tertinggal (*orphaned tasks*).
- Memverifikasi apakah semua blok diagram Mermaid bebas dari kesalahan sintaksis.

## Deliverables & Output Artifacts

1. **Living Document**: `docs/ValidationReport.md`
2. **Decision Record**: `docs/decisions/VDR-[YYYYMMDDHHmm].md`

---

## The 7 Cross-Document Integrity Rules (7-Way Traceability Matrix)

```
[ProblemFraming.md] ──(1. Pain Point Match)──> [PRD.md]
                                                   │
                                            (2. Story & Contract Match)
                                                   ▼
[Architecture.md]   <──(3. Component Match)─── [SystemSpec.md]
        │
 (4. Rule & Concurrency Match)
        ▼
[Governance.md]     ──(5. Actionable Tasks)──> [TaskBacklog.md]
                                                       │
                                            (6. Granular Refinement)
                                                       ▼
[docs/decisions/*]  <──(7. Decision Track)──── [TASK-[ID].md Cards]
```

### 1. Problem-to-PRD Alignment (Rule 1)
- Setiap fitur **P0 (MVP)** di `docs/PRD.md` wajib memiliki akar masalah yang jelas di `docs/ProblemFraming.md`.
- Fitur yang tidak menjawab pain point apa pun dianggap sebagai pelanggaran YAGNI (*Phantom Feature*) dan wajib dieliminasi atau direklasifikasi.

### 2. PRD-to-SystemSpec Alignment (Rule 2)
- Setiap fitur di `docs/PRD.md` wajib dijabarkan menjadi minimal satu *User Story* dengan kriteria penerimaan format Gherkin (`Given`, `When`, `Then`) di `docs/SystemSpec.md`.
- Endpoint API, parameter input, dan pesan webhook di `SystemSpec.md` wajib mencerminkan kebutuhan interaksi pengguna di PRD.

### 3. SystemSpec-to-Architecture Alignment (Rule 3)
- Semua entitas domain, atribut data unik/terindeks, dan kontrak API di `docs/SystemSpec.md` wajib memiliki modul pemilik, skema tabel/DDL, dan alur konkurensi yang jelas di `docs/Architecture.md`.
- Alur data (*data flow*) pada diagram arsitektur wajib mencakup seluruh skenario interaksi sistem.

### 4. Architecture-to-Governance Alignment (Rule 4)
- Pilihan teknologi, model thread/actor, dan batasan memori di `docs/Architecture.md` wajib tunduk pada aturan ketat di `docs/Governance.md`.
- Setiap komponen yang menangani data sensitif wajib mematuhi standar enkripsi PII, penyensoran log otomatis (*log redaction*), dan disiplin lockfile `env-guard`.

### 5. Architecture/Governance-to-TaskBacklog Alignment (Rule 5)
- Seluruh modul di `docs/Architecture.md` wajib memiliki kartu tugas konkret yang dapat dieksekusi di `docs/TaskBacklog.md` (*100% Backlog Coverage*).
- Setiap kartu tugas wajib memiliki ukuran kompleksitas (S/M), batasan dependensi (`Depends On`), status keamanan paralel (`Parallel Safe`), dan perintah verifikasi terminal 0-failure.

### 6. TaskBacklog-to-GranularRefinement Alignment (Rule 6)
- Setiap kartu tugas makro yang siap dieksekusi wajib dipertajam menjadi kartu tugas granular di `docs/tasks/TASK-[ID].md` yang mematuhi **7 Anatomi Presisi** (termasuk pre/post-conditions dan blast radius).

### 7. Cross-Cutting-to-DecisionRecords Alignment (Rule 7)
- Setiap keputusan penting di seluruh 8 tahap (PFDR di Framing, PDR di PRD, SDR di Spec, ADR di Architecture, GDR di Governance, TDR di Backlog, RDR di Refinement, dan VDR di Validation) wajib terdokumentasi rapi di `docs/decisions/` tanpa ada kontradiksi status (*Accepted vs Superseded*).

---

## 3 Tingkat Keparahan Anomali (*Drift Severity Tiers*)

Setiap temuan anomali atau drift diklasifikasikan ke dalam 3 tier keparahan:

| Tingkat Keparahan | Kriteria Dampak | Status Gerbang Rilis | Contoh Temuan |
|:---|:---|:---|:---|
| 🔴 **CRITICAL (Blocker)** | Merusak integritas sistem, celah keamanan fatal, atau menghentikan alur kerja | **NO-GO (Koding Dilarang Dimulai)** | Endpoint di spec tanpa modul arsitektur; Kunci rahasia bocor di commit; Fitur P0 PRD tidak ada di TaskBacklog; Diagram Mermaid error fatal. |
| 🟡 **WARNING (High Attention)** | Inkonsistensi non-fatal yang berisiko memicu utang teknis jika diabaikan | **CONDITIONAL GO (Butuh Batas Waktu)** | Atribut tipe data berbeda nama; Tugas backlog belum diberi ukuran S/M; Keputusan arsitektur belum dibukukan ke ADR. |
| 🟢 **INFO (Polishing)** | Saran peningkatan keterbacaan atau perapian kosmetik | **GO (Diizinkan Lanjut)** | Tipografi label diagram Mermaid; Perapian format tabel markdown; Penambahan komentar penjelas. |

---

## Stale Cascade Detection & Recovery Protocol

Ketika terjadi perubahan di salah satu dokumen hulu (misal: penambahan fitur di PRD atau pergantian database di Architecture):
1. **Identifikasi Titik Perubahan (*Change Origin*)**: Temukan dokumen paling hulu yang berubah.
2. **Telusuri Rantai Ketergantungan Hilir (*Trace Downward*)**:
   - Jika `PRD` berubah $\rightarrow$ Perbarui `SystemSpec` $\rightarrow$ Perbarui `Architecture` $\rightarrow$ Perbarui `TaskBacklog` $\rightarrow$ Perbarui `TASK-[ID].md`.
   - Jika `Architecture` berubah $\rightarrow$ Perbarui `Governance` $\rightarrow$ Perbarui `TaskBacklog` $\rightarrow$ Perbarui `TASK-[ID].md`.
3. **Catat Keputusan Baru**: Gunakan `decision-recorder` untuk membuat ADR/GDR/TDR baru yang mencatat alasan teknis perubahan.
4. **Verifikasi Ulang**: Jalankan audit validasi konteks ulang untuk memastikan seluruh dokumen hilir kembali 100% sinkron (*zero drift*).

---

## Audit Sintaksis Diagram Mermaid

Agent wajib memeriksa setiap blok diagram ````mermaid```` di seluruh repositori:
- **Tanda Kutip Label Khusus**: Node label yang mengandung spasi, tanda kurung `()`, kurung siku `[]`, atau karakter khusus WAJIB diapit tanda kutip ganda (contoh: `nodeA["Payment Gateway (Stripe)"]`).
- **Bebas HTML Mentah**: Dilarang menggunakan tag HTML mentah seperti `<br>`, `<b>`, atau `<div>` di dalam label node diagram.
- **Arah Diagram Valid**: Menetapkan arah yang valid (`graph TD`, `graph LR`, `sequenceDiagram`, `erDiagram`).
- **Referensi Node Konsisten**: Pastikan relasi panah (`-->`, `-.->`, `==>`) menghubungkan ID node yang benar-benar terdefinisi.

---

## Template: `docs/ValidationReport.md`

````markdown
# Context Validation Report: [Nama Sistem / Proyek]

- **Versi Laporan**: 1.0
- **Tanggal Audit**: [YYYY-MM-DD]
- **Auditor**: Pero Context Validator Squad
- **Status Keseluruhan**: [🔴 NO-GO (Blocker) / 🟡 CONDITIONAL GO / 🟢 PASS (Go)]
- **Decision Record**: [docs/decisions/VDR-[YYYYMMDDHHmm].md](decisions/VDR-[YYYYMMDDHHmm].md)

## 1. 7-Way Traceability & Alignment Matrix

| Aturan Ketertelusuran | Rantai Dokumen | Status Audit | Catatan Temuan |
|:---|:---|:---|:---|
| **Rule 1: Problem -> PRD** | `ProblemFraming` $\rightarrow$ `PRD` | [✓ PASS / ⚠️ WARN / ❌ FAIL] | [Catatan keselarasan pain point & fitur MVP] |
| **Rule 2: PRD -> SystemSpec** | `PRD` $\rightarrow$ `SystemSpec` | [✓ PASS / ⚠️ WARN / ❌ FAIL] | [Catatan kriteria Gherkin & kontrak payload] |
| **Rule 3: SystemSpec -> Architecture** | `SystemSpec` $\rightarrow$ `Architecture` | [✓ PASS / ⚠️ WARN / ❌ FAIL] | [Catatan kepemilikan entitas & C4 diagram] |
| **Rule 4: Architecture -> Governance** | `Architecture` $\rightarrow$ `Governance` | [✓ PASS / ⚠️ WARN / ❌ FAIL] | [Catatan model konkurensi & supply chain security] |
| **Rule 5: Architecture -> TaskBacklog** | `Architecture` $\rightarrow$ `TaskBacklog` | [✓ PASS / ⚠️ WARN / ❌ FAIL] | [Catatan 100% Backlog Coverage & ukuran S/M] |
| **Rule 6: TaskBacklog -> GranularRefinement**| `TaskBacklog` $\rightarrow$ `TASK-[ID]` | [✓ PASS / ⚠️ WARN / ❌ FAIL] | [Catatan 7 Anatomi Presisi & TDD Red Spec] |
| **Rule 7: Cross-Cutting -> DecisionRecords** | `All Docs` $\rightarrow$ `decisions/` | [✓ PASS / ⚠️ WARN / ❌ FAIL] | [Catatan kelengkapan PFDR, PDR, SDR, ADR, GDR, TDR, RDR, VDR] |

## 2. Mermaid Diagrams Health Check

| Dokumen Sumber | Tipe Diagram | Status Sintaksis | Hasil Inspeksi |
|:---|:---|:---|:---|
| `docs/SystemSpec.md` | ERD / State Diagram | [✓ Valid / ❌ Error] | Bebas tag HTML, label diapit tanda kutip |
| `docs/Architecture.md` | C4 Context / Container | [✓ Valid / ❌ Error] | Hubungan antar node konsisten |

## 3. Matriks Temuan Anomali & Tingkat Keparahan (*Drift Severity Matrix*)

| ID Anomali | Dokumen Terdampak | Tingkat Keparahan | Deskripsi Masalah | Rekomendasi Rencana Aksi Pemulihan |
|:---|:---|:---|:---|:---|
| `ANOM-01` | `PRD.md` vs `TaskBacklog.md` | 🔴 CRITICAL | [e.g. Fitur P0 Notifikasi Pembayaran tidak memiliki task di Backlog] | [Tambahkan Task 3.4 di Phase 3 Backlog] |
| `ANOM-02` | `SystemSpec.md` vs `Architecture.md` | 🟡 WARNING | [e.g. Tipe data idempotencyKey belum tercantum di skema DDL] | [Perbarui kolom DDL di Architecture.md] |
| `ANOM-03` | `Architecture.md` | 🟢 INFO | [e.g. Label node diagram C4 Container dapat diperjelas] | [Perbarui teks diagram via living-doc-sync] |

## 4. Rencana Aksi Pemulihan Cascade (*Cascade Update Plan*)
1. [Langkah 1: Perbaikan dokumen hulu]
2. [Langkah 2: Sinkronisasi dokumen hilir]
3. [Langkah 3: Pembuatan ADR/VDR baru]

## 5. Keputusan Akhir Kesiapan Eksekusi (Go / No-Go Verdict)
- **Vonis Akhir**: **[🟢 GO: PROYEK SIAP DIKODING / 🔴 NO-GO: BLOCKED]**
- **Justifikasi**: [Ringkasan mengapa proyek dinyatakan siap atau harus memperbaiki blocker terlebih dahulu].
````

---

## Template: `docs/decisions/VDR-[YYYYMMDDHHmm].md`

````markdown
# VDR-[Nomor]: [Judul Keputusan Validasi Konteks, misal: Persetujuan Hasil Validasi Konteks & Pemberian Izin Go Eksekusi TDD]

- **Status**: Diterima (Accepted) / Ditinjau (Proposed) / Digantikan (Superseded)
- **Tanggal**: [YYYY-MM-DD]
- **Pengambil Keputusan**: Pengguna & Tim Validasi Konteks AI
- **Dokumen Terkait**: [docs/ValidationReport.md](../ValidationReport.md)

## 1. Konteks & Ruang Lingkup Audit
[Jelaskan latar belakang pelaksanaan audit validasi konteks dan dokumen mana saja yang diperiksa].

## 2. Vonis Kelulusan & Rekonsiliasi yang Ditetapkan
[Jelaskan vonis kelulusan (Go / No-Go), rekonsiliasi anomali yang disepakati bersama pengguna di chat, dan penanganan fitur siluman].

## 3. Alternatif Vonis yang Ditolak
| Alternatif Vonis | Alasan Penolakan |
|:---|:---|
| [Alternatif 1: Go Langsung tanpa perbaikan] | [Mengapa ditolak / risiko bug fatal dan deviasi arsitektur di produksi] |
| [Alternatif 2: No-Go Total untuk anomali minor] | [Mengapa ditolak / menghambat kecepatan rilis secara tidak perlu] |

## 4. Konsekuensi Positif & Beban Operasional (Trade-offs)
- **Konsekuensi Positif**: [100% konsistensi hulu-ke-hilir, nol fitur siluman, koding TDD berjalan mulus tanpa hambatan]
- **Beban Operasional**: [Perlu waktu ekstra untuk sinkronisasi cascade sebelum penulisan kode dimulai]
- **Strategi Mitigasi / Otomatisasi**: [Bagaimana beban tersebut diringankan via living-doc-sync dan verifikasi otomatis]

## 5. Prasyarat Eksekusi Tahap Koding (Execution Prerequisites)
[Daftar syarat mutlak yang harus dipenuhi developer/subagent sebelum mulai menulis baris kode pertama].
````

## Anti-Patterns & Common Mistakes
- **Rubber-Stamp Validation (Sycophantic PASS)**: Memberikan stempel kelulusan (*PASS*) secara terburu-buru hanya demi menyenangkan pengguna tanpa membaca dan memeriksa inkonsistensi dokumen secara kritis.
- **Simulated Validation Deciding**: Menentukan sendiri vonis kelulusan (*Go / No-Go*) atau menghapus anomali dokumen tanpa pernah melakukan wawancara grilling di chat bersama pengguna.
- **Phantom Features Allowed**: Membiarkan tugas di `TaskBacklog.md` yang sama sekali tidak memiliki dasar kebutuhan di `PRD.md` atau `ProblemFraming.md`.
- **Broken Mermaid Blindness**: Meloloskan diagram Mermaid yang memiliki kesalahan sintaksis atau karakter khusus yang tidak dikutip, sehingga diagram gagal di-render di Markdown viewer.
- **Untracked Drift (Missing Cascade Updates)**: Memperbaiki salah satu dokumen (misal mengganti nama tabel di Architecture) tanpa menyinkronkan dokumen hilirnya (SystemSpec, TaskBacklog, dan kartu tugas).
- **Ignoring Critical Blockers**: Memaksakan tim mulai koding padahal masih ada anomali berstatus 🔴 CRITICAL.
- **Question Avalanche or Premature Cessation**: Mengirimkan lebih dari 2 pertanyaan per putaran chat atau bertanya kurang dari 5 / lebih dari 10 pertanyaan pada Tahap 3.
- **Forced Irrelevant Specialization**: Memaksakan pencarian eksternal untuk audit internal murni, alih-alih mendeklarasikan status `N/A: Internal Audit Only`.
- **Unbounded Web Search Avalanche**: Melakukan pencarian web berlebih untuk tugas audit yang datanya sudah 100% tersedia di direktori lokal `docs/`.

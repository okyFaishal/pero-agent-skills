---
name: pero-context-validation
description: Use when validating cross-document consistency, detecting documentation drift, verifying Mermaid diagrams, or preventing specification regressions across docs/
---

# Pero Context & Living Document Validation (`pero:context-validation`)

## Overview
**Origin**: *Pero Custom SDLC Pipeline - Stage 8 (Universal)*.
Skill ini bertindak sebagai **"Petugas Sensor Alarm & Pencocok Peta Proyek"**. Fungsinya adalah memeriksa apakah seluruh dokumen spesifikasi (`docs/ProblemFraming.md`, `docs/PRD.md`, `docs/SystemSpec.md`, `docs/Architecture.md`, `docs/Governance.md`, `docs/TaskBacklog.md`, dan `docs/decisions/`) saling cocok satu sama lain secara 100%, mendeteksi dokumen yang basi (*documentation drift*), memvalidasi diagram Mermaid, dan mencegah terjadinya regresi spesifikasi.

## Sub-Skill Integration (Perkakas Pendukung)
Dalam menjalankan validasi konteks, agent WAJIB mengorkestrasi sub-skill berikut:
- **Dokumentasi Hidup**: **`REQUIRED SUB-SKILL`**: Gunakan `living-doc-sync` untuk menyelaraskan diagram Mermaid dan denah sistem saat ada perubahan di kode atau dokumen.
- **Audit Kualitas & Kepatuhan**: **`REQUIRED SUB-SKILL`**: Gunakan `code-reviewer` untuk melakukan pemeriksaan kepatuhan spesifikasi tingkat tinggi (*spec compliance*).
- **Validasi Skema Data**: **`SUPPORTING SUB-SKILL`**: Gunakan `schema-validator` untuk memastikan struktur data payload konsisten antar spesifikasi.

## When to Use
- Setelah menyelesaikan penyusunan seluruh dokumen hulu sebelum tim mulai mengeksekusi koding massal.
- Setiap kali terjadi perubahan kebutuhan (*requirement change*) di PRD atau Arsitektur untuk memastikan perubahan merambat rapi (*cascade update*) ke daftar tugas.
- Sebelum perilisan milestone besar untuk memastikan tidak ada fitur siluman (*phantom features*) atau tugas yang tertinggal (*orphaned tasks*).
- Memverifikasi apakah semua blok diagram Mermaid bebas dari kesalahan sintaksis.

---

## The 5 Cross-Document Integrity Rules (Traceability Matrix)

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
```

### 1. Problem-to-PRD Alignment
- Setiap fitur **P0 (MVP)** di `docs/PRD.md` wajib memiliki akar masalah yang jelas di `docs/ProblemFraming.md`.
- Fitur yang tidak menjawab pain point apa pun dianggap sebagai pelanggaran YAGNI dan wajib dieliminasi.

### 2. PRD-to-SystemSpec Alignment
- Setiap fitur di `docs/PRD.md` wajib dijabarkan menjadi minimal satu *User Story* dengan kriteria penerimaan format Gherkin (`Given`, `When`, `Then`) di `docs/SystemSpec.md`.
- Endpoint API atau pesan IPC di `SystemSpec.md` wajib mencerminkan kebutuhan interaksi pengguna di PRD.

### 3. SystemSpec-to-Architecture Alignment
- Semua entitas data domain dan kontrak pertukaran data di `docs/SystemSpec.md` wajib memiliki modul/komponen pemilik dan batas konkurensi yang jelas di `docs/Architecture.md`.
- Alur data (*data flow*) pada diagram arsitektur wajib mencakup seluruh skenario interaksi sistem.

### 4. Architecture-to-Governance Alignment
- Pilihan teknologi, model thread/actor, dan manajemen memori di `docs/Architecture.md` wajib tunduk pada aturan ketat di `docs/Governance.md`.
- Setiap komponen yang menangani data sensitif wajib mematuhi standar perlindungan kredensial `env-guard`.

### 5. Governance-to-TaskBacklog Alignment
- Seluruh modul di `docs/Architecture.md` wajib memiliki kartu tugas konkret yang dapat dieksekusi di `docs/TaskBacklog.md`.
- Setiap kartu tugas wajib menyertakan perintah verifikasi terminal dan menerapkan disiplin TDD (`test-driven-development`).

---

## Stale Cascade Detection & Recovery Protocol

Ketika terjadi perubahan di salah satu dokumen (misal: penambahan fitur di PRD atau pergantian database di Architecture):
1. **Identifikasi Titik Perubahan**: Temukan dokumen paling hulu yang berubah.
2. **Telusuri Rantai Ketergantungan (*Trace Downward*)**:
   - Jika `PRD` berubah $\rightarrow$ Perbarui `SystemSpec` $\rightarrow$ Perbarui `Architecture` $\rightarrow$ Perbarui `TaskBacklog`.
   - Jika `Architecture` berubah $\rightarrow$ Perbarui `Governance` $\rightarrow$ Perbarui `TaskBacklog`.
3. **Catat Keputusan Baru**: Gunakan `decision-recorder` untuk membuat ADR/PDR baru yang mencatat alasan perubahan.
4. **Verifikasi Ulang**: Jalankan audit validasi konteks untuk memastikan tidak ada dokumen yang tertinggal.

---

## Audit Diagram Mermaid

Agent wajib memeriksa setiap blok code fenced ````mermaid```` di seluruh dokumen:
- Pastikan penamaan node tidak mengandung karakter terlarang tanpa tanda kutip.
- Hindari tag HTML mentah di dalam label diagram.
- Pastikan relasi panah (`-->`, `-.->`, `==>`) terhubung ke ID node yang valid.

---

## Template: `docs/ValidationReport.md`

```markdown
# Context Validation Report: [Nama Proyek]

- **Tanggal Audit**: [YYYY-MM-DD]
- **Auditor**: Pero Context Validator
- **Status Keseluruhan**: [✓ PASS / ⚠️ WARNING / ❌ FAIL]

## 1. Traceability & Alignment Checklist
- [x] **Rule 1: Problem -> PRD**: Semua fitur MVP menjawab pain point terverifikasi.
- [x] **Rule 2: PRD -> SystemSpec**: Semua user stories memiliki kriteria Gherkin & kontrak payload.
- [x] **Rule 3: SystemSpec -> Architecture**: Semua entitas domain memiliki komponen pemilik di denah sistem.
- [x] **Rule 4: Architecture -> Governance**: Model konkurensi dan keamanan sesuai standar tata kelola.
- [x] **Rule 5: Architecture -> TaskBacklog**: Seluruh komponen terurai menjadi tugas berfase dengan perintah verifikasi.

## 2. Mermaid Diagrams Health Check
- `docs/Architecture.md`: [✓ Valid Sintaksis]
- `docs/SystemSpec.md`: [✓ Valid Sintaksis]

## 3. Temuan Anomali & Rekomendasi Perbaikan
- **Temuan**: [Tidak ada anomali / Daftar item yang mengalami drift]
- **Tindakan**: [Langkah penyelarasan jika ada yang basi]

## 4. Kesimpulan Kesiapan Eksekusi
[Pernyataan apakah proyek siap dieksekusi ke tahap koding TDD atau memerlukan perbaikan dokumen]
```

---

## Anti-Patterns & Common Mistakes
- **Fitur Siluman (*Phantom Features*)**: Ada tugas koding di `TaskBacklog.md` yang sama sekali tidak pernah diminta di `PRD.md`.
- **Diagram Mermaid Rusak**: Mengunggah diagram arsitektur yang gagal di-render oleh Markdown viewer.
- **Keputusan Tak Berdasar (*Untracked ADRs*)**: Mengubah arsitektur tanpa membuat catatan keputusan di `docs/decisions/`.
- **Membiarkan Dokumen Usang (*Documentation Drift*)**: Mengubah kode langsung tanpa menyinkronkan dokumen arsitektur dan spesifikasi.

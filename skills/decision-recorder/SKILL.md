---
name: decision-recorder
description: Use when making non-trivial architectural, product, or governance decisions that need to be recorded in docs/decisions/
---

# Universal Decision Recorder (`decision-recorder`)

## Overview
**Origin**: *Michael Nygard ADR Pattern + Markdown Architectural Decision Records (MADR) + ThoughtWorks Lightweight ADR Standard*.  
Skill ini adalah **"Buku Harian Notaris & Pencatat Sejarah Keputusan Arsitektur"**. Mengotomatisasi pencatatan keputusan penting proyek ke folder `docs/decisions/` dengan format berkas *immutable timestamped record*, mencegah amnesia arsitektur (*architecture amnesia*), dan mendokumentasikan konteks mengapa suatu keputusan diambil.

> **Analogi Sederhana (ELI5):**  
> Bayangkan **Buku Log Penerbangan & Catatan Notaris Kapal**:
> - **Proyek Tanpa Decision Records (Amnesia Arsitektur)**: Dua tahun kemudian saat kapten kapal berganti, awak kapal baru bingung mengapa kemudi kapal diikat tali ganda. Karena tidak ada catatan, tali dipotong dan kapal karam saat diterjang ombak besar.
> - **Dengan Decision Records (Transparan & Abadi)**: Setiap keputusan besar (seperti *"Mengapa memilih mesin diesel daripada turbin listrik"*) dicatat rapi lengkap dengan tanggal, alternatif yang sempat dipertimbangkan, dan risiko yang harus diwaspadai. Awak baru cukup membaca catatan tersebut untuk memahami latar belakangnya.

---

## Landasan Teori & Referensi Industri Nyata

Skill ini dibangun di atas 3 pilar tata kelola keputusan arsitektur modern yang memadukan asal-usul seminal (*Foundational Classics*) dengan studi empiris 5 tahun terakhir (2021–2026) dan standar resmi internasional:

### 1. Architectural Decision Records & Immutable Historical Capture
Konsep bahwa keputusan arsitektur harus didokumentasikan sebagai rekaman tak terubahkan (*immutable history*) yang berdampingan langsung dengan kode sumber untuk mengeliminasi amnesia arsitektur.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Michael Nygard*, "Documenting Architecture Decisions" (Cognitect Blog, 2011).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *A. van der Ven, A. Jansen, et al.*, "Architectural Decision Records in Practice: An Empirical Study on Benefits, Barriers, and Adoption in Open-Source Projects" (IEEE Transactions on Software Engineering - TSE, Vol. 49, No. 5, IEEE, 2023).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *ISO/IEC/IEEE 42010:2022*, "Software, systems and enterprise — Architecture description (Clause 5.7: Architectural Decisions & Rationale)" (International Organization for Standardization, 2022).

### 2. Markdown Architectural Decision Records (MADR) & Semantic Traceability
Standardisasi format berbasis Markdown ringan dengan penelusuran status siklus hidup dan keterkaitan grafik ketergantungan keputusan (*Decision DAG*).
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Olaf Zimmermann, Oliver Kopp, et al.*, "Architectural Decisions: The Core Artifacts of Software Architecture" (IEEE Software, Vol. 28, No. 1, 2011).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *M. Soliman, M. Salama, et al.*, "Continuous Architectural Decision Recording: Evaluating Automatic Extraction and Impact Traceability" (ACM Transactions on Software Engineering and Methodology - TOSEM, Vol. 33, No. 1, ACM, 2024).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *MADR Working Group*, "Markdown Architectural Decision Records (MADR) Specification v3.0" (adr.github.io, 2023).

### 3. Architectural Knowledge Management & Cognitive Drift Prevention
Penyaringan rasional agar tidak membebani tim dengan pencatatan hal sepele yang tidak berdampak lintas modul, sembari mengunci alasan di balik kompromi desain kritis (*trade-offs*).
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Philippe Kruchten*, "The 4+1 View Model of Architecture" (IEEE Software, Vol. 12, No. 6, 1995).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *L. Chen, R. Ali, et al.*, "Mitigating Architecture Drift through Continuous Decision Capture in Agile Software Engineering" (Journal of Systems and Software - JSS, Elsevier, Vol. 208, 2024).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *Carnegie Mellon Software Engineering Institute (SEI)*, "Architectural Knowledge Management and Decision Rationale Standards" (SEI Technical Report, 2023).

---

## 10 Jenis Dokumen Keputusan Universal

Setiap berkas disimpan pada `docs/decisions/` dengan penamaan: `[TYPE]-[YYYYMMDDHHmm].md`

1. **PFDR (Problem Framing Decision Record)**: Keputusan definisi akar masalah, penolakan asumsi bias, dan batasan Non-Goals hulu (Stage 1 - `pero-problem-framing`).
2. **PDR (Product Decision Record)**: Keputusan ruang lingkup fitur MVP (P0 vs P1/P2) dan matriks alur produk (Stage 2 - `pero-prd-writing`).
3. **SDR (System Design Record)**: Kontrak API envelope, model entitas ERD, dan skenario Gherkin (Stage 3 - `pero-user-stories`).
4. **ADR (Architectural Decision Record)**: Pemilihan stack teknologi, database, deklarasi server MCP, dan pola konkurensi (Stage 4 - `pero-system-architecture`).
5. **DDR (Design Decision Record)**: Keputusan arah estetika, konfigurasi 3 Dial, token warna semantik, skala tipografi, wireframe layar, dan matriks 5 state komponen antarmuka (Stage 5 - `pero-uiux-design`).
6. **GDR (Governance Decision Record)**: Standar thread-safety, batas keamanan rahasia env-guard, linter matrix, dan quality gates (Stage 6 - `pero-quality-governance`).
7. **TDR (Task Decision Record)**: Strategi pemecahan fase backlog 6 domain dan mitigasi dependensi koding (Stage 7 - `pero-task-decomposition`).
8. **RDR (Refinement Decision Record)**: Keputusan tanda tangan metode bertipe ketat, invarian pre/post-conditions, kasus batas ekstrem, dan blast radius kartu tugas granular (Stage 8 - `pero-granular-refinement`).
9. **VDR (Validation Decision Record)**: Keputusan hasil audit ketertelusuran 8-arah (*8-way traceability*), rekonsiliasi cascade drift, verifikasi Mermaid, dan vonis akhir Go/No-Go sebelum fase koding TDD (Stage 9 - `pero-context-validation`).
10. **CRDR (Change Request Decision Record)**: Keputusan revisi cakupan proyek di tengah jalan, penambahan fitur (*ADD*), perubahan arsitektur (*MODIFY/PIVOT*), penghapusan modul (*REMOVE*), serta pembatalan atau pergantian kartu tugas aktif (*SUPERSEDED/CANCELLED*) (Companion - `pero-change-management`).

---

## Siklus Hidup Status Keputusan (*Decision Lifecycle*)

```
┌─────────────────────────────────────────────────────────────┐
│                 SIKLUS STATUS KEPUTUSAN (MADR)              │
├─────────────────────────────────────────────────────────────┤
│   Draft ───> Proposed ───> Accepted ───> Superseded         │
│                                │                            │
│                                └───> Deprecated             │
└─────────────────────────────────────────────────────────────┘
```

*   **Draft**: Rancangan awal yang sedang disusun oleh AI atau tim.
*   **Proposed**: Siap ditinjau oleh pengguna pada sesi grilling atau review.
*   **Accepted**: Telah disetujui dan menjadi hukum teknis resmi proyek.
*   **Superseded**: Digantikan oleh keputusan baru yang lebih mutakhir (Wajib cantumkan rujukan: `Supersedes ADR-[ID]` dan `Superseded by ADR-[ID]`).
*   **Deprecated**: Fitur atau arsitektur dihapus dan tidak berlaku lagi.

---

## Format Baku MADR (Markdown Architecture Decision Record)

```markdown
# [TYPE]-[YYYYMMDDHHmm]: [Judul Keputusan yang Ringkas & Jelas]

- **Tanggal**: YYYY-MM-DD
- **Status**: Accepted
- **Pengambil Keputusan**: [Nama Pengguna / Agen AI]
- **Kategori**: [Problem / Product / System / Architecture / Design / Governance / Task / Refinement / Validation / Change]
- **Relasi**: [Optional: Supersedes ADR-202601011000.md]

---

## 1. Konteks & Masalah (ELI5)
[Jelaskan masalah dengan analogi sederhana dunia nyata. Mengapa keputusan ini harus diambil sekarang?]

## 2. Faktor Pendorong Keputusan (*Decision Drivers*)
- Faktor 1: [Misal: Kebutuhan konkurensi tinggi 10.000 req/detik]
- Faktor 2: [Misal: Keterbatasan anggaran server & memori RAM]
- Faktor 3: [Misal: Waktu rilis MVP maksimal 2 minggu]

## 3. Opsi yang Dipertimbangkan
1. **Opsi A ([Nama Opsi])**:
   - *Kelebihan*: [...]
   - *Trade-off / Kekurangan*: [...]
2. **Opsi B ([Nama Opsi])**:
   - *Kelebihan*: [...]
   - *Trade-off / Kekurangan*: [...]

## 4. Keputusan Final & Rationale
Dipilih **[Opsi X]** karena:
- [Alasan utama 1 berbasis data]
- [Alasan utama 2]

### Landasan Bukti & Referensi Akademik (Empirical Grounding)
- [Author et al., Year] — "Title", Journal/Conference. DOI: 10.xxxx/yyyy (Ref: docs/references/papers/[paper_id].pdf, SHA-256: [hash])

## 5. Konsekuensi Teknis
- **Dampak Positif**: [Manfaat arsitektur yang langsung diperoleh]
- **Trade-off Negatif**: [Kompromi yang harus diterima]
- **Strategi Mitigasi**: [Langkah pencegahan agar trade-off tidak memicu bug]
```

---

## Ambang Batas YAGNI: Kapan TIDAK Boleh Membuat ADR?

Untuk mencegah penumpukan dokumen sampah (*documentation bloat*), ikuti aturan penyaringan ini:

*   ❌ **DILARANG membuat ADR untuk**:
    - Penamaan variabel lokal atau format spasi fungsi.
    - Pemilihan versi patch dependensi rutin (misal: update `v1.2.1` ke `v1.2.2`).
    - Modifikasi bugfix kecil di dalam satu fungsi terisolasi.
*   ✅ **WAJIB membuat ADR untuk**:
    - Perubahan paradigma arsitektur (misal: REST ke GraphQL, SQL ke NoSQL).
    - Penambahan dependensi besar baru yang mengubah alur runtime.
    - Perubahan skema autentikasi atau model perizinan keamanan.
    - Keputusan yang tidak mudah dibatalkan (*one-way door decision*).

---

## Tabel Anti-Pola Decision Recorder

| Pola Terlarang | Mengapa Dilarang Keras? | Solusi Wajib |
|---|---|---|
| **Post-Facto Fake Record** | Menulis ADR berbulan-bulan setelah fitur selesai hanya untuk formalitas. | Tulis ADR pada saat keputusan diambil bersama pengguna. |
| **No Alternatives Listed** | Menulis keputusan tanpa mencantumkan opsi alternatif lain yang sempat dipertimbangkan. | Wajib sertakan minimal 2 opsi pembanding beserta analisis trade-off-nya. |
| **Living Ghost ADR** | Mengubah isi keputusan lama secara diam-diam tanpa memperbarui status siklus hidup. | Jangan edit keputusan lama; buat keputusan baru dengan status `Supersedes [ADR-Lama]`. |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum menyimpan rekaman keputusan baru:
- [ ] Format nama berkas sesuai standar: `docs/decisions/[TYPE]-[YYYYMMDDHHmm].md` (dengan TYPE salah satu dari: `PFDR`, `PDR`, `SDR`, `ADR`, `DDR`, `GDR`, `TDR`, `RDR`, `VDR`, `CRDR`).
- [ ] Berkas memuat status siklus hidup yang jelas (Draft/Proposed/Accepted/Superseded).
- [ ] Konteks masalah dijelaskan dengan analogi ramah (ELI5).
- [ ] Mencantumkan minimal 2 opsi pembanding dengan analisis untung-rugi nyata.
- [ ] Konsekuensi dan strategi mitigasi teknis dicatat secara transparan.



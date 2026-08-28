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

Skill ini dibangun di atas 3 pilar tata kelola keputusan arsitektur modern:

### 1. Architectural Decision Records & Immutable History
Konsep bahwa keputusan arsitektur harus didokumentasikan sebagai rekaman tak terubahkan (*immutable history*) yang berdampingan langsung dengan kode sumber.
*   **Referensi 1 (Pencetus ADR)**: *Michael Nygard*, "Documenting Architecture Decisions" (Cognitect Blog, 2011).
*   **Referensi 2 (Standar Industri)**: *ThoughtWorks Technology Radar*, "Lightweight Architecture Decision Records" ([thoughtworks.com/radar/techniques/lightweight-architecture-decision-records](https://thoughtworks.com/radar/techniques/lightweight-architecture-decision-records)).
*   **Referensi 3 (Buku Arsitektur)**: *Gregor Hohpe*, "The Software Architect Elevator: Redefining the Architect's Role in the Digital Enterprise - Decisions as Options" (O'Reilly Media).

### 2. MADR (Markdown Architecture Decision Records) & DAG Lifecycle
Standardisasi format berbasis Markdown dengan penelusuran status siklus hidup dan keterkaitan grafik berarah (*Directed Acyclic Graph / DAG*).
*   **Referensi 1 (Spesifikasi MADR)**: *Oliver Kopp, Olaf Zimmermann, et al.*, "Markdown Architectural Decision Records (MADR)" ([adr.github.io/madr/](https://adr.github.io/madr/)).
*   **Referensi 2 (Jurnal IEEE)**: *Olaf Zimmermann*, "Architectural Decisions: The Core Artifacts of Software Architecture" (IEEE Software, Vol. 28, No. 1).
*   **Referensi 3 (Perkakas CLI)**: *Nat Pryce*, "adr-tools: A command-line tool for managing Architectural Decision Records" ([github.com/npryce/adr-tools](https://github.com/npryce/adr-tools)).

### 3. YAGNI Governance & Decision Filtering Threshold
Penyaringan rasional agar tidak membebani tim dengan pencatatan hal sepele yang tidak berdampak lintas modul.
*   **Referensi 1 (Prinsip YAGNI)**: *Martin Fowler*, "Yagni (You Aren't Gonna Need It)" ([martinfowler.com/bliki/Yagni.html](https://martinfowler.com/bliki/Yagni.html)).
*   **Referensi 2 (Manajemen Keputusan)**: *Philippe Kruchten*, "The 4+1 View Model of Architecture & Architectural Knowledge Management" (IEEE Software).
*   **Referensi 3 (Anti-Astronaut)**: *Joel Spolsky*, "Architecture Astronauts Take Over" (Avoiding Speculative Governance).

---

## 5 Jenis Dokumen Keputusan Universal

Setiap berkas disimpan pada `docs/decisions/` dengan penamaan: `[TYPE]-[YYYYMMDDHHmm].md`

1. **PDR (Product Decision Record)**: Keputusan cakupan fitur MVP, batasan persona, dan penolakan fitur sampingan.
2. **SDR (System Design Record)**: Desain modul, aliran event, dan batasan konteks (*bounded context*).
3. **ADR (Architectural Decision Record)**: Pemilihan database, kerangka kerja (framework), protokol API, atau strategi caching.
4. **GDR (Governance Decision Record)**: Standar thread-safety, aturan keamanan sandi, dan kebijakan lisensi dependensi.
5. **TDR (Task Decision Record)**: Strategi pemecahan fase tugas, urutan dependensi koding, dan mitigasi risiko teknis.

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
*   **Superseded**: Digantikan oleh keputusan baru yang lebih mutakhir (Wajib cantumkan tautan: `Supersedes [ADR-LAMA](...)` dan `Superseded by [ADR-BARU](...)`).
*   **Deprecated**: Fitur atau arsitektur dihapus dan tidak berlaku lagi.

---

## Format Baku MADR (Markdown Architecture Decision Record)

```markdown
# [TYPE]-[YYYYMMDDHHmm]: [Judul Keputusan yang Ringkas & Jelas]

- **Tanggal**: YYYY-MM-DD
- **Status**: Accepted
- **Pengambil Keputusan**: [Nama Pengguna / Agen AI]
- **Kategori**: [Product / Architecture / Security / Database / Task]
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
- [ ] Format nama berkas sesuai standar: `docs/decisions/[TYPE]-[YYYYMMDDHHmm].md`.
- [ ] Berkas memuat status siklus hidup yang jelas (Draft/Proposed/Accepted).
- [ ] Konteks masalah dijelaskan dengan analogi ramah (ELI5).
- [ ] Mencantumkan minimal 2 opsi pembanding dengan analisis untung-rugi nyata.
- [ ] Konsekuensi dan strategi mitigasi teknis dicatat secara transparan.


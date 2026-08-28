---
name: systematic-debugging
description: Use when encountering any bug, test failure, crash, or unexpected behavior, before proposing fixes
---

# Systematic Debugging (`systematic-debugging`)

## Overview
**Origin**: *Hypothesis-Driven Scientific Debugging ("Why Programs Fail" - Andreas Zeller) + Delta Debugging & Root Cause Analysis (RCA)*.  
Skill ini adalah **"Protokol Investigasi Ilmiah & Bedah Akar Masalah"**. Mewajibkan setiap bug, kegagalan uji coba, crash, atau perilaku abnormal diselesaikan secara ilmiah melalui pembuktian hipotesis dan isolasi kasus reproduksi minimal (*Minimal Reproducible Example*), bukan dengan tebak-tebak berhadiah (*shotgun trial-and-error*).

> **Analogi Sederhana (ELI5):**  
> Bayangkan **Dokter Spesialis vs Dukun Tebak-Tebakan**:
> - **Trial-and-Error (Dukun)**: Pasien datang mengeluh sakit perut, dokter langsung memberi 5 macam obat acak dan mengoperasi usus tanpa melakukan rontgen atau tes darah, sambil berharap salah satunya manjur.
> - **Systematic Debugging (Dokter Ahli)**: Dokter memeriksa gejala spesifik, melakukan rontgen di area yang sakit untuk mengisolasi penyebab, menyusun diagnosis pasti (*infeksi bakteri X*), memberikan 1 antibiotik yang tepat, lalu melakukan tes darah ulang untuk memastikan pasien sembuh total tanpa efek samping.

---

## 5 Fase Investigasi Ilmiah (Siklus Zeller)

```
┌─────────────────────────────────────────────────────────────┐
│             5 FASE SYSTEMATIC DEBUGGING (ZELLER)            │
├─────────────────────────────────────────────────────────────┤
│ 1. Observe & Reproduce : Tangkap stacktrace & buat MRE      │
│ 2. Isolate & Bisect    : Temukan titik anomali pertama      │
│ 3. Hypothesize         : Jelaskan mekanisme kegagalan logis │
│ 4. Surgical Fix        : Perbaikan minimal tepat di akar    │
│ 5. Regression Defense  : Tulis failing test permanen        │
└─────────────────────────────────────────────────────────────┘
```

---

### Fase 1: Observe & Reproduce (Observasi Gejala & MRE)
1. **Dilarang Menyentuh Kode Solusi Sebelum Error Dapat Direproduksi**:
   - Tangkap pesan error lengkap, kode status, dan stack trace dari baris paling atas hingga paling bawah.
   - Buat satu skrip atau unit test mandiri (*Minimal Reproducible Example*) yang dapat memicu error tersebut secara konsisten 100% setiap kali dijalankan.

---

### Fase 2: Isolate & Bisect (Isolasi Titik Penyimpangan Nilai)
1. **Lacak Alur Data (*Trace Backwards*)**:
   - Mulai dari titik terjadinya crash/eksepsi, telusuri ke belakang variabel mana yang pertama kali bernilai abnormal (`null`, `undefined`, atau *out-of-bound*).
2. **Gunakan Pencarian Biner / Git Bisect (Jika Bug Regresi)**:
   - Jika kode sebelumnya berfungsi dan baru rusak belakangan, gunakan `git bisect` untuk menemukan commit persis yang memperkenalkan bug tersebut.

---

### Fase 3: Formulate Testable Hypothesis (Rumuskan Hipotesis Ilmiah)
- Tuliskan hipotesis secara eksplisit: *"Fungsi X gagal karena ketika array Y kosong, baris Z mencoba mengakses indeks 0 tanpa validasi panjang, sehingga memicu panic/TypeError."*
- Lakukan eksperimen cepat untuk membuktikan hipotesis tersebut (misal: dengan assertion atau breakpoint).

---

### Fase 4: Surgical Minimal Fix (Perbaikan Bedah Presisi)
- **Terapkan Perbaikan Minimal**: Modifikasi sesedikit mungkin baris kode yang secara spesifik menetralkan akar penyebab masalah.
- **Dilarang Merombak Arsitektur Acak**: Jangan merefaktor file yang tidak berhubungan saat sedang memperbaiki bug.

---

### Fase 5: Regression Defense & Clean (Uji Bebas Regresi)
1. **Kunci dengan Automated Test**:
   - Masukkan skrip MRE tadi ke dalam test suite resmi proyek sebagai unit/integration test pencegah regresi (*regression test*).
2. **Jalankan Seluruh Test Suite**:
   - Jalankan seluruh tes proyek untuk menjamin perbaikan tidak merusak fitur lain di sekitarnya.
3. **Bersihkan Logging Sementara**:
   - Hapus semua `console.log`, `print()`, atau breakpoint diagnostik sementara sebelum melakukan commit.

---

## Tabel Anti-Pola (*Anti-Patterns*)

| Pola Terlarang | Mengapa Dilarang Keras? | Solusi Wajib |
|---|---|---|
| **Shotgun Debugging** | Mengubah-ubah kode acak di 5 tempat berbeda dengan harapan salah satunya berhasil. | Berhenti. Isolasi titik error terlebih dahulu dengan logging terarah atau unit test. |
| **Symptom Masking** | Membungkus error dengan `try-catch` kosong atau `if (x == null) return;` tanpa tahu kenapa null. | Cari tahu *siapa* dan *mengapa* nilai tersebut menjadi null di hulu data. |
| **No Reproduction Script** | Langsung membuat pull request perbaikan tanpa pernah mencoba memicu errornya sendiri. | Wajib buat skrip/test yang membuktikan bug terjadi (RED) sebelum diperbaiki (GREEN). |
| **Leaving Debug Noise** | Membiarkan `console.log("TEST 123")` tertinggal di kode produksi. | Bersihkan seluruh instrumen debug setelah verifikasi berhasil. |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum mengklaim sebuah bug telah diperbaiki:
- [ ] Mampu mereproduksi error secara konsisten sebelum menuliskan perbaikan kode.
- [ ] Akar penyebab masalah (*root cause*) dapat dijelaskan secara ilmiah, bukan sekadar menebak gejala.
- [ ] Perbaikan kode bersifat presisi (*surgical*) dan hanya menargetkan titik akar masalah.
- [ ] Telah menambahkan satu unit test regresi yang membuktikan bug sembuh permanen.
- [ ] Seluruh test suite proyek lulus 100% tanpa ada fitur lain yang rusak (*zero regression*).
- [ ] Seluruh logging diagnostik sementara telah dibersihkan.

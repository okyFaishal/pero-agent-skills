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

## Sub-Skill Integration (Perkakas Pendukung)
Dalam menjalankan proses investigasi masalah, agent WAJIB mengorkestrasi sub-skill berikut:
- **Investigasi Galat Massal Paralel**: **`SUPPORTING SUB-SKILL`**: Gunakan [`dispatching-parallel-agents`](../dispatching-parallel-agents/SKILL.md) ketika menghadapi 2 atau lebih berkas pengujian (`*.test.ts`, `test_*.py`) yang gagal dengan akar masalah berbeda di subsistem terpisah, mendelegasikan investigasi tiap berkas tes ke sub-agen paralel mandiri.
- **Penegak Siklus Pengujian TDD**: **`REQUIRED SUB-SKILL`**: Gunakan [`test-driven-development`](../test-driven-development/SKILL.md) untuk menulis failing regression test sebelum menerapkan perbaikan bedah (*surgical fix*).
- **Riset Solusi Eksternal Terukur (Pagar Batas Fase)**: **`SUPPORTING SUB-SKILL`**: Pada Fase 1 (Isolasi Akar Masalah & Pembuatan MRE), penelusuran web **DILARANG KERAS** untuk mencegah halusinasi solusi dini. Penelusuran web via protokol [`web-search`](../web-search/SKILL.md) (Search MCP ➔ `read_url_content`) hanya diperbolehkan pada Fase 2/3 ketika menghadapi *compiler panic*, crash mesin runtime tingkat rendah, atau bug dependensi pihak ketiga yang telah terisolasi, bebas dari perintah terminal `curl`.
- **Riset Makalah Ilmiah Bersyarat (Khusus Fase 3)**: **`CONDITIONAL SUB-SKILL`**: Gunakan [`scientific-research`](../scientific-research/SKILL.md) dan [`pdf-reader`](../pdf-reader/SKILL.md) HANYA pada Fase 3 ketika hipotesis kegagalan berakar pada **ketidakstabilan numerik (*floating point cancellation*, *loss NaN* pada ML)** atau **deadlock konsensus terdistribusi**. Jika naskah baru diunduh, agen **WAJIB mencatat SHA-256 dan memperbarui `docs/references/MANIFEST.json`** sebelum masuk ke Fase 4. DILARANG KERAS memanggil riset paper pada Fase 1 (MRE) atau untuk bug sintaks, null pointer, query database lambat, dan error HTTP biasa.
- **Verifikasi Bebas Regresi**: **`REQUIRED SUB-SKILL`**: Gunakan [`verification-before-completion`](../verification-before-completion/SKILL.md) untuk membuktikan bahwa seluruh test suite lulus 100% setelah perbaikan bedah.

---

## Landasan Teori & Referensi Industri Nyata

Skill ini dibangun di atas 3 pilar rekayasa investigasi ilmiah, lokalisasi kesalahan otomatis (*fault localization*), dan pertahanan regresi permanen:

### 1. Scientific Hypothesis-Driven Debugging & Delta Debugging
Metodologi pembuktian hipotesis kausalitas ilmiah untuk mengisolasi kondisi input terkecil yang menyebabkan program gagal (*Minimal Reproducible Example*), menggantikan metode tebak-tebak acak.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Andreas Zeller*, "Why Programs Fail: A Guide to Systematic Debugging (Delta Debugging Algorithm)" (Morgan Kaufmann, 2005/2009).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *Y. Lou, A. Ghanbari, et al.*, "Automated Fault Localization and Program Repair in the Era of Large Language Models: An Industrial Survey and Benchmark" (IEEE/ACM 46th International Conference on Software Engineering - ICSE '24, ACM/IEEE, 2024).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *IEEE Std 1044-2020*, "IEEE Standard Classification for Software Anomalies (Fault Isolation and Root Cause Analysis)" (IEEE Computer Society, 2020).

### 2. Spectrum-Based Fault Localization (SBFL) & Program Slicing
Teknik penelusuran alur eksekusi (*execution traces*) dan pemotongan kode dinamis untuk mendeteksi baris kode anomali pertama tanpa mengotori berkas yang sehat.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Frank Tip*, "A Survey of Program Slicing Techniques" (Journal of Programming Languages, Vol. 3, 1995).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *J. Sohn & S. Yoo*, "FLAVOR: Fault Localization and Verification for Automated Program Repair" (ACM Transactions on Software Engineering and Methodology - TOSEM, Vol. 33, No. 1, ACM, 2024).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *Google SRE Group*, "Site Reliability Engineering: Effective Troubleshooting & Incident Postmortem Framework" (Google Engineering, 2023).

### 3. Regression Defense & Minimal Reproducible Examples (MRE)
Penguncian akar masalah ke dalam test suite permanen sebelum perbaikan bedah dilakukan untuk memastikan bug yang sama mustahil muncul kembali (*Zero Regression*).
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Gerard Meszaros*, "xUnit Test Patterns: Defect Localization & Regression Testing" (Addison-Wesley, 2007).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *S. Kang, J. Yoon, et al.*, "Large Language Models for Test Case Generation and Bug Localization: An Empirical Assessment on Defect4J" (ACM Transactions on Software Engineering and Methodology - TOSEM, Vol. 32, No. 4, ACM, 2023).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *NIST SP 800-218*, "Secure Software Development Framework (SSDF) Version 1.1: Task RV.1 (Analyze and Remediate Software Flaws)" (National Institute of Standards and Technology, 2022).

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
- **Riset Makalah Terfokus & Academic-First Priority (Khusus Bug Algoritmik/Numerik/Konkurensi)**: Jika kegagalan bersumber pada kalkulasi matematika, pembulatan floating point, atau model konsensus terdistribusi yang tidak tercakup dalam dokumentasi standar, agen **WAJIB memanggil [`scientific-research`](../scientific-research/SKILL.md) dan [`pdf-reader`](../pdf-reader/SKILL.md) terlebih dahulu** untuk memvalidasi teorema formal sebelum mencari solusi forum di web. Jika paper baru diunduh, hitung SHA-256 dan catat ke `docs/references/MANIFEST.json` sebelum masuk ke Fase 4. Dilarang mencari paper untuk bug koding/sintaks biasa.

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
| **Search-First Hallucination** | Langsung mencari solusi acak di internet atau terminal scraping sebelum memahami kegagalan lokal. | Isolasi invarian dan reproduksi MRE di lokal terlebih dahulu; riset eksternal hanya untuk crash compiler/upstream via Search MCP. |
| **Symptom Masking** | Membungkus error dengan `try-catch` kosong atau `if (x == null) return;` tanpa tahu kenapa null. | Cari tahu *siapa* dan *mengapa* nilai tersebut menjadi null di hulu data. |
| **No Reproduction Script** | Langsung membuat pull request perbaikan tanpa pernah mencoba memicu errornya sendiri. | Wajib buat skrip/test yang membuktikan bug terjadi (RED) sebelum diperbaiki (GREEN). |
| **Leaving Debug Noise** | Membiarkan `console.log("TEST 123")` tertinggal di kode produksi. | Bersihkan seluruh instrumen debug setelah verifikasi berhasil. |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum mengklaim sebuah bug telah diperbaiki:
- [ ] Mampu mereproduksi error secara konsisten sebelum menuliskan perbaikan kode.
- [ ] Tidak melakukan pencarian web acak sebelum bug berhasil diisolasi di lingkungan lokal.
- [ ] Akar penyebab masalah (*root cause*) dapat dijelaskan secara ilmiah, bukan sekadar menebak gejala.
- [ ] Perbaikan kode bersifat presisi (*surgical*) dan hanya menargetkan titik akar masalah.
- [ ] Telah menambahkan satu unit test regresi yang membuktikan bug sembuh permanen.
- [ ] Seluruh test suite proyek lulus 100% tanpa ada fitur lain yang rusak (*zero regression*).
- [ ] Seluruh logging diagnostik sementara telah dibersihkan.

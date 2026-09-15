---
name: test-driven-development
description: Use when implementing any feature or bugfix, before writing implementation code
---

# Test-Driven Development (`test-driven-development`)

## Overview
**Origin**: *Extreme Programming (XP) Core Practice + Kent Beck TDD Pattern + Martin Fowler Practical Test Pyramid*.  
Skill ini adalah **"Penegak Hukum Koding Disiplin & Gerbang Uji Sebelum Implementasi"**. Prinsip mutlak: **DILARANG MENULIS SATU BARIS PUN KODE IMPLEMENTASI SEBELUM ADA PENGUJIAN OTOMATIS YANG GAGAL DENGAN ALASAN YANG TEPAT (FAILING TEST / RED)**.

> **Analogi Sederhana (ELI5):**  
> Bayangkan kita sedang **Membangun Jembatan Gantung Kereta Cepat**:
> - **Koding Tanpa TDD (Asal Bangun)**: Pekerja langsung memasang aspal dan rel kereta di atas jurang, lalu menyuruh kereta berpenumpang melintas untuk melihat apakah jembatannya roboh atau tidak. Jika ada yang retak, mereka menambalnya sambil kereta melaju kencang.
> - **Dengan TDD (Disiplin Teruji)**: Insinyur memasang sensor beban dan tali penahan uji coba terlebih dahulu (*Failing Test*). Ketika sensor berbunyi "Belum Ada Penyangga" (*RED*), mereka memasang tiang baja minimal yang kokoh (*GREEN*). Setelah sensor menunjukkan status aman 100%, mereka merapikan cat dan mengencangkan baut (*REFACTOR*).

## Sub-Skill Integration (Perkakas Pendukung)
Dalam menjalankan siklus pengujian TDD, agent WAJIB mengorkestrasi sub-skill berikut:
- **Mesin Eksekusi Sub-Agen Otonom**: **`SUPPORTING SUB-SKILL`**: Gunakan [`subagent-driven-development`](../subagent-driven-development/SKILL.md) untuk menjalankan siklus Red-Green-Refactor di dalam memori terisolasi per kartu tugas.
- **Penyaring Kode Bebas Sampah**: **`REQUIRED SUB-SKILL`**: Gunakan [`anti-slop`](../anti-slop/SKILL.md) pada tahap Refactor untuk membuang duplikasi kode, komentar sepele, dan kode tiruan palsu.
- **Verifikasi Bukti Terminal Nyata**: **`REQUIRED SUB-SKILL`**: Gunakan [`verification-before-completion`](../verification-before-completion/SKILL.md) untuk membuktikan kelulusan tes secara faktual di terminal.
- **Ekstraksi Golden Test Vectors (Strictly Read-Only)**: **`CONDITIONAL SUB-SKILL`**: Gunakan [`pdf-reader`](../pdf-reader/SKILL.md) pada Fase 1 (RED) HANYA untuk mengekstrak angka uji patokan resmi (*golden test vectors*), dataset benchmark, dan ambang batas galat toleransi $\epsilon$ dari tabel naskah akademik lokal yang terdaftar di `docs/references/MANIFEST.json` untuk modul komputasi ilmiah/kriptografi. DILARANG KERAS memanggil di Fase GREEN dan REFACTOR, serta dilarang memicu `scientific-research`.
- **Investigasi Kegagalan Tak Terduga**: **`SUPPORTING SUB-SKILL`**: Gunakan [`systematic-debugging`](../systematic-debugging/SKILL.md) jika menghadapi kegagalan uji yang rumit atau regresi tak terduga sebelum mencoba perbaikan asal tebak.

---

## Landasan Teori & Referensi Industri Nyata

Skill ini dibangun di atas 3 pilar rekayasa perangkat lunak teruji dengan memadukan karya klasik perintis (*Foundational Classics*) bersama validasi empiris peer-reviewed 5 tahun terakhir (2021–2026) dan standar resmi:

### 1. Siklus Red-Green-Refactor & Test-First Development
Prinsip bahwa pengujian harus memandu desain arsitektur, bukan sekadar penutup formalitas setelah koding selesai, kini tervalidasi secara empiris di era AI coding.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Kent Beck*, "Test-Driven Development: By Example" (Addison-Wesley Signature Series, 2002).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *F. Madeyski & L. Madeyski*, "Test-Driven Development in the Age of AI Code Assistants: An Empirical Study on Defect Density and Design Quality" (IEEE Transactions on Software Engineering - TSE, Vol. 50, No. 1, IEEE, 2024).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *ISO/IEC/IEEE 29119-4:2021*, "Software and systems engineering — Software testing — Part 4: Test techniques" (International Organization for Standardization, 2021).

### 2. Test Pyramid & Test Doubles Taxonomy
Klasifikasi pengujian bertingkat serta isolasi ketergantungan menggunakan pengganti objek yang tepat tanpa jebakan *over-mocking* atau data tiruan palsu.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Gerard Meszaros*, "xUnit Test Patterns: Refactoring Test Code - Test Double Patterns" (Addison-Wesley, 2007) & *Martin Fowler*, "The Practical Test Pyramid" (martinfowler.com).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *A. Aleti, M. Martinez, et al.*, "Empirical Evaluation of Test Smells and Over-Mocking in Automated Test Generation" (ACM Transactions on Software Engineering and Methodology - TOSEM, Vol. 33, No. 2, ACM, 2024).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *Google Engineering Practices*, "Testing on the Toilet: Effective Unit Testing and Test Double Taxonomy" (Google Open Source Documentation, 2023).

### 3. Boundary Value Analysis & Mutation Testing Feedback
Teknik penentuan skenario uji hitam (*black-box testing*) pada nilai batas ekstrem dan evaluasi ketahanan assertion melalui analisis mutasi.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Glenford J. Myers & Corey Sandler*, "The Art of Software Testing" (John Wiley & Sons, 1979/2011).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *S. Panichella*, "Automated Boundary Value Test Synthesis and Failure Oracle Generation: An Industrial Study" (Empirical Software Engineering, Springer, Vol. 28, 2023).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *NIST SP 800-218*, "Secure Software Development Framework (SSDF) Version 1.1: Tasks PW.7 & PW.8 (Automated Test Execution & Flaw Remediation)" (National Institute of Standards and Technology, 2022).

---

## The Iron Law of TDD

```
KODE DITULIS SEBELUM TEST GAGAL?
HAPUS KODE ITU SEKARANG JUGA. KEMBALI KE TAHAP RED.
```

Tidak ada dispensasi atau alasan "fiturnya terlalu sepele". Fitur sepele tanpa uji coba adalah penyebab utama bug regresi di lingkungan produksi.

---

## Alur Kerja 3 Fase: RED - GREEN - REFACTOR

```
┌─────────────────────────────────────────────────────────────┐
│                 SIKLUS TDD DISIPLIN (PERO)                  │
├─────────────────────────────────────────────────────────────┤
│ 1. RED      : Tulis failing test spesifik -> Wajib GAGAL    │
│ 2. GREEN    : Tulis kode implementasi minimal -> LULUS      │
│ 3. REFACTOR : Bersihkan slop & duplikasi -> Tetap LULUS     │
└─────────────────────────────────────────────────────────────┘
```

### Fase 1: RED (Merah — Uji Kegagalan yang Diharapkan)
1. Buat berkas unit test pada direktori pengujian resmi (misal: `tests/`, `__tests__/`, `*_test.go`, `test_*.py`).
2. Tulis satu skenario uji yang memanggil fungsi, antarmuka, atau parameter yang **belum ada**.
3. Jalankan test runner lokal di terminal.
4. **Wajib Diverifikasi**: Pastikan tes menghasilkan status **GAGAL** karena logika fungsi belum tersedia (*Expected Failure*), bukan karena kesalahan sintaks penulisan tes.
5. **Golden Vectors Akademik (Modul Ilmiah/Kriptografi)**: Jika pengujian menyangkut kalkulasi matematika presisi, gunakan [`pdf-reader`](../pdf-reader/SKILL.md) untuk mengekstrak vektor uji dan toleransi $\epsilon$ resmi dari tabel naskah rujukan lokal di `MANIFEST.json`. Dilarang mengunduh paper baru.

### Fase 2: GREEN (Hijau — Implementasi Minimal)
1. Tulis kode implementasi sesederhana mungkin yang hanya cukup untuk meloloskan tes tadi.
2. Dilarang menulis abstraksi spekulatif (*generic handler, dynamic factory*) jika tidak dituntut oleh tes.
3. Jalankan kembali test runner di terminal dan pastikan status berubah menjadi **HIJAU (LULUS 100%)**.

### Fase 3: REFACTOR (Poles — Bersihkan & Optimasi)
1. Jalankan audit `anti-slop`: hapus duplikasi kode, singkirkan komentar sepele, dan rapikan penamaan variabel.
2. Lakukan perbaikan struktur tanpa merubah perilaku eksternal sistem.
3. Jalankan kembali seluruh test suite di terminal untuk membuktikan bahwa refactoring tidak merusak fungsionalitas (*zero regression*).

---

## Taksonomi Pengganti Uji (*Test Doubles*)

Hindari melakukan mock sembarangan (*mock-hallucination*). Gunakan jenis pengganti yang tepat sesuai kebutuhan:

| Tipe Double | Definisi Sederhana (ELI5) | Kapan Digunakan? |
|---|---|---|
| **Dummy** | Objek boneka kosong hanya untuk mengisi parameter fungsi yang wajib diisi. | Parameter fungsi yang tidak pernah dibaca dalam skenario uji. |
| **Stub** | Jawaban instan yang sudah diprogram sebelumnya (*hardcoded response*). | Menggantikan panggilan HTTP atau query database yang mengembalikan data statis. |
| **Spy** | Mata-mata yang mencatat berapa kali dan argumen apa saja yang dikirim ke suatu fungsi. | Memverifikasi apakah fungsi pengiriman email atau pencatat log dipanggil secara benar. |
| **Mock** | Kontrak ekspektasi ketat yang memvalidasi urutan dan format pemanggilan fungsi. | Memverifikasi interaksi kompleks antar komponen independen. |
| **Fake** | Implementasi ringan yang berfungsi penuh namun tidak cocok untuk produksi (misal: *In-Memory Database* atau *Mock Repository*). | Pengujian integrasi cepat tanpa harus menyalakan server database eksternal. |

---

## Matriks Eksekusi Test Runner Polyglot

| Ekosistem | Perintah Unit Test Cepat | Perintah Full Suite Test | Filter Single Test File |
|---|---|---|---|
| **Node.js / TS** | `npx vitest run` / `npm test` | `npm run test:ci` | `npx vitest run path/to/file.test.ts` |
| **Python** | `pytest` | `pytest -v --tb=short` | `pytest tests/test_feature.py -k "test_case"` |
| **Go** | `go test ./...` | `go test -v -race ./...` | `go test -v -run TestFeature ./pkg/feature` |
| **Rust** | `cargo test` | `cargo test --all-targets` | `cargo test test_feature_name` |
| **Flutter / Dart** | `flutter test` | `flutter test --coverage` | `flutter test test/feature_test.dart` |
| **Java / Kotlin** | `./gradlew test` | `./gradlew check` | `./gradlew test --tests FeatureTest` |
| **C# / .NET** | `dotnet test` | `dotnet test --verbosity normal`| `dotnet test --filter FullyQualifiedName~FeatureTest` |
| **Swift** | `swift test` | `swift test --enable-code-coverage` | `swift test --filter FeatureTests` |

---

## Tabel Anti-Pola TDD (*Testing Anti-Patterns*)

| Pola Terlarang | Mengapa Dilarang Keras? | Solusi Wajib |
|---|---|---|
| **Test-After Writing** | Menulis kode implementasi dulu lalu membuat tes belakangan. Tes yang dibuat hanya mengonfirmasi apa yang terlanjur dikoding, bukan apa yang seharusnya dispesifikasikan. | Hapus kode implementasi. Mulai dari menulis tes yang gagal di Fase RED. |
| **Assert-Free Test** | Tes yang hanya memanggil fungsi tanpa perintah penegasan (`expect`, `assert`). Tes selalu hijau meski fungsi salah. | Setiap skenario uji wajib memiliki minimal satu `assertion` yang bermakna. |
| **The Liar Mock** | Melakukan mock terhadap 100% dependensi sehingga kode nyata tidak pernah dieksekusi sama sekali. | Gunakan Fake atau lakukan tes integrasi nyata pada lapisan batas sistem. |
| **Boundary Ignorance** | Hanya menguji kasus positif (*happy path*) dan melewatkan input kosong, array 0 elemen, nilai negatif, atau batas maksimum. | Terapkan *Boundary Value Analysis* (Uji titik: Minimum, Min-1, Max, Max+1, Null/Empty). |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum melanjutkan ke tahap refactor atau menyatakan implementasi selesai:
- [ ] Menulis skenario uji gagal terlebih dahulu dan melihat bukti pesan error di terminal (RED).
- [ ] Menulis kode implementasi minimal dan melihat bukti tes berubah menjadi hijau (GREEN).
- [ ] Menguji nilai batas ekstrem (*empty string*, *null*, *0*, *out-of-bounds array*).
- [ ] Menggunakan jenis *Test Double* yang sesuai (tidak melakukan mock palsu berlebih).
- [ ] Seluruh test suite pada proyek lulus 100% dengan status exit code 0.


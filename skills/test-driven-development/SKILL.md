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

---

## Landasan Teori & Referensi Industri Nyata

Skill ini dibangun di atas 3 pilar rekayasa perangkat lunak teruji, di mana setiap teori diperkuat oleh standar industri nyata:

### 1. Siklus Red-Green-Refactor & Test-First Development
Prinsip bahwa pengujian harus memandu desain arsitektur, bukan sekadar penutup formalitas setelah koding selesai.
*   **Referensi 1 (Buku Klasik)**: *Kent Beck*, "Test-Driven Development: By Example" (Addison-Wesley Signature Series, ISBN: 0321146530).
*   **Referensi 2 (Panduan Industri)**: *Martin Fowler*, "Test-Driven Development" Overview & Refactoring Patterns ([martinfowler.com/bliki/TestDrivenDevelopment.html](https://martinfowler.com/bliki/TestDrivenDevelopment.html)).
*   **Referensi 3 (Standar Metodologi)**: *Extreme Programming (XP) Rules*, "Test-First Programming Standard" ([extremeprogramming.org/rules/testfirst.html](http://www.extremeprogramming.org/rules/testfirst.html)).

### 2. Test Pyramid & Test Doubles Taxonomy
Klasifikasi pengujian bertingkat serta isolasi ketergantungan menggunakan pengganti objek yang tepat tanpa over-mocking.
*   **Referensi 1 (Piramida Pengujian)**: *Mike Cohn & Martin Fowler*, "The Practical Test Pyramid" ([martinfowler.com/articles/practical-test-pyramid.html](https://martinfowler.com/articles/practical-test-pyramid.html)).
*   **Referensi 2 (Pola Pengujian xUnit)**: *Gerard Meszaros*, "xUnit Test Patterns: Refactoring Test Code - Test Double Patterns" (Addison-Wesley).
*   **Referensi 3 (Praktik Google)**: *Google Testing Blog*, "Testing on the Toilet (TotT): Know Your Test Doubles" & "Just Say No to More End-to-End Tests".

### 3. Boundary Value Analysis (BVA) & Equivalence Partitioning
Teknik penentuan skenario uji hitam (*black-box testing*) pada nilai batas ekstrem dan kelas ekuivalensi untuk mencegah celah *off-by-one*.
*   **Referensi 1 (Standar Pengujian Perangkat Lunak)**: *Glenford J. Myers & Corey Sandler*, "The Art of Software Testing" (3rd Edition, John Wiley & Sons).
*   **Referensi 2 (Buku Black-Box Testing)**: *Boris Beizer*, "Black-Box Testing: Techniques for Functional Testing of Software and Systems" (Wiley).
*   **Referensi 3 (Standar Internasional)**: *ISO/IEC/IEEE 29119-4*, "Software and Systems Engineering - Software Testing - Part 4: Test Techniques (Boundary Value Analysis)".

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


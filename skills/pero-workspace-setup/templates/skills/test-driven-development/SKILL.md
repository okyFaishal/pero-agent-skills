---
name: test-driven-development
description: Use when implementing any feature or bugfix, before writing implementation code
---

# Test-Driven Development (Universal TDD Enforcer)

## Overview
**Origin**: *Battle-Tested Industry Standard (Superpowers / Kent Beck TDD Pattern)*.
Prinsip utama: **TIDAK ADA KODE IMPLEMENTASI SEBELUM ADA FAILING TEST**.
Berlaku mutlak untuk **SEMUA bahasa pemrograman & framework** (JavaScript/TypeScript, Python, Go, Rust, Java, Kotlin, Swift, Dart, C#, PHP, Ruby).

## The Iron Law
```
KODE DITULIS SEBELUM TEST GAGAL? HAPUS KODE ITU SEKARANG JUGA. MULAI DARI AWAL.
```
Tidak ada pengecualian: Dilarang membuat kode dulu lalu menulis test belakangan (*test-after*).

## Siklus RED-GREEN-REFACTOR
1. **RED (Merah - Pasang Gembok Ujian)**:
   - Tulis satu unit test yang memanggil fungsi/perilaku yang *belum ada*.
   - Jalankan test runner (`npm test`, `pytest`, `go test`, `cargo test`, `flutter test`, `swift test`, dll).
   - Pastikan test **GAGAL** dengan alasan yang tepat (*Expected Failure*).
2. **GREEN (Hijau - Buat Kunci Pas Minimal)**:
   - Tulis kode implementasi paling sederhana yang hanya cukup untuk meloloskan test tadi.
   - Jalankan test runner dan pastikan berubah menjadi **LULUS (HIJAU)**.
3. **REFACTOR (Poles & Rapikan)**:
   - Rapikan struktur kode, hilangkan duplikasi, dan perbaiki penamaan tanpa merubah perilaku eksternal.
   - Pastikan semua test tetap **LULUS**.

## Perintah Test Runner Polyglot
- **Node.js / Web**: `npm test` / `pnpm test` / `npx vitest` / `jest`
- **Python**: `pytest`
- **Go**: `go test -v ./...`
- **Rust**: `cargo test`
- **Flutter / Dart**: `flutter test`
- **Swift / macOS / iOS**: `swift test` atau `xcodebuild test`
- **Java / Kotlin**: `./gradlew test` atau `mvn test`
- **C# / .NET**: `dotnet test`

## Tabel Anti-Alasan
| Alasan AI yang Dilarang | Fakta Nyata |
|---|---|
| "Fitur ini terlalu sepele untuk di-test dulu" | Fitur sepele adalah sumber regresi nomor 1. Tulis test (hanya 30 detik). |
| "Saya tulis implementasinya dulu biar cepat" | Test-after menguji apa yang terlanjur dibuat, bukan apa yang seharusnya dibuat. |
| "Saya sudah tes manual di terminal" | Uji manual hilang begitu sesi selesai. Wajibkan automated regression test. |

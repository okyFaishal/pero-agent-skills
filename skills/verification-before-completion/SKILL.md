---
name: verification-before-completion
description: Use when about to claim work is complete, fixed, or passing, before committing or reporting done
---

# Verification Before Completion (`verification-before-completion`)

## Overview
**Origin**: *Continuous Delivery Quality Gates (Martin Fowler) + Shift-Left Multi-Stage Verification Standard*.  
Skill ini adalah **"Gerbang Pengesahan Akhir & Penegak Bukti Nyata (Evidence Before Assertions)"**. Hukum mutlak: **DILARANG MENYATAKAN SELESAI TANPA BUKTI NYATA EKSEKUSI TERMINAL (EXIT CODE 0, 0 ERRORS, 0 WARNINGS KRITIS)**.

> **Analogi Sederhana (ELI5):**  
> Bayangkan **Sertifikasi Kelayakan Terbang Pesawat Komersial**:
> - **Klaim Palsu (Tanpa Bukti)**: Montir berkata, *"Pesawat sudah siap terbang, tadi saya lihat sekilas bautnya sudah kencang kok!"*, tanpa pernah menyalakan mesin jet atau menguji instrumen radar.
> - **Verification Gate (Dengan Bukti)**: Petugas inspeksi keselamatan menjalankan uji coba checklist elektrik, menyalakan turbin di landasan pacu, mencetak lembar log tes sensor dengan stempel "LULUS 100%", baru menyerahkan izin terbang kepada pilot.

---

## 4 Gerbang Verifikasi Bertingkat (*4-Stage Quality Gates*)

```
┌─────────────────────────────────────────────────────────────┐
│          4 TAHAP GERBANG VERIFIKASI SEBELUM SELESAI         │
├─────────────────────────────────────────────────────────────┤
│ Gate 1: Static Analysis & Linter   (Format & Anti-Code Smell)│
│ Gate 2: Type Check & Compilation   (0 Compile Errors)       │
│ Gate 3: Automated Test Execution   (Unit & Integration 100%)│
│ Gate 4: Terminal Evidence Report   (Tampilkan Exit Code 0)  │
└─────────────────────────────────────────────────────────────┘
```

---

### Gate 1: Static Analysis & Linter
Pastikan tidak ada pelanggaran sintaksis, variabel tak terpakai, atau kesalahan pemformatan:
- Menjalankan linter resmi proyek (misal: `eslint`, `flake8`/`ruff`, `golangci-lint`, `cargo clippy`).

---

### Gate 2: Type Check & Compilation
Pastikan kode lolos kompilasi tipe data tanpa mengandalkan bypass `any` atau `ts-ignore`:
- TypeScript: `npx tsc --noEmit`
- Rust: `cargo check`
- Go: `go vet ./...`
- C# / Java: `dotnet build --no-incremental` / `./gradlew compileJava`

---

### Gate 3: Automated Test Execution
Jalankan seluruh test suite terkait dan pastikan semua uji coba berubah menjadi hijau:
- Minimal menjalankan unit test modul yang diubah dan tes integrasi hulu-hilirnya.
- 0 failures, 0 errors, 0 flaky skips.

---

### Gate 4: Terminal Evidence & Clean State
1. **Periksa Status Git**:
   - Jalankan `git status` untuk memastikan tidak ada file sampah sementara, log debug, atau artefak build yang tertinggal di luar `.gitignore`.
2. **Sajikan Bukti Nyata**:
   - Tunjukkan cuplikan eksekusi terminal sebenarnya kepada pengguna (waktu eksekusi, jumlah test yang lulus, dan status exit code 0).

---

## Matriks Eksekusi Multi-Bahasa (Polyglot Matrix)

| Ekosistem | Gerbang 1: Lint | Gerbang 2: Type Check | Gerbang 3: Test Suite |
|---|---|---|---|
| **Node / TS** | `npm run lint` | `npx tsc --noEmit` | `npm test` / `npx vitest run` |
| **Python** | `ruff check .` | `mypy .` / `pyright` | `pytest -v` |
| **Go** | `golangci-lint run` | `go vet ./...` | `go test -v -race ./...` |
| **Rust** | `cargo clippy` | `cargo check` | `cargo test --all` |
| **Flutter** | `flutter analyze` | `dart analyze` | `flutter test` |
| **Swift** | `swiftlint` | `swift build` | `swift test` |
| **Java/Kotlin** | `./gradlew checkstyleMain` | `./gradlew compileKotlin` | `./gradlew test` |
| **C# / .NET** | `dotnet format --verify-no-changes` | `dotnet build` | `dotnet test` |

---

## Tabel Anti-Pola (*Anti-Patterns*)

| Pola Terlarang | Mengapa Dilarang Keras? | Solusi Wajib |
|---|---|---|
| **Premature Completion Claim** | Menulis *"Perbaikan berhasil dan semua sudah beres!"* sebelum menjalankan test di terminal. | Jalankan perintah tes di terminal terlebih dahulu; sajikan bukti lognya. |
| **Mock Hallucination** | Menganggap kode bekerja hanya karena tes mock hijau, padahal kode nyata belum pernah di-build. | Jalankan `build` nyata untuk memastikan tidak ada import atau dependensi rusak. |
| **Ignoring Warnings** | Mengabaikan warning kompilator kritis dengan dalih *"cuma warning, bukan error"*. | Bersihkan semua warning sebelum menyatakan pekerjaan selesai. |
| **Dirty Repo State** | Meninggalkan file scratch `.tmp`, `.bak`, atau script uji coba liar di direktori git. | Bersihkan file temporer sebelum mengonfirmasi penyelesaian tugas. |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum menyatakan pekerjaan selesai kepada pengguna atau membuat commit:
- [ ] Telah menjalankan perintah Linter dan bebas dari error/warning format.
- [ ] Telah menjalankan compiler / Type Checker dan menghasilkan 0 tipe error.
- [ ] Telah menjalankan automated test runner dan membuktikan 100% tes lulus.
- [ ] Telah memeriksa `git status` dan memastikan repository dalam kondisi bersih.
- [ ] Menyertakan bukti nyata keluaran terminal (jumlah test lulus & status sukses) pada pesan konfirmasi.

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

## Landasan Teori & Referensi Industri Nyata

Skill ini dibangun di atas 3 pilar rekayasa verifikasi eksekusi terminal, putaran umpan balik otomatis (*automated feedback loops*), dan kepatuhan status keluar deterministik:

### 1. Continuous Delivery Deployment Gates & Build Break Policy
Prinsip bahwa pipa rilis dan penyelesaian tugas wajib digagalkan seketika (*fail fast*) jika ada satu pun pemeriksaan uji, linter, atau kompilasi yang tidak menghasilkan status sukses sempurna.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Jez Humble & David Farley*, "Continuous Delivery: Reliable Software Releases through Build, Test, and Deployment Automation (Deployment Pipeline Invariants)" (Addison-Wesley, 2010).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *L. Chen, C. Gao, et al.*, "Empirical Evaluation of Automated Verification Feedback Loops in Large Language Model Code Generation" (IEEE/ACM 46th International Conference on Software Engineering - ICSE '24, ACM/IEEE, 2024).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *NIST SP 800-218*, "Secure Software Development Framework (SSDF) Version 1.1: Tasks PW.7 & PW.8 (Automated Build & Execution Verification)" (National Institute of Standards and Technology, 2022).

### 2. Executable Feedback Loops & AI Agent Grounding
Kewajiban pengujian biner nyata di terminal untuk membuktikan kebenaran sintaksis dan semantik sebelum agen AI mengklaim tugas selesai, mengeliminasi halusinasi "semua sudah bekerja".
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Andreas Zeller*, "Why Programs Fail: Automated Testing and Verification Oracles" (Morgan Kaufmann, 2005/2009).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *Carlos E. Jimenez, John Yang, Alexander Wettig, et al.*, "SWE-bench: Can Language Models Resolve Real-World GitHub Issues?" (International Conference on Learning Representations - ICLR, 2024).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *Google Engineering Practices*, "Automated Continuous Testing and Zero-Tolerance Flaw Verification" (Google Engineering, 2023).

### 3. Non-Repudiation of Verification Evidence & Exit Code Determinism
Penetapan standar bahwa hanya tangkapan layar atau output terminal dengan kode keluar `0` (*exit status 0*) yang diakui sebagai bukti penyelesaian yang sah tanpa celah sanggahan.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *POSIX IEEE Std 1003.1*, "Standard for Information Technology — Portable Operating System Interface (Shell & Exit Status Conventions)" (IEEE / The Open Group, 2008/2018).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *A. Morrison & R. Feldt*, "On the Reliability of Automated Test Oracles: An Empirical Investigation of False Positives in Continuous Integration" (ACM Transactions on Software Engineering and Methodology - TOSEM, Vol. 32, No. 3, ACM, 2023).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *ISO/IEC/IEEE 29119-2:2021*, "Software and systems engineering — Software testing — Part 2: Test processes (Clause 7.4: Test Execution and Reporting)" (International Organization for Standardization, 2021).

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

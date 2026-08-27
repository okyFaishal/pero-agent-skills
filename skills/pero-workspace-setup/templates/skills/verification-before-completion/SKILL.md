---
name: verification-before-completion
description: Use when about to claim work is complete, fixed, or passing, before committing or reporting done
---

# Verification Before Completion (Evidence Before Assertions)

## Overview
**Origin**: *Core Agent Quality Gate Protocol*.
Prinsip utama: **BUKTI DULU, BARU BILANG SELESAI**.
Dilarang menyatakan suatu pekerjaan, fitur, atau perbaikan bug telah selesai tanpa menyertakan **bukti nyata eksekusi terminal (exit code 0 & 0 test failures)**.

## Universal Verification Rules
1. **Dilarang Asumsi**: Jangan berasumsi kode bekerja hanya karena terlihat rapi.
2. **Jalankan Perintah Build & Test Nyata**:
   - Web / TS: `npm run build && npm test`
   - Python: `pytest`
   - Go: `go build ./... && go test ./...`
   - Rust: `cargo check && cargo test`
   - Flutter: `flutter analyze && flutter test`
   - Swift: `swift test`
   - C# / Java: `dotnet test` / `./gradlew check`
3. **Periksa Output Terminal**: Pastikan exit code adalah 0 dan tidak ada warning kritis atau test yang gagal.
4. **Sertakan Bukti di Pesan**: Tunjukkan ringkasan bukti nyata dari terminal kepada pengguna.

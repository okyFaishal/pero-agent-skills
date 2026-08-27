---
name: env-guard
description: Use when interacting with environment variables, secrets, credentials, or running potentially destructive terminal commands
---

# Universal Environment & Terminal Safety Guard

## Overview
**Origin**: *Zero-Trust Secret Protection & Command Sandboxing Protocol*.
Satpam penjaga keamanan data rahasia dan pencegah eksekusi perintah terminal destruktif di semua lingkungan OS (macOS, Linux, Windows).

## Universal Safety Rules
1. **Perlindungan Kunci Rahasia**:
   - Dilarang mencetak nilai token, password, private key, atau isi file `.env` ke layar pesan.
   - File konfigurasi rahasia wajib selalu terdaftar di `.gitignore`.
2. **Penyaringan Perintah Destruktif**:
   - Dilarang menjalankan perintah penghapusan massal tanpa konfirmasi (misal: `rm -rf /`, drop database produksi).
   - Dilarang mengeksekusi skrip internet acak tanpa audit (`curl | bash` atau `eval`).
3. **Process Sandboxing**:
   - Proses latar belakang wajib memiliki timeout agar tidak menjadi proses zombie.

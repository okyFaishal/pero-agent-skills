---
name: env-guard
description: Use when interacting with environment variables, secrets, credentials, or running potentially destructive terminal commands
---

# Universal Environment & Terminal Safety Guard (`env-guard`)

## Overview
**Origin**: *OWASP Secrets Management & Zero-Trust Command Sandboxing Protocol*.  
Skill ini adalah **"Satpam Penjaga Keamanan Kredensial & Anti-Perintah Terminal Destruktif"**. Bertugas menjamin tidak ada kunci rahasia (API key, password, private key, token JWT, file `.env`) yang bocor ke log percakapan atau git commit, serta mencegah eksekusi perintah terminal liar yang dapat merusak file sistem pengguna.

> **Analogi Sederhana (ELI5):**  
> Bayangkan **Kotak Brankas & Tombol Darurat Pabrik**:
> - **Kecerobohan Kredensial**: Menempelkan kunci brankas dan PIN ATM di pintu kaca depan kantor yang bisa dibaca semua orang lewat.
> - **Perintah Destruktif**: Menekan tombol penghancur gedung tanpa mengecek apakah ada orang di dalamnya.
> - **Skill `env-guard`**: Satpam ketat yang otomatis menyensor PIN dengan tinta hitam (*redaction*) dan memasang gembok pengaman fisik pada tombol darurat agar tidak sengaja terpencet.

---

## 3 Pilar Perlindungan Lingkungan & Terminal

```
┌─────────────────────────────────────────────────────────────┐
│             3 PILAR PERLINDUNGAN ENV-GUARD                  │
├─────────────────────────────────────────────────────────────┤
│ 1. Secret Redaction : Sensor kunci rahasia dari log/chat   │
│ 2. Command Guard    : Blokir perintah destruktif massal     │
│ 3. Shell Sandboxing : Jalankan subprocess aman & timeout    │
└─────────────────────────────────────────────────────────────┘
```

---

### Pilar 1: Secret Redaction (Penyensoran Kunci Otomatis)
1. **Dilarang Mencetak File Sensitif**:
   - ❌ Dilarang membaca file `.env`, `.env.local`, `credentials.json`, `*.pem`, `*.key` dengan tujuan mencetak nilainya ke layar obrolan.
   - ✅ Hanya tampilkan nama variabel (*key only*), bukan nilainya (contoh: `DATABASE_URL=***REDACTED***`).
2. **Pola Regex Sensor Kredensial**:
   - Sensor string yang cocok dengan format token: `/(bearer\s+)?[a-zA-Z0-9_-]{20,}/i`, `ghp_[a-zA-Z0-9]{36}`, `sk-[a-zA-Z0-9]{48}`, `AIza[0-9A-Za-z-_]{35}`.
3. **Proteksi Version Control**:
   - Selalu pastikan file `.env`, `.env.*`, `*.pem`, `*.key`, `serviceAccountKey.json` terdaftar di `.gitignore`.

---

### Pilar 2: Command Guard (Daftar Hitam Perintah Destruktif)

| Kategori Bahaya | Perintah yang DILARANG KERAS | Risiko Fatal |
|---|---|---|
| **Penghapusan Massal Sistem** | `rm -rf /`, `rm -rf ~`, `rm -rf /*`, `rm -rf ./*` tanpa target spesifik | Kehilangan seluruh OS atau direktori induk. |
| **Kerusakan Disk & Format** | `mkfs.*`, `dd if=/dev/zero of=/dev/...`, `fdisk` | Partisi harddisk terhapus permanen. |
| **Injeksi Skrip Eksternal Liar** | `curl ... \| bash`, `wget ... \| sh` tanpa audit hash | Eksekusi malware tak dikenal. |
| **Operasi Database Destruktif** | `DROP DATABASE`, `TRUNCATE TABLE` langsung di lingkungan produksi | Data hilang tanpa pemulihan. |
| **Eksposur Kredensial di CLI** | `mysql -u root -p'my_secret_password'` (terlihat di `ps aux`) | Password terekam di riwayat proses sistem. |

---

### Pilar 3: Shell Subprocess Sandboxing & Hygiene
1. **Eksekusi Shell yang Disiplin**:
   - Gunakan `set -euo pipefail` di awal skrip Bash untuk mencegah eksekusi berlanjut jika ada perintah antara yang gagal.
   - Buat file sementara dengan izin terbatas: gunakan `umask 077` sebelum membuat temporary credential.
2. **Pengelolaan Proses Latar Belakang (*Background Task*)**:
   - Setiap proses latar belakang (dev server, watcher) wajib memiliki mekanisme penghentian (*kill*) dan batas waktu (*timeout*) agar tidak menjadi proses zombie yang menguras CPU/RAM.

---

## Contoh Pola: Menangani Kredensial

```bash
# ❌ POLA BURUK (Mencetak dan membocorkan token di terminal/history)
export GITHUB_TOKEN="ghp_1234567890abcdef1234567890abcdef"
echo "My token is: $GITHUB_TOKEN"
cat .env

# ✅ POLA BAIK (Menggunakan pipe / file descriptor aman & menyensor output)
# Menghindari argumen CLI yang terlihat di 'ps aux'
gh auth login --with-token < <(echo "$GITHUB_TOKEN")
# Verifikasi keberadaan variabel tanpa mencetak nilainya
if [[ -n "${GITHUB_TOKEN:-}" ]]; then
  echo "✓ GITHUB_TOKEN terdeteksi aman [Panjang: ${#GITHUB_TOKEN} karakter]."
fi
```

---

## Tabel Anti-Pola (*Anti-Patterns*)

| Pola Terlarang | Mengapa Berbahaya? | Solusi Wajib |
|---|---|---|
| **Hardcoded Secrets** | Menulis API key langsung di string kode sumber. | Muat dari environment variable dengan library pengelola config. |
| **Commit .env to Git** | Mengunggah file `.env` ke repositori git. | Tambahkan `.env` ke `.gitignore` dan sediakan `.env.example`. |
| **Unsafe Script Piping** | Menjalankan `curl url | sh` di target mesin tanpa inspeksi berkas. | Unduh berkas terlebih dahulu, verifikasi isinya, baru eksekusi. |
| **Pass Password as CLI Arg** | Mengirim password via parameter `--password=...`. | Gunakan STDIN piping atau file konfigurasi terproteksi (`chmod 600`). |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum menjalankan perintah terminal atau menyusun kode konfigurasi:
- [ ] Tidak ada token, API key, atau password yang tercetak dalam bentuk teks polos (*plain-text*) di chat.
- [ ] File sensitif (`.env`, `*.key`, `*.pem`) sudah terverifikasi ada di dalam `.gitignore`.
- [ ] Perintah terminal tidak mengandung pola destruktif yang berisiko merusak sistem (`rm -rf /`, dll).
- [ ] Skrip otomatisasi shell menggunakan pengaman `set -euo pipefail`.

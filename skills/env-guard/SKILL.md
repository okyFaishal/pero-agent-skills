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

## Landasan Teori & Referensi Industri Nyata

Skill ini dibangun di atas 3 pilar rekayasa keamanan komputasi, isolasi hak akses minimum (*least privilege*), dan pertahanan perimeter jaringan/terminal:

### 1. Principle of Least Privilege & Secrets Management
Prinsip bahwa sistem dan operator tidak boleh memiliki akses lebih dari yang mutlak dibutuhkan, serta kewajiban penyensoran rahasia (*secret redaction*) untuk mencegah kebocoran kredensial ke log publik atau git commit.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Jerome H. Saltzer & Michael D. Schroeder*, "The Protection of Information in Computer Systems (Principle of Least Privilege & Complete Mediation)" (Proceedings of the IEEE, Vol. 63, No. 9, 1975).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *M. Meli, M. R. McNiece, & B. Reaves*, "How Bad Can It Git? Characterizing Secret Leakage in Public GitHub Repositories and Automated Mitigation" (IEEE Symposium on Security and Privacy - S&P, IEEE, 2022).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *NIST SP 800-218*, "Secure Software Development Framework (SSDF) Version 1.1: Tasks PO.1 & PW.4 (Protecting Credentials & Preventing Hardcoded Secrets)" (National Institute of Standards and Technology, 2022).

### 2. Zero-Trust Sandboxing & Destructive Command Guardrails
Pembatasan eksekusi proses terminal liar melalui sanitasi argumen shell dan pemblokiran perintah destruktif tanpa konfirmasi pengguna.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Butler W. Lampson*, "A Note on the Confinement Problem" (Communications of the ACM, Vol. 16, No. 10, 1973).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *A. S. M. Touhidul Hasan et al.*, "Empirical Evaluation of Command Injection Vulnerabilities in Polyglot Developer Workspaces" (ACM Transactions on Software Engineering and Methodology - TOSEM, Vol. 32, No. 4, ACM, 2023).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *NIST SP 800-207*, "Zero Trust Architecture (ZTA)" (National Institute of Standards and Technology, 2020) & *US CISA*, "Principles and Approaches for Secure by Design Software" (Cybersecurity and Infrastructure Security Agency, 2023).

### 3. Network Perimeter SSRF Defense & Cloud Metadata Shielding
Pemblokiran akses jaringan agen ke subnet privat, antarmuka loopback lokal, dan alamat metadata penyedia cloud (*169.254.169.254*) untuk mengeliminasi celah Server-Side Request Forgery.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Steven M. Bellovin*, "Security Problems in the TCP/IP Protocol Suite" (Computer Communication Review, Vol. 19, No. 2, 1989).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *Y. Zhang, J. Chen, et al.*, "Server-Side Request Forgery in Modern Cloud-Native Environments: Attack Surfaces and Automated Mitigations" (IEEE Transactions on Dependable and Secure Computing - TDSC, Vol. 21, No. 1, IEEE, 2024).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *OWASP Foundation*, "OWASP Top 10:2021 — A10: Server-Side Request Forgery (SSRF) Prevention Cheat Sheet" (OWASP Standards, 2023).

---

## 4 Pilar Perlindungan Lingkungan, Jaringan & Terminal

```
┌─────────────────────────────────────────────────────────────┐
│             4 PILAR PERLINDUNGAN ENV-GUARD                  │
├─────────────────────────────────────────────────────────────┤
│ 1. Secret Redaction : Sensor kunci rahasia dari log/chat   │
│ 2. Command Guard    : Blokir perintah destruktif & scraping │
│ 3. Shell Sandboxing : Jalankan subprocess aman & timeout    │
│ 4. Network & SSRF   : Blokir akses IP privat & metadata     │
└─────────────────────────────────────────────────────────────┘
```

---

### Pilar 1: Secret Redaction (Penyensoran Kunci Otomatis)
1. **Dilarang Mencetak File Sensitif**:
   - ❌ Dilarang membaca file `.env`, `.env.local`, `credentials.json`, `*.pem`, `*.key` dengan tujuan mencetak nilainya ke layar obrolan.
   - ✅ Hanya tampilkan nama variabel (*key only*), bukan nilainya (contoh: `DATABASE_URL=***REDACTED***`, `OPENALEX_API_KEY=***REDACTED***`, `OPENALEX_MAILTO=***REDACTED***`).
2. **Pola Regex Sensor Kredensial**:
   - Sensor string yang cocok dengan format token: `/(bearer\s+)?[a-zA-Z0-9_-]{20,}/i`, `ghp_[a-zA-Z0-9]{36}`, `sk-[a-zA-Z0-9]{48}`, `AIza[0-9A-Za-z-_]{35}`, serta kunci API peladen MCP pihak ketiga (misalnya `OPENALEX_API_KEY`, `TAVILY_API_KEY`, `STITCH_API_KEY`).
3. **Proteksi Version Control**:
   - Selalu pastikan file `.env`, `.env.*`, `*.pem`, `*.key`, `serviceAccountKey.json` terdaftar di `.gitignore`.

---

### Pilar 2: Command Guard (Daftar Hitam Perintah Destruktif & Scraping Liar)

| Kategori Bahaya | Perintah yang DILARANG KERAS | Risiko Fatal |
|---|---|---|
| **Penghapusan Massal Sistem** | `rm -rf /`, `rm -rf ~`, `rm -rf /*`, `rm -rf ./*` tanpa target spesifik | Kehilangan seluruh OS atau direktori induk. |
| **Kerusakan Disk & Format** | `mkfs.*`, `dd if=/dev/zero of=/dev/...`, `fdisk` | Partisi harddisk terhapus permanen. |
| **Terminal Web Scraping Liar** | `curl -Is -L ...`, `curl ... > page.html`, `wget ...` untuk membaca web/cek tautan | Memicu blokir Cloudflare (403), membanjiri konteks dengan HTML mentah, dan memotong sandbox keamanan. Gunakan Search/Fetch MCP. |
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

### Pilar 4: Network & SSRF Guardrails (Pagar Jaringan & Anti-SSRF)
Untuk mencegah eksfiltrasi kredensial atau penetrasi jaringan privat:
1. **Pemblokiran Alamat Jaringan Internal / Privat**:
   - DILARANG melakukan permintaan web atau fetch ke alamat loopback/lokal: `127.0.0.1`, `localhost`, `0.0.0.0`, `::1`.
   - DILARANG mengakses subnet jaringan internal RFC 1918: `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`.
2. **Pemblokiran Endpoint Metadata Cloud Provider**:
   - DILARANG KERAS mengarahkan perkakas fetch/HTTP ke alamat IP metadata cloud: `169.254.169.254` (AWS/GCP/Azure link-local metadata) atau `metadata.google.internal`.
3. **Mandat Perkakas Resmi**:
   - Seluruh aktivitas penelusuran web eksternal wajib melewati perkakas terisolasi resmi (`search_web`, `read_url_content`, Fetch MCP, Puppeteer MCP) yang telah dilengkapi filter sanitasi.

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
| **Terminal Web Scraping** | Menjalankan `curl`, `wget`, atau python requests di terminal untuk membaca web/cek tautan. | Gunakan perkakas resmi `search_web`, `read_url_content`, atau Fetch MCP. |
| **SSRF / Internal Probing** | Mencoba memanggil IP lokal (`127.0.0.1`) atau metadata cloud (`169.254.169.254`). | Batasi pemanggilan web hanya ke domain publik resmi tervalidasi. |
| **Pass Password as CLI Arg** | Mengirim password via parameter `--password=...`. | Gunakan STDIN piping atau file konfigurasi terproteksi (`chmod 600`). |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum menjalankan perintah terminal atau menyusun kode konfigurasi:
- [ ] Tidak ada token, API key, atau password yang tercetak dalam bentuk teks polos (*plain-text*) di chat.
- [ ] File sensitif (`.env`, `*.key`, `*.pem`) sudah terverifikasi ada di dalam `.gitignore`.
- [ ] Perintah terminal tidak mengandung pola destruktif yang berisiko merusak sistem (`rm -rf /`, dll).
- [ ] Tidak menjalankan perintah terminal (`curl`/`wget`) untuk web scraping atau uji tautan (wajib gunakan perkakas Search/Fetch MCP).
- [ ] Permintaan web eksternal bebas dari target IP privat, loopback, dan endpoint metadata cloud (`169.254.169.254`).
- [ ] Skrip otomatisasi shell menggunakan pengaman `set -euo pipefail`.

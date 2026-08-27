---
name: pero-workspace-setup
description: Use when initializing a workspace, installing or updating standard skills in .agents/skills/, or configuring workspace governance rules in AGENTS.md
---

# Pero Workspace Setup (`pero:workspace-setup`)

## Overview
**Origin**: *Pero Custom Engineering Suite* (Universal Provisioner).
Skill ini bertindak sebagai **"Manajer Arsitek & Penata Meja Kerja Universal"**. Dirancang untuk **SEMUA jenis teknologi** (Web, Mobile, Backend API, Database, Desktop, CLI). Fungsinya menginisialisasi folder `.agents/skills/`, menyiapkan aturan tata kelola `AGENTS.md`, mengamankan `.gitignore`, serta menegakkan protokol Anti-Sycophancy dan penjelasan sederhana ("Bahasa Bayi"/ELI5).

## When to Use
- Menginisialisasi proyek baru dengan bahasa/framework apa pun (TypeScript, Go, Python, Rust, Swift, Dart/Flutter, Java, C#, PHP, Ruby, dll).
- Memeriksa kesehatan (*health check*) seluruh modul skill di workspace.
- Memulihkan (*repair*) skill yang rusak atau terhapus dari template bawaan.
- Sinkronisasi dengan repositori remote Git (GitHub) saat dipublikasikan.

## Quick Reference & Commands
| Operasi | Perintah | Keterangan |
|---|---|---|
| **Setup Universal (Lokal)** | `bash .agents/skills/pero-workspace-setup/scripts/install-skills.sh` | Instalasi mandiri (idempotent) |
| **Setup ke Proyek Lain** | `bash .agents/skills/pero-workspace-setup/scripts/install-skills.sh /path/to/target-project` | Pasang ke proyek apa pun di mesin |
| **Cek Kesehatan (Health Check)**| `bash .agents/skills/pero-workspace-setup/scripts/install-skills.sh --check` | Validasi kelengkapan & frontmatter |
| **Pulihkan dari Template** | `bash .agents/skills/pero-workspace-setup/scripts/install-skills.sh --repair` | Timpa ulang skill yang rusak |
| **Sync dari Remote GitHub** | `bash .agents/skills/pero-workspace-setup/scripts/install-skills.sh --remote <GIT_URL>` | Unduh versi mutakhir dari Git |

## Key Capabilities
1. **100% Universal & Polyglot**: Tidak terikat pada satu bahasa pemrograman atau OS tertentu.
2. **Offline Bundled Templates**: Membawa salinan lengkap 15 skill tanpa ketergantungan internet.
3. **Remote Git Sync Ready**: Siap terhubung ke GitHub sentral kapan saja.
4. **Auto-Guard `.gitignore`**: Memasang proteksi file rahasia (.env, keys, tokens).
5. **Safe Backup**: Menjaga file konfigurasi lama agar tidak tertimpa tanpa jejak.

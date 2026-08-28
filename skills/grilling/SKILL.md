---
name: grilling
description: Grill the user relentlessly about a plan, decision, or idea. Use when requirements are ambiguous, architectural trade-offs exist, before finalizing specifications, or when stress-testing ideas.
---

# Grilling (Universal Relentless Alignment & Stress-Testing)

## Overview
**Origin**: *Matt Pocock's Grilling Pattern & Universal Alignment Protocol*.  
Skill wawancara mendalam yang terstruktur untuk menguji ketahanan rencana (*stress-test*), membedah kompromi arsitektur (*trade-offs*), dan menyelaraskan pemahaman hingga 100% tanpa ada asumsi tersembunyi.

Ibarat **arsitek yang membedah denah pohon keputusan (*Design Tree*) bersama pemilik rumah**: setiap keputusan pokok akan membuka cabang keputusan baru di bawahnya.

## When to Use
- Kebutuhan ide produk, arsitektur, atau rencana teknis masih ambigu, terlalu umum, atau belum teruji ketahanannya.
- Terdapat trade-off arsitektur signifikan (misal: SQL vs NoSQL, Monolith vs Microservices, SSR vs SPA, Sync vs Async, REST vs gRPC).
- Dipanggil oleh tahapan hulu Pero SDLC:
  - `pero:problem-framing` (membedah pain points, batasan non-goals, dan persona).
  - `pero:prd-writing` (membedah prioritas fitur MVP P0 vs P1/P2).
  - `pero:user-stories` (membedah skenario ekstrem / *edge cases* dan aturan bisnis).
- Kapan pun pengguna meminta *"grill me"*, *"uji ide ini"*, *"stress-test rencanaku"*, atau *"bedah keputusanku"*.

## Protokol Kerja: Pohon Keputusan (*Design Tree*) & Ronde (*Rounds*)

### 1. Konsep Batas Terbuka (*Frontier*)
- Petakan seluruh keputusan ke dalam **Pohon Desain (*Design Tree*)**.
- **Frontier** adalah sekumpulan keputusan yang syarat-syarat sebelumnya sudah selesai disepakati dan bisa ditanyakan **saat ini juga** tanpa perlu menebak jawaban yang belum ada.
- Kerjakan pohon keputusan dalam **Sistem Ronde (*Rounds*)**: ajukan seluruh pertanyaan pada *frontier* saat ini dalam satu ronde terstruktur.
- Pertanyaan cabang yang masih bergantung pada jawaban pertanyaan lain yang belum diputuskan di ronde ini **DILARANG** ditanyakan sekarang; simpan untuk ronde berikutnya.

### 2. Format Baku Ronde Pertanyaan
Format setiap ronde wajib menggunakan struktur standar berikut:

```
❓ **Q1** - **<Judul Keputusan>**: <Penjelasan masalah dalam bahasa sederhana, berikan 2–4 pilihan konkret (A/B/C/D) dengan analogi sehari-hari (ELI5)>

➡️ **Rekomendasi**: <Pilihan rekomendasi terbaik menurut AI beserta alasan teknisnya yang kuat>

---

❓ **Q2** - **<Judul Keputusan>**: <Penjelasan masalah dan opsi pilihan terstruktur>

➡️ **Rekomendasi**: <Pilihan rekomendasi terbaik menurut AI beserta alasannya>
```

### 3. Hukum Pembagian Tugas: Fakta vs Keputusan
- **Mencari Fakta adalah Tugas AI**: Jika suatu pertanyaan pada frontier membutuhkan fakta dari lingkungan proyek (isi file, struktur folder, dependency, konfigurasi sistem, dokumentasi library), AI **WAJIB mencarinya sendiri** via tools pembaca berkas, terminal, atau sub-agen.
  - **DILARANG KERAS** menanyakan kepada pengguna hal-hal teknis yang bisa diperiksa sendiri oleh AI.
  - Jika pencarian fakta sedang berjalan (misal sub-agen sedang riset), jangan memblokir pertanyaan lain: ajukan pertanyaan frontier lain yang sudah siap sekarang.
- **Mengambil Keputusan adalah Hak Pengguna**: Sajikan opsi dan rekomendasi secara transparan, lalu tunggu jawaban pengguna sebelum membuka ronde berikutnya.

### 4. Standar Komunikasi Ramah (ELI5)
- Setiap opsi teknis wajib dijelaskan dengan **analogi dunia nyata** (misal: *"Database NoSQL ini seperti kotak kardus serbaguna tempat menaruh barang bentuk apa saja, sedangkan Relational Database seperti lemari berkas dengan sekat berlabel kaku"*).
- Hindari menumpuk istilah tanpa penjelasan: sertakan definisi 1 kalimat sederhana untuk setiap istilah teknis yang digunakan.

### 5. Batas Akhir (*Completion Criterion*)
Sesi grilling selesai ketika **frontier sudah kosong**: semua cabang pohon keputusan telah dijelajahi, disepakati, dan tidak ada lagi asumsi tersembunyi.
Dilarang langsung membuat kode atau mengeksekusi sebelum pengguna mengonfirmasi bahwa kesepahaman telah tercapai (*shared understanding*).


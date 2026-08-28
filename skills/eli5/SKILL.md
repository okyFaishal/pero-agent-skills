---
name: eli5
description: Transform complex technical concepts, architectures, and documentation into clear, layered explanations using concrete analogies and plain language without losing technical rigor. Use when explaining technical concepts, clarifying dense engineering topics, or auditing documentation clarity.
---

# ELI5 (Universal Technical Simplification & Layered Explanations)

## Overview
Skill untuk mentransformasi konsep teknis yang padat, istilah asing (*jargon*), dan arsitektur rumit menjadi penjelasan yang mudah dicerna oleh siapa saja (Explain Like I'm 5 / ELI5) tanpa mengurangi ketepatan fakta teknis.

Ibarat **penerjemah bahasa teknis ke bahasa manusia**: mengambil prinsip kerja mesin yang rumit dan menjelaskannya menggunakan perumpamaan benda sehari-hari yang sudah akrab bagi semua orang.

---

## When to Use
- Menjelaskan arsitektur, kode, pesan error, algoritma, atau istilah teknis kepada pengguna atau audiens non-teknis.
- Mengaudit dan menyederhanakan file dokumentasi (`.md`, `.mdx`) yang terlalu padat istilah atau membingungkan.
- Ketika pengguna meminta *"jelaskan dengan sederhana"*, *"apa maksudnya ini secara awam"*, *"ELI5"*, atau *"gunakan analogi"*.
- Bagian dari gerbang komunikasi standar (Rule 3 pada `AGENTS.md`).

---

## Filosofi Inti & Standar Komunikasi

### 1. Struktur Penjelasan 3-Lapis (*Layered Explanation*)
Setiap penjelasan konsep teknis wajib disusun secara bertingkat:

```
┌─────────────────────────────────────────────────────────────┐
│                 STRUKTUR 3-LAPIS (ELI5)                     │
├─────────────────────────────────────────────────────────────┤
│ Lapis 1: Analogi Nyata (Perumpamaan konkret sehari-hari)   │
│ Lapis 2: Bahasa Awam   (Alur kerja tanpa istilah rumit)     │
│ Lapis 3: Detail Teknis (Rincian mekanisme rekayasa senior)  │
└─────────────────────────────────────────────────────────────┘
```

* **Lapis 1 (Analogi Konkret):** Gunakan objek fisik dunia nyata (misal: lemari berkas, loket kasir, pelayan restoran, polisi lalu lintas). Jangan gunakan analogi abstrak.
* **Lapis 2 (Bahasa Awam):** Jelaskan alur kerja inti dan nilai manfaatnya (*why & what*) dengan kalimat ringkas dan mengalir.
* **Lapis 3 (Detail Teknis):** Jelaskan mekanisme teknis spesifik (nama protokol, pola arsitektur, konkurensi) agar insinyur senior tetap mendapatkan nilai teknis penuh.

---

### 2. Aturan Nada & Larangan Kata Meremehkan (*Tone & Anti-Condescension*)
Dilarang menggunakan kata-kata yang mengasumsikan hal tersebut sepele atau merendahkan pemahaman pembaca:

| ❌ Dilarang Keras | Alasan |
| :--- | :--- |
| *"Simply..."*, *"Tinggal..."*, *"Gampang saja..."* | Menyembunyikan kompleksitas dan membuat pembaca merasa dihakimi jika gagal paham. |
| *"Obviously..."*, *"Jelas bahwa..."*, *"Semua orang tahu..."* | Asumsi kosong yang meremehkan audiens. |
| *"Just run this..."*, *"Hanya perlu..."* | Mengabaikan potensi risiko atau prasyarat yang belum terpenuhi. |
| Emoji berlebihan (🚀, 💡, 🔥, ✨, 📌) | Mengotori keterbacaan teks dan memicu distorsi visual. |
| Basa-basi pembuka/penutup AI (*"Tentu saja!"*, *"Semoga membantu!"*) | Menghabiskan ruang baca tanpa memberi nilai informasi nyata. |

---

### 3. Akurasi Teknis Tidak Boleh Dikompromikan
* **Menyederhanakan bahasa BUKAN berarti mengurangi kebenaran fakta.**
* Jika suatu analogi memiliki batasan (tidak 100% mewakili mekanisme internal sistem), sebutkan batas analogi tersebut secara singkat agar tidak menimbulkan miskonsepsi.

---

## Alur Kerja: Menyederhanakan Dokumen Teknis (*Document Audit Mode*)

Jika dipanggil untuk menyederhanakan file dokumentasi (`.md`/`.mdx`):

1. **Identifikasi Kepadatan Jargon (*Jargon Density*):**
   * Cari singkatan yang belum diuraikan kepanjangannya pada pemunculan pertama.
   * Cari istilah teknis yang dipakai tanpa penjelasan konteks atau alasan mengapa fitur itu ada.
2. **Buat Perbandingan Sebelum & Sesudah (*Before/After*):**
   * Sajikan cuplikan teks asli yang rumit.
   * Sajikan versi baru yang sudah disederhanakan dengan struktur 3-lapis.
   * Jelaskan perbaikan apa yang dilakukan.
3. **Pertahankan Integritas:**
   * Jangan menghapus blok kode asli atau diagram penting.
   * Tingkatkan penjelasan naratif di sekitar kode/diagram tersebut.


---
name: anti-slop
description: Enforce zero-fluff, minimalist, high-signal engineering and eradicate AI-generated boilerplate, gratuitous comments, synthetic filler, and over-engineering.
---

# Universal Anti-Slop & High-Signal Engineering (`anti-slop`)

## Overview
**Origin**: *Anti-Slop Universal Engineering Standard + YAGNI Minimalist Architecture*.  
Skill ini adalah **"Filter Pemurni Kualitas Rekayasa & Anti-Sampah Sintetis"**. Menjamin setiap baris kode, teks, arsitektur, dan penjelasan yang dihasilkan agen AI bebas dari racun "AI Slop" (abstraksi berlebih, komentar sepele, basa-basi kosong, dan kode tiruan palsu).

> **Analogi Sederhana (ELI5):**  
> Bayangkan seorang **Penyunting & Chef Bintang Lima**:
> - **AI Slop**: Masakan cepat saji yang banyak tepung pengembang (*boilerplate* berlebih), micin kimia (*basa-basi pujian kosong*), dan sayur layu (*komentar kode tidak penting*).
> - **Skill `anti-slop`**: Pisau bedah dapur yang memotong semua lemak berlebih, memastikan hanya daging segar pilihan yang disajikan (*hanya kode esensial yang lolos tes*), dan menyajikan hidangan dengan cita rasa murni manusia.

---

## 3 Tingkat Aturan Anti-Slop (*3-Tier Rule Gates*)

```
┌─────────────────────────────────────────────────────────────┐
│                3 TINGKAT GERBANG ANTI-SLOP                  │
├─────────────────────────────────────────────────────────────┤
│ 1. Hard Gate     : Batas mutlak yang dilarang keras          │
│ 2. Purpose-Gate  : Abstraksi hanya jika ada alasan nyata    │
│ 3. Quality Locks : Kebersihan kode, teks & pengujian nyata  │
└─────────────────────────────────────────────────────────────┘
```

---

### Tier 1: Hard Gates (Batas Mutlak)

1. **Zero Conversational Fluff**:
   - ❌ DILARANG menggunakan kata pembuka/penutup basa-basi: *"Certainly!"*, *"Tentu saja!"*, *"Ide yang sangat hebat!"*, *"Semoga membantu! 🚀✨"*.
   - ✅ Langsung mulai dengan tindakan teknis, bukti nyata, atau jawaban langsung (*Action-First*).
2. **Zero Obvious / Gratuitous Comments**:
   - ❌ DILARANG menulis komentar yang sekadar menjelaskan *APA* yang diperbuat oleh kode (contoh: `// increment counter`, `// return user object`, `// set timeout to 5s`).
   - ✅ Komentar HANYA diizinkan untuk menjelaskan *MENGAPA* keputusan bisnis aneh atau solusi sementara (*workaround*) diambil.
3. **No Code Truncation / Placeholder Lazy Editing**:
   - ❌ DILARANG memotong kode dengan `// ... rest of code unchanged ...` atau `/* existing implementation */`.
   - ✅ Selalu sajikan blok kode lengkap atau edit bagian terarah secara presisi.
4. **No Ghost Dependencies / Hallucinated Imports**:
   - ❌ DILARANG mengimpor modul eksternal sebelum memverifikasi manifest proyek (`package.json`, `go.mod`, `Cargo.toml`, `pyproject.toml`).
   - ✅ Utamakan modul standar bawaan (*standard library*) bahasa terkait.

---

### Tier 2: Purpose-Gates (Larangan Over-Engineering / YAGNI)

1. **Minimum Viable Implementation**:
   - Tulis kode paling sederhana dan ringkas yang cukup untuk membuat failing test menjadi hijau.
   - Dilarang membuat lapisan abstraksi generik (*generic adapter, factory factory, dynamic registry*) jika hanya ada 1 pemanggil nyata.
2. **Reuse-First Protocol**:
   - Wajib melakukan pencarian berkas (`grep`/`find`) untuk memeriksa apakah proyek sudah memiliki fungsi utilitas serupa di `utils/` atau `helpers/` sebelum membuat fungsi baru.
3. **No Speculative Config & Flags**:
   - Jangan menambahkan parameter opsional atau opsi konfigurasi "jaga-jaga untuk masa depan" jika tidak diminta dalam spesifikasi.

---

### Tier 3: Quality Locks (Kode Bersih & Pengujian Nyata)

1. **No Hollow / Fake Tests**:
   - Dilarang membuat unit test yang hanya mengetes variabel tiruan (*mock*) tanpa menguji alur logika dan percabangan nyata.
   - Setiap tes wajib mampu gagal (*assertive*) jika implementasi diubah.
2. **Clean Tone & Natural Voice**:
   - Dilarang menggunakan pola kalimat klise AI dalam dokumentasi (contoh: *"In today's fast-paced world..."*, *"Not only X, but also Y"*).
   - Gunakan kalimat aktif, ringkas, dan langsung pada inti informasi.
3. **Safe Memory & Resource Hygiene**:
   - Seluruh koneksi, file stream, dan timer wajib ditutup secara eksplisit (*no dangling resources*).

---

## 4-Block Delivery Gate Report (Sebelum Selesai)

Sebelum menyatakan pekerjaan selesai atau membuka Pull Request, agen wajib memastikan seluruh 4 blok ini terpenuhi:

- [ ] **Block 1: Code Leanliness** → Tidak ada kode berlebih di luar acceptance criteria (YAGNI).
- [ ] **Block 2: Noise Elimination** → Bebas dari komentar sepele dan placeholder pemotongan kode.
- [ ] **Block 3: Real Execution** → Seluruh pengujian lulus di terminal nyata (bukan sekadar mock hijau).
- [ ] **Block 4: Grounded Imports** → Seluruh dependensi terdaftar resmi di manifest proyek.


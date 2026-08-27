---
name: living-doc-sync
description: Use when code changes impact system architecture, interfaces, directory structure, or documentation in docs/
---

# Universal Living Documentation Synchronizer

## Overview
**Origin**: *Living Architecture & Anti-Drift Documentation Standard*.
Mencegah terjadinya *Documentation Drift* pada teknologi apa pun. Memastikan gambar diagram Mermaid di `Architecture.md`, daftar API di `SystemSpec.md`, dan `README.md` selalu selaras dengan kode sumber terbaru.

## Synchronization Protocol
1. **Deteksi Perubahan Kode**: Periksa file apa saja yang baru diubah (`git diff --name-only`).
2. **Sinkronkan Dokumen**:
   - Struktur komponen / relasi modul berubah $ightarrow$ Perbarui diagram Mermaid di `docs/Architecture.md`.
   - Payload / endpoint berubah $ightarrow$ Perbarui `docs/SystemSpec.md`.
   - Cara build / dependensi berubah $ightarrow$ Perbarui `README.md`.
3. **Validasi Sintaksis Mermaid**: Pastikan blok diagram Mermaid dapat di-render dengan sempurna tanpa sintaksis rusak.

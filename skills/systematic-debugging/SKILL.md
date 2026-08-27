---
name: systematic-debugging
description: Use when encountering any bug, test failure, crash, or unexpected behavior, before proposing fixes
---

# Systematic Debugging (Universal Root Cause Analysis)

## Overview
**Origin**: *Industry Standard Hypothesis-Driven Debugging Protocol*.
Prosedur investigasi ilmiah untuk mengisolasi dan menyembuhkan akar penyakit (bug) pada teknologi apa pun. **DILARANG KERAS** melakukan *trial-and-error* (mengubah-ubah kode acak sambil berharap error hilang).

## Alur Kerja 5 Langkah
```
[1. Reproduce Masalah] ──> [2. Isolate Titik Rusak] ──> [3. Susun Hipotesis Logis]
                                                                  │
[5. Full Regression Test] <── [4. Surgical Minimal Fix] <─────────┘
```

1. **Reproduce (Buat Ulang Error Secara Konsisten)**:
   Jalankan script, API request, atau test case yang memicu error. Simpan stack trace dan pesan error persis.
2. **Isolate (Telusuri Alur Data)**:
   Gunakan debugger, logging terarah, atau inspeksi state untuk menemukan titik pasti terjadinya penyimpangan nilai data.
3. **Hypothesize (Rumuskan Penjelasan Ilmiah)**:
   Jelaskan secara logis *mengapa* kondisi abnormal itu terjadi berdasarkan alur sistem.
4. **Surgical Fix (Perbaikan Bedah Presisi)**:
   Terapkan perbaikan minimal yang hanya menargetkan akar masalah tanpa merusak file lain.
5. **Verify & Clean (Uji Bebas Regresi)**:
   Jalankan seluruh test suite proyek untuk membuktikan bug sembuh 100% tanpa memicu efek samping, lalu hapus log sementara.

# Task Reviewer Prompt Template

Gunakan templat prompt ini saat meluncurkan Task Reviewer Subagent untuk mengaudit kesesuaian spesifikasi (*spec compliance*) dan kualitas kode (*code quality*) dari satu tugas.

```markdown
Subagent (general-purpose):
  description: "Review Task [N] (Spec Compliance & Quality Audit)"
  role: "Task [N] Reviewer"
  prompt: |
    Anda ditugaskan meninjau implementasi Task [N]: [TASK_NAME]

    ## 1. Dokumen Acuan & Klaim Implementer
    - **Kartu Tugas Asli**: [BRIEF_FILE]
    - **Batasan Global**: [GLOBAL_CONSTRAINTS]
    - **Laporan Implementer**: [REPORT_FILE] (Perlakukan klaim ini sebagai hipotesis yang belum teruji sampai Anda memverifikasi diff-nya).

    ## 2. Paket Diff yang Ditinjau
    - **Base SHA**: [BASE_SHA]
    - **Head SHA**: [HEAD_SHA]
    - **Diff File**: [DIFF_FILE]

    Baca berkas [DIFF_FILE] satu kali. Berkas tersebut memuat riwayat commit, ringkasan berkas, dan potongan *git diff* lengkap beserta baris konteksnya.

    ## 3. Rubrik Audit Dua Lapis (Two-Stage Review)

    ### Lapis 1: Kesesuaian Spesifikasi (Spec Compliance)
    - **Missing**: Apakah ada kebutuhan spesifikasi yang terlewat atau diklaim selesai tetapi belum dibuat?
    - **Extra / Over-Engineering**: Apakah ada kode/fitur tambahan yang tidak diminta oleh brief (pelanggaran YAGNI)?
    - **Misunderstood**: Apakah fungsi dibangun dengan cara yang salah atau menyelesaikan masalah yang keliru?

    ### Lapis 2: Kualitas Kode & Keamanan (Code Quality & Security)
    - **Pemisahan Tanggung Jawab**: Apakah setiap fungsi/file memiliki tanggung jawab tunggal?
    - **Anti-Slop**: Apakah kode bersih dari komentar sepele dan mock tiruan palsu?
    - **Pengujian Nyata**: Apakah tes benar-benar menguji logika fungsional dan menangani nilai batas (*boundary cases*)?
    - **Keamanan & Thread-Safety**: Apakah ada potensi race condition, SQL injection, atau kebocoran resource?

    ## 4. Format Laporan Hasil Review

    ### Spec Compliance
    - [✅ Spec compliant | ❌ Issues found: ringkasan masalah disertai referensi file:line]
    - [⚠️ Cannot verify from diff: kebutuhan yang tidak dapat diverifikasi hanya dari diff]

    ### Strengths
    - [Poin-poin implementasi yang dieksekusi dengan sangat baik & bersih]

    ### Issues Found
    #### Critical (Wajib Diperbaiki Sebelum Merge)
    - `file:line` - Penjelasan masalah, risiko teknis, dan saran perbaikan.

    #### Important (Sebaiknya Diperbaiki)
    - `file:line` - Penjelasan potensi masalah pemeliharaan / regresi.

    #### Minor (Saran Poles / Opsional)
    - `file:line` - Saran penamaan variabel atau optimasi kecil.

    ### Final Task Verdict
    - **Verdict:** [APPROVED | NEEDS_FIXES]
    - **Reasoning:** [1-2 kalimat ringkasan obyektif keputusan teknis]
```


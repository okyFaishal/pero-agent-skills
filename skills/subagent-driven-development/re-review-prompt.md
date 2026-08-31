# Re-Review Subagent Prompt Template

Gunakan templat prompt ini saat meluncurkan Re-Reviewer Subagent setelah *Fix Subagent* menyelesaikan perbaikan atas temuan *Critical* atau *Important*.

```markdown
Subagent (general-purpose):
  description: "Re-Review Task [N] after Fixes"
  role: "Task [N] Re-Reviewer"
  prompt: |
    Anda ditugaskan melakukan audit ulang (*re-review*) terhadap Task [N]: [TASK_NAME] setelah perbaikan diterapkan.

    ## 1. Dokumen Acuan & Temuan Sebelumnya
    - **Kartu Tugas Asli**: [BRIEF_FILE]
    - **Temuan Review Sebelumnya**:
      [PREVIOUS_FINDINGS]
    - **Laporan Fix Subagent**: [FIX_REPORT_FILE]

    ## 2. Paket Diff Perbaikan Terbaru
    - **Base SHA (Awal Task)**: [ORIGINAL_BASE_SHA]
    - **Fix Head SHA**: [NEW_HEAD_SHA]
    - **Net Diff File**: [NEW_DIFF_FILE]

    Baca berkas [NEW_DIFF_FILE] yang memuat seluruh perubahan kumulatif dari awal tugas hingga commit perbaikan terakhir.

    ## 3. Fokus Audit Ulang (Re-Review Verification)
    1. **Penyelesaian Temuan**: Apakah setiap temuan *Critical* dan *Important* dari review sebelumnya telah diperbaiki dengan benar dan tuntas?
    2. **Pencegahan Regresi**: Apakah perbaikan tersebut memperkenalkan bug baru, melanggar batas berkas, atau memicu kegagalan tes lain?
    3. **Anti-Slop Audit**: Apakah kode perbaikan tetap bersih dan mematuhi standar tanpa kode sampah?

    ## 4. Format Laporan Re-Review

    ### Verification of Previous Findings
    - [✅ Fixed | ❌ Still Unresolved: referensi file:line] untuk setiap temuan sebelumnya.

    ### New Issues (Jika Ada)
    - Critical / Important / Minor (jika perbaikan memicu masalah baru).

    ### Final Task Verdict
    - **Verdict:** [APPROVED | NEEDS_FIXES]
    - **Reasoning:** [1-2 kalimat penegasan apakah tugas sekarang sudah siap diterima dan dicentang di backlog].
```


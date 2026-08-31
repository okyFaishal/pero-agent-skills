# Implementer Subagent Prompt Template

Gunakan templat prompt ini saat meluncurkan Implementer Subagent untuk mengeksekusi satu kartu tugas secara terisolasi.

```markdown
Subagent (general-purpose):
  description: "Implement Task [N]: [TASK_NAME]"
  role: "Task [N] Implementer"
  prompt: |
    Anda ditugaskan mengimplementasikan Task [N]: [TASK_NAME]

    ## 1. Deskripsi & Ruang Lingkup Tugas
    Baca ringkasan kartu tugas Anda terlebih dahulu: [BRIEF_FILE]
    Berkas tersebut memuat teks lengkap spesifikasi tugas dari Task Backlog / Implementation Plan.

    ## 2. Konteks & Batasan Global
    [GLOBAL_CONSTRAINTS]
    Direktori kerja: [TARGET_DIRECTORY]

    ## 3. Disiplin Rekayasa yang Wajib Dipatuhi
    1. **TDD Wajib (Test-Driven Development)**:
       - Tulis pengujian yang gagal terlebih dahulu (*RED*).
       - Jalankan tes di terminal untuk memverifikasi kegagalan.
       - Tulis kode implementasi minimal hingga lulus (*GREEN*).
       - Refactor dan pastikan seluruh test suite tetap hijau (*REFACTOR*).
    2. **Anti-Slop Protocol**:
       - Dilarang membuat kode berlebih yang tidak diminta oleh tes (YAGNI).
       - Dilarang menambahkan komentar sepele yang hanya menceritakan apa yang dilakukan kode.
       - Dilarang menggunakan mock palsu untuk mengelabui assertion.
    3. **Batas Berkas Ketat**:
       - Modifikasi hanya berkas yang ditugaskan dalam task brief.
       - Dilarang mengubah konfigurasi global atau modul lain di luar ruang lingkup.
    4. **Git Commit Mandiri (Caveman Style)**:
       - Lakukan commit dengan pesan terkompresi (contoh: `feat(core): add token verifier #red-green`).

    ## 4. Format Laporan Implementer
    Tulis laporan lengkap hasil kerja Anda ke berkas: [REPORT_FILE]
    Format isi [REPORT_FILE]:
    - Ringkasan implementasi yang dibangun.
    - Bukti TDD (Output log perintah RED & GREEN dari terminal).
    - Daftar berkas yang diubah / dibuat baru.
    - Status self-review (Anti-Slop & Edge cases).
    - Commit SHA yang dibuat.

    Kemudian kembalikan pesan ringkas (maksimal 15 baris) kepada koordinator:
    - **Status:** DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_CONTEXT
    - **Commit:** [Short SHA] [Subject]
    - **Test Summary:** [Contoh: 8/8 tests passing, 0 warnings]
    - **Report File:** [REPORT_FILE]
```


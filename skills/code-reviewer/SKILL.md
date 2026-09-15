---
name: code-reviewer
description: Use when completing tasks, implementing major features, or before merging to verify work meets requirements and quality standards
---

# Universal Two-Stage Code Reviewer (`code-reviewer`)

## Overview
**Origin**: *Google Engineering Practices (eng-practices) + Fagan Inspection Method + OWASP Secure Code Review Standards*.  
Skill ini adalah **"Gerbang Audit Kualitas Dua Tahap & Penjaga Keamanan Kode"**. Menegakkan peninjauan kode yang obyektif berbasis bukti (*evidence-based*), memisahkan audit kesesuaian spesifikasi fungsional dari audit keamanan/kualitas teknis, dan mencegah kebocoran bug atau celah keamanan sebelum kode digabungkan (*merge*).

> **Analogi Sederhana (ELI5):**  
> Bayangkan **Pemeriksaan Paspor & Kargo di Bandara Internasional**:
> - **Petugas 1 (Kesesuaian Tiket & Identitas / Gate 1 - Spec Match)**: Memeriksa apakah nama penumpang cocok dengan tiket pesawat dan tujuan penerbangan sesuai jadwal (apakah fitur yang dibuat benar-benar yang diminta pengguna).
> - **Petugas 2 (Mesin X-Ray & Bea Cukai / Gate 2 - Security & Safety)**: Memindai koper untuk mendeteksi barang berbahaya, bahan peledak, atau kebocoran racun (memeriksa celah keamanan SQL injection, kebocoran memori, race condition, dan kualitas kode bersih).

## Sub-Skill Integration (Perkakas Pendukung)
Dalam menjalankan proses audit peninjauan kode, agent WAJIB mengorkestrasi sub-skill berikut:
- **Pengawas Mutu Task Otonom**: **`SUPPORTING SUB-SKILL`**: Gunakan [`subagent-driven-development`](../subagent-driven-development/SKILL.md) untuk menjalankan peran Task Reviewer Subagent (verifikasi git diff per task) dan Final Merge Reviewer di akhir cabang.
- **Penyaring Kode Bebas Sampah**: **`REQUIRED SUB-SKILL`**: Gunakan [`anti-slop`](../anti-slop/SKILL.md) untuk memastikan tidak ada kode berlebih (YAGNI), komentar sepele, atau mock palsu yang lolos review.
- **Verifikasi Bukti Terminal**: **`REQUIRED SUB-SKILL`**: Gunakan [`verification-before-completion`](../verification-before-completion/SKILL.md) untuk memastikan tes terminal benar-benar hijau sebelum memberi persetujuan (*approval*).

---

## Landasan Teori & Referensi Industri Nyata

Skill ini dirancang berdasarkan 3 pilar rekayasa peninjauan kode modern yang memadukan asal-usul inspeksi formal (*Foundational Classics*) dengan studi empiris 5 tahun terakhir (2021–2026) dan standar resmi industri:

### 1. Two-Stage Code Inspection & Cognitive Load Optimization
Pemisahan peninjauan menjadi dua tahap terfokus (Kesesuaian Spesifikasi vs Kualitas/Keamanan Kode) untuk mengeliminasi bias kelelahan inspeksi (*review fatigue*) dan memaksimalkan penemuan bug logis.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Michael E. Fagan*, "Design and Code Inspections to Reduce Errors in Program Development" (IBM Systems Journal, Vol. 15, No. 3, 1976).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *A. Bacchelli, C. Bird, et al.*, "Modern Code Review in Practice: A Large-Scale Empirical Study on Defect Detection and Inspection Fatigue" (ACM Transactions on Software Engineering and Methodology - TOSEM, Vol. 32, No. 4, ACM, 2023).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *Google Engineering Practices*, "Code Review Developer Guide (eng-practices): Standards, Speed, and Rigor" (Google Open Source Documentation, 2023).

### 2. Threat Modeling & Secure Code Review Standards
Audit keamanan proaktif berdasarkan taksonomi kelemahan perangkat lunak untuk mendeteksi celah injeksi, kebocoran rahasia, dan pelanggaran kontrol akses.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Michael Howard & David LeBlanc*, "Writing Secure Code" (Microsoft Press, 2003).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *M. Morrison, K. Herzig, et al.*, "Vulnerabilities Unveiled: Automated vs Human-in-the-Loop Security Code Review in High-Assurance Systems" (IEEE/ACM 46th International Conference on Software Engineering - ICSE '24, ACM/IEEE, 2024).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *NIST SP 800-218*, "Secure Software Development Framework (SSDF) Version 1.1: Tasks PW.4 & RV.1 (Reviewing Code for Security Vulnerabilities)" (National Institute of Standards and Technology, 2022) & *OWASP Foundation*, "OWASP Top 10 Security Risks & Code Review Guide" (2023).

### 3. Static Analysis Guardrails & Cognitive Complexity Metrics
Validasi otomatis menggunakan analisis statis dan metrik kompleksitas kognitif untuk memastikan kode mudah dipelihara dan tidak membingungkan pengembang masa depan.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Thomas J. McCabe*, "A Complexity Measure" (IEEE Transactions on Software Engineering, Vol. SE-2, No. 4, 1976).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *G. Annunziata, A. Serebrenik, et al.*, "Cognitive Complexity in Modern Code Review: Evaluating Readability and Maintenance Bottlenecks" (Empirical Software Engineering, Springer, Vol. 28, 2023).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *ISO/IEC 25010:2023*, "Systems and software engineering — Systems and software Quality Requirements and Evaluation (SQuaRE) — Product quality model (Clause 4.2.7: Maintainability & Analyzability)" (International Organization for Standardization, 2023).

---

## 4-Step Review Workflow

```
┌─────────────────────────────────────────────────────────────┐
│               ALUR 4 LANGKAH PENINJAUAN KODE                │
├─────────────────────────────────────────────────────────────┤
│ Step 1: Build Context & Grounding (Buka berkas utuh & tipe) │
│ Step 2: Categorize Code Category  (Executable vs Demo)      │
│ Step 3: Run Polyglot Tooling      (Compiler, Linter, SAST)  │
│ Step 4: Two-Stage Gatekeeper Audit (Spec Match & Quality)   │
└─────────────────────────────────────────────────────────────┘
```

### Step 1: Build Context & Grounding
1. **Full File Context**: Buka dan baca berkas target secara utuh di sekitar area perubahan (*diff*), bukan hanya cuplikan baris yang diubah.
2. **Retrieval Over Pre-Training**: Buka berkas kontrak tipe data lokal (`.d.ts`, `.proto`, DTO, entity schema) untuk memverifikasi keakuratan tipe dan nama fungsi.
3. **Periksa Riwayat Git**: Jalankan `git log --oneline -5 -- <file>` jika memerlukan konteks historis arsitektur.

### Step 2: Categorize the Code
Tentukan kategori kode untuk menetapkan ambang batas ketat:
*   **Illustrative (Snippet Konsep/Dokumentasi)**: Penamaan API wajib realistis dan alur penjelasan logis.
*   **Demonstrative (Cuplikan Fungsional)**: Wajib valid secara sintaksis dan sesuai kontrak antarmuka.
*   **Executable (Kode Produksi)**: Wajib 100% lulus kompilasi, lulus linter, memiliki automated unit test, dan bebas celah keamanan.

### Step 3: Run Polyglot Tooling Checks
Jalankan compiler dan linter lokal sebelum memberikan penilaian kualitatif:
*   **TypeScript/Node**: `npx tsc --noEmit` & `npx eslint <files>`
*   **Python**: `mypy <files>` & `ruff check <files>`
*   **Go**: `go vet ./...` & `golangci-lint run`
*   **Rust**: `cargo check` & `cargo clippy`
*   **C# / Java**: `dotnet build` / `./gradlew compileJava`

### Step 4: Two-Stage Gatekeeper Audit

#### Gate 1: Spec & Interface Compliance (Kesesuaian Spesifikasi)
- [ ] **Acceptance Criteria**: Seluruh kriteria penerimaan pada PRD/User Story terpenuhi 100%.
- [ ] **Anti-Bloat (YAGNI)**: Tidak ada kode ekstra, parameter tak terpakai, atau fitur sampingan yang tidak diminta.
- [ ] **Contract Alignment**: Payload data dan nama endpoint sesuai dengan kontrak API yang disepakati.

#### Gate 2: Code Quality, Concurrency & Security (Kualitas & Keamanan)
- [ ] **Sanitasi Input (OWASP)**: Parameter bebas dari celah SQL Injection, Cross-Site Scripting (XSS), dan Path Traversal.
- [ ] **Zero Credential Leaks**: Tidak ada API key, token rahasia, atau kata sandi yang di-hardcode ke dalam kode sumber.
- [ ] **Concurrency & Thread-Safety**: Aman dari benturan akses data simultan (*race conditions*, *deadlock*, unhandled async promises).
- [ ] **Resource Management**: Seluruh koneksi database, stream berkas, dan timer ditutup secara eksplisit (*no memory leaks*).
- [ ] **Robust Error Handling**: Tidak ada error yang ditelan tanpa log (*no empty catch blocks*).
- [ ] **Boundary Test Coverage**: Memiliki pengujian otomatis untuk kasus positif, kasus gagal (*edge cases*), dan nilai batas ekstrem.

---

## Klasifikasi Keparahan Temuan (*Severity Matrix*)

Setiap temuan review wajib diberi label keparahan yang jelas:

| Tingkat Keparahan | Dampak | Tindakan Wajib |
|---|---|---|
| 🔴 **BLOCKING (Kritis)** | Celah keamanan, kebocoran rahasia, data race, atau kegagalan kriteria penerimaan. | Kode **DITOLAK**. Wajib diperbaiki dan diuji ulang sebelum boleh di-merge. |
| 🟡 **WARNING (Penting)** | Ketiadaan validasi nilai batas, duplikasi kode (DRY violation), atau performa suboptimal. | Wajib didiskusikan atau diperbaiki sebelum rilis produksi. |
| 🟢 **NITPICK (Saran Kecil)** | Perbaikan gaya penamaan minor atau saran estetika kode. | Opsional. Penggabungan kode tidak boleh ditahan hanya karena nitpick. |

---

## Tabel Anti-Pola Peninjauan (*Review Anti-Patterns*)

| Pola Terlarang | Mengapa Dilarang Keras? | Solusi Wajib |
|---|---|---|
| **Diff-Only Blind Review** | Menilai kode hanya dari potongan diff git tanpa melihat konteks berkas utuh. | Buka dan baca berkas utuh di workspace untuk memahami aliran data. |
| **Bikeshedding / Nitpick Overload** | Menghabiskan energi memperdebatkan spasi atau nama variabel minor sambil melewatkan celah keamanan SQL injection. | Utamakan Gate 1 (Kesesuaian Spek) dan Gate 2 (Keamanan/Stabilitas) sebelum hal kosmetik. |
| **Rubber-Stamping** | Memberikan persetujuan instan (*"LGTM!"*) tanpa pernah menjalankan compiler atau membaca kode secara kritis. | Jalankan compiler/linter dan centang seluruh daftar periksa Two-Stage Audit. |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum menyetujui perubahan kode atau membuka Pull Request:
- [ ] Telah membaca berkas target secara utuh bersama berkas kontrak/skema lokal terkait.
- [ ] Telah menjalankan compiler dan linter lokal dengan hasil 0 error.
- [ ] Memverifikasi 100% kriteria penerimaan fungsional terpenuhi (Gate 1).
- [ ] Memverifikasi kode bebas dari celah keamanan OWASP dan kebocoran resource (Gate 2).
- [ ] Memberikan label keparahan yang jelas pada setiap komentar temuan (Blocking vs Nitpick).


---
name: pero-change-management
description: Orchestrate mid-flight scope pivots, feature additions, modifications, or removals across the Pero SDLC lifecycle. Use when adding, changing, or deleting features or requirements during or after task execution.
---

# Universal Change & Scope Pivot Manager (`pero-change-management`)

## Overview
**Origin**: *Change Management Architecture (ITIL / CMII) + Agile Scope Refactoring + Blast Radius Isolation*.  
Skill ini adalah **"Pengatur Lalu Lintas Revisi & Pivot Proyek"**. Bertugas mengorkestrasi perubahan saat pengguna ingin menambah (*ADD*), mengubah (*MODIFY/PIVOT*), atau menghapus (*REMOVE*) fitur di tengah-tengah pengerjaan tugas (*in-flight*) maupun setelah tugas selesai (*post-completion*). Skill ini mencegah terjadinya kode buta (*blind coding*), kerusakan regresi tak terduga (*blast radius unchecked*), dan tugas menggantung (*zombie tasks*).

> **Analogi Sederhana (ELI5):**  
> Bayangkan pembangunan **Gedung Bertingkat**:
> - Tukang batu sedang sibuk mengecor lantai dua. Tiba-tiba pemilik gedung berteriak: *"Stop! Saya ingin tangga darurat dibongkar dan diganti lift kapsul kaca!"*
> - **Jika tanpa Mandor Revisi**: Tukang batu akan terus mengecor tangga yang akan dibongkar (buang-buang semen), atau tukang lain langsung menghantam pilar beton dengan godam sehingga seluruh atap retak (*regression*).
> - **Dengan `pero-change-management` (Mandor Revisi)**: Mandor langsung meniup peluit agar pengecoran tangga berhenti seketika (*pause task*), menghitung apakah beban lift kaca aman bagi pondasi (*analisis dampak*), membatalkan jadwal kerja tangga di papan tulis (*superseded/cancelled*), memperbarui denah arsitek, baru kemudian menyuruh tukang mulai bekerja dengan aman.

---

## When to Use
- **Penambahan Fitur (*ADD*)**: Pengguna ingin menyisipkan kemampuan baru di tengah proses pengembangan atau setelah rilis MVP.
- **Perubahan Arah / Revisi (*MODIFY / PIVOT*)**: Pengguna ingin mengganti alur kerja, integrasi pihak ketiga (misal: SMS diganti Google OAuth), skema database, atau tampilan UI yang sedang atau sudah dibuat.
- **Penghapusan Fitur (*REMOVE / DEPRECATE*)**: Pengguna memutuskan membuang sebuah fitur, endpoint API, tabel data, atau komponen antarmuka yang sudah tidak terpakai.
- **Konflik Tugas di Tengah Jalan**: Terjadi perubahan arah yang membuat kartu tugas aktif di `docs/TaskBacklog.md` atau `docs/tasks/TASK-[ID].md` menjadi tidak relevan.

---

## Alur Kerja 4 Fase Manajemen Perubahan

```
┌─────────────────────────────────────────────────────────────┐
│          4 FASE SIKLUS PERO CHANGE MANAGEMENT               │
├─────────────────────────────────────────────────────────────┤
│ 1. Change Triage & Scale Classification (Mikro vs Makro)    │
│ 2. Blast Radius Scan & Active Task State Control (No Zombie)│
│ 3. Cascade Specification Reconciliation (Top-Down Entry)    │
│ 4. Execution Handoff & Clean Removal (TDD & Safe Cleanup)   │
└─────────────────────────────────────────────────────────────┘
```

---

### Fase 1: Change Triage & Classification

Agent mengidentifikasi tipe permintaan perubahan dan mengelompokkan skala dampaknya:

#### A. Tipe Tindakan (*Action Type*)
1. **`ADD` (Penambahan)**: Menambah kapabilitas baru tanpa merusak fungsi yang sudah ada.
2. **`MODIFY / PIVOT` (Perubahan)**: Mengubah logika, kontrak antarmuka, aliran data, atau tampilan yang sudah berjalan.
3. **`REMOVE` (Penghapusan)**: Menghilangkan fungsionalitas lama beserta kode, tes, dan dokumentasinya secara bersih.

#### B. Skala Dampak (*Impact Scale*)
1. **Patch / Micro**:
   - Cakupan: Perbaikan bug kecil, penyesuaian teks label, warna tombol sekunder, atau validasi field sederhana.
   - Penanganan: Tidak perlu merombak PRD/Arsitektur. Langsung sesuaikan kartu tugas terkait di `docs/tasks/TASK-[ID].md` dan jalankan TDD.
2. **Minor / Feature**:
   - Cakupan: Menambah alur fitur baru, menambah endpoint API baru, atau tabel baru yang tidak merusak modul utama.
   - Penanganan: Masuk dari `docs/SystemSpec.md` dan `docs/DesignSystem.md`, perbarui `docs/TaskBacklog.md`, lalu eksekusi.
3. **Major / Architectural Pivot**:
   - Cakupan: Mengganti framework, mengubah alur autentikasi inti, mengubah database relasional ke document store, atau menghapus modul bisnis utama.
   - Penanganan: Wajib masuk dari tingkat teratas (`docs/PRD.md` atau `docs/ProblemFraming.md`), jalankan gerbang Grilling, audit arsitektur (`docs/Architecture.md`), dan rekam keputusan `CRDR`.

---

### Fase 2: Blast Radius Scan & Active Task State Control

Sebelum satu baris kode pun diubah, Agent wajib memetakan area dampak dan menertibkan status tugas aktif di `docs/TaskBacklog.md`:

#### A. Pemindaian Area Terdampak (*Blast Radius Scan*)
Periksa berkas apa saja yang akan terpengaruh:
1. **Modul Kode**: File controller, service, domain entity, UI component, atau helper utilitas.
2. **Pengujian**: Unit test, integration test, atau e2e test yang akan gagal akibat perubahan logika.
3. **Dokumen & Diagram**: Diagram C4 di `docs/Architecture.md`, kontrak API di `docs/SystemSpec.md`, atau wireframe di `docs/DesignSystem.md`.

#### B. Penertiban Status Tugas Aktif (Anti-Zombie Tasks)
Jika ada tugas di `docs/TaskBacklog.md` yang sedang berstatus `IN_PROGRESS` atau `TODO` yang bertentangan dengan perubahan:
1. **Hentikan Segera (*Immediate Pause*)**:
   - Hentikan pekerjaan pada tugas lama. Jangan menulis kode yang akan langsung dibuang.
2. **Transisi Status Baku**:
   - `SUPERSEDED`: Tugas digantikan oleh kartu tugas baru yang lebih relevan.
   - `CANCELLED`: Tugas dibatalkan sepenuhnya karena fiturnya dihapus.
   - `PAUSED`: Tugas ditunda sementara menunggu kejelasan spesifikasi baru.
3. **Catat Alasan di Backlog**:
   ```markdown
   - [x] TASK-004: Implementasi Autentikasi SMS Gateway (STATUS: SUPERSEDED by TASK-012 per CRDR-202609081230 - Diganti Google OAuth)
   ```

---

### Fase 3: Cascade Specification Reconciliation (Pintu Masuk Terarah)

Agent menentukan titik masuk (*entry point*) yang tepat pada 9 dokumen inti. Dilarang melompat langsung ke koding jika dokumen spesifikasi belum diselaraskan!

```
                               PINTU MASUK SESUAI SKALA
                                          │
    ┌─────────────────────────────────────┴─────────────────────────────────────┐
    ▼                                     ▼                                     ▼
[Pivotal / Problem]              [Feature / Contract]                  [Local / UI-Only]
docs/ProblemFraming.md           docs/SystemSpec.md                    docs/DesignSystem.md
docs/PRD.md                      docs/Architecture.md                  docs/tasks/TASK-[ID].md
    │                                     │                                     │
    └─────────────────────────────────────┼─────────────────────────────────────┘
                                          ▼
                               docs/TaskBacklog.md (Update Status & New Tasks)
                                          ▼
                               docs/tasks/TASK-[ID].md (Granular Spec)
                                          ▼
                               docs/decisions/CRDR-[YYYYMMDDHHmm].md
```

1. **Jika Menambah Fitur (*ADD*)**:
   - Tambahkan skenario Gherkin di `docs/SystemSpec.md`.
   - Tambahkan kartu tugas baru di `docs/TaskBacklog.md`.
   - Rinci kartu tugas baru di `docs/tasks/TASK-[ID].md`.
2. **Jika Mengubah Fitur (*MODIFY / PIVOT*)**:
   - Perbarui kontrak di `docs/SystemSpec.md` dan diagram alur di `docs/Architecture.md`.
   - Tandai tugas lama sebagai `SUPERSEDED`, buat kartu tugas baru pengganti.
3. **Jika Menghapus Fitur (*REMOVE*)**:
   - Hapus skenario fitur dari `docs/SystemSpec.md`.
   - Hapus komponen terkait dari diagram di `docs/Architecture.md` dan `docs/DesignSystem.md`.
   - Tandai seluruh tugas terkait di `docs/TaskBacklog.md` sebagai `CANCELLED`.
4. **Pencatatan Keputusan**:
   - Rekam perubahan ke dalam `docs/decisions/CRDR-[YYYYMMDDHHmm].md` (*Change Request Decision Record*).

---

### Fase 4: Execution Handoff & Safety Protocol

#### A. Protokol Penambahan / Perubahan (ADD & MODIFY)
1. **Gunakan TDD (`test-driven-development`)**:
   - Selalu tulis failing test terlebih dahulu untuk skenario atau kontrak baru.
   - Implementasikan fungsi kode baru hingga seluruh tes lulus (*Green*).
   - Refactor tanpa mengubah perilaku.
2. **Verifikasi Terminal (`verification-before-completion`)**:
   - Jalankan seluruh rangkaian tes (`npm test`, `pytest`, `cargo test`, dll.) untuk memastikan tidak ada fitur lama yang rusak.

#### B. Protokol Penghapusan Bersih (*Clean Removal / Dead Code Elimination*)
Menghapus kode harus dilakukan secara metodis agar tidak meninggalkan sampah atau error tersembunyi:
1. **Langkah 1 (Audit Referensi)**: Cari seluruh import dan pemanggilan fungsi/komponen yang akan dihapus menggunakan `grep_search`.
2. **Langkah 2 (Hapus Tes Terkait)**: Hapus atau sesuaikan unit test yang secara eksplisit menguji fitur lama.
3. **Langkah 3 (Hapus Kode Implementasi)**: Hapus file atau blok kode fitur yang sudah tidak terpakai.
4. **Langkah 4 (Bersihkan Dependensi Yatim)**: Jika ada package/library pihak ketiga yang hanya digunakan oleh fitur yang dihapus, hapus dari `package.json` / `requirements.txt` / `Cargo.toml`.
5. **Langkah 5 (Uji Kompilasi & Build)**: Jalankan build dan test di terminal untuk memastikan nol kegagalan impor (*zero broken imports*).
6. **Langkah 6 (Pemicuan Sinkronisasi Dokumen)**: Panggil [`living-doc-sync`](file:///Users/okyfaishal/project/pero-agent-skills/skills/living-doc-sync/SKILL.md) untuk mendeteksi berkas yang terhapus dan menyinkronkan diagram dokumen.

---

## Interactive Grilling Pause Gate: Kesepakatan Strategi Perubahan

Sebelum mengeksekusi perubahan skala Minor atau Major, Agent **WAJIB** berhenti sejenak dan menggunakan tool `ask_question` untuk menyepakati strategi perubahan dengan pengguna:

```json
{
  "toolSummary": "Change Request Alignment",
  "toolAction": "Asking questions",
  "questions": [
    {
      "question": "Bagaimana strategi penanganan data lama dan tugas aktif untuk perubahan fitur ini?",
      "options": [
        "(Recommended) Jalankan Top-Down Cascade: batalkan tugas lama (SUPERSEDED), buat kartu tugas baru di backlog, dan perbarui skenario uji terlebih dahulu.",
        "Quick Patch Terisolasi: langsung ubah kode dan unit test secara lokal tanpa mengubah dokumen arsitektur tingkat atas.",
        "Pertahankan Keduanya (Dual-Run): pertahankan fitur lama sebagai fallback terdepresiasi dan bangun fitur baru di endpoint/komponen terpisah."
      ],
      "is_multi_select": false
    }
  ]
}
```

---

## Template Dokumen Keputusan Perubahan (`CRDR`)

Setiap perubahan skala Minor atau Major wajib dicatat di `docs/decisions/CRDR-[YYYYMMDDHHmm].md`:

```markdown
# CRDR-[YYYYMMDDHHmm]: [Judul Singkat Perubahan / Pivot]

- **Status**: [PROPOSED | ACCEPTED | SUPERSEDED]
- **Tanggal**: YYYY-MM-DD HH:mm
- **Tipe Perubahan**: [ADD | MODIFY/PIVOT | REMOVE]
- **Skala Dampak**: [Patch/Micro | Minor/Feature | Major/Architectural Pivot]
- **Pintu Masuk Dokumen**: [docs/ProblemFraming.md | docs/PRD.md | docs/SystemSpec.md | docs/Architecture.md | docs/DesignSystem.md | docs/TaskBacklog.md]

## 1. Konteks & Alasan Perubahan (Why)
[Jelaskan mengapa perubahan ini diminta oleh pengguna, apa masalah pada rancangan sebelumnya, atau peluang baru apa yang ingin dicapai]

## 2. Analisis Area Dampak (Blast Radius)
- **Komponen/Berkas Terdampak**: [Daftar file kode dan dokumen yang terimbas]
- **Kontrak/API Berubah**: [Endpoint, skema DTO, atau event yang terpengaruh]
- **Dampak Data/Migrasi**: [Apakah memerlukan migrasi tabel atau format data lama]

## 3. Penertiban Status Tugas (Task Reconciliation)
- **Tugas Lama yang Dibatalkan / Digantikan**:
  - `TASK-[ID]`: [Alasan SUPERSEDED / CANCELLED]
- **Tugas Baru yang Ditambahkan**:
  - `TASK-[NEW_ID]`: [Deskripsi singkat tugas baru]

## 4. Rencana Transisi & Pengujian
- [ ] Dokumen spesifikasi dan diagram diselaraskan.
- [ ] Failing test (TDD) disusun untuk skenario baru.
- [ ] Kode lama dibersihkan (khusus REMOVE / MODIFY).
- [ ] Full regression test suite terminal exit code 0.
```

---

## Tabel Anti-Pola (*Anti-Patterns*)

| Anti-Pola Terlarang | Mengapa Berbahaya | Yang Wajib Dilakukan |
|---|---|---|
| **Blind Code Editing** | Mengubah file kode langsung tanpa memeriksa dokumen arsitektur dan relasi dependensi lain. | Jalankan Fase 1 & 2: petakan blast radius dan tentukan pintu masuk dokumen. |
| **Zombie Tasks** | Membiarkan tugas lama tetap berstatus `TODO` atau `IN_PROGRESS` padahal fiturnya sudah dibatalkan. | Ubah status tugas lama menjadi `SUPERSEDED` atau `CANCELLED` lengkap dengan catatan alasan. |
| **Dirty Removal (Zombie Code)** | Menghapus tombol di antarmuka namun membiarkan fungsi backend, route, dan dependensi menggantung tak terpakai. | Lakukan pembersihan kode mati (*Dead Code Elimination*) 6-langkah hingga tuntas. |
| **Silent Spec Drift** | Mengubah perilaku fitur di kode nyata tanpa pernah memperbarui skenario Gherkin di `docs/SystemSpec.md`. | Selaraskan dokumen spesifikasi sebelum kode implementasi selesai dikerjakan. |

---

## Checklist Validasi Mandiri (*Self-Validation Checklist*)
- [ ] Apakah tipe tindakan (`ADD`, `MODIFY`, `REMOVE`) dan skala dampak sudah diklasifikasikan dengan jelas?
- [ ] Apakah seluruh tugas aktif yang berkonflik sudah ditandai `PAUSED`, `SUPERSEDED`, atau `CANCELLED`?
- [ ] Apakah dokumen spesifikasi teratas yang relevan sudah diperbarui sebelum koding?
- [ ] Apakah keputusan perubahan telah dicatat dalam format `CRDR-[YYYYMMDDHHmm].md`?
- [ ] Apakah seluruh pengujian regresi di terminal lulus (exit code 0)?
- [ ] Khusus `REMOVE`: Apakah seluruh import mati dan package yatim sudah dibersihkan?

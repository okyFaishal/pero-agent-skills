---
name: pero-user-stories
description: Use when translating product requirements into detailed user stories, Gherkin acceptance criteria, domain data models, and API contracts
---

# Pero User Stories & System Spec (`pero:user-stories`)

## Overview
**Origin**: *Pero Custom SDLC Pipeline - Stage 3 (Universal)*.
Skill ini bertindak sebagai **"Buku Komik Cerita Pengguna & Aturan Main Game"** (Menjelaskan siapa pemainnya, apa yang dia lakukan, dan apa tanda bahwa dia menang atau berhasil). Tugasnya adalah menerjemahkan kebutuhan produk tingkat tinggi dari `docs/PRD.md` menjadi dokumen **System Specification (`docs/SystemSpec.md`)** yang presisi, mendalam, dan langsung dapat dieksekusi oleh tim engineering: merinci user stories berformat Gherkin (*Given-When-Then*), kamus data entitas domain inti, kontrak antarmuka API/IPC, serta matriks penanganan error standar.

## Sub-Skill Integration (Perkakas Pendukung)
Dalam menjalankan tahapan ini, agent WAJIB mengorkestrasi sub-skill berikut:
- **Upstream Context Reader**: **`MANDATORY`**: Wajib membaca `docs/PRD.md` untuk memastikan setiap cerita pengguna, model domain, dan endpoint API selaras 100% dengan ruang lingkup fitur MVP (P0) dan fase lanjutan (P1).
- **Wawancara Skenario Ekstrem & Aturan Bisnis**: **`REQUIRED SUB-SKILL`**: Gunakan `grill-me` untuk membedah skenario aneh/ekstrem (*edge cases*), kondisi kegagalan, dan aturan bisnis yang ambigu satu per satu dengan analogi ramah ("Bahasa Bayi").
- **Perancangan Kontrak Antarmuka & Pesan**: **`SUPPORTING SUB-SKILL`**: Gunakan `api-contract-design` untuk menyusun struktur payload endpoint REST, GraphQL, gRPC, WebSocket, atau pesan IPC secara konsisten (*envelope sukses & gagal*).
- **Validasi Skema & Batasan Nilai**: **`SUPPORTING SUB-SKILL`**: Gunakan `schema-validator` untuk mendefinisikan batasan tipe data konkret (UUID, String, Int, Boolean, dll.), status wajib/opsional, dan batasan nilai (*boundary constraints*).
- **Pencatatan Keputusan Sistem**: **`SUPPORTING SUB-SKILL`**: Gunakan `decision-recorder` untuk membukukan keputusan perancangan sistem ke `docs/decisions/SDR-[YYYYMMDDHHmm].md`.

## When to Use
- Mengubah spesifikasi kebutuhan produk dari `docs/PRD.md` menjadi cerita pengguna teknis yang terperinci.
- Merumuskan kriteria penerimaan pengujian berbasis perilaku (*Behavior-Driven*) dengan sintaks Gherkin (*Given-When-Then*).
- Menyusun kamus entitas data domain inti (*Core Domain Entities & Data Dictionary*).
- Menetapkan kontrak antarmuka API, protokol IPC, atau alur pesan (*Message Flow Contracts*) sebelum menulis kode.
- Merumuskan aturan validasi data dan matriks penanganan error terstandarisasi.

## The 5-Section System Spec Framework

```
[1. System Overview & Scope] ──> [2. User Stories & Gherkin AC]
                                              │
[4. API / IPC Contracts]     <── [3. Core Domain Entities & Dictionary]
          │
[5. Validation & Error Matrix]
```

### 1. System Overview & Functional Scope
- Batasan dan arsitektur fungsional sistem yang akan dibangun berdasarkan PRD, memetakan modul-modul utama yang masuk ke dalam rilis.

### 2. User Stories with Gherkin Acceptance Criteria
- Format Cerita: `Sebagai [persona], saya ingin [tindakan], sehingga [manfaat]`.
- Kriteria Penerimaan dengan Sintaks Gherkin (`Given` [kondisi awal/prasyarat], `When` [aksi pengguna/sistem], `Then` [hasil akhir yang diharapkan]).
- Wajib mencakup:
  - **Happy Path**: Skenario ideal saat alur berjalan normal dan sukses.
  - **Negative Path**: Skenario saat validasi gagal, otentikasi ditolak, atau data tidak valid.
  - **Edge Cases**: Skenario kondisi ekstrem (nilai batas, duplikasi data, timeout, atau koneksi terputus).

### 3. Core Domain Entities & Data Dictionary
- Tabel entitas domain data universal/polyglot dengan atribut, tipe data konkret (UUID, String, Int64, Float, Boolean, DateTime ISO-8601), status *Required/Optional*, default value, serta relasi antar entitas.

### 4. API / IPC / Message Flow Contracts
- Rincian kontrak antarmuka (*Contract-First*):
  - Protokol & Endpoint (misal: REST `POST /api/v1/resource`, RPC method, IPC event channel).
  - Request Payload Schema dengan tipe data dan aturan validasi.
  - Envelope Respons Standar (Format Sukses & Format Error) mematuhi prinsip `api-contract-design`.

### 5. Validation Rules & Error Handling Matrices
- Matriks kode error sistem yang terstruktur:
  - Kode error unik & status HTTP / IPC code.
  - Kondisi pemicu error.
  - Pesan error ramah pengguna ("Bahasa Bayi" / user-friendly message).
  - Solusi / tindakan remediasi yang disarankan.

## Deliverables & Output Artifacts

1. **Living Document**: `docs/SystemSpec.md`
2. **Decision Record**: `docs/decisions/SDR-[YYYYMMDDHHmm].md`

---

## Template: `docs/SystemSpec.md`

```markdown
# System Specification: [Nama Sistem / Modul]

- **Versi**: 1.0
- **Status**: Disetujui (Approved)
- **Tanggal**: [YYYY-MM-DD]
- **Dokumen Induk**: [docs/PRD.md](file:///docs/PRD.md)
- **Decision Record**: [docs/decisions/SDR-[YYYYMMDDHHmm].md](file:///docs/decisions/SDR-[YYYYMMDDHHmm].md)

## 1. System Overview & Functional Scope
[Jelaskan ikhtisar teknis sistem dalam 1-2 paragraf dengan analogi sederhana ("Bahasa Bayi"). Sebutkan batasan modul yang masuk cakupan implementasi.]

## 2. User Stories & Gherkin Acceptance Criteria

### US-001: [Judul User Story 1]
- **Deskripsi**: Sebagai *[persona]*, saya ingin *[tindakan]*, sehingga *[manfaat]*.
- **Prioritas**: P0 (MVP) / P1

#### Acceptance Criteria (Gherkin):
```gherkin
Scenario: [Happy Path - Nama Skenario Sukses]
  Given [kondisi awal atau prasyarat sistem]
  When [pengguna melakukan aksi tertentu]
  Then [sistem memberikan hasil sukses yang diharapkan]
  And [status data berubah sesuai aturan]

Scenario: [Negative Path - Validasi Input Gagal]
  Given [pengguna berada di formulir atau antarmuka terkait]
  When [pengguna memasukkan data tidak valid atau mengosongkan field wajib]
  Then [sistem menolak permintaan dengan kode error yang sesuai]
  And [menampilkan pesan error yang jelas dan mudah dipahami]

Scenario: [Edge Case - Penanganan Nilai Batas / Kondisi Ekstrem]
  Given [kondisi ekstrem seperti batas kuota atau koneksi lambat]
  When [pengguna mencoba mengirim permintaan]
  Then [sistem menangani kondisi tersebut secara aman tanpa crash]
```

### US-002: [Judul User Story 2]
- **Deskripsi**: Sebagai *[persona]*, saya ingin *[tindakan]*, sehingga *[manfaat]*.
- **Prioritas**: P0 (MVP) / P1

#### Acceptance Criteria (Gherkin):
```gherkin
Scenario: [Nama Skenario]
  Given [kondisi awal]
  When [aksi yang dijalankan]
  Then [ekspektasi perilaku sistem]
```

## 3. Core Domain Entities & Data Dictionary

### 3.1. Entitas: `[NamaEntitas]`
[Penjelasan fungsi entitas dalam analogi sederhana, misal: "Seperti buku catatan kasir yang mencatat tiap transaksi"].

| Field / Atribut | Tipe Data | Wajib/Opsional | Nilai Default | Keterangan & Batasan Validasi |
|---|---|---|---|---|
| `id` | UUID / String | Wajib | UUID v4 | Identitas unik entitas |
| `name` | String | Wajib | - | Panjang 1-100 karakter, tidak boleh kosong |
| `status` | Enum (`ACTIVE`, `PENDING`, `ARCHIVED`) | Wajib | `PENDING` | Status siklus hidup data |
| `created_at` | DateTime (ISO-8601) | Wajib | `now()` | Waktu pembuatan data |
| `updated_at` | DateTime (ISO-8601) | Wajib | `now()` | Waktu pembaruan data terakhir |

### 3.2. Relasi Antar Entitas (Entity Relationships)
- `[Entitas A]` (1) ── (N) `[Entitas B]`: [Penjelasan relasi dalam 1 kalimat]

## 4. API / IPC / Message Flow Contracts

### 4.1. Contract: `[POST /api/v1/resource]` (atau IPC/Message Channel)
- **Tujuan**: [Deskripsi fungsi kontrak ini]
- **Protokol / Metode**: `POST` (REST) / `gRPC` / `WebSocket` / `IPC`
- **Header**:
  - `Content-Type`: `application/json`
  - `Authorization`: `Bearer <token>`

#### Request Payload:
```json
{
  "name": "Contoh Nama",
  "status": "ACTIVE"
}
```

#### Response Envelope — Sukses (200 / 201):
```json
{
  "status": "success",
  "data": {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "name": "Contoh Nama",
    "status": "ACTIVE",
    "created_at": "2026-08-27T12:00:00Z"
  },
  "meta": {
    "timestamp": "2026-08-27T12:00:00Z"
  }
}
```

#### Response Envelope — Gagal / Error (400 / 422 / 500):
```json
{
  "status": "error",
  "error": {
    "code": "ERR_VALIDATION_FAILED",
    "message": "Data yang dikirimkan tidak valid",
    "details": [
      {
        "field": "name",
        "issue": "Field 'name' wajib diisi dan minimal 1 karakter"
      }
    ]
  }
}
```

## 5. Validation Rules & Error Handling Matrices

| Kode Error | HTTP / IPC Code | Pemicu / Kondisi | Pesan Pengguna (ELI5) | Solusi / Mitigasi |
|---|---|---|---|---|
| `ERR_NOT_FOUND` | 404 | ID entitas tidak ditemukan di database | "Data yang Anda cari tidak ditemukan atau telah dihapus." | Periksa kembali ID atau segarkan halaman. |
| `ERR_VALIDATION_FAILED` | 422 / 400 | Format data atau tipe field melanggar batas | "Ada isian formulir yang belum sesuai, silakan cek petunjuk merah." | Lengkapi isian formulir sesuai aturan. |
| `ERR_UNAUTHORIZED` | 401 | Token kadaluarsa atau otentikasi hilang | "Sesi masuk Anda telah berakhir. Silakan login kembali." | Arahkan pengguna ke antarmuka login. |
| `ERR_FORBIDDEN` | 403 | Pengguna tidak memiliki izin hak akses | "Anda tidak memiliki izin untuk membuka bagian ini." | Hubungi administrator sistem. |
| `ERR_INTERNAL_SERVER` | 500 | Kegagalan sistem internal tak terduga | "Sistem sedang mengalami kendala teknis. Tim kami sedang menanganinya." | Log detail error ke server, sediakan tombol coba lagi. |
```

## Anti-Patterns & Common Mistakes
- **Kriteria Penerimaan yang Samar (Vague Acceptance Criteria)**: Menulis "Tombol harus bekerja dengan baik" alih-alih skenario Gherkin konkret (`Given`, `When`, `Then`) yang memvalidasi perubahan state dan output yang bisa diuji otomatis.
- **Mengabaikan Skenario Kegagalan & Edge Cases (Happy Path Bias)**: Hanya merancang skenario saat input sempurna tanpa mendefinisikan apa yang terjadi saat validasi gagal, database down, atau token kedaluwarsa.
- **Melewatkan Tipe Data & Batasan Nilai (Skipping Data Types & Boundaries)**: Menulis nama atribut di kamus data tanpa tipe data konkret (misal: tidak tegas antara string vs integer, atau melewatkan batasan nullability).
- **Menyimpang dari PRD (Scope Drift / Unanchored Specs)**: Merancang cerita, entitas, atau API yang tidak bersumber dari kebutuhan fungsional yang telah disepakati di `docs/PRD.md`.
- **Format Respons yang Inkonsisten**: Menggunakan format payload yang berbeda-beda di setiap endpoint tanpa pembungkus amplop standar (*standard response envelope*).

---
name: living-doc-sync
description: Use when code changes impact system architecture, interfaces, directory structure, or documentation in docs/
---

# Universal Living Documentation Synchronizer (`living-doc-sync`)

## Overview
**Origin**: *Living Documentation: Continuous Knowledge Sharing by Design (Cyrille Martraire) + Docs-as-Code Standard*.  
Skill ini adalah **"Penjaga Keselarasan Arsitektur Hidup & Anti-Dokumentasi Basi"**. Mencegah terjadinya *Documentation Drift*—kondisi di mana dokumentasi teknis, diagram alur Mermaid, spesifikasi API, dan README tertinggal atau berbohong dibandingkan kode sumber nyata di repositori.

> **Analogi Sederhana (ELI5):**  
> Bayangkan **Peta Navigasi GPS Mobil**:
> - **Dokumentasi Basi (Drift)**: Peta kertas cetakan sepuluh tahun lalu yang tidak tahu ada jalan layang baru atau jalan buntu. Pengemudi (pengembang atau AI baru) akan tersesat dan menabrak.
> - **Living Documentation**: Sistem GPS digital yang otomatis memperbarui rute setiap kali ada pembongkaran jalan (*commit/PR*). Denah dan jalan raya selalu 100% cocok dengan kondisi aspal nyata.

---

## 3 Siklus Sinkronisasi Dokumen Hidup

```
┌─────────────────────────────────────────────────────────────┐
│          3 SIKLUS LIVING DOCUMENTATION RECONCILIATION       │
├─────────────────────────────────────────────────────────────┤
│ 1. Drift Detection  : Deteksi perubahan via git diff        │
│ 2. Tri-Doc Sync     : Sinkronkan Arsitektur, Spek & README  │
│ 3. Syntax Guard     : Audit diagram Mermaid & link berkas   │
└─────────────────────────────────────────────────────────────┘
```

---

### Siklus 1: Automated Drift Detection (Deteksi Perubahan Nyata)
Sebelum menyatakan tugas selesai atau membuat PR, jalankan audit diff:
```bash
git diff --name-only HEAD~1  # Atau git status
```
Evaluasi dampak perubahan kode terhadap dokumentasi:
1. **Perubahan Arsitektural**: Jika ada penambahan modul, folder baru, database baru, atau protokol komunikasi baru → Wajib perbarui `docs/Architecture.md` atau `README.md`.
2. **Perubahan Kontrak API / DTO**: Jika ada penambahan endpoint, query param, atau modifikasi schema payload → Wajib perbarui `docs/SystemSpec.md` / `openapi.yaml`.
3. **Perubahan Dependensi / Cara Menjalankan**: Jika ada package baru atau script run/build berubah → Wajib perbarui `README.md`.

---

### Siklus 2: Tri-Doc Synchronization (Penyelarasan 3 Lapis)

| Lapisan Dokumen | Berkas Target | Hal yang Wajib Diselaraskan |
|---|---|---|
| **Lapis 1: High-Level Architecture** | `docs/Architecture.md` / `README.md` | Diagram relasi modul (Mermaid), daftar teknologi, batas domain context. |
| **Lapis 2: Contract & Interface Spec** | `docs/SystemSpec.md` / `docs/api/` | Skema payload JSON, header request, status code HTTP, rute endpoint. |
| **Lapis 3: Technical Decision (ADR)** | `docs/decisions/[TYPE]-[YYYYMMDDHHmm].md` | Alasan keputusan teknis non-sepele (*why*), trade-off, dan opsi yang ditolak. |

---

### Siklus 3: Mermaid & Document Syntax Guard
Setiap kali memperbarui diagram Mermaid pada file Markdown:
1. **Gunakan Syntax Valid**:
   - Berikan tanda kutip ganda pada label dengan karakter khusus: `id["User Service (Auth & RBAC)"]`.
   - Hindari tag HTML langsung di dalam node Mermaid.
2. **Gunakan Tautan Relatif yang Valid**:
   - Pastikan setiap link dokumen mengarah ke berkas nyata yang benar-benar ada.

---

## Contoh Penyelarasan: Menambah Modul Baru

**Sebelum Sinkronisasi (Contoh Drift - Diagram Usang):**
```mermaid
flowchart LR
    Client --> API_Gateway --> Order_Service --> DB[(Order DB)]
```

**Setelah Sinkronisasi (Contoh Living Sync - Sinkron dengan Kode):**
```mermaid
flowchart LR
    Client --> API_Gateway
    API_Gateway --> Order_Service
    Order_Service --> DB[(Order DB)]
    Order_Service --"Event: OrderCreated"--> MQ[(Message Broker)]
    MQ --> Notif_Service["Notification Service"]
```

---

## Tabel Anti-Pola (*Anti-Patterns*)

| Pola Terlarang | Mengapa Berbahaya? | Solusi Wajib |
|---|---|---|
| **Documentation Debt / Later Syndrome** | Menunda update dokumentasi dengan alasan *"nanti dirapikan sekaligus"*. | Jadikan update dokumen sebagai kriteria kelulusan (*Definition of Done*) PR saat ini. |
| **Dead Diagram** | Diagram gambar statis (PNG/JPG) yang tidak bisa di-version control dan cepat basi. | Selalu gunakan diagram berbasis teks terkelola (*Mermaid as Code*). |
| **Duplicate Truth** | Menuliskan daftar endpoint di 3 file berbeda secara manual sehingga mudah inkonsisten. | Miliki satu Single Source of Truth (SSOT) dan gunakan referensi silang. |
| **Corrupted Escape Syntax** | Karakter formula LaTeX rusak seperti `$\rightarrow$` yang terpotong menjadi `ightarrow`. | Gunakan simbol panah bersih `→` atau escape LaTeX `\rightarrow` yang valid. |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum menyelesaikan pekerjaan:
- [ ] Telah menjalankan `git diff --name-only` untuk mengaudit seluruh file yang diubah.
- [ ] Diagram Mermaid di `docs/Architecture.md` / `README.md` selaras dengan struktur kode terbaru.
- [ ] Perubahan endpoint, schema, atau method signature telah tercatat di `docs/SystemSpec.md`.
- [ ] Panduan instalasi dan dependensi baru (jika ada) telah diuji dan dituliskan di `README.md`.
- [ ] Tidak ada sintaks Mermaid yang rusak dan tidak ada tautan file (*broken link*) yang mati.

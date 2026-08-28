---
name: context-7
description: Use when needing official library documentation, modern API patterns, framework release specs, or resolving third-party package APIs via Context7 MCP
---

# Context 7 Documentation Bridge (`context-7`)

## Overview
**Origin**: *Model Context Protocol (MCP) Grounded Documentation Standard + Anti-Hallucination API Specification*.  
Skill ini adalah **"Jembatan Dokumentasi Resmi Terkini & Penangkal Halusinasi API"**. Bertugas menjamin agen AI selalu mengacu pada dokumentasi, signature metode, dan konfigurasi resmi versi terbaru langsung dari penerbit library (NPM, PyPI, Crates.io, Go Packages, Maven, Pub.dev, CocoaPods, NuGet), bukan dari ingatan lama bobot model (*outdated training weights*).

> **Analogi Sederhana (ELI5):**  
> Bayangkan **Konsultasi ke Dokter Spesialis dengan Jurnal Medis Terbaru**:
> - **Halusinasi AI (Tanpa MCP)**: Dokter meresepkan obat berdasarkan ingatan samar dari buku pelajaran kedokteran lima tahun lalu, padahal dosis dan formula obat tersebut sudah direvisi bulan lalu.
> - **Grounded Context7 (Dengan MCP)**: Dokter langsung membuka database farmasi digital terkini di komputer untuk memeriksa dosis, efek samping, dan kontraindikasi resmi sebelum menuliskan resep untuk pasien.

---

## 3 Alur Kerja Penarikan Dokumentasi MCP

```
┌─────────────────────────────────────────────────────────────┐
│          3 LANGKAH GROUNDED DOCUMENTATION RETRIEVAL         │
├─────────────────────────────────────────────────────────────┤
│ 1. Resolve ID   : Temukan Library ID resmi (/org/pkg)       │
│ 2. Query Docs   : Ambil dokumentasi topik spesifik          │
│ 3. Grounded Use : Terapkan API nyata ke kode implementasi   │
└─────────────────────────────────────────────────────────────┘
```

---

### Langkah 1: Resolusi Library ID (`resolve-library-id`)
Panggil tool MCP `resolve-library-id` untuk memetakan nama umum library ke identifier unik Context7:
- Contoh query: `libraryName: "tailwind"` → Mengembalikan `/tailwindlabs/tailwindcss` atau `/tailwindlabs/tailwindcss/v4`.
- Contoh query: `libraryName: "pydantic"` → Mengembalikan `/pydantic/pydantic/v2`.
- *Catatan Efisiensi*: Jika ID sudah diketahui dengan format pasti (`/org/project`), langkah ini dapat dilewati langsung ke Langkah 2.

---

### Langkah 2: Pengambilan Dokumen Terarah (`query-docs`)
Panggil tool MCP `query-docs` dengan parameter library ID dan kata kunci query yang presisi:
- **Batasan Efisiensi Context**: Maksimal **3 pemanggilan per sesi masalah** untuk mencegah pemborosan context window.
- **Hindari Query Terlalu Umum**: Gunakan kata kunci fungsional (misal: `"authentication middleware"`, `"zod v3 transform"`, bukan sekadar `"help"`).

---

### Langkah 3: Protokol Grounded Implementation
1. **Verifikasi Signature & Tipe**: Cocokkan argumen fungsi, nama return type, dan exception yang dilempar dengan hasil dokumentasi.
2. **Periksa Fitur Usang (*Deprecations*)**: Pastikan metode yang ditulis tidak lagi menggunakan API yang sudah diberi tanda deprecated pada versi target proyek.
3. **Mekanisme Fallback (Jika MCP Offline / Tidak Tersedia)**:
   - Gunakan skill `web-search` untuk mencari halaman dokumentasi resmi (misal: `site:docs.pydantic.dev v2 model_validate`).
   - Gunakan tool `read_url_content` untuk mengekstrak markdown dokumentasi langsung dari URL web resmi.

---

## Matriks Ekosistem Polyglot

| Ekosistem | Contoh Paket Modern | Pola Query Target di Context7 |
|---|---|---|
| **Node.js / React** | React 19, Next.js 15, Tailwind v4 | `resolve-library-id: "next"`, `query: "server actions revalidatePath"` |
| **Python** | Pydantic v2, FastAPI, SQLAlchemy 2 | `resolve-library-id: "pydantic"`, `query: "model_validator mode after"` |
| **Go** | Gin, GORM, Chi, Fiber | `resolve-library-id: "gin"`, `query: "middleware abort with status json"` |
| **Rust** | Axum, Tokio, Serde, SeaORM | `resolve-library-id: "axum"`, `query: "State extractor handler"` |
| **Flutter / Dart** | Riverpod, Bloc, GoRouter | `resolve-library-id: "flutter"`, `query: "GoRouter redirect state"` |
| **Swift / iOS** | SwiftData, NavigationStack | `resolve-library-id: "swift"`, `query: "ModelContainer schema migration"` |

---

## Tabel Anti-Pola (*Anti-Patterns*)

| Pola Terlarang | Mengapa Berbahaya? | Solusi Wajib |
|---|---|---|
| **Blind Guessing** | Menebak nama method berdasarkan asumsi versi lama (misal: `dict()` pada Pydantic v2). | Query Context7 untuk memastikan method resmi (`model_dump()`). |
| **Context Window Flooding** | Memanggil `query-docs` puluhan kali hingga context token habis. | Targetkan pencarian spesifik (maksimal 3 kali query terarah). |
| **Fabricated Packages** | Mengasumsikan nama package import tanpa mengecek package registry. | Validasi nama import dari dokumentasi resmi atau manifest proyek. |
| **Ignoring Fallback** | Berhenti bekerja saat server MCP tidak responsif. | Segera beralih ke `web-search` untuk mencari dokumentasi resmi. |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum mengimplementasikan library baru atau mengupdate API:
- [ ] Telah memeriksa manifest proyek (`package.json`, `pyproject.toml`, dll) untuk mengetahui versi library yang terpasang.
- [ ] Telah melakukan query dokumentasi resmi via Context7 atau web search untuk versi yang bersangkutan.
- [ ] Signature metode, parameter, dan return types terbukti valid sesuai dokumentasi resmi.
- [ ] Tidak ada penggunaan metode deprecated atau sintaksis usang.

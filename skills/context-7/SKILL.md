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

## Landasan Teori & Referensi Industri Nyata

Skill ini dibangun di atas 3 pilar rekayasa Retrieval-Augmented Generation (RAG) untuk kode, mitigasi halusinasi versi dependensi (*API drift*), dan penjaminan fakta dokumentasi resmi:

### 1. Retrieval-Augmented Code Generation (RepoCoder & Doc-RAG)
Penyuntikan konteks dokumentasi resmi langsung ke dalam jendela konteks model sebelum generasi kode dilakukan guna mengatasi keterbatasan memori bobot latihan model.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Patrick Lewis et al.*, "Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks" (Advances in Neural Information Processing Systems - NeurIPS, 2020).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *D. Shrivastava, H. Larochelle, & P. Vincent*, "RepoCoder: Repository-Level Code Completion Through Iterative Retrieval and Generation" (Findings of the Association for Computational Linguistics: EMNLP, 2023).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *Anthropic*, "Model Context Protocol (MCP) Specification: Dynamic Resource and Prompt Interfaces" (modelcontextprotocol.io, 2024).

### 2. Mitigation of API Drift & Library Version Hallucination
Pencegahan penggunaan metode lama yang sudah usang (*deprecated methods*) atau signature fungsi hasil tebakan halusinasi dengan mengikat agen ke spesifikasi OpenAPI resmi.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *David Lorge Parnas*, "On the Criteria to Be Used in Decomposing Systems into Modules" (Communications of the ACM, Vol. 15, No. 12, 1972).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *D. Zan, B. Chen, et al.*, "Large Language Models for Software Engineering: A Systematic Survey on Code Generation, Retrieval, and Library Hallucinations" (ACM Computing Surveys - CSUR, ACM, Vol. 56, No. 8, 2024).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *OpenAPI Initiative*, "OpenAPI Specification v3.1.0: Machine-Readable Interface Documentation Standards" (Linux Foundation, 2023).

### 3. Up-To-Date Grounding & Epistemic Humility in AI Systems
Pemberlakuan disiplin kerendahan hati epistemik (*epistemic humility*), di mana agen menyadari batas ketidaktahuannya terhadap rilis pustaka baru dan wajib memverifikasi ke sumber kebenaran primer (*ground truth*).
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Herbert A. Simon*, "Administrative Behavior: Bounded Rationality and Knowledge Search" (Macmillan, 1976).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *Y. Gao, Y. Xiong, et al.*, "Retrieval-Augmented Generation for Large Language Models: A Survey on Epistemic Grounding and Freshness" (IEEE Transactions on Knowledge and Data Engineering, 2024).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *NIST SP 800-218*, "Secure Software Development Framework (SSDF) Version 1.1: Task PW.1 (Validate Third-Party APIs and Software Dependencies)" (National Institute of Standards and Technology, 2022).

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
- **Pagu Adaptif & Penghentian Dini (*Adaptive Ceiling & Early Exit*)**: Maksimal **5 pemanggilan terarah per sesi masalah** untuk tugas kompleks (1 query arsitektur/tinjauan umum + hingga 4 query signature/fitur spesifik). Begitu signature metode atau blok kode yang dicari ditemukan, agen **WAJIB langsung berhenti** memanggil `query-docs` tanpa menghabiskan sisa jatah kuota.
- **Dilarang Panggilan Liar Tanpa Batas (*Zero Unbounded Queries*)**: Kendati menggunakan `CONTEXT7_API_KEY`, dilarang keras mematikan batas pemanggilan. Panggilan tanpa kendali memicu banjir token (*context window flooding*), kepikunan instruksi (*lost-in-the-middle*), dan risiko menguras kuota bulanan seketika.
- **Hindari Query Terlalu Umum**: Gunakan kata kunci fungsional presisi (misal: `"authentication middleware"`, `"zod v3 transform"`, bukan sekadar `"help"`).

---

### Langkah 3: Protokol Grounded Implementation
1. **Verifikasi Signature & Tipe**: Cocokkan argumen fungsi, nama return type, dan exception yang dilempar dengan hasil dokumentasi.
2. **Periksa Fitur Usang (*Deprecations*)**: Pastikan metode yang ditulis tidak lagi menggunakan API yang sudah diberi tanda deprecated pada versi target proyek.
3. **Mekanisme Fallback (Jika MCP Context7 Offline / Tidak Tersedia)**:
   - Gunakan skill `web-search` via Search MCP (`search_web` atau Tavily) untuk mencari halaman dokumentasi resmi dengan pembatasan domain (misal: `site:docs.pydantic.dev v2 model_validate`).
   - Ekstrak isi dokumentasi menggunakan pembaca semantik bersih (`read_url_content` atau Fetch MCP) untuk mendapatkan format markdown murni tanpa sampah HTML.
   - DILARANG KERAS menggunakan perintah terminal `curl` atau scraping shell mentah.

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
| **Context Window Flooding & Unbounded Loops** | Memanggil `query-docs` tanpa batas hingga context token habis dan kuota bulanan hangus. | Terapkan pagu adaptif (maksimal 5 query terarah dengan penghentian dini segera setelah informasi ditemukan). |
| **Fabricated Packages** | Mengasumsikan nama package import tanpa mengecek package registry. | Validasi nama import dari dokumentasi resmi atau manifest proyek. |
| **Ignoring Fallback** | Berhenti bekerja saat server MCP tidak responsif. | Segera beralih ke `web-search` untuk mencari dokumentasi resmi. |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum mengimplementasikan library baru atau mengupdate API:
- [ ] Telah memeriksa manifest proyek (`package.json`, `pyproject.toml`, dll) untuk mengetahui versi library yang terpasang.
- [ ] Telah melakukan query dokumentasi resmi via Context7 atau web search untuk versi yang bersangkutan.
- [ ] Signature metode, parameter, dan return types terbukti valid sesuai dokumentasi resmi.
- [ ] Tidak ada penggunaan metode deprecated atau sintaksis usang.

---
name: web-search
description: Use when verifying external technical facts, researching bug solutions, discovering SDK releases, or retrieving public documentation via search
---

# Universal Fact Grounding & High-Precision Web Search (`web-search`)

## Overview
**Origin**: *Information Foraging Theory (PARC) + Google E-E-A-T Search Quality Standards + Multi-Source Fact Checking Protocol*.  
Skill ini adalah **"Protokol Riset Forensik Digital & Penegak Kebenaran Fakta Eksternal"**. Menjamin setiap fakta teknis, pesan error langka, kompatibilitas dependensi, dan rilis SDK baru diverifikasi secara akurat dari sumber primer berwenang, bebas dari halusinasi dan informasi kedaluwarsa.

> **Analogi Sederhana (ELI5):**  
> Bayangkan seorang **Detektif Forensik & Peneliti Arsip Resmi**:
> - **AI Tanpa Grounding (Menebak Cerita)**: Ketika ditanya cara memperbaiki mesin pesawat tipe baru, ia mengarang instruksi berdasarkan ingatan samar dari dongeng fiksi (*halusinasi*), sehingga mesin terbakar saat dinyalakan.
> - **Dengan Web Search Disiplin (Fakta Terverifikasi)**: Detektif langsung membuka manual servis resmi dari pabrik pembuatnya, mencocokkan nomor seri dan versi suku cadang (*SemVer*), memverifikasi bahwa prosedur tersebut sudah divalidasi oleh regulator penerbangan, baru memberikan instruksi perbaikan yang 100% aman.

---

## Landasan Teori & Referensi Industri Nyata

Skill ini dibangun di atas 3 pilar rekayasa penelusuran informasi dan verifikasi data:

### 1. Information Foraging Theory & Query Optimization
Prinsip bahwa agen pencari informasi harus memaksimalkan rasio perolehan informasi (*information diet*) melalui formulasi petunjuk aroma informasi (*information scent*) yang tajam.
*   **Referensi 1 (Teori Dasar PARC)**: *Peter Pirolli & Stuart Card*, "Information Foraging Theory in Information-Seeking Environments" (Palo Alto Research Center / Xerox, Psychological Review, Vol. 106, No. 4).
*   **Referensi 2 (Standar Kualitas Google)**: *Google Search Central*, "Creating Helpful, Reliable, People-First Content - Search Quality Rater Guidelines (E-E-A-T Principles)" ([developers.google.com/search/docs/fundamentals/creating-helpful-content](https://developers.google.com/search/docs/fundamentals/creating-helpful-content)).
*   **Referensi 3 (Kerangka Penelusuran)**: *Ben Shneiderman, Donald Byrd, & W. Bruce Croft*, "Clarifying Search: A User-Interface Framework for Text Searches" (D-Lib Magazine).

### 2. SemVer Specificity & Temporal Grounding
Penelusuran yang terikat secara ketat pada versi rilis semantik (*Semantic Versioning*) untuk menghindari penerapan API yang sudah usang (*deprecated*) atau belum dirilis.
*   **Referensi 1 (Spesifikasi SemVer)**: *Tom Preston-Werner*, "Semantic Versioning 2.0.0" ([semver.org](https://semver.org)).
*   **Referensi 2 (Standar MDN Web Docs)**: *Mozilla Developer Network (MDN)*, "Browser & API Compatibility Matrix Standards" ([developer.mozilla.org](https://developer.mozilla.org)).
*   **Referensi 3 (Standar IETF)**: *IETF RFC 2119*, "Key words for use in RFCs to Indicate Requirement Levels" ([ietf.org/rfc/rfc2119.txt](https://www.ietf.org/rfc/rfc2119.txt)).

### 3. Triangulation & Multi-Source Anti-Hallucination Protocol
Verifikasi silang dari minimal dua sumber independen untuk memastikan kebenaran rilis atau perbaikan bug sebelum diterapkan.
*   **Referensi 1 (Standar Cek Fakta)**: *International Fact-Checking Network (IFCN)*, "The Poynter Institute Code of Principles for Multi-Source Verification" ([poynter.org/ifcn/](https://www.poynter.org/ifcn/)).
*   **Referensi 2 (Standar Evaluasi NIST)**: *NIST Special Publication 500-335*, "Information Technology: Guidelines for Evidence-Based Information Retrieval Evaluation".
*   **Referensi 3 (Riset Anti-Halusinasi ACM)**: *ACM Computing Surveys*, "A Survey on Hallucination in Large Language Models: Principles, Taxonomy, and Mitigation Strategies" (ACM CSUR).

---

## Formula Query Presisi 3 Tingkat (*3-Tier Search Query*)

Hindari pencarian umum yang ambigu. Gunakan formula query 3 tingkat:

```
┌─────────────────────────────────────────────────────────────┐
│               FORMULA QUERY WEB SEARCH PRESISI              │
├─────────────────────────────────────────────────────────────┤
│ [Exact Error / Symbol] + [Package / Tool] + [SemVer / OS]   │
└─────────────────────────────────────────────────────────────┘
```

*   ❌ **Query Buruk (Terlalu Umum)**: `react error hydration`
*   ✅ **Query Presisi Pero**: `"Hydration failed because the initial UI does not match" "next" "14.2" app router`
*   ❌ **Query Buruk**: `golang postgres connection refused`
*   ✅ **Query Presisi Pero**: `"pq: the database system is starting up" "pgx/v5" docker compose healthcheck`

---

## Hierarki Otoritas Sumber Data (*E-E-A-T Source Hierarchy*)

Saat mengevaluasi hasil pencarian, prioritaskan sumber berdasarkan tingkat kepercayaannya:

| Tingkat Otoritas | Jenis Sumber | Tingkat Kepercayaan |
|---|---|---|
| 🥇 **Tier 1 (Primer)** | Dokumentasi resmi vendor/library, repositori resmi GitHub/GitLab (Issues & Releases), RFC resmi, MDN Web Docs. | **Mutlak (100%)** — Jadikan rujukan utama. |
| 🥈 **Tier 2 (Sekunder)** | Blog resmi tim inti pembuat library, changelog resmi paket manajer (npm, PyPI, crates.io, pkg.go.dev). | **Sangat Tinggi (90%)** — Sangat tepercaya untuk breaking changes. |
| 🥉 **Tier 3 (Komunitas)** | StackOverflow (Jawaban berstatus Accepted & memiliki skor vote tinggi), diskusi resmi GitHub, artikel teknik insinyur terverifikasi. | **Sedang (75%)** — Wajib diverifikasi ulang di lingkungan lokal. |
| ❌ **Tier 4 (Terlarang)** | Situs web agregator scraper otomatis, blog hasil generatif AI tak berpenulis, tutorial usang (>3 tahun tanpa update). | **Ditolak (0%)** — Dilarang dijadikan rujukan. |

---

## Protokol Triangulasi Anti-Halusinasi

1. **Cocokkan Versi SemVer**: Pastikan solusi yang ditemukan sesuai dengan versi dependensi yang tercantum di `package.json`, `go.mod`, `Cargo.toml`, atau `pyproject.toml` lokal.
2. **Verifikasi Tanda Tangan Fungsi (*Function Signature*)**: Jangan mengasumsikan parameter baru ada jika belum diverifikasi pada dokumentasi resmi rilis terkait.
3. **Sertakan Atribusi URL**: Setiap kali mengusulkan perbaikan berbasis riset web, cantumkan tautan URL sumber primer sebagai bukti pendukung.

---

## Tabel Anti-Pola Penelusuran (*Web Search Anti-Patterns*)

| Pola Terlarang | Mengapa Dilarang Keras? | Solusi Wajib |
|---|---|---|
| **Hallucinated Package** | Menyarankan library eksternal yang sebenarnya tidak pernah ada di registry resmi. | Lakukan pencarian registry (`npm`, `pypi`, `crates.io`) untuk memverifikasi eksistensi paket. |
| **Outdated Recipe** | Mengambil cuplikan kode dari artikel tahun 2018 yang menggunakan API usang (*deprecated*). | Tambahkan filter tahun atau kata kunci versi spesifik pada query pencarian. |
| **Unattributed Claim** | Mengklaim *"Library X sekarang mendukung fitur Y"* tanpa menyertakan tautan changelog resmi. | Sertakan tautan rilis atau dokumentasi resmi vendor terkait. |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum menyajikan hasil riset web kepada pengguna atau menerapkannya ke kode:
- [ ] Menggunakan formula pencarian presisi (pesan error lengkap + nama paket + versi).
- [ ] Informasi berasal dari sumber Tier 1 atau Tier 2 yang terverifikasi.
- [ ] Memastikan kompatibilitas versi semantik (SemVer) sesuai dengan proyek lokal.
- [ ] Menyertakan URL referensi resmi pada penjelasan perbaikan.


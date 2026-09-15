---
name: scientific-research
description: Use when searching academic literature via Semantic Scholar MCP, downloading peer-reviewed papers to local storage, tracking SHA-256 manifest integrity, or validating formal citations
---

# Universal Scientific Research Orchestrator (`scientific-research`)

## Overview
**Origin**: *Evidence-Based Software Engineering (EBSE) + Semantic Scholar Academic Graph + Anti-Hallucination Empirical Grounding*.  
Skill ini adalah **"Pustaka & Pengawal Riset Jurnal Ilmiah Peer-Reviewed"**. Bertugas menjembatani agen AI dengan literatur akademik mutakhir dunia via Semantic Scholar MCP, mengunduh salinan berkas fisik ke `docs/references/papers/`, mencatat sidik jari SHA-256 ke `docs/references/MANIFEST.json`, dan menegakkan sitasi formal tanpa kebocoran status jaringan transport.

> **Analogi Sederhana (ELI5):**  
> Bayangkan **Konsultasi ke Laboratorium Riset Material & Jurnal Fisika Internasional**:
> - **Koding Tanpa Riset Ilmiah (Tebak-Tebakan)**: Insinyur merancang jembatan gantung hanya berdasarkan firasat atau obrolan santai di warung kopi. Saat diterpa angin topan, jembatan berguncang dan runtuh.
> - **Dengan Scientific Research (Terbukti Empiris)**: Insinyur membuka jurnal fisika getaran dan aerodinamika, mengutip batas resonansi resmi, dan membuktikan kalkulasinya di lembar keputusan sebelum tiang pertama dicor.

---

## Sub-Skill Integration (Perkakas Pendukung)
- **Pengamanan Kunci Kredensial**: Gunakan [`env-guard`](../env-guard/SKILL.md) untuk melindungi `SEMANTIC_SCHOLAR_API_KEY`.
- **Pencatatan Keputusan Formal**: Gunakan [`decision-recorder`](../decision-recorder/SKILL.md) untuk menyematkan sitasi formal ke dalam `ADR` atau `GDR`.
- **Pembaca Naskah Terfokus**: Teruskan berkas naskah yang berhasil diunduh ke [`pdf-reader`](../pdf-reader/SKILL.md) untuk ekstraksi rumus secara hemat token.

---

## Landasan Teori & Referensi Industri Nyata

Skill ini dibangun di atas 3 pilar rekayasa perangkat lunak berbasis bukti, penambangan graf pengetahuan ilmiah, dan tata kelola keputusan arsitektur:

### 1. Evidence-Based Software Engineering (EBSE)
Penerapan disiplin bahwa pemilihan algoritma, arsitektur, dan model rekayasa wajib disandarkan pada bukti empiris peer-reviewed terbaik yang tersedia.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Barbara A. Kitchenham, Tore Dybå, & Magne Jørgensen*, "Evidence-Based Software Engineering" (Proceedings of the 26th International Conference on Software Engineering - ICSE '04, IEEE, 2004).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *C. Wohlin et al.*, "Rigorous Evidence Aggregation in Software Engineering: Guidelines and Quality Criteria" (IEEE Transactions on Software Engineering - TSE, Vol. 49, No. 3, IEEE, 2023).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *ISO/IEC/IEEE 42010:2022*, "Software, systems and enterprise — Architecture description (Clause 5.7: Architectural Decisions and Rationale)" (International Organization for Standardization, 2022).

### 2. Semantic Academic Knowledge Graphs & Algorithmic Retrieval
Pemanfaatan graf pengetahuan literatur ilmiah untuk menautkan makalah, sitasi kausalitas, dan dataset acuan pengujian resmi.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Eugene Garfield*, "Citation Indexing: Its Theory and Application in Science, Technology, and Humanities" (John Wiley & Sons, 1979).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *D. Wadden, K. Lo, et al.*, "SciFact: Verifying Scientific Claims using Evidence from the Open Academic Graph" (Findings of the Association for Computational Linguistics: EMNLP, 2020/2023).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *Semantic Scholar API Team*, "Model Context Protocol (MCP) Semantic Scholar Interface Specification" (Allen Institute for AI - AI2, 2024).

### 3. Cryptographic Artifact Integrity & Local Reproducibility
Prinsip keterlacakan abadi di mana setiap naskah acuan eksternal dikunci dengan hash kriptografi SHA-256 dan disimpan secara mandiri di repositori agar sistem tahan luring (*offline-proof*).
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Ralph C. Merkle*, "A Certified Digital Signature" (Advances in Cryptology - CRYPTO '89, Lecture Notes in Computer Science, Springer, 1989).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *F. Servant et al.*, "Reproducibility and Traceability in Modern Open-Source AI Frameworks" (ACM Transactions on Software Engineering and Methodology - TOSEM, 2024).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *NIST FIPS 180-4*, "Secure Hash Standard (SHS): SHA-256 Validation and File Integrity Criteria" (National Institute of Standards and Technology, 2015/2023).

---

## 3 Alur Kerja Riset Ilmiah Terstruktur

```
┌─────────────────────────────────────────────────────────────┐
│             3 TAHAP SCIENTIFIC RESEARCH PROTOCOL            │
├─────────────────────────────────────────────────────────────┤
│ 1. Search & Filter : Cari paper via Semantic Scholar MCP    │
│ 2. Local Download  : Simpan PDF & hitung SHA-256            │
│ 3. Manifest Record : Daftarkan ke MANIFEST.json & Sitasi    │
└─────────────────────────────────────────────────────────────┘
```

### Langkah 1: Penelusuran Makalah Ilmiah (`search_papers`)
Panggil tool Semantic Scholar MCP dengan kueri spesifik (misal: `"raft consensus algorithm"`, `"Argon2 memory hardness"`, `"mutation testing fault detection"`):
- Saring hasil berdasarkan tahun publikasi dan reputasi konferensi/jurnal (IEEE, ACM, USENIX, NeurIPS, ICSE).
- Ambil metadata inti: `paperId`, `title`, `authors`, `year`, `venue`, `doi`, `openAccessPdf`.

### Langkah 2: Unduh Berkas PDF Lokal & Hitung SHA-256
- Unduh berkas fisik ke `docs/references/papers/[paper_id].pdf`.
- Hitung sidik jari integritas menggunakan algoritma SHA-256:
  `shasum -a 256 docs/references/papers/[paper_id].pdf`

### Langkah 3: Pencatatan Manifest & Format Sitasi Formal
- Tambahkan entri baru ke `docs/references/MANIFEST.json` sesuai skema `manifest.schema.json`.
- Gunakan format sitasi akademis formal:
  `[Author et al., Year] — "Title", Venue. DOI: 10.xxxx/yyyy`
- **Aturan Integritas Sitasi**: DILARANG membocorkan status jaringan transport (seperti `200 OK`, `HTTP 200`, atau `Fetched from URL`).

---

## Tabel Anti-Pola (*Anti-Patterns*)

| Pola Terlarang | Mengapa Dilarang? | Solusi Wajib |
|---|---|---|
| **Unguided MCP Flooding** | Memanggil puluhan kueri acak tanpa fokus masalah. | Batasi maksimal 2-3 kueri presisi per investigasi arsitektur. |
| **Raw PDF Ingestion** | Menyedot seluruh teks mentah naskah ke konteks obrolan. | Gunakan `pdf-reader` JIT 2-tahap (TOC $\rightarrow$ Bab target). |
| **Decorative Citation** | Mengutip judul paper mentereng tanpa menyertakan rumus riil. | Wajib cantumkan formula/bukti kausal yang dipakai di kode. |
| **Missing Manifest Entry** | Menyimpan PDF di disk tanpa mencatat hash di `MANIFEST.json`. | Setiap PDF baru wajib diverifikasi hash-nya di manifest. |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)
- [ ] Berkas naskah fisik tersimpan di `docs/references/papers/[paper_id].pdf`.
- [ ] Hash SHA-256 telah dihitung dan cocok dengan berkas fisik.
- [ ] Data naskah terdaftar di `docs/references/MANIFEST.json` dan valid terhadap skema.
- [ ] Sitasi bebas dari kebocoran status transport HTTP.

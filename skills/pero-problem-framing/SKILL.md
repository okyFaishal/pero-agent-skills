---
name: pero-problem-framing
description: Use when starting a new project, exploring raw user ideas, defining core user pain points, or separating root problems from symptoms before writing specifications
---

# Pero Problem Framing (`pero:problem-framing`)

## Overview
**Origin**: *Pero Custom SDLC Pipeline - Stage 1 (Universal)*.  
**Pipeline Navigation**: **Stage 1: Problem Framing** ➔ [Stage 2: PRD Writing](../pero-prd-writing/SKILL.md)

Skill ini bertindak sebagai **"Dokter Diagnosa Masalah yang Bijak"**. Tugasnya adalah membedah ide mentah pengguna menjadi rumusan masalah yang tervalidasi secara mendalam, memisahkan antara "gejala luar" dan "akar masalah asli", serta menentukan batas ruang lingkup secara tegas sebelum buru-buru membuat dokumen PRD atau menulis kode.

## Sub-Skill Integration (Perkakas Pendukung)
Dalam menjalankan tahapan ini, agent WAJIB mengorkestrasi sub-skill berikut:
- **Riset Multi-Dimensi Paralel & Bukti Empiris Web (Adaptive Squad: 3 Wajib + 1–3 Spesialis)**: **`REQUIRED SUB-SKILL`**: Gunakan [`dispatching-parallel-agents`](../dispatching-parallel-agents/SKILL.md) untuk mendelegasikan tim agen riset independen secara paralel yang masing-masing dibekali alat [`web-search`](../web-search/SKILL.md).
  - **3 Agen Wajib**: *Persona & Pain Points*, *Pasar & Benchmark Kompetitor*, *Kelayakan Arsitektur Teknis*.
  - **1–3 Agen Spesialis Dinamis (Wajib pilih min. 1, maks. 3)**: Dipilih secara kontekstual sesuai karakteristik ide dari katalog spesialis (*Kepatuhan Regulasi/Privasi, Nilai Finansial/Kesediaan Membayar, Benteng Pertahanan/Moat, atau Inersia Adopsi/Kebiasaan Lama*).
  - **Pagar Pencarian & Kuncian URL Persis**: Setiap agen dibatasi 1–2 pencarian web terarah, wajib menerapkan *Verbatim URL Pinning* (URL disalin karakter demi karakter langsung dari keluaran `search_web` / Search MCP), serta wajib melakukan uji kesehatan tautan pra-terbit via pembaca semantik resmi `read_url_content` atau Fetch MCP untuk memastikan dokumen dapat diakses secara stabil. Dilarang keras menggunakan terminal `curl` (anti-WAF 403 & proteksi SSRF), dilarang membocorkan kode status HTTP ke laporan akhir, dan bukti wajib menjawab klaim kausalitas secara langsung (total menghasilkan minimal 4 hingga 6 bukti empiris tervalidasi).
- **Musyawarah 5 Sudut Pandang AI Paralel (Fork-Join via `llm-council` & `dispatching-parallel-agents`)**: **`REQUIRED / STRATEGIC SUB-SKILL`**: Gunakan [`llm-council`](../llm-council/SKILL.md) yang didelegasikan secara paralel serentak dalam 1-turn via [`dispatching-parallel-agents`](../dispatching-parallel-agents/SKILL.md) (`invoke_subagent`) dengan isolasi memori mandiri (*shared-nothing isolation*) dari 5 kursi dewan kanonikal (*Product Strategist / The First Principles, Skeptic Auditor / The Contrarian, Domain Specialist / The Expansionist, Tech Feasibility Lead / The Executor, User Advocate / The Outsider*). Mencegah bias jangkar (*anchoring effect*) dan sikap asal setuju (*sycophancy*) sebelum Ketua Sidang merumuskan sintesis kompromi.
- **Wawancara Socratic & Stress-Test 2-Tahap**: **`REQUIRED SUB-SKILL`**: Gunakan [`grilling`](../grilling/SKILL.md) secara interaktif langsung kepada pengguna via perkakas modal **`ask_question`** dalam **2 ronde terpisah**:
  1. *Ronde 1 (Tahap 2)*: Membedah akar masalah dengan *Dynamic Depth Root Cause Analysis* (D-RCA: kedalaman dinamis $k \in [3, 8]$ berbasis *First Principles Root Anchor*) via modal `ask_question` dengan opsi konkret (2–5 alternatif), diawali pilihan `(Recommended)`, dan pengelompokan fleksibel (1 mandiri atau 2–4 serentak).
  2. *Ronde 2 (Tahap 4)*: Menguji titik buta (*blind spots*), kritik tajam, dan dilema kompromi (*trade-offs*) hasil sidang Dewan AI paralel via `ask_question` dengan opsi rekomendasi terstruktur.
  Batas volume per ronde berkisar antara **5 hingga 10 pertanyaan terarah**. Agent WAJIB memanggil `ask_question` dan menunggu respon pengguna. DILARANG mengarang atau mensimulasikan jawaban secara mandiri.
- **Audit Konsistensi Masalah Hulu**: **`SUPPORTING SUB-SKILL`**: Gunakan [`pero-context-validation`](../pero-context-validation/SKILL.md) untuk memastikan rumusan masalah tidak kontradiktif dengan batasan *Non-Goals* atau metrik dampak.
- **Riset Jurnal Ilmiah Bersyarat (*Deep-Tech Gatekeeper*)**: **`CONDITIONAL SUB-SKILL`**: Gunakan [`scientific-research`](../scientific-research/SKILL.md) pada Tahap 1 hanya jika proyek berkategori *Deep-Tech*, kriptografi baru, algoritma mutakhir, atau keselamatan jiwa. Untuk aplikasi bisnis/SaaS/CRUD standar, sub-skill ini dinonaktifkan secara otomatis.
- **Pencatatan Keputusan Produk**: **`SUPPORTING SUB-SKILL`**: Gunakan [`decision-recorder`](../decision-recorder/SKILL.md) untuk membukukan kesepakatan ruang lingkup ke `docs/decisions/PFDR-[YYYYMMDDHHmm].md`.

---

## Landasan Teori & Referensi Industri Nyata

Skill ini dibangun di atas 3 pilar rekayasa diagnosa masalah, musyawarah multi-agen, dan verifikasi empiris:

### 1. Autonomous Root Cause Analysis & Multi-Source Telemetry Reasoning
Metodologi pelacakan akar masalah mendalam untuk memisahkan gejala permukaan dari kegagalan struktural sistemik.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Sakichi Toyoda & Taiichi Ohno*, "Toyota Production System: Beyond Large-Scale Production (Root Cause 5-Whys)" (Productivity Press).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *Y. Chen, Y. Liu, et al.*, "RCACopilot: Automated Root Cause Analysis for Large-Scale Microservice Systems via Large Language Models" (EuroSys '24: Proceedings of the Nineteenth European Conference on Computer Systems, ACM, 2024).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *IETF RFC 9110*, "HTTP Semantics: Status Codes and Metadata Verification" (Internet Engineering Task Force, 2022).

### 2. Multi-Agent Deliberation & Cognitive Bias Mitigation (Anti-Anchoring & Anti-Sycophancy)
Pemberantasan bias konfirmasi dan sikap asal setuju melalui sidang penasihat multi-perspektif independen.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Herbert A. Simon*, "Administrative Behavior: A Study of Decision-Making Processes in Administrative Organization (Bounded Rationality)" (Macmillan, 1947/1976).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *Yilun Du, Shuang Li, Antonio Torralba, Joshua B. Tenenbaum, & Igor Mordatch*, "Improving Factuality and Reasoning in Language Models through Multiagent Debate" (MIT CSAIL & Google DeepMind, ICML 2024).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *Percy Liang et al.*, "Holistic Evaluation of Language Models (HELM) & Multi-Perspective Reasoning" (Stanford Center for Research on Foundation Models - CRFM, Annals of the NY Academy of Sciences, 2023).

### 3. Empirical Grounding & Inconsistency Detection in Problem Framing
Validasi keabsahan kebutuhan awal terhadap batasan sistem nyata sebelum perancangan spesifikasi formal.
*   **Referensi 1 (Foundational Classic / Asal-Usul Historis)**: *Eric Brewer*, "Towards Robust Distributed Systems (The CAP Theorem Invariants)" (ACM Symposium on Principles of Distributed Computing, 2000).
*   **Referensi 2 (Prioritas 1: Validasi Empiris Peer-Reviewed 2021–2026)**: *P. Ronanki et al.*, "Inconsistency Detection in Natural Language Requirements using ChatGPT: A Preliminary Evaluation" (IEEE 31st International Requirements Engineering Conference - RE '23, IEEE, 2023).
*   **Referensi 3 (Prioritas 2: Standar Resmi / Fallback Specification)**: *ISO/IEC/IEEE 29148:2018/2022*, "Systems and software engineering — Life cycle processes — Requirements engineering" (International Organization for Standardization).

---

## When to Use
- Memulai proyek baru atau merancang fitur/kemampuan baru berskala besar.
- Pengguna memiliki ide konseptual yang masih samar, terlalu sempit, atau terlalu luas.
- Ingin membedah apakah keluhan pengguna adalah akar masalah atau hanya gejala permukaan dengan dukungan bukti empiris.
- Menghilangkan bias asumsi dan inkonsistensi sebelum masuk ke tahap pembuatan PRD ([`pero-prd-writing`](../pero-prd-writing/SKILL.md)).

## The 5-Stage Problem Framing Framework

```
[1. Adaptive Squad Discovery (DPA + Web Search)]
    (3 Agen Wajib + 1–3 Agen Spesialis Dinamis -> Terkumpul 4–6 bukti URL valid)
                         │
                         ▼
[2. Dynamic Depth RCA & Grilling (D-RCA User R1)] ──> Rambu Henti Wajib (k = 3..8, First Principles Anchor)
                         │
                         ▼
[3. Parallel Multi-Perspective Council (DPA + LLM Council)]──> Sidang 5 persona paralel (1-turn shared-nothing)
                         │
                         ▼
[4. Council-Driven Grilling (User R2)]   ──> Rambu Henti Wajib (uji titik buta dewan via ask_question)
                         │
                         ▼
[5. Boundaries (Non-Goals) & Metrics]    ──> Kunci ruang lingkup & tulis dokumen
```

### 1. Pembedahan Riset Paralel Berbasis Web (Adaptive Squad: 3 Wajib + 1–3 Spesialis)
Mendelegasikan tim agen riset independen via `dispatching-parallel-agents` yang masing-masing dibekali alat `web-search` untuk menambang bukti empiris langsung dari internet:

#### A. 3 Agen Inti (Wajib Berjalan di Setiap Proyek):
1. **Agen 1 (Persona & Masalah Pengguna)**: Menyelidiki keluhan pengguna nyata, forum diskusi komunitas (Reddit/komunitas profesional), dan kesulitan utama persona target.
2. **Agen 2 (Riset Pasar & Benchmark Kompetitor)**: Menyelidiki alternatif solusi di pasar, fitur unggulan kompetitor, model harga, dan studi kasus kegagalan produk serupa.
3. **Agen 3 (Kelayakan Teknis & Arsitektur)**: Menyelidiki dokumentasi resmi framework/library, batasan API pihak ketiga, dan kompleksitas implementasi kode.

#### B. 1–3 Agen Spesialis Dinamis (Wajib Memilih Minimal 1, Maksimal 3):
Agent utama **WAJIB memilih minimal 1 dan maksimal 3** peran spesialis berikut sesuai karakteristik ide proyek:
- **Spesialis Legal, Kepatuhan & Privasi (*Compliance & Privacy Auditor*)**:
  - *Kapan Dipilih*: Ide mengelola data pribadi pengguna (UU PDP/GDPR), transaksi keuangan, rekam medis kesehatan, atau scraping data publik berbasis AI.
  - *Fokus Riset*: Regulasi resmi, kebijakan privasi, kepatuhan lisensi data, dan potensi sanksi hukum industri.
- **Spesialis Nilai Finansial & Kesediaan Membayar (*Willingness-to-Pay Analyst*)**:
  - *Kapan Dipilih*: Ide berupa produk komersial, SaaS berbayar, marketplace, atau fitur yang membutuhkan kalkulasi ROI dan anggaran pelanggan.
  - *Fokus Riset*: Bukti transaksi pasar, patokan harga wajar industri, kalkulasi kerugian finansial jika masalah diabaikan, dan kesediaan membayar (*willingness to pay*).
- **Spesialis Benteng Pertahanan (*Defensibility & Moat Analyst*)**:
  - *Kapan Dipilih*: Ide berada di pasar yang padat, mudah ditiru (misal: AI wrapper biasa), atau berisiko ditelan oleh pembaruan fitur raksasa teknologi.
  - *Fokus Riset*: Analisis diferensiasi unik, hambatan masuk (*barriers to entry*), efek jaringan (*network effects*), dan biaya berpindah (*switching costs*).
- **Spesialis Inersia Kebiasaan & Resistensi Alur Kerja (*Adoption Inertia Analyst*)**:
  - *Kapan Dipilih*: Ide menggantikan kebiasaan manual lama yang sudah mengakar (misal: menggantikan Excel, buku catatan, atau chat WhatsApp kerja).
  - *Fokus Riset*: Beban gesekan psikologis saat migrasi, tingkat kegagalan adopsi sistem sejenis, dan strategi transisi alur kerja tanpa penolakan tim.

#### C. Pagar Batas Pencarian & Integritas Bukti (*Guardrails*):
- **Batas Beban**: Total agen yang berjalan paralel adalah **4 hingga 6 agen** (3 wajib + 1 hingga 3 spesialis). DILARANG menjalankan 0 spesialis atau lebih dari 3 spesialis.
- **Batas Kuota Pencarian**: Setiap agen dibatasi maksimal **1–2 pencarian web terarah** untuk mencegah pemborosan kuota dan risiko *rate limit*.
- **Integritas Bukti Empiris & Protokol Keselarasan Semantik 3-Titik (*Tri-Point Semantic Alignment Protocol / T-SAP*)**:
  - Setiap agen wajib menyertakan **minimal 1 tautan URL resmi dan aktif** dengan temuan konkret yang secara langsung membuktikan premis (total menghasilkan **minimal 4 hingga 6 bukti empiris tervalidasi**).
  - **Uji Keterikatan Kausal Bukti (*Causal Entailment Invariant*)**: Konten bukti wajib secara logis menerangkan *mekanisme mengapa* suatu kondisi/kegagalan terjadi ($\text{Bukti} \implies \text{Mekanisme Kausal}$). DILARANG KERAS melakukan pencocokan kata kunci semu (*superficial lexical matching*) atau mengutip statistik keparahan dampak fisik/jumlah korban semata (*Outcome-Only Fallacy*) saat pertanyaan menanyakan alasan ketidakmampuan kognitif atau batasan sistem.
  - **Wajib Kuncian Tautan Persis (*Verbatim Pinning*)**: URL wajib disalin persis karakter demi karakter langsung dari keluaran perkakas `search_web`. DILARANG KERAS menyintesis, mempercantik, atau mereka-reka struktur URL dari ingatan internal (*parametric memory*).
  - **Uji Keterbacaan Pra-Terbit (*Pre-Flight Health Check*)**: Uji setiap tautan via pembaca semantik resmi `read_url_content` atau Fetch MCP untuk memastikan dokumen dapat diakses secara stabil. DILARANG KERAS menggunakan `curl` di terminal (menghindari false 403 dari Cloudflare dan risiko keamanan). Jika tautan berstatus 404/403 atau waktu tunggu habis, tautan dilarang dicantumkan.
  - **Format Atribusi Bersih Tanpa Slop Mesin**:
    - Untuk Jurnal Ilmiah: Wajib mencantumkan `[Nama Penulis et al., Tahun]` (misal: `[Endsley, 1995]`).
    - Untuk Website Resmi: Wajib mencantumkan nama institusi/pemerintah/organisasi penerbit `[Nama Lembaga/Pemerintah]` (misal: `[WMO - World Meteorological Organization]`).
    - DILARANG KERAS mencantumkan kode status jaringan teknis seperti `(Status: 200 OK)` atau `HTTP 200` pada sitasi teks atau laporan akhir.
  - **Jaring Pengaman Portal Resmi (*Domain Portal Fallback*)**: Jika tautan ke artikel spesifik tidak dapat diakses secara stabil atau gagal verifikasi, agen wajib beralih (*fallback*) ke akar portal dokumentasi resmi vendor yang permanen (misalnya: `https://docs.docker.com/` alih-alih artikel pihak ketiga yang rusak).

#### D. Pintu Penyaring Otomatis Riset Ilmiah (*Deep-Tech Gatekeeper & Circuit Breaker*):
- **Klasifikasi Ide Awal Proyek**:
  - *Kategori Deep-Tech, Kriptografi, Algoritma Baru, Keselamatan Kritis (Medis/Avionik), atau Bioinformatika*: Agen 3 (Kelayakan Teknis) dan Agen Spesialis **WAJIB memprioritaskan [`scientific-research`](../scientific-research/SKILL.md)** untuk mengumpulkan bukti kausal berformat formal `[Penulis, Tahun]` langsung dari naskah peer-reviewed ber-DOI.
  - *1-Shot Fast-Fail Circuit Breaker*: Jika pencarian Semantic Scholar tidak menemukan naskah relevan dalam 1 kali percobaan atau kuota/koneksi terhambat, agen seketika jatuh (*failover*) ke `web-search` dalam putaran yang sama tanpa menunda jalannya framing.
  - *Kategori Aplikasi Bisnis Standar, SaaS, Web, CRUD, atau Utilitas Harian*: Agen **DILARANG KERAS memanggil Semantic Scholar** untuk mencegah kelumpuhan analisis (*analysis paralysis*) dan pemborosan token; agen wajib murni mengandalkan suara pengguna, data kompetitor, dan `web-search`.

### 2. Diagnosa Akar Masalah Dinamis (Dynamic Depth RCA & `grilling` - Ronde 1 Chat via `ask_question`)
- **RAMBU HENTI WAJIB (MANDATORY PAUSE GATE - RONDE 1)**:
  - Agent **DILARANG** langsung membuat atau mengisi berkas `docs/ProblemFraming.md` sebelum melakukan wawancara interaktif menggunakan perkakas **`ask_question`**.
  - Dilarang keras melakukan *self-answering* (mengarang dan mengisi sendiri analisis akar masalah tanpa konfirmasi pilihan pengguna).
- **Prinsip Kedalaman Dinamis (*Dynamic Depth* $k \in [3, 8]$)**:
  - **Pelepasan Batas Kaku 5-Whys**: Angka 5 pada 5-Whys adalah heuristik historis manufaktur mekanik, bukan hukum komputasi. Penelusuran sebab-akibat berjalan dinamis dengan batas bawah minimum $k_{\min} = 3$ (mencegah henti dini di gejala permukaan) hingga sirkuit pemutus batas atas $k_{\max} = 8$ (mencegah *infinite philosophical regress*).
  - **Kriteria Henti Jangkar Prinsip Pertama (*First Principles Root Anchor*)**: Iterasi Why wajib berhenti pada tingkat $k$ ($k \ge 3$) jika dan hanya jika argumen kausal telah mengunci salah satu dari **4 Kriteria Jangkar**:
    1. *Invarian Fisika atau Komputasi Mendasar*: Batasan matematis/alam yang tidak bisa diubah perangkat lunak (Teorema CAP, batas propagasi latensi RTT jaringan optik, batasan memori).
    2. *Batasan Regulasi & Standar Eksternal Aksiomatik*: Hukum legal atau standar protokol resmi yang mengikat (UU PDP, PCI-DSS, RFC 9110, ISO/IEC).
    3. *Titik Intervensi Arsitektur Tertinggi*: Ketiadaan mekanisme penjaga otomatis (*missing automated guardrail/linter rule*), isolasi antrean asinkron, atau batas anggaran sistem, di mana menanyakan 'mengapa' satu tingkat lebih dalam hanya menghasilkan keluhan psikologis abstrak.
    4. *Pemutus Sirkuit Anti-Tautologi*: Iterasi dihentikan jika langkah berikutnya menghasilkan jawaban memutar atau menyalahkan keterbatasan waktu.
- **Anatomi 5-Elemen Presisi per Butir Why (High-Signal & Berbukti Empiris)**:
  Setiap butir Why dalam analisis wajib memiliki 5 komponen lengkap:
  1. *Pertanyaan Kausal*: Pertanyaan turunan logis dari kegagalan tingkat sebelumnya.
  2. *Mekanisme Kegagalan*: Penjelasan teknis alur kegagalan sistem dalam 1–2 kalimat padat tanpa basa-basi.
  3. *Dampak Kuantitatif & Telemetri*: Metrik kerugian nyata (latensi p99, persentase kegagalan transaksi, radius dampak).
  4. *Jangkar Bukti Empiris*: Standar formal (RFC/CVE/ISO), jurnal ilmiah berformat `[Penulis, Tahun]`, atau rujukan resmi `[Lembaga/Pemerintah]` yang membuktikan langsung mekanisme tersebut tanpa kebocoran status transport HTTP.
  5. *Klasifikasi Tingkat*: Gejala Awal (*Surface Symptom*) | Propagasi Sistemik (*Propagating Mechanism*) | First Principles Root Anchor (*Systemic Root*).
- **Pagar Batas & Format Pertanyaan (Volume & Delivery Guardrails)**:
  - **Batas Kuantitas**: Sesi wawancara akar masalah dibatasi total akumulasi **5 hingga 10 pertanyaan** (fleksibel sesuai kedalaman D-RCA yang dibutuhkan).
  - **Pengelompokan Fleksibel (*Flexible Batching*)**: Pertanyaan diajukan secara fleksibel via array `questions` pada perkakas `ask_question`: bisa **1 pertanyaan mandiri** jika berdiri sendiri, atau **2 hingga 4 pertanyaan serentak** jika berada dalam satu klaster tema masalah yang sama.
  - **Opsi Maksimal & Rekomendasi**: Setiap pertanyaan menyajikan **2 hingga 5 opsi realistis** (bukan biner kaku) dengan opsi terbaik AI diletakkan di nomor 1 berawalan `(Recommended)`.
- **Protokol Wawancara Chat Ronde 1 (Interaktif via `ask_question`)**:
  1. Sajikan intisari temuan empiris dan bukti URL dari tim agen riset sebagai pengantar konteks awal.
  2. Panggil perkakas `ask_question` berisi paket pertanyaan D-RCA dengan opsi terstruktur dan rekomendasi teknis terbaik.
  3. Tunggu respon pemilihan pengguna dari antarmuka modal.
  4. Lanjutkan penggalian hingga simpul akar *First Principles Root Anchor* disepakati bersama oleh pengguna.

### 3. Musyawarah Dewan AI Paralel (1-Turn Parallel Dispatch via `llm-council` & `dispatching-parallel-agents`)
Untuk membasmi bias jangkar (*anchoring effect*) dan bias asal setuju (*sycophancy*), musyawarah 5 penasihat dewan WAJIB dijalankan secara paralel dalam 1 putaran alat (*single turn*) dengan isolasi memori mandiri (*shared-nothing isolation*):
- **Tahap 3.1: Pengemasan Dossier (Problem Framing Dossier Packaging)**:
  Agen utama merangkum temuan Tahap 1 (korpus bukti empiris terverifikasi) dan Tahap 2 (ranting D-RCA yang telah disepakati) ke dalam satu dossier masalah netral dan ringkas.
- **Tahap 3.2: Delegasi Paralel Serentak (1-Turn Parallel Dispatch via `invoke_subagent`)**:
  Agen utama memanggil perkakas `invoke_subagent` dengan array 5 sub-agen sekaligus dalam 1 turn. Setiap sub-agen menerima dossier identik dan prompt mandiri sesuai kursi taksonomi kanonikal:
  1. **Product Strategist** (*The First Principles Thinker*): Menguji esensi fundamental masalah, proposisi nilai 10x, dan memotong ilusi solusi semu.
  2. **Skeptic Auditor** (*The Contrarian*): Menyerang celah kegagalan tersembunyi, skenario terburuk (*worst-case*), dan titik buta fatal (*fatal blind spots*).
  3. **Domain Specialist** (*The Expansionist*): Menguji dinamika industri nyata, parit pertahanan (*moat*), dan kepatuhan regulasi/hukum.
  4. **Tech Feasibility Lead** (*The Executor*): Mengaudit batas kelayakan teknis, ketergantungan API pihak ketiga, dan menegakkan prinsip Anti-Slop/YAGNI.
  5. **User Advocate** (*The Outsider*): Menghapus bias orang dalam, menguji beban inersia kebiasaan lama pengguna, dan menghitung gesekan kognitif adopsi.
- **Tahap 3.3: Kontrak Format Laporan Mandiri Penasihat**:
  Setiap penasihat mengembalikan laporan terstruktur maksimal 200 kata mencakup: *Sikap Dewan (Stance)*, *Tesis Utama (ELI5)*, *3 Titik Kritik Tajam*, *Batasan Non-Goals Wajib*, dan *1 Dilema Strategis Pengguna*.
- **Tahap 3.4: Sintesis Ketua Sidang & Pemetaan Benturan Dialektis**:
  Ketua Sidang (agen utama) mengumpulkan 5 laporan mandiri, menghitung sebaran sikap (*Stance Tally*), mengekstrak konsensus ($\ge 3$ suara sepakat), dan memetakan benturan dialektis (*Dialectical Tensions*) menjadi bahan baku untuk Ronde 2 Grilling.

### 4. Stress-Test Hasil Dewan AI (Council-Driven Grilling via `grilling` - Ronde 2 Chat via `ask_question`)
- **RAMBU HENTI WAJIB (MANDATORY PAUSE GATE - RONDE 2)**:
  - Agent **DILARANG** langsung mengunci batasan (*Non-Goals*) atau membuat dokumen akhir sebelum menghadapkan hasil kritik Dewan AI kepada pengguna via perkakas **`ask_question`**.
  - Dilarang keras memutuskan kompromi (*trade-offs*) strategis secara sepihak tanpa mandat pengguna.
- **Pagar Batas & Format Pertanyaan Dewan (Volume & Delivery Guardrails)**:
  - **Batas Kuantitas**: Sesi wawancara pasca-dewan dibatasi total akumulasi **5 hingga 10 pertanyaan** strategis.
  - **Pengelompokan Fleksibel (*Flexible Batching*)**: Diajukan secara fleksibel via `ask_question` (1 pertanyaan mandiri atau 2–4 pertanyaan serentak per putaran) lengkap dengan 2 hingga 5 alternatif konkret dan rekomendasi AI.
- **Protokol Wawancara Chat Ronde 2 (Interaktif via `ask_question`)**:
  1. Rangkum kritik terpedas, risiko paling krusial, dan titik buta (*blind spots*) yang diangkat oleh 5 penasihat AI (terutama dari *Skeptic Auditor* dan *Tech Feasibility*).
  2. Hadapkan dilema tersebut kepada pengguna melalui perkakas modal `ask_question` dengan opsi-opsi mitigasi konkret (diawali `(Recommended)`).
  3. Tunggu pilihan pengguna dari modal interaktif.
  4. Lanjutkan penggalian hingga seluruh kompromi dewan disepakati bersama.
  5. Jadikan pilihan pengguna sebagai ketetapan mutlak dalam merumuskan ruang lingkup dan batasan (*Non-Goals*).

### 5. Pagar Batasan (Boundaries) & Metrik Keberhasilan
- Menetapkan daftar **Non-Goals (Out-of-Scope)** secara tegas berdasarkan hasil musyawarah dan keputusan pengguna pada Ronde 2 untuk mencegah pelebaran ruang lingkup (*scope creep*).
- Menentukan indikator keberhasilan terukur (kuantitatif & kualitatif).

## Deliverables & Output Artifacts

1. **Living Document**: `docs/ProblemFraming.md`
2. **Decision Record**: `docs/decisions/PFDR-[YYYYMMDDHHmm].md`

---

## Template: `docs/ProblemFraming.md`

````markdown
# Problem Framing: [Nama Proyek / Fitur]

- **Tanggal**: [YYYY-MM-DD]
- **Status**: Tervalidasi (Validated)
- **Author / Lead**: Pero & Architect
- **Decision Record**: [docs/decisions/PFDR-[YYYYMMDDHHmm].md](decisions/PFDR-[YYYYMMDDHHmm].md)

## 1. Executive Problem Statement
[Jelaskan masalah inti dalam 1-2 kalimat tajam dan jelas menggunakan analogi sederhana (ELI5)]

## 2. Target Persona & Pain Points
- **Target Pengguna**: [Siapa yang mengalami masalah ini]
- **Cara Lama yang Melelahkan (Workarounds)**: [Cara kerja saat ini dan letak kesulitannya]
- **Dampak Kerugian**: [Apa kerugian finansial/waktu jika masalah ini diabaikan]

## 3. Dynamic Root Cause Analysis (D-RCA)
*(Kedalaman dinamis k=3..8 hingga menyentuh First Principles Root Anchor. Setiap tingkatan wajib menyertakan mekanisme kegagalan teknis, dampak kuantitatif, dan bukti referensi empiris tervalidasi: [Penulis, Tahun] untuk jurnal atau [Lembaga/Organisasi] untuk website resmi tanpa kebocoran status HTTP)*

- **Why 1 — [Label Gejala Permukaan]**:
  - **Pertanyaan Kausal**: Mengapa [masalah utama] terjadi pada alur kerja pengguna?
  - **Mekanisme Kegagalan**: [Penjelasan mekanisme teknis kegagalan, 1-2 kalimat padat tanpa basa-basi]
  - **Dampak Kuantitatif & Telemetri**: [Metrik kerugian/dampak nyata, misal: waktu tunggu melonjak dari X ke Y, failure rate Z%]
  - **Jangkar Bukti Empiris**: [Nama Lembaga / Penulis et al., Tahun] — "[Judul Laporan/Paper]", [`https://...`](https://...) atau [ID Standar: RFC/CVE/ISO]
  - **Klasifikasi Tingkat**: Gejala Awal (Surface Symptom)

- **Why 2 — [Label Propagasi Kegagalan]**:
  - **Pertanyaan Kausal**: Mengapa [kondisi Why 1] terjadi?
  - **Mekanisme Kegagalan**: [Penjelasan mekanisme teknis di tingkat subsistem/antarmuka]
  - **Dampak Kuantitatif & Telemetri**: [Metrik degradasi performa/telemetri subsistem terkait]
  - **Jangkar Bukti Empiris**: [Nama Lembaga / Penulis et al., Tahun] — "[Judul Laporan/Paper]", [`https://...`](https://...)
  - **Klasifikasi Tingkat**: Propagasi Sistemik (Propagating Mechanism)

- **Why [k] — [Label Akar Masalah Fundamental] (ROOT ANCHOR)**:
  - **Pertanyaan Kausal**: Mengapa [kondisi Why k-1] terjadi?
  - **Mekanisme Kegagalan**: [Pernyataan akar penyebab sistemik/invarian komputasi/batasan regulasi yang mendasari seluruh kegagalan]
  - **Dampak Kuantitatif & Telemetri**: [Radius dampak maksimal terhadap operasional produk/sistem]
  - **Jangkar Bukti Empiris**: [Nama Dokumen Standar / RFC / Penulis et al., Tahun] — "[Judul Spesifikasi/Standar]", [`https://...`](https://...)
  - **Klasifikasi Tingkat**: **First Principles Root Anchor: [Pilih: Invarian Fisika / Standar Eksternal Aksiomatik / Titik Intervensi Arsitektur Tertinggi]**
  - **Kriteria Henti**: Iterasi dihentikan pada k=[k] karena telah menyentuh batas fundamental yang dapat ditangani melalui intervensi rekayasa konkret.

## 4. Boundaries & Scope Constraints
- **In-Scope (Fokus Utama)**:
  - [Ruang lingkup 1]
  - [Ruang lingkup 2]
- **Non-Goals (Dilarang Dibuat / Batasan Ketat)**:
  - [Non-Goal 1: Hal yang sengaja TIDAK akan dibuat sekarang]
  - [Non-Goal 2]

## 5. Bukti Empiris & Referensi Industri Terverifikasi
*(Terkumpul minimal 4 hingga 6 sumber dari 3 Agen Inti + 1–3 Agen Spesialis. Wajib membuktikan langsung mekanisme sebab-akibat / T-SAP)*
| No | Domain Riset (Agen) | Entitas Penerbit / Penulis & Tahun | Judul Dokumen / Laporan | URL Referensi (Verbatim) | Temuan Kunci / Fakta Empiris Kausal |
|:---|:---|:---|:---|:---|:---|
| 1 | Persona & User Pain | [Lembaga / Penulis et al., Tahun] | [Judul Studi Kasus] | `https://...` | [Fakta / Mekanisme Kausal Konkret] |
| 2 | Market & Competitor | [Lembaga / Penulis et al., Tahun] | [Judul Laporan Pasar] | `https://...` | [Temuan Kunci Diferensiasi] |
| 3 | Tech Feasibility | [Lembaga / Penulis et al., Tahun] | [Judul Spesifikasi/Benchmark] | `https://...` | [Bukti Kelayakan Arsitektur] |
| 4 | [Spesialis Terpilih 1] | [Lembaga / Penulis et al., Tahun] | [Judul Riset Spesialis 1] | `https://...` | [Temuan Kunci Spesialis] |
| 5 | [Spesialis Terpilih 2 (opsional)] | [Lembaga / Penulis et al., Tahun] | [Judul Riset Spesialis 2] | `https://...` | [Temuan Kunci Spesialis] |
| 6 | [Spesialis Terpilih 3 (opsional)] | [Lembaga / Penulis et al., Tahun] | [Judul Riset Spesialis 3] | `https://...` | [Temuan Kunci Spesialis] |

## 6. Ukuran Keberhasilan (Success Metrics)
- **Metrik Utama**: [Angka / Target Terukur, misal: Reduksi waktu kerja 80%]
- **Kondisi Selesai**: [Kriteria konkret saat masalah ini resmi teratasi]

## 7. Hasil Musyawarah Dewan AI & Keputusan Pengguna
- **Konsensus Definisi Masalah**: [Ringkasan kesepakatan 5 persona AI]
- **Titik Buta & Kritik Tajam Dewan**: [Blind spot dan risiko kritis yang diangkat persona dewan]
- **Keputusan Strategis Pengguna (Hasil Grilling R2)**: [Pilihan opsi dan arahan pengguna atas kritik dewan]
````

---

## Template: `docs/decisions/PFDR-[YYYYMMDDHHmm].md`

````markdown
# PFDR-[YYYYMMDDHHmm]: [Judul Keputusan Definisi Masalah & Batasan Non-Goals]

- **Status**: Diterima (Accepted) / Ditinjau (Proposed) / Digantikan (Superseded)
- **Tanggal**: [YYYY-MM-DD]
- **Pengambil Keputusan**: Pengguna & Tim Problem Framing AI
- **Dokumen Terkait**: `docs/ProblemFraming.md`

## 1. Konteks Masalah & Kebutuhan Penetapan Arah
[Jelaskan latar belakang masalah inti dan mengapa batas non-goals perlu dikunci di awal].

## 2. Batasan In-Scope vs Non-Goals yang Ditetapkan
[Rincian hal yang masuk cakupan dan hal yang secara sengaja ditolak / ditunda ke fase rilis mendatang].

## 3. Alternatif Pembingkaian Masalah yang Ditolak
| Alternatif Framing | Alasan Penolakan |
|:---|:---|
| [Alternatif 1] | [Mengapa ditolak / bias asumsi / tidak didukung bukti empiris] |
| [Alternatif 2] | [Kelemahan teknis / ruang lingkup terlalu luas / risiko YAGNI] |

## 4. Konsekuensi Positif & Beban Operasional (Trade-offs)
- **Konsekuensi Positif**: [Fokus tajam pada masalah inti, mencegah scope creep]
- **Beban Operasional**: [Fitur sekunder ditolak sementara waktu]
- **Strategi Mitigasi**: [Meninjau kembali non-goals setelah MVP divalidasi pengguna]
````

## Anti-Patterns & Common Mistakes
- **Tangential Citation / Outcome-Only Fallacy (Sitasi Salah Sasaran)**: Mengutip referensi yang hanya mencocokkan kata kunci umum atau menyajikan statistik jumlah korban/akibat fisik semata saat pertanyaan mencari akar mekanisme kognitif atau teknis (misal: mengutip statistik korban kecelakaan kabut FHWA saat ditanya mengapa pengendara tidak bisa mengevaluasi bahaya rute secara mandiri dari angka cuaca internet).
- **Transport Boilerplate Leakage (HTTP 200 Slop)**: Membocorkan status teknis jaringan internal seperti `(Status: 200 OK)` atau `HTTP 200` ke dalam sitasi pengguna atau dokumen laporan.
- **Artificial Depth Forcing (Pemaksaan Batas Kaku 5-Whys)**: Memaksakan persis 5 iterasi dengan menambah pertanyaan bantalan (*padding*) omong kosong ketika masalah sudah mencapai akar di langkah ke-3/4, atau memotong paksa di langkah ke-5 padahal belum menyentuh First Principles Root Anchor.
- **Shallow One-Liner Whys (Ranting Kausal Dangkal 1-Baris)**: Mengisi jawaban Why hanya dengan 1 kalimat pendek tanpa menjelaskan mekanisme kegagalan teknis dan tanpa metrik dampak terukur.
- **Unanchored Causal Explanations (Kausalitas Tanpa Bukti Empiris)**: Menuliskan ranting Why tanpa menyertakan referensi spesifikasi resmi, RFC, standar ISO/CVE, atau literatur otoritatif yang membuktikan secara langsung validitas mekanisme kausal tersebut.
- **Sequential Council Execution & Anchoring Trap (Dewan Sekuensial Monolitik)**: Menjalankan 5 persona dewan secara berurutan dalam satu obrolan monolitik panjang yang memicu efek bias jangkar, saling sungkan (*sycophancy*), dan penurunan atensi model (*attention decay*), alih-alih memanfaatkan 1-turn parallel dispatch via `invoke_subagent`.
- **Question Avalanche or Premature Cessation**: Mengirimkan lebih dari 4 pertanyaan serentak per putaran via modal `ask_question` (atau memaksakan pertanyaan acak di luar klaster topik), mengajukan total kurang dari 5 pertanyaan (terlalu dangkal dan malas), atau melampaui batas akumulasi 10 pertanyaan pada sesi wawancara (memicu kelelahan pengguna dan *analysis paralysis*).
- **Violating Specialist Squad Bounds**: Menjalankan 0 agen spesialis (hanya 3 agen inti tanpa spesialisasi) atau menjalankan lebih dari 3 agen spesialis (>6 total agen) yang mengakibatkan kebanjiran konteks (*context bloat*) dan pelanggaran batas kuota (*rate limit*).
- **Simulated Self-Interrogation (Wawancara Palsu / Halusinasi Mandiri)**: Mengisi sendiri tanya-jawab D-RCA di dalam berkas dokumen tanpa pernah bertanya dan menunggu balasan pengguna di obrolan (*chat*).
- **Bypassing Council Grilling**: Menjalankan sidang dewan AI namun langsung menyimpulkan dan menulis dokumen sendiri tanpa membawa kritik dan titik buta dewan kepada pengguna di chat untuk diputuskan bersama.
- **Unbounded Web Search Avalanche**: Memberondong puluhan pencarian web tanpa batas yang memicu pemborosan token dan risiko rate limit, alih-alih memanfaatkan 1–2 pencarian terarah per sub-agen.
- **Unverified Hallucinated Problem**: Mengarang klaim masalah tanpa melampirkan bukti empiris atau riset web yang valid.
- **Broken or Hallucinated Evidence URLs**: Mencantumkan tautan URL fiktif rekaan AI, tautan dengan slug yang ditebak-tebak, atau tautan rusak berstatus 404/403 ke dalam dokumen `docs/ProblemFraming.md` tanpa melakukan *Verbatim Pinning* dan verifikasi keterbacaan dokumen secara nyata.
- **Narrow Tunnel Vision**: Merumuskan masalah hanya dari satu sudut pandang sempit tanpa validasi multi-agen paralel atau dewan AI.
- **Inconsistent Scope**: Menuliskan akar masalah yang bertentangan dengan daftar Non-Goals.
- **Langsung Melompat ke Solusi Koding**: Membicarakan stack database atau desain UI sebelum membuktikan bahwa masalah aslinya nyata.

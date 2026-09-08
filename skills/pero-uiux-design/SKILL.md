---
name: pero-uiux-design
description: Use when designing UI/UX design systems, component architecture, layout wireframes, design tokens, interaction states, or responsive flows before task decomposition
---

# Pero UI/UX Design System & Experience Architecture (`pero:uiux-design`)

## Overview
**Origin**: *Pero Custom SDLC Pipeline - Stage 5 (Universal)*.  
Skill ini bertindak sebagai **"Arsitek Tata Rancang Pengalaman Pengguna & Penjaga Estetika Visual"**.
(Menganalogikan arsitek interior yang menggambar denah ruangan, memilih paduan warna cat, mengatur pencahayaan alami, dan menata letak perabot rumah tangga agar indah dipandang, nyaman dihuni, dan tidak menyesakkan sebelum tukang kayu dan tukang cat mulai memaku dan mengecat dinding).

Tugas utamanya adalah menerjemahkan kebutuhan fungsional dari `docs/PRD.md`, skenario alur pengguna dari `docs/SystemSpec.md`, dan fondasi teknologi dari `docs/Architecture.md` menjadi cetak biru desain sistem visual **`docs/DesignSystem.md`** yang komprehensif, modular, bebas dari kebiasaan buruk AI (*anti-slop*), dan siap dijadikan rujukan mutlak oleh kartu tugas koding antarmuka di `docs/TaskBacklog.md`.

---

## Sub-Skill Integration (Perkakas Pendukung)
Dalam menjalankan perancangan desain antarmuka, agent WAJIB mengorkestrasi sub-skill berikut:
- **Upstream Context Reader**: **`MANDATORY`**: Wajib membaca `docs/PRD.md`, `docs/SystemSpec.md`, dan `docs/Architecture.md` untuk memastikan sistem desain secara langsung menopang seluruh alur pengguna (Gherkin user stories), kebutuhan visual MVP, dan tumpukan teknologi frontend yang telah disepakati.
- **Dekomposisi Riset Desain 5 Spesialis Tetap (*Fixed UI/UX Squad*)**: **`REQUIRED SUB-SKILL`**: Gunakan `dispatching-parallel-agents` untuk mendelegasikan tim beranggotakan **5 Agen Spesialis Desain Tetap** secara paralel yang masing-masing dibekali alat `context-7` dan `web-search`. Setiap spesialis wajib melakukan evaluasi relevansi awal (*Relevance Pre-Flight Check*). Jika domain relevan, agen dibatasi **minimal 2 dan maksimal 5 pencarian terarah**. Jika proyek murni backend headless tanpa UI grafis, agen wajib mendeklarasikan *Early-Exit* (`N/A: Headless Architecture`).
- **Mesin Estetika & Disiplin Anti-Slop**: **`REQUIRED SUB-SKILL`**: Gunakan `taste-skill` sebagai acuan baku pemilihan palet warna, rasio kontras, konfigurasi 3 Dial (*Variance, Motion, Density*), aturan tipografi, dan larangan pola klise AI (seperti gradasi ungu norak, hero teks rata tengah yang membosankan, dan mockup palsu).
- **Verifikasi Komponen & Pustaka Resmi**: **`REQUIRED SUB-SKILL`**: Gunakan `context-7` untuk memeriksa dokumentasi resmi pustaka komponen (misal: Tailwind v4, shadcn/ui, Radix Themes, Material 3, Carbon) guna memastikan komponen yang dirancang benar-benar didukung oleh paket resmi.
- **Musyawarah Dewan Desain Sistem**: **`REQUIRED / STRATEGIC SUB-SKILL`**: Gunakan `llm-council` untuk menguji perdebatan arah visual (Minimalis Dingin vs Hangat Humanis, Kepadatan Data vs Ruang Bernapas, Kustomisasi Token vs Pustaka Siap Pakai) melalui sidang 5 persona AI.
- **Wawancara Penguncian Desain di Chat**: **`REQUIRED SUB-SKILL`**: Gunakan `grilling` secara interaktif langsung kepada pengguna via perkakas modal **`ask_question`** dengan batas volume berkisar antara **5 hingga 10 pertanyaan terarah**, pengelompokan pertanyaan fleksibel (1 mandiri atau 2–4 serentak per putaran), dan menyajikan opsi maksimal (2–5 alternatif konkret) diawali label `(Recommended)`. Agent WAJIB memanggil `ask_question` dan menunggu respon pengguna. DILARANG menentukan estetika sepihak.
- **Sinkronisasi Dokumen Hidup**: **`SUPPORTING SUB-SKILL`**: Gunakan `living-doc-sync` untuk memastikan tata letak dan hierarki komponen selalu selaras dengan kode nyata.
- **Pencatatan Keputusan Desain**: **`SUPPORTING SUB-SKILL`**: Gunakan `decision-recorder` untuk membukukan keputusan desain ke `docs/decisions/DDR-[YYYYMMDDHHmm].md` (*Design Decision Record*).

---

## When to Use
- Merancang antarmuka aplikasi web, aplikasi mobile, dashboard data, atau portal pengguna baru.
- Menentukan sistem token visual (warna, tipografi, spasi, kelengkungan sudut, elevasi bayangan) sebelum koding frontend dimulai.
- Menetapkan denah tata letak layar utama (*wireframes*) dan alur interaksi multi-langkah.
- Menjamin kelengkapan siklus status antarmuka (loading skeleton, empty state, error state, active/focus state) agar hasil koding tidak terasa setengah jadi.
- Memastikan kepatuhan aksesibilitas kontras warna (WCAG 2.1 AA) dan kenyamanan tampilan di perangkat ponsel (*responsive mobile*).

---

## The 5-Stage UI/UX Design Framework

```
[0. Ingestion docs/PRD.md, docs/SystemSpec.md, docs/Architecture.md]
                                  │
                                  ▼
[1. Riset 5 Spesialis Desain Tetap via dispatching-parallel-agents]
    (Token, Wireframe, Interaction States, Product UI, Accessibility)
                                  │
                                  ▼
[2. Sidang Dewan Estetika & Arah Visual (LLM Council)]
    (5 Persona AI membedah Vibe, Density Dials, Komponen & Aksesibilitas)
                                  │
                                  ▼
[3. Wawancara Penguncian Desain via ask_question (Modal Interaktif)]
    (5-10 Tanya: kunci palet warna, tipografi, kepadatan data, navigasi)
                                  │
                                  ▼
[4. Penerbitan Dokumen Living docs/DesignSystem.md Formal]
    (Token Hex, Wireframes ASCII/Mermaid, Matriks 5 State, Pola Dashboard)
                                  │
                                  ▼
[5. Pembukuan Rekam Keputusan DDR Formal & Handoff ke Task Decomposition]
```

---

### 1. Dekomposisi Riset Paralel Berbasis 5 Spesialis Desain Tetap
Mendelegasikan tim 5 agen spesialis desain tetap via `dispatching-parallel-agents` yang masing-masing dibekali perkakas `context-7` dan `web-search`:

#### A. 5 Peran Spesialis Desain Tetap (*Fixed UI/UX Roles*):
1. **Spesialis 1: Fondasi Token Desain & Skema Warna (*Design Tokens & Color Specialist*)**:
   - *Fokus*: Merumuskan palet warna semantik (Background, Surface, Text Primary/Secondary, Accent tunggal, Destructive, Muted, Border), skala tipografi (Geist/Outfit/Satoshi dsb. dengan clamp responsive), skala spasi modular (4px/8px), skala kelengkungan sudut (*border radius*), dan aturan konsistensi tema (Dark/Light Lock).
2. **Spesialis 2: Tata Letak Arsitektur Informasi & Wireframe (*Information Architecture & Wireframes Specialist*)**:
   - *Fokus*: Merancang denah tata letak visual layar-layar utama dari PRD (Header/Navbar, Sidebar vs Bottom Nav mobile, Bento Grid, Kontainer responsif `max-w-7xl`, pembagian kolom grid). Menggambar sketsa tata letak visual berbasis ASCII art atau diagram Mermaid.
3. **Spesialis 3: Matriks Siklus Status Interaksi (*Interaction States & Feedback Specialist*)**:
   - *Fokus*: Merancang siklus utuh 5 status antarmuka pada setiap komponen kunci:
     - *Default / Idle*: Bentuk standar komponen.
     - *Hover / Active / Focus*: Efek mikro-interaksi taktil (`scale-[0.98]` atau `-translate-y-[1px]`, ring fokus jelas).
     - *Loading Skeleton*: Kerangka pemuatan yang persis mengikuti bentuk konten (dilarang menggunakan spinner lingkaran tunggal di tengah layar kosong).
     - *Empty State*: Ilustrasi visual ramah dan tombol pemicu aksi saat belum ada data.
     - *Error & Toast Feedback*: Banner kesalahan kontekstual dan notifikasi mengambang ringkas.
4. **Spesialis 4: Antarmuka Produk, Dashboard & Tabel Data (*Product UI & Complex Patterns Specialist*)**:
   - *Fokus*: Merancang komponen aplikasi tingkat lanjut:
     - *Dashboard & KPI*: Hirarki kartu metrik, angka display besar, indikator tren (+/- persen), pemisahan grid tanpa border berlebih.
     - *Data Tables*: Rata kiri untuk teks, rata kanan untuk angka/mata uang, penanganan teks kepanjangan (*truncation*), baris hover halus, dan navigasi halaman (*pagination*).
     - *Multi-Step Wizards*: Penunjuk progres langkah, penyimpanan otomatis (*auto-save state*), dan validasi inline seketika.
     - *Dialog & Drawer*: Lembar geser (*slide-over sheet*), jendela modal dengan penutup tombol Escape, dan backdrop scrim lembut.
5. **Spesialis 5: Aksesibilitas, Kontras & Standar Responsif (*Accessibility & Mobile Usability Specialist*)**:
   - *Fokus*: Mengaudit rasio kontras warna standar WCAG 2.1 AA (minimal 4.5:1 untuk teks biasa, 3:1 untuk teks besar), area sentuh minimal ponsel (44x44px), navigasi keyboard Tab yang logis, label pembaca layar (*screen reader ARIA*), serta kepatuhan preferensi reduksi gerak (*prefers-reduced-motion*).

#### B. Mekanisme Evaluasi Relevansi Awal & Pintu Keluar Dini (*Relevance Pre-Flight Check & Early Exit*):
- Setiap spesialis membaca dokumen hulu sebelum menjalankan riset.
- **Klausul Headless / CLI Architecture**: Jika proyek murni berupa pustaka backend, daemon, atau perkakas terminal (CLI) tanpa antarmuka grafis:
  - Seluruh spesialis **WAJIB** mendeklarasikan: `Status: N/A - Headless Architecture`.
  - Spesialis 1 merumuskan standar antarmuka baris perintah (warna ANSI terminal, keringkasan prompt, format tabel ASCII ringkas).
  - Agen berstatus `N/A` **DILARANG melakukan pencarian web (0 search)** dan dilarang mengarang spesifikasi UI web palsu.

#### C. Pagar Batas Riset & Pencarian (*Guardrails*):
- Untuk proyek berantarmuka: **Minimal 2 dan Maksimal 5 pencarian terarah** per agen yang relevan untuk memeriksa dokumentasi komponen resmi.
- Untuk proyek headless/N/A: **0 pencarian**.

---

### 2. Musyawarah Dewan Desain Sistem (via `llm-council`)
- Menyidangkan arah visual ke 5 persona dewan AI (*Product Strategist, Skeptic Auditor, Domain Specialist, Tech Feasibility, User Advocate*).
- Topik musyawarah:
  - *Arah Gaya Visual (Vibe Language)*: Linear-style minimalis vs Modern B2B SaaS vs Konsumen Mewah vs Padat Data (*Cockpit*).
  - *Konfigurasi 3 Dial*: Menentukan angka patokan `DESIGN_VARIANCE` (1-10), `MOTION_INTENSITY` (1-10), dan `VISUAL_DENSITY` (1-10) sesuai karakteristik persona target di PRD.
  - *Pemilihan Fondasi Komponen*: Menggunakan pustaka resmi (shadcn/ui, Radix, Tailwind v4 murni) vs sistem desain vendor (Material 3, Carbon, Fluent).
  - *Dilema Kompromi*: Menyeimbangkan antara keindahan visual (*aesthetic airiness*) dengan efisiensi kerja pengguna (*data density*).
- Dewan menghasilkan rekomendasi terstruktur (2 hingga 5 alternatif konkret) untuk dibawa ke sesi wawancara pengguna.

---

### 3. Wawancara Penguncian Desain di Chat (via `grilling` & `ask_question`)
- **RAMBU HENTI WAJIB (MANDATORY PAUSE GATE)**:
  - Agent **DILARANG** langsung menulis berkas `docs/DesignSystem.md` sebelum menyepakati arah visual, palet warna, dan kepadatan antarmuka bersama pengguna via perkakas modal **`ask_question`**.
  - Dilarang keras memilih warna atau font secara sepihak tanpa konfirmasi pengguna.
- **Pagar Batas & Format Pertanyaan**:
  - **Batas Kuantitas**: Sesi wawancara dibatasi total akumulasi **5 hingga 10 pertanyaan** terarah.
  - **Pengelompokan Fleksibel (*Flexible Batching*)**: Diajukan secara adaptif via `ask_question`: bisa **1 pertanyaan mandiri** atau **2 hingga 4 pertanyaan serentak** jika berada dalam rumpun tema yang sama (misal paket Palet Warna + Tipografi + Mode Gelap).
  - **Opsi Maksimal & Rekomendasi**: Menyajikan **2 hingga 5 alternatif konkret**, dengan rekomendasi teknis terbaik AI diletakkan di nomor 1 berawalan `(Recommended)`.
- **Fokus Topik Wawancara (via `ask_question`)**:
  1. *Arah Gaya & Nuansa Visual*: Minimalis teknis (*Linear-clean*), modern ramah, atau profesional padat data.
  2. *Palet Warna & Aksen Tunggal*: Pemilihan basis netral (Zinc, Slate, Stone) dan warna aksen tunggal (Emerald, Electric Blue, Deep Rose, Burnt Orange).
  3. *Tipografi & Karakter Teks*: Pilihan pasangan font (Geist Sans + Mono, Satoshi + JetBrains, Outfit + Inter).
  4. *Kepadatan Antarmuka (Density Dial)*: Luas dan bernapas (*Airy*) vs Padat ringkas (*Cockpit/Dashboard*).
  5. *Kebijakan Tema Tampilan*: Terkunci Dark Mode, Terkunci Light Mode, atau Adaptif Otomatis.
- Tunggu pilihan pengguna dari modal interaktif sebelum menyusun dokumen desain.

---

### 4. Penerbitan Dokumen `docs/DesignSystem.md` Formal
Menulis berkas cetak biru desain lengkap ke `docs/DesignSystem.md` mengikuti template standar resmi Pero.

---

### 5. Pembukuan Rekam Keputusan DDR Formal & Handoff
- Mencatat keputusan arsitektur visual ke `docs/decisions/DDR-[YYYYMMDDHHmm].md` (*Design Decision Record*).
- Menyerahkan cetak biru desain ke tahap selanjutnya (`pero-quality-governance` dan `pero-task-decomposition`), sehingga tugas koding domain UI/Client memiliki rujukan token dan komponen yang pasti.

---

## Deliverables & Output Artifacts

1. **Living Document**: `docs/DesignSystem.md`
2. **Decision Record**: `docs/decisions/DDR-[YYYYMMDDHHmm].md`

---

## Template: `docs/DesignSystem.md`

````markdown
# Design System Specification: [Nama Proyek]

- **Tanggal**: [YYYY-MM-DD]
- **Status**: Disetujui (Approved)
- **Author / Lead**: Pero UI/UX Architect & Frontend Lead
- **Dokumen Induk**: [PRD.md](PRD.md), [SystemSpec.md](SystemSpec.md), & [Architecture.md](Architecture.md)
- **Decision Record**: [decisions/DDR-[YYYYMMDDHHmm].md](decisions/DDR-[YYYYMMDDHHmm].md)

---

## 1. Visi Visual & Konfigurasi 3 Dial (*Aesthetic Engine*)
- **Aesthetic Vibe**: [Linear-clean / Modern B2B SaaS / Editorial / Data Cockpit]
- **Target Persona & Context**: [Audiens utama dan ekspektasi kenyamanan visual mereka]
- **Konfigurasi 3 Dial**:
  - `DESIGN_VARIANCE: [1-10]` ([Penjelasan variasi tata letak: simetris teratur vs asimetris dinamis])
  - `MOTION_INTENSITY: [1-10]` ([Penjelasan gerak: statis tenang vs transisi halus taktil])
  - `VISUAL_DENSITY: [1-10]` ([Penjelasan kepadatan: bernapas lega vs padat data])

---

## 2. Fondasi Token Desain (*Design Tokens*)

### A. Palet Warna Semantik (*Semantic Color Palette*)
*(Terkunci 1 warna aksen utama. Seluruh teks dan latar belakang wajib memenuhi rasio kontras WCAG AA)*
| Token Name | Nilai Hex (Light Mode) | Nilai Hex (Dark Mode) | Peruntukan Penggunaan |
|:---|:---|:---|:---|
| `--color-bg-primary` | `#ffffff` | `#09090b` (Zinc-950) | Latar belakang halaman utama |
| `--color-bg-surface` | `#f4f4f5` (Zinc-100) | `#18181b` (Zinc-900) | Latar belakang kartu, panel, modal |
| `--color-border` | `#e4e4e7` (Zinc-200) | `#27272a` (Zinc-800) | Garis pemisah, batas input, divider |
| `--color-text-primary`| `#09090b` (Zinc-950) | `#fafafa` (Zinc-50) | Judul utama, teks primer |
| `--color-text-muted` | `#71717a` (Zinc-500) | `#a1a1aa` (Zinc-400) | Teks sekunder, label pembantu, placeholder |
| `--color-accent` | `#[HEX_AKSEN]` | `#[HEX_AKSEN]` | Tombol utama, indikator fokus, status aktif |
| `--color-accent-hover`| `#[HEX_HOVER]` | `#[HEX_HOVER]` | Efek sorot tombol utama |
| `--color-destructive` | `#ef4444` (Red-500) | `#f87171` (Red-400) | Tombol hapus, pesan kesalahan fatal |
| `--color-warning` | `#f59e0b` (Amber-500)| `#fbbf24` (Amber-400)| Peringatan, status tertunda |
| `--color-success` | `#10b981` (Emerald-500)|`#34d399` (Emerald-400)| Sukses, konfirmasi selesai |

### B. Skala Tipografi (*Typography Scale*)
- **Font Utama (Sans Display / Body)**: `[Nama Font, misal: Geist, Outfit, Satoshi]`
- **Font Kode / Monospace**: `[Nama Font Mono, misal: Geist Mono, JetBrains Mono]`
| Level | Skala Ukuran | Line Height | Tracking | Penggunaan |
|:---|:---|:---|:---|:---|
| `display` | `clamp(2.5rem, 5vw, 4rem)` | `1.05` | `-0.04em` | Hero display utama |
| `h1` | `clamp(1.875rem, 3vw, 2.5rem)` | `1.15` | `-0.03em` | Judul halaman / section utama |
| `h2` | `1.5rem` (`24px`) | `1.25` | `-0.02em` | Judul kartu besar / modal |
| `h3` | `1.125rem` (`18px`) | `1.35` | `-0.01em` | Sub-judul / judul tabel |
| `body` | `0.9375rem` (`15px`) | `1.5` | `normal` | Teks bacaan, paragraf, deskripsi |
| `small` | `0.8125rem` (`13px`) | `1.4` | `normal` | Label form, teks pembantu, badge |
| `mono` | `0.75rem` (`12px`) | `1.4` | `0.02em` | Angka data, ID transaksi, timestamp |

### C. Skala Spasi & Sudut Kelengkungan (*Spacing & Radius Scale*)
- **Skala Kelengkungan (*Corner Radius*)**:
  - `radius-sm`: `6px` (Badge, tag kecil, indikator)
  - `radius-md`: `8px` (Input form, tombol, dropdown item)
  - `radius-lg`: `12px` (Kartu konten, panel mengambang)
  - `radius-xl`: `16px` (Modal utama, dialog besar)
- **Skala Spasi Modular**: Kelipatan 4px/8px (`gap-2` = 8px, `gap-4` = 16px, `gap-6` = 24px, `gap-8` = 32px).

---

## 3. Tata Letak Layar Utama & Wireframes (*Screen Layouts*)

### A. Denah Tata Letak Global (*Global Shell / Navigation*)
```
┌────────────────────────────────────────────────────────────────────────┐
│ Navbar: [Logo / Brand]        [Pencarian / Menu]        [User Avatar]  │
├─────────────────┬──────────────────────────────────────────────────────┤
│ Sidebar Nav     │ Konten Utama (max-w-7xl mx-auto, px-6 py-8)          │
│ - [Menu 1]      │ ┌──────────────────────────────────────────────────┐ │
│ - [Menu 2]      │ │ Header Halaman: Judul + Tombol Aksi Utama (CTA)  │ │
│ - [Menu 3]      │ └──────────────────────────────────────────────────┘ │
│                 │ ┌───────────────┐ ┌───────────────┐ ┌──────────────┐ │
│                 │ │ Kartu KPI 1   │ │ Kartu KPI 2   │ │ Kartu KPI 3  │ │
│                 │ └───────────────┘ └───────────────┘ └──────────────┘ │
│                 │ ┌──────────────────────────────────────────────────┐ │
│                 │ │ Tabel Data / Daftar Utama                        │ │
│                 │ └──────────────────────────────────────────────────┘ │
└─────────────────┴──────────────────────────────────────────────────────┘
```

### B. Wireframe Layar Kunci (Berdasarkan PRD & Stories)
[Gambarkan sketsa tata letak untuk minimal 2-3 layar utama proyek menggunakan ASCII art atau diagram Mermaid].

---

## 4. Matriks Siklus Status Interaksi (*5-State Component Matrix*)

Setiap komponen yang berinteraksi dengan data atau pengguna WAJIB memiliki spesifikasi untuk ke-5 status berikut:

| Komponen | Default / Idle | Hover / Active / Focus | Loading State (Skeleton) | Empty State | Error State |
|:---|:---|:---|:---|:---|:---|
| **Tombol CTA** | Latar warna aksen solid, teks putih | `-translate-y-[0.5px]`, opasitas 90%, ring fokus 2px aksen | Label diganti spinner mini + `disabled:opacity-70` | N/A | Status gagal berubah merah sesaat + pesan tooltip |
| **Input Form** | Border netral, latar surface | Border aksen, ring glow halus 1px aksen | Shimmer bergaris abu-abu | Placeholder teks abu-abu pembantu | Border merah, pesan error di bawah input |
| **Kartu KPI** | Angka bold, label muted, border halus | Border berubah sedikit lebih terang, kursor pointer | Kotak abu-abu berkedip halus (*skeleton pulse*) | Angka tampil `0` atau `-` dengan catatan | Pesan "Gagal memuat metrik" + tombol coba lagi |
| **Tabel Data** | Baris bergaris halus, teks rata kiri/kanan | Baris berubah warna tipis saat disorot kursor | 5 baris balok shimmer menyerupai data asli | Ilustrasi kotak kosong + tombol "Tambah Data Baru" | Banner merah kontekstual di atas tabel |

---

## 5. Pola Antarmuka Produk (*Product UI Patterns*)

### A. Kartu Metrik & Dashboard
- Angka utama menggunakan tipografi `h1` atau `display` tebal (*font-bold*).
- Label metrik diletakkan di atas atau di bawah angka dengan tipografi `small text-muted`.
- Indikator tren positif/negatif menggunakan pill kecil berwarna hijau/merah dengan ikon panah.
- Dilarang menumpuk terlalu banyak kartu dalam satu baris (maksimal 4 kolom di desktop, 1-2 di mobile).

### B. Tabel Data (*Data Tables*)
- Teks nama/deskripsi rata kiri (*align-left*).
- Angka kuantitas, saldo finansial, dan persentase rata kanan (*align-right*).
- Header tabel terkunci di atas (*sticky header*) jika tabel dapat digulir (*scroll*).
- Teks yang terlalu panjang dipotong rapi dengan ellipsis (`truncate`) disertai tooltip pembaca teks lengkap.
- Baris kosong diberi tanda strip `-`, dilarang membiarkan sel kosong tanpa isi.

### C. Jendela Dialog & Lembar Geser (*Modals & Slide-over Drawers*)
- Wajib memiliki latar belakang redup (*backdrop scrim* gelap tembus pandang) yang mengunci fokus layar di baliknya.
- Wajib dapat ditutup dengan menekan tombol keyboard `Escape` atau mengklik area luar jendela.
- Posisi tombol aksi konfirmasi selalu berada di kanan bawah, diawali tombol batal di kirinya.

---

## 6. Kepatuhan Aksesibilitas (WCAG 2.1 AA) & Tampilan Ponsel (*Mobile*)
- **Uji Kontras Warna**: Seluruh pasangan warna teks dan latar belakang telah diverifikasi memenuhi rasio minimal 4.5:1.
- **Area Sentuh Mobile (*Touch Targets*)**: Seluruh tombol dan kontrol interaktif memiliki area klik minimal `44x44px` pada layar sentuh.
- **Navigasi Keyboard**: Seluruh elemen interaktif dapat dijangkau menggunakan tombol `Tab` dan memiliki ring fokus yang terlihat jelas (`focus-visible:ring-2`).
- **Dukungan Reduksi Gerak**: Animasi otomatis dinonaktifkan jika pengguna mengaktifkan `prefers-reduced-motion`.

---

## 7. Klausul Arsitektur Headless / CLI (Opsional)
*(Hanya berlaku jika proyek murni berupa CLI tool atau Backend API tanpa GUI)*
- **Status Proyek**: `Headless / CLI Architecture`
- **Konvensi Tampilan Terminal**:
  - Palet ANSI: Cyan untuk petunjuk, Hijau untuk sukses, Kuning untuk peringatan, Merah untuk gagal.
  - Densitas Output: Mode ringkas (*concise*) secara default, mode rinci (*verbose*) via flag `--verbose`.
  - Penanganan Input Prompt: Menampilkan opsi bernomor jelas dan nilai bawaan (*default value*).
````

---

## Template: `docs/decisions/DDR-[YYYYMMDDHHmm].md`

````markdown
# DDR-[YYYYMMDDHHmm]: [Judul Keputusan Sistem Desain & Arah Visual]

- **Status**: Diterima (Accepted) / Ditinjau (Proposed) / Digantikan (Superseded)
- **Tanggal**: [YYYY-MM-DD]
- **Pengambil Keputusan**: Pengguna, Desainer UI/UX, & Tim Frontend Lead
- **Dokumen Terkait**: [docs/DesignSystem.md](../DesignSystem.md)

## 1. Konteks Masalah & Kebutuhan Desain Visual
[Jelaskan latar belakang mengapa sistem desain ini dirumuskan, audiens target yang dituju, dan kesan visual yang ingin dicapai].

## 2. Pilihan Fondasi Desain & Konfigurasi yang Ditetapkan
- **Aesthetic Vibe**: [Linear-clean / Modern B2B / dsb.]
- **Konfigurasi 3 Dial**: `VARIANCE: [X]`, `MOTION: [Y]`, `DENSITY: [Z]`
- **Basis Token Warna**: [Netral Zinc/Slate + 1 Aksen Tunggal Terkunci]
- **Pustaka Komponen Acuan**: [Tailwind v4 / shadcn/ui / Radix Themes / dsb.]

## 3. Alternatif Arah Desain yang Ditolak
| Alternatif Desain | Alasan Penolakan |
|:---|:---|
| [Alternatif 1, misal: Colorful Playful / Gradasi Ungu] | [Terlalu bising, tidak cocok untuk audiens enterprise B2B, melanggar anti-slop] |
| [Alternatif 2, misal: Data Cockpit Ultra-Dense] | [Memicu kelelahan mata bagi pengguna awam, bertentangan dengan kebutuhan PRD] |

## 4. Konsekuensi Positif & Beban Pemeliharaan (Trade-offs)
- **Konsekuensi Positif**: [Tampilan antarmuka konsisten, kartu tugas frontend memiliki rujukan baku yang pasti, mencegah desain acak-acakan].
- **Beban Pemeliharaan**: [Setiap komponen baru wajib menyertakan 5 status interaksi lengkap dan mematuhi rasio kontras WCAG AA].
- **Strategi Mitigasi**: [Mengotomatisasi pengecekan linter dan tes aksesibilitas di tahap Quality Governance].
````

---

## Anti-Patterns & Common Mistakes
- **AI Gradient Slop**: Menggunakan gradasi warna ungu/pink mencolok tanpa tujuan fungsional pada tombol atau latar belakang halaman.
- **Static-Only Syndrome**: Hanya merancang tampilan sukses statis, tanpa merancang bentuk kerangka pemuatan (*loading skeleton*), kondisi data kosong (*empty state*), atau kondisi gagal (*error state*).
- **Single Centered Card Cliché**: Merancang seluruh halaman dengan satu kotak kartu putih di tengah layar hitam polos tanpa variasi tata letak yang bernapas.
- **Unreachable Touch Targets**: Membuat tombol atau teks tautan di layar ponsel dengan tinggi kurang dari 44px sehingga sulit ditekan jari pengguna.
- **Contrast Failure**: Menaruh teks abu-abu muda di atas latar belakang putih atau teks putih di atas tombol kuning yang membuat tulisan tidak terbaca (*melanggar WCAG AA*).
- **Missing Headless Declaration**: Memaksakan pembuatan wireframe web pada proyek yang jelas-jelas murni berupa perkakas terminal (CLI) atau backend headless.
- **Skipping Design Grilling**: Menentukan warna dan gaya visual sendiri tanpa pernah mengonfirmasi pilihan arah desain bersama pengguna di obrolan chat.

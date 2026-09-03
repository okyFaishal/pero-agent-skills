---
name: pero-granular-refinement
description: Use when sharpening technical task cards with exact file paths, method signatures, boundary cases, and failing test specifications before implementation
---

# Pero Granular Task Refinement (`pero:granular-refinement`)

## Overview
**Origin**: *Pero Custom SDLC Pipeline - Stage 7 (Universal)*.
Skill ini bertindak sebagai **"Kaca Pembesar Tukang Jam / Sketsa Bedah Presisi"** (Sebelum dokter bedah membuat sayatan pertama atau tukang jam membongkar roda gigi halus, mereka melihat lewat kaca pembesar berdaya tinggi untuk menandai urat persis mana yang dipegang, baut nomor berapa yang diputar, dan apa tanda jika roda gigi sudah terpasang kencang). 

Tugasnya adalah mempertajam butir tugas makro dari `docs/TaskBacklog.md` menjadi **Kartu Spesifikasi Tugas Granular (*Granular Task Specification Card*)** yang sangat presisi, konkret, dan bebas tebak-tebakan. Dokumen ini membekali subagent atau engineer dengan path file target yang pasti, tanda tangan metode bertipe ketat (*typed signatures*), skenario uji batas ekstrem (*edge cases*), dan spesifikasi failing test TDD awal (*Red step*) sebelum satu baris pun kode implementasi ditulis.

## Sub-Skill Integration (Perkakas Pendukung)
Dalam menjalankan proses penajaman tugas granular, agent WAJIB mengorkestrasi sub-skill berikut:
- **Upstream Context Reader**: **`MANDATORY`**: Wajib membaca butir tugas spesifik dari `docs/TaskBacklog.md` serta memeriksa kontrak terkait di `docs/SystemSpec.md`, cetak biru modul di `docs/Architecture.md`, dan batas kualitas di `docs/Governance.md`.
- **Dekomposisi Riset 5 Spesialis Penajaman Tetap (*Fixed Refinement Squad*)**: **`REQUIRED SUB-SKILL`**: Gunakan `dispatching-parallel-agents` untuk mendelegasikan tim beranggotakan **5 Agen Spesialis Penajaman Granular Tetap** secara paralel yang masing-masing dibekali alat `context-7` dan `web-search`. Setiap spesialis wajib melakukan evaluasi relevansi awal (*Relevance Pre-Flight Check*). Jika domain relevan, agen dibatasi **minimal 2 dan maksimal 5 pencarian terarah**. Jika domain tidak relevan (misal SDK eksternal pada tugas logika murni tanpa dependensi), agen wajib mendeklarasikan *Early-Exit* (`N/A: Not Applicable`) dan dilarang melakukan pencarian.
- **Verifikasi Dokumentasi Library & SDK Resmi**: **`REQUIRED SUB-SKILL`**: Gunakan `context-7` dan `web-search` untuk memeriksa dokumentasi resmi paket/library pihak ketiga, memastikan tanda tangan fungsi (*method signatures*), tipe data argumen, dan lifecycle method sesuai rilis API mutakhir, bukan hasil halusinasi.
- **Penegakan Kode Bersih & Anti-Slop**: **`REQUIRED SUB-SKILL`**: Gunakan `anti-slop` untuk melarang over-engineering (YAGNI), mengeliminasi komentar sepele yang redundan, dan melarang mock data palsu yang tidak menguji kegagalan nyata.
- **Penegak Siklus Pengujian TDD**: **`REQUIRED SUB-SKILL`**: Gunakan `test-driven-development` untuk merancang spesifikasi failing test (*Red step*) secara eksplisit di awal—mencakup nama fungsi test, input mock/fixtures, dan assertion yang diharapkan gagal sebelum implementasi ada.
- **Verifikasi Bukti Eksekusi Terminal**: **`REQUIRED SUB-SKILL`**: Gunakan `verification-before-completion` untuk menetapkan perintah eksekusi terminal dan kriteria lulus exit code 0 tanpa toleransi kegagalan.
- **Musyawarah Dewan Integritas Teknis**: **`REQUIRED / STRATEGIC SUB-SKILL`**: Gunakan `llm-council` untuk menyidangkan trade-off teknis pada kartu tugas (misal: Functional Result tuple vs Custom Exception, in-memory stub vs containerized test, distributed lock vs DB token) melalui 5 persona AI.
- **Wawancara Penguncian Spesifikasi Tugas di Chat**: **`REQUIRED SUB-SKILL`**: Gunakan `grilling` secara interaktif langsung kepada pengguna di chat dengan batas **minimal 5 dan maksimal 10 pertanyaan** bertahap (1–2 pertanyaan per putaran) untuk mengunci tanda tangan method, batas kasus ekstrem, strategi mocking, dan kriteria uji. Agent WAJIB menghentikan eksekusi (*pause*) dan menunggu respon pengguna. DILARANG menentukan detail kartu sepihak.
- **Perancangan Kontrak & Tanda Tangan Metode**: **`SUPPORTING SUB-SKILL`**: Gunakan `api-contract-design` untuk menyusun struktur parameter method, return envelope, dan status kode error secara konsisten.
- **Validasi Skema & Batasan Payload**: **`SUPPORTING SUB-SKILL`**: Gunakan `schema-validator` untuk memvalidasi struktur tipe data DTO, payload request/response, dan batasan batas (*boundary constraints*) pada interface.
- **Proteksi Rahasia & Lingkungan**: **`SUPPORTING SUB-SKILL`**: Gunakan `env-guard` untuk memastikan tidak ada kunci rahasia atau kredensial yang dituliskan langsung dalam fixtures kartu tugas.
- **Penyalur Eksekusi Otonom Sub-Agen**: **`SUPPORTING SUB-SKILL`**: Gunakan `subagent-driven-development` untuk menyalurkan kartu tugas yang sudah dipertajam menjadi *task brief* mandiri yang siap dieksekusi oleh Implementer Subagent.
- **Pencatatan Keputusan Penajaman Tugas**: **`SUPPORTING SUB-SKILL`**: Gunakan `decision-recorder` untuk membukukan keputusan desain mikro, strategi error handling, dan mitigasi dependensi ke `docs/decisions/RDR-[YYYYMMDDHHmm].md` menggunakan template standar resmi.
- **Audit Konsistensi Penajaman Tugas**: **`SUPPORTING SUB-SKILL`**: Gunakan `pero-context-validation` untuk memastikan kartu tugas tidak mengalami *drift* dari arsitektur, tata kelola, dan spesifikasi hulu.
- **Spesifikasi Estetika & Dial Visual Antarmuka**: **`CONDITIONAL SUB-SKILL`**: Jika kartu tugas menargetkan pembuatan atau modifikasi komponen antarmuka pengguna (Frontend/UI/Landing Page), gunakan `taste-skill` untuk menetapkan *Brief Inference*, nilai 3 Dial (`DESIGN_VARIANCE`, `MOTION_INTENSITY`, `VISUAL_DENSITY`), pasangan tipografi, 4–6 token warna Hex, dan aturan *anti-slop* visual pada kartu tugas. Jika kartu tugas murni backend/core/data tanpa perubahan UI, sub-skill ini tidak digunakan.

## The 5-Stage Granular Refinement Framework

```
[0. Ingestion docs/TaskBacklog.md & Upstream Context]
                                   │
                                   ▼
[1. Riset 5 Spesialis Penajaman Tetap + Context7 & Web Search]
    (Signatures, Boundary/Idempotency, TDD Red Spec, SDK Grounding, Anti-Slop)
                                   │
                                   ▼
[2. Sidang Dewan Integritas Teknis (LLM Council)]
    (5 Persona AI menguji: Result vs Exception, Invariant Pre/Post, Blast Radius)
                                   │
                                   ▼
[3. Wawancara Penguncian Spesifikasi di Chat (Grilling Rambu Henti)]
    (Min 5, Max 10 Tanya: kunci signatures, edge cases, error codes, test runner)
                                   │
                                   ▼
[4. Penerbitan Kartu Tugas Formal docs/tasks/TASK-[ID].md (7 Anatomi Presisi)]
                                   │
                                   ▼
[5. Pembukuan Rekam Keputusan RDR Formal & Audit Konsistensi Hulu-Hilir]
```

### 1. Dekomposisi Riset Paralel Berbasis 5 Spesialis Penajaman Tetap
Mendelegasikan tim 5 agen spesialis penajaman tetap via `dispatching-parallel-agents` yang masing-masing dibekali alat `context-7` dan `web-search`:

#### A. 5 Peran Spesialis Penajaman Granular Tetap (*Fixed Task Refinement Roles*):
1. **Spesialis 1: Tanda Tangan Tipe & Kontrak Data Murni (*Types, DTOs & Method Signatures Specialist*)**:
   - *Fokus*: Meneliti input params, return types, custom error classes, immutability, dan validasi Zod/Pydantic/Go struct tanpa tipe ambigu (`any` / `Object`).
2. **Spesialis 2: Kasus Batas Ekstrem, Idempotency & Konkurensi (*Boundary, Idempotency & Edge-Cases Specialist*)**:
   - *Fokus*: Meneliti kondisi masukan null/empty/whitespace, batas maksimum numerik, duplikasi request paralel (*idempotency key*), race conditions, dan database rollback.
3. **Spesialis 3: Desain Skenario Uji TDD & Red Spec (*TDD Fixtures, Mocks & Assertions Specialist*)**:
   - *Fokus*: Merancang nama fungsi test deskriptif, mock fixtures deterministik terisolasi, dan assertions yang tajam (menolak mock data kosong yang tidak menguji logika).
4. **Spesialis 4: Dokumentasi Library Pihak Ketiga & Grounding API (*Third-Party SDK & Library Grounding Specialist*)**:
   - *Fokus*: Memeriksa dokumentasi resmi SDK pihak ketiga via `context-7` dan `web-search` untuk memastikan method signatures dan lifecycle API 100% mutakhir dan anti-halusinasi.
5. **Spesialis 5: Pagar Anti-Slop, Keamanan Data & Estetika (*Anti-Slop, Data Masking & Taste Specialist*)**:
   - *Fokus*: Memastikan kartu tugas mematuhi `anti-slop` (bebas over-engineering/YAGNI, bebas komentar sepele), proteksi credential (`env-guard`), penyensoran log PII, dan menyematkan parameter visual `taste-skill` jika menyentuh antarmuka UI.

#### B. Mekanisme Evaluasi Relevansi Awal & Pintu Keluar Dini (*Relevance Pre-Flight Check & Early Exit*):
- Setiap spesialis membaca konteks tugas sebelum menjalankan riset.
- Jika domain spesialis tersebut **sama sekali tidak relevan** (misalnya: Spesialis 4 pada fungsi algoritma matematika murni tanpa pustaka eksternal):
  - Spesialis **WAJIB** mendeklarasikan: `Status: Not Applicable (N/A). Alasan: [Penjelasan mengapa domain ini tidak dibutuhkan]`.
  - Agen berstatus `N/A` **DILARANG melakukan pencarian (0 search)** dan **DILARANG mengarang dependensi palsu**.

#### C. Pagar Batas Riset & Pencarian (*Guardrails*):
- Untuk domain yang relevan: **Minimal 2 pencarian terarah** (wajib merujuk dokumentasi resmi Context7 atau standar framework) dan **Maksimal 5 pencarian terarah** per agen.
- Untuk domain `N/A`: **0 pencarian**.
- Setiap agen spesialis aktif wajib menyertakan minimal 1 tautan URL / rujukan resmi dalam laporannya.

### 2. Musyawarah Dewan Integritas Teknis (via `llm-council`)
- Menyidangkan perdebatan desain mikro kartu tugas ke 5 persona dewan AI (*Product Strategist, Skeptic Auditor, Domain Specialist, Tech Feasibility, User Advocate*).
- Topik sidang:
  - Pola penanganan error: Pelemparan `Custom Exception` vs Functional `Result<T, E>` tuple.
  - Skenario penguncian konkurensi: Optimistic Locking vs Distributed Redis Lock.
  - Strategi isolasi test: In-memory stub fixtures vs Containerized integration testing.
- Dewan menghasilkan sintesis konsensus dan opsi kompromi teknis (Opsi A vs Opsi B) untuk diserahkan ke sesi wawancara chat.

### 3. Wawancara Penguncian Spesifikasi Tugas di Chat (via `grilling`)
- **RAMBU HENTI WAJIB (MANDATORY PAUSE GATE)**:
  - Agent **DILARANG** langsung menerbitkan kartu tugas `docs/tasks/TASK-[ID].md` sebelum menyepakati tanda tangan metode, skenario batas ekstrem, strategi mocking, dan perintah verifikasi bersama pengguna di obrolan (*chat*).
  - Dilarang keras menentukan detail implementasi atau format error secara sepihak.
- **Pagar Batas Pertanyaan (Volume & Delivery Guardrails)**:
  - **Batas Kuantitas**: Sesi wawancara dibatasi **minimal 5 pertanyaan** (untuk menguji seluruh aspek teknis kartu tugas) dan **maksimal 10 pertanyaan** (mencegah kelelahan pengguna).
  - **Penyampaian Bertahap (*Anti-Question Avalanche*)**: DILARANG memberondong pertanyaan sekaligus. Ajukan 1–2 pertanyaan per putaran chat dengan opsi konkret (Opsi A vs Opsi B) dan rekomendasi teknis AI.
- **Fokus Topik Wawancara**:
  1. Gaya Penanganan Error (Functional `Result<T, E>` tuple vs Pelemparan `Custom Exception`).
  2. Mekanisme Idempotency & Concurrency Locking (Database unique token vs Atomic distributed lock).
  3. Kedalaman Mocking pada Test Suite (Mock interface terisolasi vs In-memory database stub).
  4. Aturan Validasi Input Ekstrem (Kebijakan trimming whitespace, batasan panjang string, regex strictness).
  5. Target Perintah Eksekusi Terminal (Timeout runner dan filter file test spesifik).
- **Hentikan pemanggilan tools (STOP)** dan tunggu keputusan pengguna di chat pada setiap putaran.

### 4. Penerbitan Kartu Tugas Formal docs/tasks/TASK-[ID].md
- Menyusun kartu spesifikasi tugas presisi mematuhi **7 Anatomi Presisi**, target files konkret, invariant kontrak, dan perintah verifikasi terminal 0-failure.

### 5. Pembukuan Rekam Keputusan RDR Formal & Audit Konsistensi
- Membukukan seluruh keputusan desain mikro ke `docs/decisions/RDR-[YYYYMMDDHHmm].md` (*Refinement Decision Record*) menggunakan template standar resmi.
- Menjalankan audit konsistensi hulu-hilir via `pero-context-validation` untuk memastikan kartu tugas selaras dengan PRD, SystemSpec, Architecture, Governance, dan TaskBacklog.

## When to Use
- Sebelum subagent, pengembang, atau pelaksana koding mengeksekusi tugas apa pun dari `docs/TaskBacklog.md`.
- Mengubah butir checklist tugas tingkat tinggi menjadi kartu instruksi teknis yang siap dieksekusi secara otonom (*agent-ready*).
- Menentukan lokasi file test dan implementasi yang presisi tanpa ambiguitas struktur folder.
- Merumuskan tanda tangan fungsi/metode publik lengkap dengan tipe data parameter, tipe kembalian (*return type*), dan tipe error/exception.
- Mendefinisikan seluruh kasus batas (*edge cases*), nilai nol/kosong, timeout jaringan, dan tabrakan konkurensi.
- Menyiapkan perintah CLI terminal verifikasi instan untuk siklus Red dan Green.

## The 7 Anatomies of a Refined Task Card
Setiap tugas yang dipertajam **WAJIB** memiliki 7 anatomi presisi berikut:

```
┌────────────────────────────────────────────────────────────────────────┐
│               THE 7 ANATOMIES OF A REFINED TASK CARD                   │
├────────────────────────────────────────────────────────────────────────┤
│ 1. Exact Target File Paths       : [Test Path] + [Implementation Path] │
│ 2. Precise Public Interface      : Typed Parameters, Return, Errors    │
│ 3. Contract Invariance           : Pre-conditions & Post-conditions    │
│ 4. Concrete Boundary & Edge Cases: Null, Empty, Timeout, Collisions    │
│ 5. Step-by-Step TDD Test Cases   : Test Names, Fixtures, Assertions    │
│ 6. Blast Radius & Revert Strategy: Side Effects, Dependent Modules     │
│ 7. Terminal CLI & Exit Codes     : Failing (Red) -> Passing (Green)    │
└────────────────────────────────────────────────────────────────────────┘
```

### 1. Exact Target File Paths
- **Test File Path**: Lokasi file unit/integration test (misal: `tests/core/services/payment_service.test.ts`).
- **Implementation File Path**: Lokasi file sumber logika bisnis (misal: `src/core/services/payment_service.ts`).
- **Supporting File Paths**: File tipe bersama, migrasi database, atau konfigurasi pendukung.

### 2. Precise Public Interface & Method Signatures
- Menuliskan tanda tangan metode dalam format bahasa target dengan tipe data eksplisit (tanpa `any`, `Object`, atau pointer ambigu).

### 3. Contract Invariance (Pre-conditions & Post-conditions)
- **Pre-conditions**: Syarat mutlak yang wajib bernilai benar sebelum method dieksekusi (misal: user terotentikasi, amount > 0).
- **Post-conditions**: Jaminan mutlak yang pasti terpenuhi setelah method selesai (misal: record order tersimpan di database, event terkirim, saldo berkurang tepat $N$).

### 4. Concrete Boundary & Edge Cases Matrix
- Mendokumentasikan secara rinci skenario anomali: nilai kosong/null, batas maksimum numerik, kegagalan jaringan/timeout, dan tabrakan konkurensi.

### 5. Step-by-Step TDD Test Cases (Red Spec)
- Menyusun rancangan test runner konkret untuk tahap **Red (Failing Test)** lengkap dengan nama test deskriptif, input fixtures, dan assertions.

### 6. Blast Radius, Side-Effects & Revert Strategy
- Memetakan modul mana saja yang berpotensi terdampak oleh perubahan ini, serta prosedur pembatalan (*rollback/revert*) jika tugas gagal diselesaikan.

### 7. Terminal Command Line & Expected Exit Code
- Menyediakan perintah terminal konkret untuk mengeksekusi pengujian:
  - **Failing Command (Red)**: Perintah untuk memverifikasi test gagal karena implementasi belum ada (`exit code != 0`).
  - **Passing Command (Green)**: Perintah untuk memverifikasi seluruh test lulus pasca implementasi (`exit code 0`, `0 failures`).

## Deliverables & Output Artifacts

1. **Living Artifact**: `docs/tasks/TASK-[ID].md`
2. **Decision Record**: `docs/decisions/RDR-[YYYYMMDDHHmm].md`

---

## Output Artifact Format: Granular Task Specification Card

Setiap penajaman tugas menghasilkan kartu berformat berikut:

````markdown
# Task Refinement Card: [Task ID] - [Judul Tugas]

- **Status**: Ready for Implementation (TDD Phase)
- **Domain**: [Web | Mobile | Backend | Database | Security | Core]
- **Complexity / Size**: [S (1-2 files, ~100 lines) | M (3-4 files, ~200-300 lines)]
- **Sumber Backlog**: [docs/TaskBacklog.md](docs/TaskBacklog.md) (Task X.Y)
- **Referensi Desain**: [docs/SystemSpec.md](docs/SystemSpec.md) & [docs/Architecture.md](docs/Architecture.md)
- **Decision Record**: [docs/decisions/RDR-[YYYYMMDDHHmm].md](../decisions/RDR-[YYYYMMDDHHmm].md)

---

### 1. Target File Paths
- **Test File**: `tests/path/to/target.test.ts`
- **Implementation File**: `src/path/to/target.ts`
- **Related Types/Contracts**: `src/core/types/target.ts`

---

### 2. Precise Public Interface & Method Signatures

```typescript
// Bahasa Pemrograman: [TypeScript / Go / Python / Rust / dll.]

export interface CreateOrderParams {
  userId: string;
  items: Array<{
    productId: string;
    quantity: number;
    unitPrice: number;
  }>;
  idempotencyKey: string;
}

export interface OrderResult {
  orderId: string;
  totalAmount: number;
  status: 'PENDING' | 'COMPLETED';
  createdAt: string;
}

export interface OrderServicePort {
  /**
   * Membuat order baru secara atomik dengan validasi stok dan idempotency.
   * @throws {ValidationError} jika items kosong atau quantity <= 0
   * @throws {DuplicateOrderError} jika idempotencyKey sudah pernah diproses
   * @throws {InsufficientStockError} jika stok barang tidak mencukupi
   */
  createOrder(params: CreateOrderParams): Promise<OrderResult>;
}
```

---

### 3. Contract Invariance (Pre-conditions & Post-conditions)

#### A. Pre-conditions (Syarat Mutlak Sebelum Eksekusi):
1. `params.userId` wajib berupa non-empty string dan mewakili user yang valid.
2. `params.items` wajib memiliki minimal 1 elemen dengan `quantity > 0` dan `unitPrice >= 0`.
3. `params.idempotencyKey` wajib berupa UUID v4 string yang valid.

#### B. Post-conditions (Garansi Pasti Setelah Eksekusi Selesai):
1. Record order tersimpan di database dengan status `PENDING` atau `COMPLETED`.
2. Stok setiap barang dalam `items` berkurang tepat sebesar `quantity`.
3. Kunci idempotency tersimpan dengan TTL 24 jam untuk mencegah eksekusi ganda.
4. Jika terjadi kegagalan di tengah jalan (misal stok tidak cukup), transaksi database dibatalkan penuh (*atomic rollback*) dan tidak ada data yang termutasi.

---

### 4. Concrete Boundary & Edge Cases Matrix

| Skenario Kasus | Masukan / Kondisi | Ekspektasi Perilaku | Tipe Error / Status |
|---|---|---|---|
| **Empty Items** | `items: []` | Menolak proses, tidak memotong stok | `ValidationError (422)` |
| **Zero/Negative Qty**| `quantity: 0` atau `-5` | Menolak proses kalkulasi | `ValidationError (422)` |
| **Duplicate Key** | `idempotencyKey` sama dikirim ulang paralel | Mengembalikan order sebelumnya tanpa duplikasi pemotongan | `IdempotentReplay (200/409)` |
| **Null/Missing User**| `userId: ""` atau `null` | Menolak sebelum akses database | `UnauthorizedError (401)` |
| **DB Timeout** | Database tidak merespons > 3000ms | Rollback transaksi, lepaskan lock | `GatewayTimeoutError (504)` |

---

### 5. Step-by-Step TDD Test Cases (Red Spec)

#### Test Case 1: Happy Path - Create Order Success
```typescript
it('should create order successfully and return OrderResult with PENDING status', async () => {
  // Arrange
  const fixture = {
    userId: 'usr-123',
    items: [{ productId: 'prod-001', quantity: 2, unitPrice: 50000 }],
    idempotencyKey: 'idem-uuid-001'
  };
  
  // Act
  const result = await orderService.createOrder(fixture);
  
  // Assert
  expect(result.orderId).toBeDefined();
  expect(result.totalAmount).toBe(100000);
  expect(result.status).toBe('PENDING');
});
```

#### Test Case 2: Negative Path - Empty Items Rejection
```typescript
it('should throw ValidationError when items array is empty', async () => {
  const invalidFixture = {
    userId: 'usr-123',
    items: [],
    idempotencyKey: 'idem-uuid-002'
  };
  
  await expect(orderService.createOrder(invalidFixture))
    .rejects.toThrow(ValidationError);
});
```

#### Test Case 3: Edge Case - Idempotency Concurrency Collision
```typescript
it('should prevent double-processing when two identical idempotency keys arrive concurrently', async () => {
  const fixture = {
    userId: 'usr-123',
    items: [{ productId: 'prod-001', quantity: 1, unitPrice: 50000 }],
    idempotencyKey: 'idem-concurrent-003'
  };
  
  const [res1, res2] = await Promise.allSettled([
    orderService.createOrder(fixture),
    orderService.createOrder(fixture)
  ]);
  
  const successfulCalls = [res1, res2].filter(r => r.status === 'fulfilled');
  expect(successfulCalls.length).toBe(1);
});
```

---

### 6. Blast Radius, Side-Effects & Revert Strategy
- **Modul Terdampak (*Blast Radius*)**:
  - `src/infra/repositories/order_repository.ts` (pemanggilan query insert & update)
  - `src/core/types/order.ts` (ekspor tipe data baru)
- **Potensi Efek Samping (*Side-Effects*)**:
  - Modifikasi lock sementara pada baris tabel produk saat pengecekan stok.
- **Strategi Pembatalan (*Revert / Rollback Plan*)**:
  - Jika sub-agen gagal menyelesaikan tugas:
    ```bash
    git checkout -- src/core/services/order_service.ts tests/core/services/order_service.test.ts
    ```

---

### 7. Verification Commands

- **Failing Check (Red Phase)**:
  ```bash
  npm test tests/core/services/order_service.test.ts
  # Verifikasi: Test harus dieksekusi dan GAGAL karena method belum diimplementasikan.
  ```

- **Passing Check (Green Phase)**:
  ```bash
  npm test tests/core/services/order_service.test.ts
  # Target: Exit Code 0, 0 Failures, 0 Errors.
  ```
````

---

## Template: `docs/decisions/RDR-[YYYYMMDDHHmm].md`

````markdown
# RDR-[Nomor]: [Judul Keputusan Penajaman Tugas, misal: Penetapan Interface OrderServicePort & Idempotency Locking]

- **Status**: Diterima (Accepted) / Ditinjau (Proposed) / Digantikan (Superseded)
- **Tanggal**: [YYYY-MM-DD]
- **Pengambil Keputusan**: Pengguna & Tim Penajaman Tugas AI
- **Dokumen Terkait**: [docs/tasks/TASK-[ID].md](../tasks/TASK-[ID].md) & [docs/TaskBacklog.md](../TaskBacklog.md)

## 1. Konteks Tugas & Kebutuhan Penajaman
[Jelaskan latar belakang mengapa kartu tugas ini memerlukan penetapan tanda tangan method, aturan invarian, atau strategi penanganan error khusus].

## 2. Desain Interface, Invarian & Kontrak yang Ditetapkan
[Jelaskan rincian tipe data, error hierarchy, pre/post-conditions, dan batasan teknis yang disepakati].

## 3. Alternatif Desain yang Ditolak
| Alternatif Desain | Alasan Penolakan |
|:---|:---|
| [Alternatif Desain 1] | [Mengapa tidak dipilih / potensi race condition / performa buruk] |
| [Alternatif Desain 2] | [Kelemahan teknis / tipe data terlalu longgar / overhead kompleksitas] |

## 4. Konsekuensi Positif & Beban Operasional (Trade-offs)
- **Konsekuensi Positif**: [Tipe data aman dari runtime crash, integritas data terjamin, TDD deterministik]
- **Beban Operasional**: [Perlu penulisan interface terpisah dan mocking yang ketat di test suite]
- **Strategi Mitigasi / Otomatisasi**: [Bagaimana beban tersebut diringankan via compiler type-check dan runner test otomatis]

## 5. Kebijakan Mitigasi & Radius Dampak (Blast Radius Mitigation)
[Langkah mitigasi jika perubahan pada modul ini memengaruhi modul hulu atau hilir lainnya].
````

## Anti-Patterns & Common Mistakes
- **Simulated Refinement Deciding**: Menentukan sendiri method signatures, skenario edge case, atau strategi error handling tanpa pernah melakukan wawancara grilling di chat bersama pengguna.
- **Untyped Slop & Loose DTOs**: Mengabaikan tipe data konkret (misal: memakai `data: any`, `dict` polos, atau dynamic objects tanpa schema Pydantic/Zod/Struct) yang mengundang bug runtime saat integrasi.
- **Phantom Invariants & Untracked Side Effects**: Tidak mendefinisikan pre-conditions dan post-conditions, sehingga efek samping (seperti mutasi database parsial tanpa rollback) bocor dan merusak state modul lain.
- **Hallucinated Library Signatures (Skipping Context-7)**: Mengasumsikan nama method pustaka pihak ketiga tanpa memvalidasi dokumentasi resmi via `context-7`, sehingga kode gagal kompilasi karena method deprecated atau tidak ada.
- **Happy Path Only (Skipping Boundary & Edge Cases)**: Hanya merancang skenario input ideal dan melupakan kasus `null`, array kosong, batas kuota, timeout, serta tabrakan konkurensi.
- **File Path Guessing & Ambiguous Directories**: Tidak mencantumkan nama dan path direktori file target secara pasti, membuat sub-agen pelaksana menaruh file di direktori yang salah.
- **Skipping TDD Red Spec**: Langsung meminta penulisan kode implementasi tanpa menyediakan unit test fixture dan assertion terstruktur yang diverifikasi gagal terlebih dahulu.
- **Question Avalanche or Premature Cessation**: Mengirimkan lebih dari 2 pertanyaan sekaligus dalam satu balon chat, bertanya kurang dari 5 pertanyaan, atau melampaui batas 10 pertanyaan pada Tahap 3 (memicu kelelahan pengguna).
- **Forced Irrelevant Specialization**: Memaksakan riset SDK pihak ketiga atau parameter UI pada tugas algoritma internal murni, alih-alih mendeklarasikan status `N/A`.
- **Unbounded Web Search Avalanche**: Melakukan kurang dari 2 pencarian terarah pada domain yang relevan, melampaui batas 5 pencarian per agen, atau tetap mencari pada domain `N/A`.
- **Absennya Perintah Verifikasi Terminal**: Tidak menyertakan perintah terminal pasti untuk menguji status kelulusan task (exit code 0 dan 0 failure).

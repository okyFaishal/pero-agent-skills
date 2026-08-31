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
- **Pendelegasian Tugas Terisolasi Paralel**: **`SUPPORTING SUB-SKILL`**: Gunakan `dispatching-parallel-agents` untuk membungkus setiap kartu tugas yang telah memiliki target file path terisolasi menjadi instruksi mandiri agar dapat dieksekusi secara serentak oleh sub-agen koding.
- **Penegak Siklus Pengujian TDD**: **`REQUIRED SUB-SKILL`**: Gunakan `test-driven-development` untuk merancang spesifikasi failing test (*Red step*) secara eksplisit di awal—mencakup nama fungsi test, input mock/fixtures, dan assertion yang diharapkan gagal sebelum implementasi ada.
- **Verifikasi Dokumentasi Library & SDK**: **`REQUIRED SUB-SKILL`**: Gunakan `context-7` untuk memeriksa dokumentasi resmi paket/library pihak ketiga, memastikan tanda tangan fungsi (*method signatures*), tipe data argumen, dan lifecycle method sesuai rilis API mutakhir, bukan hasil halusinasi.
- **Validasi Skema & Batasan Payload**: **`SUPPORTING SUB-SKILL`**: Gunakan `schema-validator` untuk memvalidasi struktur tipe data DTO, payload request/response, dan batasan batas (*boundary constraints*) pada interface.
- **Proteksi Rahasia & Lingkungan**: **`SUPPORTING SUB-SKILL`**: Gunakan `env-guard` untuk memastikan tidak ada kunci rahasia atau kredensial yang dituliskan langsung dalam fixtures kartu tugas.

## When to Use
- Sebelum subagent, pengembang, atau pelaksana koding mengeksekusi tugas apa pun dari `docs/TaskBacklog.md`.
- Mengubah butir checklist tugas tingkat tinggi menjadi kartu instruksi teknis yang siap dieksekusi secara otonom (*agent-ready*).
- Menentukan lokasi file test dan implementasi yang presisi tanpa ambiguitas struktur folder.
- Merumuskan tanda tangan fungsi/metode publik lengkap dengan tipe data parameter, tipe kembalian (*return type*), dan tipe error/exception.
- Mendefinisikan seluruh kasus batas (*edge cases*), nilai nol/kosong, timeout jaringan, dan tabrakan konkurensi.
- Menyiapkan perintah CLI terminal verifikasi instan untuk siklus Red dan Green.

## The 5 Anatomies of a Refined Task
Setiap tugas yang dipertajam **WAJIB** memiliki 5 anatomi presisi berikut:

```
┌────────────────────────────────────────────────────────────────────────┐
│               THE 5 ANATOMIES OF A REFINED TASK CARD                   │
├────────────────────────────────────────────────────────────────────────┤
│ 1. Exact Target File Paths       : [Test Path] + [Implementation Path] │
│ 2. Precise Public Interface      : Typed Parameters, Return, Errors    │
│ 3. Concrete Boundary & Edge Cases: Null, Empty, Timeout, Collisions    │
│ 4. Exact TDD Test Specifications : Test Names, Fixtures, Assertions    │
│ 5. Terminal CLI & Exit Codes     : Failing (Red) -> Passing (Green)    │
└────────────────────────────────────────────────────────────────────────┘
```

### 1. Exact Target File Paths
- Menetapkan lokasi file secara absolut atau relatif dari root repositori:
  - **Test File Path**: Lokasi file unit/integration test (misal: `tests/core/services/payment_service.test.ts` atau `tests/test_auth.py`).
  - **Implementation File Path**: Lokasi file sumber logika bisnis (misal: `src/core/services/payment_service.ts` atau `app/services/auth.py`).
  - **Supporting File Paths**: File tipe bersama, migrasi database, atau konfigurasi jika relevan.

### 2. Precise Public Interface & Method Signatures
- Menuliskan tanda tangan metode (*method signatures*) dalam format bahasa target dengan tipe data eksplisit:
  - Tipe data parameter input (primitif, DTO, struct, atau interface).
  - Tipe nilai kembalian (*return type* atau async promise/future/task).
  - Tipe error / exception yang dapat dilemparkan (*custom error types* atau `Result<T, E>`).
  - Tidak diperbolehkan menggunakan tipe ambigu seperti `any`, `Object`, atau pointer kosong tanpa batasan.

### 3. Concrete Boundary & Edge Cases
- Mendokumentasikan secara rinci skenario anomali dan kondisi batas:
  - **Nilai Kosong / Ketiadaan Data**: `null`, `nil`, `undefined`, string kosong `""`, array/list kosong `[]`, whitespace-only.
  - **Batas Numerik**: Nilai negatif, angka `0`, nilai maksimum batas integer/float (*overflow/underflow*).
  - **Kegagalan Jaringan & Eksternal**: Timeout response, koneksi terputus, retry exhaustion, payload corrupt.
  - **Konkurensi & Tabrakan State**: Modifikasi paralel bersamaan, lock contention, race conditions.

### 4. Exact Step-by-Step TDD Test Cases
- Menyusun rancangan test runner konkret untuk tahap **Red (Failing Test)**:
  - **Nama Fungsi Test**: Format deskriptif (misal: `it('should throw ERR_INSUFFICIENT_FUNDS when balance is lower than amount')`).
  - **Input Fixtures / Mock Data**: Objek masukan tiruan yang terisolasi dan deterministik.
  - **Langkah Eksekusi**: Pemanggilan fungsi target dengan parameter fixture.
  - **Expected Assertion**: Pernyataan ekspektasi hasil yang dapat diverifikasi mesin (`expect(status).toBe(400)`).

### 5. Terminal Command Line & Expected Exit Code
- Menyediakan perintah terminal konkret untuk mengeksekusi pengujian:
  - **Failing Command (Red)**: Perintah untuk memverifikasi test gagal karena implementasi belum ada (`exit code != 0`).
  - **Passing Command (Green)**: Perintah untuk memverifikasi seluruh test lulus pasca implementasi (`exit code 0`, `0 failures`).

---

## Refinement Execution Workflow

```
[1. Baca Upstream Backlog & Dokumen Terkait]
                      │
                      ▼
[2. Grounding API Resmi via Context-7]
                      │
                      ▼
[3. Rancang Interface, Tipe & Kasus Batas]
                      │
                      ▼
[4. Rancang Failing Test Spec (TDD Red Phase)]
                      │
                      ▼
[5. Terbitkan Granular Task Specification Card]
```

### Langkah 1: Ekstraksi Konteks Hulu
- Identifikasi ID tugas di `docs/TaskBacklog.md` (misal: `Task 3.2`).
- Periksa spesifikasi antarmuka terkait di `docs/SystemSpec.md` (kontrak endpoint, model domain, format error).
- Periksa pola arsitektur di `docs/Architecture.md` (modul boundary, dependency injection).
- Periksa standar keamanan & konkurensi di `docs/Governance.md`.

### Langkah 2: Grounding Library API via Context-7
- Sebelum mendefinisikan interface yang bergantung pada library eksternal (misal: `zod`, `jwt`, `prisma`, `tokio`, `fastapi`, `pydantic`), panggil `context-7` untuk mengecek API terkini.
- Pastikan tidak ada asumsi sintaks kadaluarsa atau metode deprecated.

### Langkah 3: Perumusan Interface & Boundary Cases
- Tuliskan interface/struct/class secara detail dengan anotasi tipe data penuh.
- Daftarkan skenario batas ekstrem yang harus ditangani fungsi tersebut.

### Langkah 4: Desain Failing Test Spec (TDD Red)
- Rumuskan test case awal:
  - Test 1: Happy Path.
  - Test 2: Invalid Input / Negative Path.
  - Test 3: Edge Case / Boundary Value.
  - Test 4: Concurrency / Timeout Handling (bila relevan).

### Langkah 5: Penerbitan Kartu Tugas Granular
- Output kartu tugas dalam format terstandarisasi yang langsung dapat diserahkan ke subagent pelaksana koding.

---

## Output Artifact Format: Granular Task Specification Card

Setiap penajaman tugas menghasilkan kartu berformat berikut:

````markdown
# Task Refinement Card: [Task ID] - [Judul Tugas]

- **Status**: Ready for Implementation (TDD Phase)
- **Domain**: [Web | Mobile | Backend | Database | Security | Core]
- **Sumber Backlog**: [docs/TaskBacklog.md](file:///docs/TaskBacklog.md) (Task X.Y)
- **Referensi Desain**: [docs/SystemSpec.md](file:///docs/SystemSpec.md) & [docs/Architecture.md](file:///docs/Architecture.md)

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

### 3. Concrete Boundary & Edge Cases Matrix

| Skenario Kasus | Masukan / Kondisi | Ekspektasi Perilaku | Tipe Error / Status |
|---|---|---|---|
| **Empty Items** | `items: []` | Menolak proses, tidak memotong stok | `ValidationError (422)` |
| **Zero/Negative Qty**| `quantity: 0` atau `-5` | Menolak proses kalkulasi | `ValidationError (422)` |
| **Duplicate Key** | `idempotencyKey` sama dikirim ulang paralel | Mengembalikan order sebelumnya tanpa duplikasi pemotongan | `IdempotentReplay (200/409)` |
| **Null/Missing User**| `userId: ""` atau `null` | Menolak sebelum akses database | `UnauthorizedError (401)` |
| **DB Timeout** | Database tidak merespons > 3000ms | Rollback transaksi, lepaskan lock | `GatewayTimeoutError (504)` |

---

### 4. Step-by-Step TDD Test Cases (Red Spec)

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

### 5. Verification Commands

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

## Anti-Patterns & Common Mistakes

- **Persyaratan yang Samar (Vague Requirements)**: Menulis deskripsi abstrak seperti *"buat autentikasi pengguna"* atau *"rapikan error handling"* tanpa merinci method signature, parameter, tipe kembalian, dan kode error.
- **Tanda Tangan Tanpa Tipe Data Konkret (Untyped / Vague Signatures)**: Mengabaikan tipe data (misal: memakai `data: any` atau `dict` polos tanpa schema Pydantic/Zod/Struct), yang mengundang bug runtime saat integrasi.
- **Menebak-nebak API Library Tanpa Context-7 (Hallucinated Library Signatures)**: Mengasumsikan nama method pustaka pihak ketiga tanpa memvalidasi dokumentasi via `context-7`, sehingga kode gagal kompilasi karena method tidak ada atau deprecated.
- **Melewatkan Kasus Batas & Edge Cases (Happy Path Only)**: Hanya merancang skenario input ideal dan melupakan kasus `null`, array kosong, batas kuota, serta tabrakan konkurensi.
- **Ambiguitas Lokasi File (File Path Guessing)**: Tidak mencantumkan nama dan path direktori file target secara pasti, membuat pelaksana koding menaruh file di direktori yang salah.
- **Melewatkan Spesifikasi Failing Test TDD (Skipping Red Spec)**: Langsung meminta pembuatan kode implementasi tanpa menyediakan unit test fixture dan assertion terstruktur.
- **Absennya Perintah Verifikasi Terminal (Missing Verification CLI)**: Tidak menyertakan perintah terminal pasti untuk menguji status kelulusan task.

---
name: api-contract-design
description: Guides stable API and interface design. Use when designing APIs, module boundaries, or any public interface. Use when creating REST, GraphQL, gRPC endpoints, defining type contracts between modules, or establishing boundaries between frontend and backend.
---

# Universal API & Contract-First Design

## Overview
**Origin**: *Addy Osmani's API & Interface Design Pattern + Universal Contract-First Architecture*.  
Rancang antarmuka (*interface*), kontrak data, dan batas modul (*module boundaries*) yang stabil, terdokumentasi jelas, dan **mustahil disalahgunakan** (*hard to misuse*). Antarmuka yang baik membuat hal yang benar menjadi sangat mudah dilakukan, dan membuat hal yang salah menjadi mustahil dieksekusi.

> **Analogi Sederhana (ELI5):**  
> - **API** itu seperti **pelayan restoran** yang mengantarkan pesanan dari meja pengunjung (aplikasi HP) ke juru masak di dapur (server backend).  
> - **API Contract** adalah **Lembar Formulir Pesanan Baku**:  
>   Formatnya dicetak jelas (Pilihan level pedas 1–5, Tambah telur Ya/Tidak). Pelayan dan koki dapur sepakat 100% pada aturan kertas tersebut **sebelum wajan dinyalakan**. Koki tidak perlu menebak, dan pelayan tidak mungkin salah mengantar makanan.

Prinsip ini berlaku universal untuk endpoint REST, GraphQL, skema gRPC/Protobuf, tipe data IPC, props komponen antarmuka, hingga komunikasi antar-service.

---

## When to Use
- Merancang endpoint API baru (REST, GraphQL, gRPC, WebSocket, atau IPC).
- Menetapkan batas modul (*module boundaries*) atau kontrak kerja sama antara tim Frontend dan Backend.
- Merumuskan skema transfer data (*DTO / Data Transfer Objects*) sebelum menulis kode implementasi.
- Mengubah atau memperluas antarmuka publik yang sudah berjalan di produksi.
- Dipanggil oleh tahapan upstream Pero SDLC:
  - `pero:user-stories` (saat menyusun kontrak data pada `docs/SystemSpec.md`).
  - `pero:system-architecture` (saat menentukan arsitektur API dan integrasi pihak ketiga).
  - `pero:granular-refinement` (saat menetapkan signature fungsi dan payload request/response).

---

## Core Engineering Principles

### 1. Hukum Hyrum (*Hyrum's Law*)
> *"Jika pengguna suatu sistem sudah cukup banyak, semua perilaku sistem yang bisa diamati—disengaja maupun tidak—akan dijadikan sandaran oleh pengguna, terlepas dari apa yang Anda tulis di atas kertas kontrak."*

**Analogi:** Jika ada celah kecil di pagar toko yang tidak sengaja terbuka dan pelanggan terbiasa mengintip dari sana, pelanggan akan marah jika celah itu mendadak ditutup, meskipun pemilik toko tidak pernah berniat menjadikannya etalase resmi.

**Implikasi Desain:**
- **Berhati-hatilah dengan apa yang Anda ekspos**: Setiap detail (teks pesan error, urutan data, waktu respon) adalah komitmen permanen.
- **Jangan bocorkan rahasia implementasi internal (*Don't leak internals*)**: Jangan mengekspos nama tabel database atau stack trace sistem ke respon publik.
- **Rancang masa pensiun sejak awal (*Plan for deprecation*)**: Berikan tanda peringatan jauh-jauh hari sebelum suatu atribut dihapus.

### 2. Aturan Satu Versi (*The One-Version Rule*)
Hindari memaksa konsumen memilih di antara banyak versi berbeda untuk pustaka atau API yang sama (*Diamond Dependency Problem*). Selalu utamakan memperluas kontrak lama secara aman (*backward compatible extension*) daripada membuat cabang versi baru yang membelah sistem.

### 3. Kontrak Didahulukan (*Contract-First*)
Definisikan bentuk antarmuka dan tipe data **sebelum** koding logika dimulai. Kontrak adalah spesifikasi hukum, koding implementasi hanya mengikuti.

```typescript
// Tentukan kontrak tipe terlebih dahulu
interface TaskAPI {
  // Membuat tugas baru dan mengembalikan objek utuh dengan ID dari server
  createTask(input: CreateTaskInput): Promise<Task>;

  // Mengambil daftar tugas berhalaman (paginated) sesuai filter
  listTasks(params: ListTasksParams): Promise<PaginatedResult<Task>>;

  // Mengambil detail 1 tugas atau melempar NotFoundError jika tidak ada
  getTask(id: string): Promise<Task>;

  // Pembaruan parsial — hanya field yang dikirim yang diperbarui
  updateTask(id: string, input: UpdateTaskInput): Promise<Task>;

  // Penghapusan idempotent — tetap sukses meski data sudah terhapus sebelumnya
  deleteTask(id: string): Promise<void>;
}
```

### 4. Format Amplop Respon Seragam (*Consistent Error & Response Semantics*)
Gunakan satu strategi pembungkus (*envelope*) seragam di seluruh endpoint:

```typescript
// Respon Sukses (Standard Success Envelope)
interface SuccessResponse<T> {
  status: "success";
  data: T;
  meta?: {
    page?: number;
    pageSize?: number;
    totalItems?: number;
    timestamp: string;
  };
}

// Respon Gagal (Standard Error Envelope - RFC 9457 Aligned)
interface ErrorResponse {
  status: "error";
  error: {
    code: string;        // Kode mesin terstandarisasi: misal "VALIDATION_ERROR"
    message: string;     // Pesan ramah manusia: "Format email tidak valid"
    details?: unknown;   // Rincian teknis/daftar kolom yang bermasalah
  };
}
```

#### Pemetaan HTTP Status Code Baku:
* `200 OK` : Permintaan berhasil dan mengembalikan data.
* `201 Created` : Berhasil membuat sumber daya baru.
* `204 No Content` : Berhasil dieksekusi tanpa isi respon (misal: `DELETE`).
* `400 Bad Request` : Format sintaksis request tidak valid.
* `401 Unauthorized` : Belum login / token otentikasi tidak ada.
* `403 Forbidden` : Sudah login tapi tidak memiliki hak akses (*authorization*).
* `404 Not Found` : Data/resource yang dicari tidak ditemukan.
* `409 Conflict` : Konflik data (duplikasi entitas, versi dokumen bentrok).
* `422 Unprocessable Entity` : Sintaks benar tapi validasi data gagal (email salah format, nilai minus).
* `500 Internal Server Error` : Kerusakan fatal internal server (dilarang membocorkan rahasia sistem).

> **DILARANG MENCAMPURADUKKAN POLA:** Jangan pernah membuat sebagian endpoint melempar error string acak, sebagian mengembalikan `null`, dan sebagian mengembalikan JSON error. Konsumen membutuhkan kepastian bentuk respons.

### 5. Saring di Pintu Gerbang (*Validate at Boundaries*)
Percayai kode internal sistem Anda, namun **periksa dengan sangat ketat setiap data yang masuk dari luar gerbang**:

```typescript
// Validasi di pintu gerbang API
app.post('/api/tasks', async (req, res) => {
  const result = CreateTaskSchema.safeParse(req.body);
  if (!result.success) {
    return res.status(422).json({
      status: "error",
      error: {
        code: 'VALIDATION_ERROR',
        message: 'Data tugas tidak valid',
        details: result.error.flatten(),
      },
    });
  }

  // Setelah lolos gerbang, kode internal bisa 100% mempercayai tipe datanya
  const task = await taskService.create(result.data);
  return res.status(201).json({ status: "success", data: task });
});
```

* **Wajib Divalidasi**: Handler route API (input user), data dari pihak ketiga / 3rd-party API (**selalu anggap berbahaya/untrusted**), variabel lingkungan (`.env`).
* **Tidak Perlu Divalidasi Berulang**: Antar fungsi internal yang berbagi kontrak tipe terpercaya, data yang baru diambil langsung dari database internal Anda.

### 6. Utamakan Menambah, Bukan Mengubah (*Prefer Addition Over Modification*)
Perluas antarmuka tanpa merusak aplikasi pengguna versi lama (*Backward Compatibility*):

```typescript
// ✅ BAIK: Menambahkan field baru yang bersifat opsional
interface CreateTaskInput {
  title: string;
  description?: string;
  priority?: 'low' | 'medium' | 'high';  // Ditambahkan belakangan, opsional
  labels?: string[];                     // Ditambahkan belakangan, opsional
}

// ❌ BURUK: Mengubah tipe data atau menghapus field yang sudah aktif
interface CreateTaskInput {
  title: string;
  // description: string;  // Dihapus — merusak aplikasi versi lama
  priority: number;       // Diubah dari string ke number — merusak konsumen
}
```

### 7. Konvensi Penamaan yang Terprediksi (*Predictable Naming*)

| Pola | Konvensi | Contoh Baku |
|---|---|---|
| **REST Endpoint** | Kata benda jamak (*Plural nouns*), tanpa kata kerja | `GET /api/tasks`, `POST /api/tasks` |
| **Sub-Resource** | Relasi hierarkis kata benda jamak | `GET /api/tasks/:id/comments` |
| **Query Parameters** | camelCase | `?sortBy=createdAt&pageSize=20` |
| **Field JSON Payload**| camelCase | `{ createdAt, updatedAt, taskId }` |
| **Field Boolean** | Awalan `is` / `has` / `can` | `isComplete`, `hasAttachments` |
| **Nilai Enum** | UPPER_SNAKE_CASE | `"IN_PROGRESS"`, `"COMPLETED"` |

---

## Aturan Besi Idempotensi (*Honouring an Idempotency Key*)

> **Analogi Idempotensi:**  
> Tombol kasir pembayaran yang cerdas: jika kasir menekan tombol "Bayar Rp 50.000" sebanyak 5 kali berturut-turut karena internet macet, saldo pembeli **tetap hanya terpotong 1 kali**.

1. **Berasal dari Niat Asli (*Intent*), Bukan Usaha Pengiriman (*Attempt*)**:  
   - Kunci idempotensi (`Idempotency-Key` pada HTTP Header) wajib digenerate oleh klien sekali saat aksi dimulai, lalu dipakai ulang pada setiap percobaan *retry*.
2. **Klaim Secara Atomik (*Atomic Claim*)**:  
   - Dilarang melakukan `SELECT` lalu `INSERT` terpisah (menimbulkan celah *race condition*).  
   - Gunakan *Unique Constraint* di database sebagai pengawal utama:
     ```typescript
     try {
       await db.insert({ key: idempotencyKey, state: 'in_progress', requestHash: hash(req.body) });
     } catch (err) {
       if (isUniqueViolation(err)) return replayOrReject(idempotencyKey);
       throw err;
     }
     const result = await processPayment(amount);
     await db.update({ key: idempotencyKey, state: 'succeeded', response: result });
     ```
3. **Kawal Payload Asli (*Guard Payload Hash*)**:  
   - Jika kunci idempotensi yang sama dikirimkan kembali dengan isi request body yang berbeda, server **WAJIB menolak keras dengan error 422**, bukan memutar ulang respon lama.

---

## Pola Desain Antarmuka Tipe Kuat (*Strongly-Typed Patterns*)

### 1. Gunakan Discriminated Unions untuk Variasi Status
```typescript
// Setiap variasi status memiliki payload yang jelas
type TaskState =
  | { type: 'pending' }
  | { type: 'in_progress'; assignee: string; startedAt: Date }
  | { type: 'completed'; completedAt: Date; completedBy: string }
  | { type: 'cancelled'; reason: string; cancelledAt: Date };
```

### 2. Pisahkan Tipe Input dan Tipe Output
```typescript
// Input: apa yang dikirim oleh pemanggil
interface CreateTaskInput {
  title: string;
  description?: string;
}

// Output: apa yang dikembalikan oleh sistem (termasuk field buatan server)
interface Task {
  id: string;
  title: string;
  description: string | null;
  createdAt: Date;
  updatedAt: Date;
  createdBy: string;
}
```

---

## Tabel Sangkalan Salah Kaprah (*Common Rationalizations*)

| Alasan Salah Kaprah Developer | Fakta Teknis Sebenarnya |
|---|---|
| *"Dokumentasi API-nya nanti saja kalau sudah jadi"* | Tipe data dan skema KONTRAK ITU SENDIRI adalah dokumentasinya. Tulis sebelum koding! |
| *"Kita belum butuh pagination (halaman) sekarang"* | Anda akan panik begitu data bertambah menjadi 100+ baris dan sistem mendadak lemot. Siapkan dari hari pertama. |
| *"PATCH itu ribet, pakai PUT saja"* | PUT mewajibkan pengiriman seluruh data utuh. Klien di dunia nyata menginginkan PATCH (hanya mengubah field tertentu). |
| *"API internal tidak butuh kontrak resmi"* | Tim internal Anda tetaplah konsumen. Tanpa kontrak resmi, Frontend dan Backend tidak bisa bekerja paralel. |
| *"Koneksi putus dobel request itu langka"* | Percobaan ulang (*retries*) justru melonjak drastis tepat di saat server sedang lambat / down—di saat resiko duplikasi paling mahal. |

---

## 🚩 Daftar Pantangan (*Red Flags*)
- Endpoint mengembalikan bentuk data yang berbeda-beda tergantung kondisi (misal kadang objek, kadang string, kadang boolean).
- Format respon error berbeda antar endpoint dalam satu proyek.
- Validasi data tercecer sembarangan di dalam logika fungsi internal, bukan di pintu gerbang (*boundary*).
- Menghapus field atau mengubah tipe data pada endpoint aktif tanpa strategi masa pensiun.
- Menggunakan kata kerja di URL REST (misal: `/api/createTask`, `/api/getUsers` — gunakan `POST /api/tasks`, `GET /api/users`).
- Mengonsumsi respon API pihak ketiga tanpa validasi skema dan penyaringan keamanan.

---

## ✅ Checklist Verifikasi Desain Kontrak API

Sebelum menyetujui desain kontrak antarmuka:
- [ ] Setiap endpoint memiliki skema tipe data input dan output yang tegas.
- [ ] Respon error mematuhi format amplop standar seragam (kode error mesin + pesan ramah).
- [ ] Validasi hanya terjadi di batas gerbang masuk sistem (*boundaries*).
- [ ] Seluruh endpoint daftar data (*list*) mendukung *pagination* dan *filtering*.
- [ ] Setiap field baru bersifat opsional dan aditif (*backward compatible*).
- [ ] Penamaan URL dan properti mematuhi konvensi konsisten (kata benda jamak & camelCase).
- [ ] Endpoint yang mengubah status/uang (*state-changing*) mendukung `Idempotency-Key` secara atomik.
- [ ] Dokumen kontrak dikunci di `docs/SystemSpec.md` sebelum pembuatan kode implementasi dimulai.

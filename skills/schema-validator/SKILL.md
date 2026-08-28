---
name: schema-validator
description: Use when designing or validating JSON schemas, API contracts, IPC payloads, or data transfer models for correctness and boundary constraints
---

# Universal Schema Validator (`schema-validator`)

## Overview
**Origin**: *Type-Driven Boundary Parsing ("Parse, don't validate" - Alexis King) + JSON Schema Draft 2020-12 & OpenAPI 3.1 Standard*.  
Skill ini adalah **"Penjaga Pintu Masuk Data Sistem"**. Bertugas menjamin setiap data mentah (*untrusted input*) dari luar—seperti request HTTP, pesan antrean (*message broker*), payload IPC, maupun berkas konfigurasi—dipilah, diuji tipe dan batasannya, serta diubah menjadi tipe data yang aman dan terjamin validitasnya sebelum menyentuh logika bisnis aplikasi.

> **Analogi Sederhana (ELI5):**  
> Bayangkan **Pemeriksaan Bagasi di Bandara**:
> - **Shotgun Validation (Cara Buruk)**: Petugas tiket, pramugari di lorong, dan pilot berkali-kali membuka koper penumpang di setiap sudut pesawat untuk mengecek apakah ada barang terlarang.
> - **Boundary Parsing (Cara Benar)**: Koper langsung dipindai oleh mesin X-ray bersertifikat tepat di pintu masuk (*gate*). Begitu lolos, koper diberi label aman dan seluruh staf di dalam kabin tidak perlu curiga atau mengecek ulang isi koper.

---

## 3 Pilar Protokol Validasi Skema

```
┌─────────────────────────────────────────────────────────────┐
│             3 PILAR BOUNDARY SCHEMA VALIDATION              │
├─────────────────────────────────────────────────────────────┤
│ 1. Cut at the Door  : Validasi di gerbang pertama masuk     │
│ 2. Parse, Not Check : Transformasikan ke Typed Model        │
│ 3. Strict Perimeter : Tolak data liar (no additional props) │
└─────────────────────────────────────────────────────────────┘
```

---

### Pilar 1: Cut at the Door (Pintu Masuk Terisolasi)
1. **Lakukan Parsing di Titik Terluar**:
   - Web Controller / API Route Handler: Lakukan validasi sebelum memanggil Service/Domain layer.
   - CLI / Queue Worker: Lakukan parsing payload sebelum dieksekusi oleh worker logic.
2. **Kondisi Ilegal Dilarang Representatif (*Make Illegal States Unrepresentable*)**:
   - Gunakan *Discriminated Unions* atau *Enums/Literal Types* daripada menggunakan boolean bertumpuk (misal: gunakan `status: 'draft' | 'published' | 'archived'` daripada `isDraft`, `isPublished`, `isArchived`).

---

### Pilar 2: Parse, Don't Validate (Transformasi ke Tipe Pasti)
- Jangan hanya memeriksa kondisi `if (!data.id)` lalu tetap menggunakan `data` mentah yang bertipe `any` atau `dict`.
- Ubah objek mentah menjadi instance model bertipe kuat (*strongly-typed object*) yang menjamin seluruh atributnya valid dan siap dikonsumsi fungsi internal.

---

### Pilar 3: Strict Perimeter (Keamanan Kontrak)
- **Kunci Properti Liar**: Selalu tetapkan `additionalProperties: false` (JSON Schema) atau `.strict()` (Zod) untuk mencegah injeksi field berbahaya yang tidak didefinisikan dalam skema.
- **Batasan Format Ketat**: Sertakan batasan panjang teks (`minLength`, `maxLength`), format khusus (`email`, `uuid`, `iso-date`), dan rentang angka (`minimum`, `maximum`).

---

## Matriks Penerapan Polyglot

| Bahasa / Framework | Library Standar | Pola Implementasi Parsing |
|---|---|---|
| **TypeScript / Node** | `zod` / `valibot` | `const parsed = UserSchema.strict().parse(req.body);` |
| **Python** | `pydantic` (v2) | `user = UserCreateDTO.model_validate(request_dict)` |
| **Go** | `go-playground/validator` | `validate.Struct(reqPayload)` dengan struct tags `binding:"required,email"` |
| **Rust** | `serde` + `validator` | `let payload: UserPayload = serde_json::from_str(&json)?; payload.validate()?;` |
| **Java / Kotlin** | `jakarta.validation` | `@Valid @RequestBody request: CreateUserRequest` |
| **Swift / iOS** | `Codable` + custom decodable | `let decoded = try JSONDecoder().decode(UserPayload.self, from: data)` |
| **REST / OpenAPI** | JSON Schema 2020-12 | `type: [string, "null"]`, `additionalProperties: false`, `unevaluatedProperties: false` |

---

## Contoh Kasus: Pola Buruk vs Pola Baik

### Contoh TypeScript (Zod)

```typescript
// ❌ POLA BURUK (Shotgun Validation & Tipe Lemah)
function handleCreateUser(data: any) {
  if (!data.email || typeof data.email !== 'string') {
    throw new Error('Email invalid');
  }
  // Data tetap 'any', field berbahaya bisa lolos, logika tersebar
  saveUserToDB(data);
}

// ✅ POLA BAIK (Boundary Parsing dengan Zod Strict)
import { z } from 'zod';

export const CreateUserSchema = z.object({
  username: z.string().min(3).max(30).regex(/^[a-zA-Z0-9_]+$/),
  email: z.string().email(),
  role: z.enum(['admin', 'member', 'guest']),
  age: z.number().int().positive().min(18)
}).strict(); // Tolak field liar tambahan

export type CreateUserDTO = z.infer<typeof CreateUserSchema>;

function handleCreateUser(rawInput: unknown) {
  const user: CreateUserDTO = CreateUserSchema.parse(rawInput);
  // Mulai dari titik ini, 'user' 100% aman dan terjamin tipe datanya
  saveUserToDB(user);
}
```

---

## Tabel Anti-Pola (*Anti-Patterns*)

| Pola Terlarang | Mengapa Berbahaya? | Solusi Wajib |
|---|---|---|
| **Shotgun Validation** | Pengecekan `if (x != null)` berulang-ulang di setiap lapisan service. | Parsing sekali di boundary pintu masuk; service hanya menerima DTO matang. |
| **Open Schema Leak** | Membiarkan `additionalProperties: true` sehingga payload disusupi atribut terlarang. | Wajib kunci skema dengan `strict()` atau `additionalProperties: false`. |
| **Primitive Obsession** | Menggunakan tipe data `string` untuk ID, tanggal, atau nomor telepon tanpa validasi format. | Gunakan tipe semantik terarah (misal: UUID, ISO-8601 string, regex pattern). |
| **Inline Schema Duplication** | Menulis ulang skema validasi yang sama di berbagai handler endpoint. | Satukan skema DTO di direktori terpusat (misal: `src/schemas/` atau `models/`). |

---

## Checklist Verifikasi Mandiri (*Self-Validation Gate*)

Sebelum menyelesaikan perancangan atau perubahan skema data, pastikan:
- [ ] Seluruh input mentah melewati parsing di gerbang terluar sebelum masuk ke domain logic.
- [ ] Atribut skema memiliki batasan tipe dan rentang nilai yang eksplisit (panjang teks, batas angka).
- [ ] Properti liar yang tidak terdefinisi otomatis ditolak (`additionalProperties: false` atau `strict()`).
- [ ] State yang tidak valid dibuat tidak mungkin terjadi (*make illegal states unrepresentable*).
- [ ] Tipe statis aplikasi diturunkan langsung dari skema runtime (*type inference* / DTO model).

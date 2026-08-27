# 🚀 Pero Agent Skills (`pero-agent-skills`)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Skills: 23 Universal](https://img.shields.io/badge/Skills-23%20Universal-brightgreen.svg)](#-katalog-lengkap-23-skill)
[![Architecture: Polyglot](https://img.shields.io/badge/Architecture-Polyglot-orange.svg)](#)

> **Ekosistem Standar SDLC & Rekayasa Agen AI Universal (Polyglot) yang Disiplin, Anti-Sycophancy, dan Berbahasa Ramah ("Bahasa Bayi" / ELI5).**

---

## 👶 Penjelasan Sederhana ("Bahasa Bayi" / ELI5)

> Bayangkan **Pero Agent Skills** ini seperti **Kotak Perkakas Robot Ajaib**:
> - Ketika ditaruh di proyek apa pun (Web, Mobile, Backend, AI, Database), asisten AI Anda langsung menjadi **Insinyur Senior yang Super Teratur**:
> - **Tidak Asal Tebak**: Selalu mencari akar masalah dulu sebelum membuat obat.
> - **Anti-Pujian Palsu (*Anti-Sycophancy*)**: Jujur berbasis bukti teknis dan berani mengingatkan jika ada desain yang membahayakan sistem.
> - **Wajib Bukti Nyata (*Evidence Before Assertions*)**: Dilarang bilang "sudah selesai" sebelum ada bukti tes terminal yang 100% lulus.
> - **Bahasa yang Ramah**: Menjelaskan konsep teknis yang rumit dengan perumpamaan sederhana sehari-hari.

---

## ⚡ Instalasi Cepat (1-Line Command)

Pasang seluruh 23 skill dan aturan tata kelola ke proyek Anda cukup dengan **satu baris perintah**:

```bash
curl -fsSL https://raw.githubusercontent.com/okyFaishal/pero-agent-skills/main/install.sh | bash
```

Atau jika ingin mengarahkan ke folder proyek tertentu:

```bash
curl -fsSL https://raw.githubusercontent.com/okyFaishal/pero-agent-skills/main/install.sh | bash -s -- /path/ke/proyek-anda
```

---

## 🗺️ Alur 8 Tahap SDLC Pero Pipeline (`pero:*`)

```
[1. problem-framing] ──> [2. prd-writing] ──> [3. user-stories] ──> [4. system-architecture]
                                                                            │
[8. context-validation] <── [7. granular-refinement] <── [6. task-decomposition] <── [5. quality-governance]
```

1. **`pero:problem-framing`** : Diagnosa akar masalah (5-Whys), persona & non-goals.
2. **`pero:prd-writing`** : Penyusunan PRD formal, matriks prioritas fitur (P0/P1/P2) & NFR.
3. **`pero:user-stories`** : User stories format Gherkin (`Given/When/Then`) & kontrak data.
4. **`pero:system-architecture`** : Perancangan arsitektur, pemilihan tech stack via Context7 & diagram Mermaid.
5. **`pero:quality-governance`** : Standar kualitas, aturan thread-safety universal & gerbang review.
6. **`pero:task-decomposition`** : Pembagian tugas ke 6 domain (Web, Mobile, Backend, DB, Security, Core).
7. **`pero:granular-refinement`** : Penajaman kartu tugas spesifik, method signature & failing tests.
8. **`pero:context-validation`** : Audit konsistensi silang antar dokumen & audit diagram Mermaid.
9. **`pero:workspace-setup`** : Provisioner & health checker meja kerja otomatis.

---

## 📊 Katalog Lengkap 23 Skill Universal

| No | Skill | Kategori | Deskripsi |
|---|---|---|---|
| 1 | `pero-workspace-setup` | Pero SDLC | Pengelola & penyedia meja kerja universal (Local & Remote) |
| 2 | `pero-problem-framing` | Pero SDLC | Diagnosa akar masalah & penegasan batas non-goals |
| 3 | `pero-prd-writing` | Pero SDLC | Pembuatan PRD, skala prioritas fitur MVP & NFR |
| 4 | `pero-user-stories` | Pero SDLC | Cerita pengguna Gherkin & kontrak interface data |
| 5 | `pero-system-architecture` | Pero SDLC | Denah arsitektur sistem, tech stack & diagram Mermaid |
| 6 | `pero-quality-governance` | Pero SDLC | Tata kelola kualitas, batas konkurensi & gerbang review |
| 7 | `pero-task-decomposition` | Pero SDLC | Pemecahan backlog berfase lintas 6 domain |
| 8 | `pero-granular-refinement` | Pero SDLC | Penajaman tugas, signature metode & failing tests |
| 9 | `pero-context-validation` | Pero SDLC | Sensor konsistensi dokumen & audit sintaksis Mermaid |
| 10 | `find-skill` | Tooling | Mesin pencari skill lokal di `.agents/skills/` |
| 11 | `context-7` | Tooling | Integrasi dokumentasi API resmi via Context7 MCP |
| 12 | `web-search` | Tooling | Riset internet terarah untuk pemecahan masalah & fakta |
| 13 | `grilling` | Discipline | Wawancara mendalam pohon keputusan (frontier rounds) & stress-test ide |
| 14 | `test-driven-development` | Discipline | Penegak Hukum Besi TDD (Red-Green-Refactor) polyglot |
| 15 | `systematic-debugging` | Discipline | Investigasi ilmiah dan isolasi akar masalah bug |
| 16 | `verification-before-completion` | Discipline | Bukti nyata eksekusi terminal sebelum klaim selesai |
| 17 | `code-reviewer` | Discipline | Review 2 lapis: Kesesuaian spesifikasi & kualitas kode |
| 18 | `api-contract-design` | Architecture | Perancangan surat perjanjian data antarmuka (Contract-First) |
| 19 | `schema-validator` | Data | Validasi integritas skema JSON, DTO & model data |
| 20 | `decision-recorder` | Governance | Pencatatan riwayat keputusan proyek (`ADR`, `PDR`, `SDR`, `GDR`, `TDR`) |
| 21 | `living-doc-sync` | Docs | Sinkronisasi dokumen hidup dan diagram arsitektur |
| 22 | `git-ops` | Operations | Standar manajemen branch, worktree, dan semantic commit |
| 23 | `env-guard` | Security | Perlindungan kunci rahasia & penyaring perintah berbahaya |

---

## 🛡️ Tiga Pilar Tata Kelola Inti

1. **Skill-First Protocol**: Agent wajib mengecek `.agents/skills/` sebelum mengambil tindakan apa pun.
2. **Anti-Sycophancy & Technical Rigor**: Kebenaran teknis di atas menyenangkan pengguna. Dilarang menggunakan pujian kosong.
3. **Bahasa Sederhana ("Bahasa Bayi" / ELI5)**: Setiap konsep teknis wajib dijelaskan dengan analogi konkret sehari-hari.

---

## 📄 Lisensi
Distributed under the MIT License. Created with ❤️ by **Pero**.

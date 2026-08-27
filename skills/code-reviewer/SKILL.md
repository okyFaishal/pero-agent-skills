---
name: code-reviewer
description: Use when completing tasks, implementing major features, or before merging to verify work meets requirements and quality standards
---

# Universal Two-Stage Code Reviewer

## Overview
**Origin**: *Dual-Gate Code Review Standard*.
Pemeriksaan kode 2 lapis (*two-stage review*) sebelum perubahan digabungkan ke cabang utama:
- **Lapis 1: Kesesuaian Spesifikasi (Spec Compliance)**
- **Lapis 2: Kualitas Kode, Arsitektur & Keamanan (Code Quality & Security)**

## Universal Checklist

### Lapis 1: Spec Compliance
- [ ] Apakah seluruh acceptance criteria pada PRD / Story / Backlog terpenuhi?
- [ ] Apakah ada penambahan kode yang tidak diminta pengguna (YAGNI)?
- [ ] Apakah interface public / schema payload sesuai dengan kontrak yang disepakati?

### Lapis 2: Code Quality, Concurrency & Security
- [ ] **Concurrency & Race Conditions**: Apakah antrean data aman dari tabrakan (thread-safety, async/await lock)?
- [ ] **Resource & Memory Management**: Tidak ada memory leak, connection leak, atau file handle yang tidak ditutup?
- [ ] **Error Handling**: Tidak ada error yang ditelan mentah-mentah (*no empty catch blocks*)?
- [ ] **Security**: Input disanitasi, tidak ada risiko SQL injection / XSS / path traversal, dan tidak ada secret bocor?
- [ ] **Test Coverage**: Memiliki automated test untuk kasus normal, kasus gagal, dan batas ekstrim?

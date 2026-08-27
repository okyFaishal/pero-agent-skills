---
name: decision-recorder
description: Use when making non-trivial architectural, product, or governance decisions that need to be recorded in docs/decisions/
---

# Universal Decision Recorder (ADR / PDR / SDR / GDR / TDR)

## Overview
**Origin**: *Architectural Decision Record (ADR) Standard*.
Mengotomatisasi pencatatan buku harian keputusan penting proyek ke folder `docs/decisions/` dengan format file *immutable timestamped record*.

## Format Penamaan File Universal
```
docs/decisions/[TYPE]-[YYYYMMDDHHmm].md
```
- `PDR`: Product Decision Record
- `SDR`: System Design Record
- `ADR`: Architectural Decision Record (Database, framework, protokol)
- `GDR`: Governance Decision Record (Standar coding, aturan keamanan)
- `TDR`: Task Decision Record (Metodologi pembagian fase tugas)

## Template Standar
```markdown
# [TYPE]-[TIMESTAMP]: [Judul Keputusan]

- **Tanggal**: [YYYY-MM-DD]
- **Status**: Disepakati (Accepted)
- **Pembuat Keputusan**: [Nama / Peran]

## Masalah & Konteks
[Jelaskan masalah dengan analogi sederhana sehari-hari]

## Opsi yang Dipertimbangkan
1. **Opsi A**: [Kelebihan & Kekurangan]
2. **Opsi B**: [Kelebihan & Kekurangan]

## Keputusan Final
Dipilih **[Opsi X]** karena:
- [Alasan 1]
- [Alasan 2]

## Konsekuensi
- **Positif**: [Manfaat yang didapat]
- **Risiko / Trade-off**: [Tantangan yang harus dimitigasi]
```

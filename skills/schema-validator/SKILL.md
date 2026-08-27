---
name: schema-validator
description: Use when designing or validating JSON schemas, API contracts, IPC payloads, or data transfer models for correctness and boundary constraints
---

# Universal Schema Validator

## Overview
**Origin**: *Universal Data Integrity & Validation Pattern*.
Skill untuk memverifikasi integritas struktur data (JSON Schema, OpenAPI, TypeScript Zod, Python Pydantic, Go Struct Tags, Swift Codable, Rust Serde).

## Validation Protocol
1. **Kelengkapan Atribut**: Pastikan seluruh field wajib (*mandatory fields*) ada dan tidak kosong.
2. **Validasi Tipe Data**: Pastikan tipe data sesuai (misal: ID tidak tertukar antara string dan int).
3. **Validasi Batas Nilai**: Uji batasan format (regex email, format ISO-8601 tanggal, rentang angka positif).

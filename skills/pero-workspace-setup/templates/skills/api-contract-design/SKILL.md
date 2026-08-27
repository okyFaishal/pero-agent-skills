---
name: api-contract-design
description: Use when designing API endpoints, IPC messaging protocols, data transfer schemas, or cross-service contracts before implementation
---

# Universal API & Contract-First Design

## Overview
**Origin**: *Contract-First System Design Pattern*.
Panduan merancang surat perjanjian data antarmuka (REST JSON, GraphQL, gRPC Protobuf, WebSocket, atau IPC) secara *Contract-First* sebelum menulis kode di client maupun server.

## Universal Design Protocol
1. **Definisi Tipe Data Konkret**: Nyatakan setiap atribut dengan tipe data tegas (String, Integer, Float, Boolean, Array, Object), status `required` / `optional`, dan batasan validasi.
2. **Pemisahan Envelope Sukses & Gagal**:
   - Sukses: `{ "status": "success", "data": { ... }, "meta": { ... } }`
   - Gagal: `{ "status": "error", "error": { "code": "ERR_CODE", "message": "Penjelasan ramah", "details": [ ... ] } }`
3. **Prinsip Backward Compatibility**: Dilarang menghapus atau mengubah arti field yang sudah berjalan di versi aplikasi sebelumnya.

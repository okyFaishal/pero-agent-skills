---
name: context-7
description: Use when needing official library documentation, modern API patterns, framework release specs, or resolving third-party package APIs via Context7 MCP
---

# Context 7 Documentation Bridge (Universal API Grounding)

## Overview
**Origin**: *MCP Context7 Protocol Integration*.
Jembatan query dokumentasi resmi dan terkini untuk **SEMUA ekosistem pemrograman** (NPM, PyPI, Crates.io, Go Modules, Maven, Pub.dev, CocoaPods, SwiftPM, Nuget). Mencegah halusinasi API versi kuno (*outdated training weights*).

## When to Use
- Menggunakan library/framework versi terbaru (misal: React 19, Tailwind v4, Pydantic v2, FastAPI, Gin, Axum, Flutter 3, SwiftData).
- Memeriksa nama method, tipe return, atau signature parameter yang valid.
- Mengecek fitur yang sudah tidak berlaku (*deprecated*).

## Protocol
1. **Cari ID Library**: Gunakan tool MCP `resolve-library-id` untuk mendapatkan ID package resmi.
2. **Ambil Dokumentasi**: Panggil tool MCP `query-docs` dengan topik spesifik yang ingin dipelajari.
3. **Gunakan Sintaksis Resmi**: Terapkan signature API nyata dari hasil query, bukan dari tebakan ingatan lama.

---
name: web-search
description: Use when verifying external technical facts, researching bug solutions, discovering SDK releases, or retrieving public documentation via search
---

# Web Search & Fact Grounding (Universal Research)

## Overview
**Origin**: *Standard Fact Grounding & Verification Protocol*.
Prosedur riset internet terarah untuk memverifikasi fakta teknis, membedah pesan error langka, dan memeriksa changelog dependensi eksternal di ekosistem teknologi mana pun.

## When to Use
- Menemukan pesan error yang tidak tercantum di dokumentasi lokal proyek.
- Memeriksa isu kompatibilitas antar package atau sistem operasi.
- Memvalidasi praktik arsitektur terkini dari sumber terpercaya.

## Search Workflow
1. **Query Spesifik**: Formulasikan teks pencarian tajam (Pesan error lengkap + Nama package + Versi).
2. **Panggil Tool**: Jalankan `search_web`.
3. **Filter Waktu & Relevansi**: Utamakan artikel/dokumentasi terbaru yang sesuai versi teknologi proyek.
4. **Atribusi Sumber**: Cantumkan URL referensi saat memberikan solusi.

---
name: find-skill
description: Use when starting a new task, uncertain which skill applies, or needing to discover relevant local skills in .agents/skills/
---

# Find Skill (Universal Discovery Engine)

## Overview
**Origin**: *Standard Agent Skills Discovery Protocol*.
Mesin pencari dan pemeta skill lokal di `.agents/skills/`. Ibarat **pemandu perpustakaan pintar** yang mencarikan buku petunjuk paling tepat untuk bahasa/framework apa pun sebelum kita mulai bekerja.

## When to Use
- Menerima tugas baru dari pengguna di proyek apa pun.
- Memastikan apakah ada standar lokal yang mengatur alur kerja tersebut.
- Sebelum memecah tugas kompleks menjadi sub-task.

## Discovery Procedure
1. Baca seluruh file `SKILL.md` di `.agents/skills/*/SKILL.md`.
2. Ekstrak bagian `description` dari frontmatter YAML masing-masing skill.
3. Cocokkan kata kunci tugas (gejala error, arsitektur, kebutuhan tes) dengan kondisi pemicu (*trigger conditions*).
4. Aktifkan skill yang cocok dengan membaca isinya secara menyeluruh sebelum bertindak.

## Common Mistakes
- **Menebak alur kerja tanpa membaca SKILL.md**: Selalu baca panduan skill secara lengkap.

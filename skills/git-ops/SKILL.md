---
name: git-ops
description: Use when creating git branches, managing git worktrees, crafting semantic commits, or preparing PRs
---

# Universal Git Operations & Repository Hygiene

## Overview
**Origin**: *Conventional Commits & Git Flow Best Practices*.
Panduan manajemen kontrol versi (Git), isolasi branch/worktree, dan konvensi commit semantik universal.

## Format Semantic Commit
```
<type>(<scope>): <short imperative description>
```
- `feat`: Penambahan fungsionalitas baru
- `fix`: Perbaikan bug atau error
- `refactor`: Perapian kode tanpa mengubah perilaku fungsional
- `test`: Penambahan atau pembaruan automated test
- `docs`: Pembaruan dokumentasi atau spesifikasi
- `chore`: Tugas pemeliharaan build, dependency, atau tooling

## Aturan Keamanan
- Dilarang force push (`git push -f`) pada branch utama (`main`/`master`).
- Pastikan working tree bersih dari file sementara sebelum menyimpan commit.

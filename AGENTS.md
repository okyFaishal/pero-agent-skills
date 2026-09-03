# Agent Workspace Rules

## 1. Skill-First Protocol (Mandatory Priority)
- **Check Skills First**: Sebelum mengeksekusi tugas apa pun (analisis, perencanaan, koding, pengujian, debugging, atau riset), Agent WAJIB memeriksa direktori `.agents/skills/` untuk menemukan skill yang relevan.
- **Strict Compliance**: Jika skill yang sesuai tersedia, Agent WAJIB membaca `SKILL.md` skill tersebut dan mematuhi instruksinya secara ketat.
- **No Unguided Heuristics**: JANGAN mengandalkan asumsi default atau kebiasaan bawaan umum ketika terdapat skill lokal yang sudah dirancang khusus untuk domain tersebut.

## 2. Anti-Sycophancy & Technical Rigor (Kebenaran Teknis > Menyenangkan Pengguna)
- **Zero Performative Flattery**: DILARANG menggunakan pujian kosong seperti *"Ide yang luar biasa!"*, *"Anda 100% benar!"*, *"Terima kasih atas sarannya yang sangat hebat!"*. Langsung fokus ke fakta dan aksi nyata.
- **Wajib Pushback Bila Berisiko**: Jika pengguna atau pihak lain menyarankan solusi yang merusak arsitektur, memicu bug regresi, melanggar prinsip YAGNI, atau melanggar keamanan, Agent **WAJIB membantah secara sopan berbasis bukti teknis** dan memberikan solusi alternatif yang aman.
- **Verify Before Complying**: Jangan menyetujui perintah tanpa mengecek fakta di kode/dokumen terlebih dahulu.
- **Factual Correction Without Drama**: Jika Agent salah, akui secara singkat dan faktual (*"Terverifikasi, kode saya salah di baris X karena Y. Memperbaiki sekarang."*) tanpa permohonan maaf berlebihan.

## 3. Communication Standard: Penjelasan dengan Bahasa Sederhana (ELI5)
- **Jelaskan Seperti ke Orang Awam**: Setiap kali menjelaskan istilah teknis, error, alur kerja, atau arsitektur kepada pengguna, Agent WAJIB menggunakan bahasa yang sangat sederhana (Explain Like I'm 5 / ELI5) seolah menjelaskan ke seseorang yang belum pernah belajar teknologi.
- **Penyampaian Mengalir & Alami (Tanpa Label Kaku)**: Sampaikan penjelasan secara bertingkat dan mengalir alami tanpa menggunakan label heading kaku (*"Lapis 1/2/3"*). Awali dengan perumpamaan konkret sehari-hari, jelaskan alur logika dengan bahasa manusia, dan sertakan rincian teknis secara mulus.
- **Dilarang Menimbun Jargon**: Jika terpaksa menyebut kata teknis (misal: *concurrency, payload, cache, schema*), sertakan langsung artinya dalam satu kalimat sederhana.
- **Sederhana Namun Akurat**: Penjelasan yang mudah dipahami TIDAK BOLEH mengurangi standar kualitas kode; kode tetap harus berstandar senior engineer, namun cara komunikasinya wajib ramah dan jelas.

## 4. Core Engineering Discipline
- **Test-Driven Development**: Terapkan TDD (`test-driven-development`). Selalu tulis failing test sebelum menulis kode implementasi.
- **Systematic Debugging**: Dilarang melakukan trial-and-error saat debugging. Gunakan `systematic-debugging` untuk menemukan root cause terlebih dahulu.
- **Evidence Before Assertions**: Dilarang mengklaim pekerjaan selesai tanpa bukti eksekusi nyata dari terminal (`verification-before-completion`).
- **Environment & Safety**: Patuhi `env-guard`. Dilarang mengekspos credential/secrets dan dilarang menjalankan perintah destruktif tanpa konfirmasi.
- **Grounding & Validation**: Validasi dokumentasi teknis via `context-7` atau `web-search`. Gunakan `grilling` saat menghadapi trade-off atau kebutuhan yang ambigu.
- **Anti-Slop Protocol**: Patuhi `anti-slop`. Dilarang menghasilkan kode over-engineered (YAGNI), komentar sepele yang menjelaskan apa yang dilakukan kode, atau kode tiruan/mock palsu.

## 5. Local Workspace Skills Directory (Complete Pero SDLC & Engineering Suite)

### A. Pero Custom SDLC Pipeline Suite (`pero:*`)
1. `pero-problem-framing/` : Diagnosa akar masalah, persona, batasan non-goals & metrik ➔ `docs/ProblemFraming.md` & `PFDR-[YYYYMMDDHHmm].md` (Adaptive Squad + Grilling R1/R2 Pause Gate).
2. `pero-prd-writing/` : Penyusunan PRD formal, prioritas fitur MVP (P0/P1/P2) & NFR ➔ `docs/PRD.md` & `PDR-[YYYYMMDDHHmm].md` (3-Track Squad + Scope Grilling Pause Gate).
3. `pero-user-stories/` : Translasi PRD ke Gherkin stories, domain ERD, RBAC & API contracts ➔ `docs/SystemSpec.md` & `SDR-[YYYYMMDDHHmm].md` (Fixed 5-Specialist Squad + Contract Grilling Pause Gate).
4. `pero-system-architecture/` : Perancangan arsitektur C4, tech stack, MCP & konkurensi ➔ `docs/Architecture.md` & `ADR-[YYYYMMDDHHmm].md` (Fixed 5-Specialist Squad + Architecture Grilling Pause Gate).
5. `pero-quality-governance/` : Standar thread-safety, linter matrix, supply chain & review gates ➔ `docs/Governance.md` & `GDR-[YYYYMMDDHHmm].md` (Fixed 5-Specialist Squad + Governance Grilling Pause Gate).
6. `pero-task-decomposition/` : Pemecahan spesifikasi ke backlog 5 fase & 6 domain tugas S/M ➔ `docs/TaskBacklog.md` & `TDR-[YYYYMMDDHHmm].md` (Fixed 5-Specialist Squad + Backlog Grilling Pause Gate).
7. `pero-granular-refinement/` : Penajaman kartu tugas presisi (7 anatomi, invarian, blast radius, failing test) ➔ `docs/tasks/TASK-[ID].md` & `RDR-[YYYYMMDDHHmm].md` (Fixed 5-Specialist Squad + Task Grilling Pause Gate).
8. `pero-context-validation/` : Validasi ketertelusuran 7-arah, 3 severity tiers & audit Mermaid ➔ `docs/ValidationReport.md` & `VDR-[YYYYMMDDHHmm].md` (Fixed 5-Specialist Squad + Go/No-Go Decision Gate).

### B. Standard Engineering & Tooling Skills
9. `find-skill/` : Mesin pencari skill lokal yang relevan dengan tugas & stack auto-detection.
10. `context-7/` : Akses dokumentasi resmi API via Context7 MCP.
11. `web-search/` : Riset web terarah dan verifikasi rilis paket eksternal (min 2, max 5 search).
12. `grilling/` : Wawancara mendalam pohon keputusan (frontier rounds) & stress-test ide/desain (min 5, max 10 tanya bertahap).
13. `test-driven-development/` : Penegak siklus Red-Green-Refactor sebelum koding implementasi.
14. `systematic-debugging/` : Investigasi ilmiah dan isolasi akar masalah bug (4-phase scientific debugging).
15. `verification-before-completion/` : Bukti verifikasi nyata terminal (exit code 0, 0 failure) sebelum menyatakan selesai.
16. `code-reviewer/` : Review 2-lapis: Kesesuaian spesifikasi & kualitas kode/keamanan/concurrency.
17. `api-contract-design/` : Perancangan kontrak data, endpoint & envelope API.
18. `schema-validator/` : Validasi JSON schema, DTO dan model serialisasi.
19. `decision-recorder/` : Pencatatan riwayat keputusan teknis 8 tipe (`PFDR`, `PDR`, `SDR`, `ADR`, `GDR`, `TDR`, `RDR`, `VDR`) di `docs/decisions/`.
20. `living-doc-sync/` : Sinkronisasi 8 dokumen inti `docs/` & rekam keputusan saat kode berubah (*Octa-Doc Ecosystem Sync*).
21. `git-ops/` : Operasional Git & GitHub, commit Caveman, template .github, dan gh CLI.
22. `env-guard/` : Proteksi file rahasia, sensor kredensial otomatis, dan pencegahan perintah terminal berbahaya.
23. `eli5/` : Simplifikasi konsep teknis & jargon ke penjelasan ramah awam beranalogi alami tanpa label kaku (`eli5`).
24. `anti-slop/` : Eliminasi boilerplate berlebih (YAGNI), komentar sampah, basa-basi AI, dan mock palsu (`anti-slop`).
25. `llm-council/` : Musyawarah 5 sudut pandang AI, peer-review anonim & sintesis dewan untuk keputusan berisiko tinggi (`llm-council`).
26. `dispatching-parallel-agents/` : Pendelegasian tugas mandiri, squad spesialis SDLC, & mass debugging ke sub-agen paralel tanpa shared state (`dispatching-parallel-agents`).
27. `subagent-driven-development/` : Eksekusi backlog otonom berkelanjutan via sub-agen segar & task review gate berlandaskan gerbang validasi Go (`subagent-driven-development`).
28. `taste-skill/` : Standar estetika visual anti-slop, inferensi brief, 3 dials (Variance, Motion, Density), dan typography untuk frontend (`taste-skill`).

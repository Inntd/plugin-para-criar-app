---
description: Regenerar o MAPA.md (índice de navegação do projeto)
allowed-tools: Read, Edit, Write, Bash(ls:*), Bash(rg:*), Bash(find:*)
---
Atualize @MAPA.md varrendo o repositório:
1. Liste as **specs** (`docs/specs/*.md`) com id + 1 linha.
2. Liste as **skills** (`.claude/skills/*/SKILL.md`) com nome + 1 linha (da description).
3. Liste os **subagentes** (`.claude/agents/*.md`) e os **comandos** (`.claude/commands/*.md`).
4. Liste os **módulos de código** principais (pastas em src/app/lib, se existirem) com 1 linha cada.
5. Aponte os arquivos-chave: TASKS.md, PROGRESS.md, REGRAS-DE-NEGOCIO.md, docs/dados/modelo-de-dados.md, docs/decisoes/.
Mantenha curto (é um índice, não documentação). Atualize a data no topo com `date '+%Y-%m-%d'`.

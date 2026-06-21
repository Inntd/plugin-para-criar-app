---
description: Criar uma skill do projeto usando a skill de criação de skills (skill-creator)
argument-hint: <para que serve a skill>
allowed-tools: Read, Write, Edit, Bash
---
Quero criar uma skill: "$ARGUMENTS"

Faça:
1. **Se a skill `skill-creator` estiver disponível, USE-A** para conduzir o processo (capturar intenção → rascunho → testar → iterar). Caso não esteja, siga o formato abaixo.
2. Capture a intenção: o que a skill deve permitir, **quando deve disparar** (frases/contextos), e o formato de saída esperado.
3. Crie `.claude/skills/<nome-kebab>/SKILL.md` com frontmatter:
   - `name`: identificador.
   - `description`: o que faz **e quando usar** — escreva de forma "puxada" para disparar bem (ex.: "Use sempre que ... mesmo que o usuário não diga explicitamente ..."). Toda informação de "quando usar" vai aqui.
4. Corpo da SKILL.md em **progressive disclosure**: instruções enxutas (< 500 linhas); recursos extras em `scripts/`, `references/`, `assets/` referenciados quando necessário.
5. Quando uma regra de negócio descrever um fluxo repetível (validação, cálculo, geração padronizada), proponha transformá-lo em skill e ligue a skill às regras (RN-00x) que ela implementa.
6. Atualize @MAPA.md (seção Skills) e confirme o caminho criado.
7. Se a skill padronizar um procedimento técnico, **proponha** a regra correspondente em `docs/REGRAS-DE-CODIGO.md` (seção "Regras do projeto"), ligada à skill.

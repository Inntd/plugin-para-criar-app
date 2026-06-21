---
name: reconciliar
description: Reconciliar o template após mudanças (specs/skills/subagentes criados na mão) — atualiza o MAPA e aponta inconsistências
argument-hint: [o que mudou, opcional]
allowed-tools: Read, Edit, Write, Bash(ls:*), Bash(rg:*), Bash(find:*), Glob
---
O que mudou (se informado): "$ARGUMENTS" (se vazio, faça uma varredura completa).

Objetivo: deixar o template **coerente** depois que peças foram adicionadas/alteradas (inclusive criadas manualmente).

Faça:
1. **Varra** o repositório:
   - Specs: `ls docs/specs/*.md`
   - Skills: `ls .claude/skills/*/SKILL.md`
   - Subagentes: `ls .claude/agents/*.md`
   - Comandos: `ls .claude/commands/*.md`
2. **Valide** cada peça nova/alterada:
   - Skills e subagentes têm frontmatter com `name` e `description`? Subagente está em **`.claude/agents/`** (e não `agentes`)? Comando começa com `---`?
   - Skill: a `description` diz **o que faz e quando usar** (bem "puxada")?
3. **Religue à cadeia:**
   - Specs listam as regras (RN-00x) que as sustentam? Se não, aponte.
   - Skills/specs que padronizam algo técnico têm regra de código (RC-00x) correspondente em `docs/REGRAS-DE-CODIGO.md`? Se faltar, proponha.
4. **Atualize @MAPA.md** (Specs, Skills, Subagentes, Comandos, Módulos) refletindo o estado real.
5. **Relate** em lista curta: o que foi reconciliado + o que precisa da sua decisão (inconsistências, nomes duplicados, peça órfã, frontmatter faltando).

Não implemente código — só reconcilie estrutura, referências e mapa.

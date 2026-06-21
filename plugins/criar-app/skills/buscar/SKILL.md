---
name: buscar
description: Busca facilitada no projeto (regras, specs, dados, código, decisões)
argument-hint: <termo ou pergunta>
allowed-tools: Read, Grep, Glob, Bash(rg:*), Bash(ls:*)
---
Busca: "$ARGUMENTS"

Faça:
1. Comece por @MAPA.md para saber onde as coisas vivem.
2. Procure com ripgrep nos lugares certos, por exemplo:
   - Regras: `rg -n "$ARGUMENTS" REGRAS-DE-NEGOCIO.md`
   - Specs/docs: `rg -n "$ARGUMENTS" docs/`
   - Código: `rg -n "$ARGUMENTS" src/ app/ lib/ 2>/dev/null`
3. Se a resposta exigir **ler vários arquivos** ou o projeto estiver grande, **delegue ao subagente `explorador`** (ele lê no contexto dele e devolve só o resumo) — isso mantém este contexto limpo.
4. Responda CURTO: o que achou + **onde está (arquivo:linha)**. Não cole arquivos inteiros.

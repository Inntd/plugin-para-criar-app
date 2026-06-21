---
name: provar
description: Provar que uma spec foi cumprida — prova item a item (implementado + testado) com nota, via subagente avaliador
argument-hint: <id ou tema da spec>
allowed-tools: Read, Grep, Glob, Bash
---
Spec a provar: "$ARGUMENTS"

Faça:
1. Localize a spec em `docs/specs/` (por id ou tema).
2. **Delegue ao subagente `avaliador`** para gerar a prova item a item (ele lê no contexto dele e devolve o resumo — economiza contexto).
3. Apresente: a **nota** (60% implementação + 40% testes), os critérios que **passaram** e os que **faltam** (com `arquivo:linha`), e o que fazer para fechar.

Princípio (do benchmark): cada critério de aceite só conta se houver um **teste que o prove**. "Parece funcionar" não é prova.

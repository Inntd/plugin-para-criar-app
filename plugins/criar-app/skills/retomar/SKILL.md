---
name: retomar
description: Analisar o que já foi feito e decidir continuar daqui ou começar do zero
allowed-tools: Read, Bash(git:*)
---
Antes de qualquer coisa, faça um **briefing de retomada**:
1. Leia @TASKS.md (Norte + "Retomar aqui") e as últimas entradas de @PROGRESS.md.
2. Rode `git status`, `git log --oneline -10` e `git diff --stat` (ver trabalho não commitado).
3. Apresente um resumo CURTO:
   - **O que já foi feito** (pontos principais).
   - **Estado atual** (marco, o que está em andamento, o que está quebrado se houver).
   - **Próximo passo sugerido** (1 ação concreta).
4. Pergunte: **"Continuar daqui ou começar do zero?"** e **espere minha resposta** antes de codar.
   - Se eu escolher *começar do zero*, proponha um plano limpo e o que fazer com o código atual (manter em branch, arquivar) — **não apague nada sem eu confirmar**.

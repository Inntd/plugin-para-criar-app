---
description: Dividir um objetivo grande em marcos e tarefas pequenas com prioridade, e gravar no TASKS.md
argument-hint: <objetivo grande>
allowed-tools: Read, Edit, Write, Bash(date:*)
---
Objetivo a dividir: "$ARGUMENTS"

Aplique **dividir para conquistar** e **grave o resultado no TASKS.md** (não implemente nada agora):
1. Confirme o objetivo final em 1 linha (ligue à dor em PROBLEMA.md, se aplicável).
2. Quebre em **marcos** (entregas grandes, na ordem que faz sentido).
3. Para o **primeiro marco** (ou o que eu indicar), liste **tarefas pequenas e objetivas** — cada uma com:
   - **prioridade**: 🔴 essencial · 🟡 importante · ⚪ pode esperar
   - **critério de sucesso** verificável (o "verify": um teste/checagem).
4. Se algo estiver ambíguo demais para quebrar, pare e me pergunte (ou use o subagente `debatedor`) — no máximo 3 tentativas.
5. Escreva no TASKS.md: atualize "🗺️ Marcos" e o "✅ Checklist do marco atual" (com prioridade + critério), e ajuste o "▶️ Retomar aqui" apontando a 1ª tarefa essencial. Use `date '+%Y-%m-%d'` se datar algo.
6. Confirme em poucas linhas: marcos criados + a 1ª tarefa a atacar.

Lembre: tarefa só está pronta para começar quando está **pequena** e com **critério de sucesso claro** (Execução orientada a metas).

---
name: regras
description: Revisar e sugerir regras de negócio que faltam para o contexto atual
argument-hint: [tela ou módulo (opcional)]
allowed-tools: Read, Bash(git:*)
---
Vamos fortalecer as regras de negócio. Foco opcional indicado pelo usuário: "$ARGUMENTS" (se vazio, considere o app todo).

Faça:
1. Leia @REGRAS-DE-NEGOCIO.md, @TASKS.md e veja o que está em andamento (`git status`, `git diff --stat`).
2. Liste **lacunas**: situações do app cujo comportamento ainda NÃO está definido por uma regra — casos de borda, validações, permissões, limites, o que acontece em erro/estado vazio/concorrência.
3. **Sugira de 3 a 7 regras candidatas**, curtas e testáveis; para cada uma, faça **uma pergunta objetiva** para eu confirmar ou ajustar.
4. As que eu confirmar, registre em REGRAS-DE-NEGOCIO.md (mesmo formato do /regra). As demais, registre como itens em "❓ Perguntas em aberto".

Não implemente nada ainda — o objetivo é definir o norte.

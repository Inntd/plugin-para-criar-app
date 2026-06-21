---
description: Criar um novo subagente em .claude/agents/ com frontmatter válido
argument-hint: <para que serve o subagente>
allowed-tools: Read, Write, Edit, Bash(ls:*)
---
Quero um novo subagente: "$ARGUMENTS"

Faça:
1. Capture: **o que** ele faz, **quando** deve ser acionado (isso vira a `description`), **quais ferramentas** precisa, e **qual modelo** (use `haiku` para busca/tarefas rápidas e baratas; `inherit` para raciocínio/implementação).
2. Crie **`.claude/agents/<nome-kebab>.md`** (a pasta é `agents`, em inglês — não `agentes`) com frontmatter:
   - `name`, `description`, `tools` (lista separada por vírgula; omitir herda todas), `model`.
   - Escreva a `description` orientada a gatilho ("Use PROATIVAMENTE quando..." / "MUST BE USED para...") para a delegação disparar bem.
3. Corpo = prompt de sistema: papel, o que fazer ao ser acionado (passos), formato de saída e restrições (ex.: read-only, ser breve).
4. Atualize @MAPA.md (seção Subagentes) e confirme o caminho criado.

Dica: se for um subagente de busca/leitura, espelhe o `explorador` (read-only, devolve resumo). Se for de verificação, espelhe o `revisor`.

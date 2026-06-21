---
description: Criar/atualizar a spec de uma funcionalidade a partir das regras — com casos de borda obrigatórios e cada critério mapeado a um teste
argument-hint: <funcionalidade>
allowed-tools: Read, Edit, Write, Bash(date:*), Bash(ls:*)
---
Funcionalidade: "$ARGUMENTS"

Faça (NÃO pule etapas — vale para qualquer tamanho de projeto):
1. Leia @REGRAS-DE-NEGOCIO.md e selecione as regras `ativa`s aplicáveis.
2. **Levante o implícito (obrigatório):** antes de escrever, pergunte sobre o que não está claro — erros, **casos de borda**, restrições, concorrência, permissões, limites. Não assuma; **quantifique** (ex.: "limite de N", não "muitos").
3. Crie/atualize a spec a partir de `docs/specs/_TEMPLATE-spec.md` (próximo SPEC-00N). Use `date '+%Y-%m-%d'`.
4. **Casos de borda e erros: preencha obrigatoriamente** (estado vazio, inválido, falha externa, concorrência, limites, permissão). Nada em branco.
5. **Critérios de aceite → testes:** preencha a **tabela** mapeando **cada critério a UM teste** (com tipo: unitário/integração/e2e). **Nenhum critério sem teste** — esse mapeamento é o que obriga a implementação e a prova depois.
6. **Fora de escopo:** liste explicitamente o que NÃO fazer.
7. Se a spec revelar um padrão técnico recorrente, proponha uma regra em `docs/REGRAS-DE-CODIGO.md` (seção "Regras do projeto").
8. Atualize @MAPA.md (seção Specs) e confirme em 1 linha.

Não implemente código agora — só a spec. Ao implementar e concluir, **prove** com **/provar**.

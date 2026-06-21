---
description: Mostra todos os comandos do projeto com categorias, exemplos e quando usar cada um
---
Exiba exatamente o texto abaixo, formatado em markdown, sem adicionar nem remover nada:

---

Comandos são atalhos que você digita no Claude Code (arquivos em `.claude/commands/`). Cada um faz uma coisa e diz quando usar.

## Construção automática

**`/construir [foco]`**
Lê `PROBLEMA.md`, `REGRAS-DE-NEGOCIO.md`, `STACK.md` e `TASKS.md` já preenchidos e constrói o app automaticamente: gera specs, implementa, cria testes, aciona o revisor e commita. Apresenta o plano antes de codar e pede confirmação.
_quando_ o contexto está preenchido e você quer construir sem rodar cada comando manualmente
_ex._ `/construir módulo de autenticação`

---

## Descoberta & planejamento

**`/problema [contexto]`**
Entende e refina a dor que o app resolve; registra em PROBLEMA.md.
_quando_ no início e ao aprender algo novo
_ex._ `/problema vendedores perdem venda no checkout`

**`/dividir <objetivo>`**
Quebra um objetivo grande em marcos e tarefas pequenas com prioridade e critério de sucesso.
_quando_ antes de construir algo grande
_ex._ `/dividir MVP do checkout de uma página`

**`/retomar`**
Briefing do que foi feito, estado atual e próximo passo; pergunta "continuar ou começar do zero?".
_quando_ ao abrir/retomar uma sessão

---

## Regras & specs

**`/regra <texto>`**
Registra uma regra de negócio e propaga pela cadeia (propõe specs, skills, regras de código e âncoras).
_quando_ sempre que uma regra surgir
_ex._ `/regra frete grátis acima de R$200 no Sudeste`

**`/regras [foco]`**
O agente aponta lacunas e sugere regras candidatas, com uma pergunta objetiva por regra.
_quando_ pra fortalecer o norte de uma área

**`/spec <funcionalidade>`**
Cria/atualiza a spec a partir das regras, listando as RN que a sustentam. Casos de borda obrigatórios + cada critério vira um teste.
_quando_ as regras de uma funcionalidade amadurecem
_ex._ `/spec cálculo do total do pedido`

**`/provar <spec>`**
Prova que a spec foi cumprida: cada critério implementado e testado (arquivo:linha), com nota.
_quando_ ao concluir, antes de dar por pronta
_ex._ `/provar SPEC-003`

---

## Criação

**`/skill <p/ quê>`**
Cria uma skill do projeto (usa a skill-creator quando disponível) e atualiza o MAPA.
_quando_ um fluxo repetível merece virar skill

**`/adicionar-subagente <p/ quê>`**
Cria um subagente em `.claude/agents/` com frontmatter válido (gatilho, ferramentas, modelo).
_quando_ precisa de um especialista novo

---

## Coerência & navegação

**`/buscar <termo>`**
Busca facilitada no repo; delega ao subagente explorador quando é fundo, pra poupar contexto.
_quando_ "onde está X?" em projeto grande

**`/mapa`**
Regenera o MAPA.md — o índice de navegação do projeto.
_quando_ depois de criar ou mover coisas

**`/reconciliar [o que mudou]`**
Após mudanças (até manuais), atualiza o MAPA, valida frontmatter e aponta inconsistências.
_quando_ depois de editar `.claude/` na mão

**`/custo`**
Custo/uso de tokens da sessão e onde se gasta mais — usa o `/usage` nativo + ccusage.
_quando_ para acompanhar gasto e achar pontos caros

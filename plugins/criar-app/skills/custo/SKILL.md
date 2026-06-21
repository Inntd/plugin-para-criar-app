---
name: custo
description: Ver custo/uso de tokens da sessão e onde se gasta mais (usa /usage nativo + ccusage)
allowed-tools: Bash(npx:*), Bash(ccusage:*)
---
Quero entender custo e uso de tokens.

Faça:
1. Lembre que o comando **nativo** `/usage` (aliases `/cost`, `/stats`) mostra o uso da **sessão atual** — em **dólar** para quem acessa via **API**, e em **tokens** (relativo ao limite do plano) para **Pro/Max**. Sugira rodá-lo.
2. Para **histórico** e "onde gasta mais", rode o **ccusage** (lê os logs locais do Claude Code, que existem em qualquer plano):
   - Por sessão: `npx ccusage@latest session`
   - Por dia: `npx ccusage@latest daily`
   - Quebra por modelo: acrescente `--breakdown`
3. Resuma: total e os **pontos de maior gasto** (modelo / sessão / dia) + 1-2 ideias de eficiência (ex.: Haiku em tarefas simples via `/model`; evitar reler arquivos grandes; `/btw` para perguntas laterais; `.claudeignore` para excluir `node_modules`).

Observações honestas:
- Valores em dólar são **estimativa local** (tokens × tabela de preços) — para cobrança oficial, use o **Console da Anthropic**.
- `npx ccusage` precisa de **npm/internet**; é ferramenta da comunidade, não oficial.
- Em **Pro/Max** não há cobrança por token — o "custo" é referência de **uso vs. limite do plano**, não fatura.

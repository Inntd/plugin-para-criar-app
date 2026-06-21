# REGRAS DE NEGÓCIO — <nome do projeto>

> Registro **vivo** das regras de negócio do app — o **norte de comportamento** do Claude Code: ele trata estas regras como **autoridade** ao implementar. Adicione uma regra quando quiser com **/regra** (ou edite à mão). O agente também **pergunta e sugere** regras quando faltam (ver rotina no CLAUDE.md) e usa **/regras** para revisar lacunas.

## Como ler
- Cada regra tem um **ID** (RN-001…) e um **Status**: `ativa`, `proposta` (a confirmar) ou `revogada`.
- Regra revogada **não** é apagada — vira `revogada` (mantém o histórico).

<!-- FORMATO de cada regra:
## RN-000 — <título curto>
- **Status:** ativa | proposta | revogada
- **Regra:** <enunciado claro e TESTÁVEL>
- **Motivo/contexto:** <por que existe>
- **Afeta:** <telas/módulos/dados>  ·  **Atualizada:** AAAA-MM-DD
-->

## Regras

## RN-001 — Frete grátis (exemplo — edite/confirme)
- **Status:** proposta
- **Regra:** Pedidos acima de R$ 200 têm frete grátis para a região Sudeste.
- **Motivo/contexto:** política comercial de lançamento (exemplo ilustrativo).
- **Afeta:** checkout, cálculo de pedido  ·  **Atualizada:** 2026-06-16

## ❓ Perguntas em aberto (a decidir)
> O agente registra aqui dúvidas de regra que dependem da sua decisão.
- [ ] (exemplo) Frete grátis vale para todas as regiões ou só Sudeste?

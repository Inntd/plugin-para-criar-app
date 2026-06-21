---
tipo: spec
id: SPEC-000
nome: 
status: rascunho     # rascunho | aprovada | implementada | obsoleta
regras: []           # IDs das regras aplicáveis (ex.: [RN-001, RN-003])
criada: AAAA-MM-DD
atualizada: AAAA-MM-DD
---

# SPEC-000 — <nome da funcionalidade>

## Objetivo
<o que esta funcionalidade entrega, em 1-2 frases>

## Regras de negócio aplicáveis
- RN-00x — <enunciado curto> (ver REGRAS-DE-NEGOCIO.md)

## Entradas
## Saídas / comportamento esperado

## Casos de borda e erros  ⚠️ OBRIGATÓRIO — não deixar em branco
> Levante o **implícito**: estado vazio, valor inválido, falha externa, concorrência, limites, permissão negada, timeout. Se algum não se aplica, escreva "n/a" com o motivo — não deixe vazio.
- <caso> → <comportamento esperado>

## Critérios de aceite → testes  (cada critério VIRA um teste)
> Regra de ouro: **nenhum critério sem teste**. O teste é o que **prova** que o critério foi cumprido — não "parece funcionar".
| # | Critério de aceite (observável) | Teste que prova | Tipo |
|---|---|---|---|
| 1 | <comportamento que deve ser verdade> | <arquivo/nome do teste> | unitário / integração / e2e |
| 2 |  |  |  |

## Fora de escopo
> Construa **só** o que está nesta spec. Não adicione o que não está aqui.
- <o que NÃO fazer>

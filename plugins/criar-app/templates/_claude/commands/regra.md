---
description: Registrar uma regra de negócio e propagar o impacto pela cadeia (specs, skills, regras de código, âncoras)
argument-hint: <enunciado da regra de negócio>
allowed-tools: Read, Edit, Write, Bash(date:*), Bash(rg:*), Bash(ls:*), Glob
---
Regra de negócio do usuário: "$ARGUMENTS"

## 1) Registrar
1. Leia @REGRAS-DE-NEGOCIO.md e ache o próximo ID livre (RN-00N).
2. Reescreva a regra de forma clara e **testável**. Se faltar algo essencial (limites, exceções, erro/estado vazio), pergunte UMA coisa objetiva antes de gravar.
3. Acrescente na seção "## Regras" com **Status: ativa**, motivo/contexto e **Atualizada:** (use `date '+%Y-%m-%d'`).
4. Se responder a algum item de "❓ Perguntas em aberto", marque como resolvido.

## 2) Propagar pela cadeia  (Problema → Regras → Specs → Skills → Código)
Avalie o impacto e **proponha** (não execute mudanças grandes sem eu confirmar):
- **Dor:** a regra ainda serve à dor em @PROBLEMA.md? Se contradiz, levante a bandeira (ou acione o subagente `advogado-do-problema`).
- **Specs:** procure specs afetadas (`rg -l "RN-0" docs/specs/` e por tema). Liste quais atualizar e o quê; ofereça rodar **/spec**.
- **Skills:** alguma skill em `.claude/skills/` precisa mudar? Ou a regra descreve um **fluxo repetível** que vira skill? Ofereça **/skill**.
- **Regras de código:** se a regra impõe padrão técnico (precisão monetária, formato, validação, limite), proponha uma **RC-00N** em `docs/REGRAS-DE-CODIGO.md` (seção "Regras do projeto"), com *origem:* esta RN.
- **Âncoras COMENT-AI:** se já existe código sobre o tema, aponte onde caberia uma âncora (ex.: `NOTE`/`SECURITY`) — sem editar código agora.
- **MAPA.md:** atualize se algo novo for criado.

## 3) Fechar
Confirme em poucas linhas: a regra gravada (ID + enunciado) + a **lista de repercussões propostas** para eu aprovar. Nesta etapa, só registro e propostas — não altere código.

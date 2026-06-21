---
name: construir
description: Lê os arquivos de contexto preenchidos (PROBLEMA.md, REGRAS-DE-NEGOCIO.md, STACK.md, TASKS.md) e constrói o app seguindo a cadeia specs → código → testes, sem precisar passar por cada comando manualmente.
argument-hint: [foco específico, ex.: "módulo de autenticação", opcional]
allowed-tools: Read, Edit, Write, Bash, Glob, Grep
---

Foco opcional do usuário: "$ARGUMENTS"

Você vai **construir o app** a partir dos arquivos de contexto já preenchidos. Siga a cadeia: contexto → specs → código → testes → prova.

## 1. Leia o contexto completo

Leia em ordem:
- @PROBLEMA.md — a dor e o objetivo
- @REGRAS-DE-NEGOCIO.md — regras ativas
- @docs/STACK.md — stack e estrutura do repo
- @TASKS.md — marcos e tarefas planejadas
- @MAPA.md — o que já existe no projeto
- `docs/specs/` — specs já criadas (se houver)

**Pare imediatamente** e peça ao usuário para preencher se encontrar:
- PROBLEMA.md sem dor definida → use `/problema`
- REGRAS-DE-NEGOCIO.md sem nenhuma regra `ativa` → use `/regra`
- STACK.md com campos `____` em branco → preencha antes de codar (as regras de código dependem da stack)

## 2. Avalie o estado atual

Identifique:
- Funcionalidades no TASKS.md **sem spec** em `docs/specs/` → precisam de spec primeiro
- Specs existentes **sem código implementado** → implementar
- Código existente **sem testes** → criar testes

Se "$ARGUMENTS" foi fornecido, restrinja o escopo a esse foco.

## 3. Monte o plano e peça confirmação

Apresente ao usuário antes de qualquer ação:

```
## O que vou construir
[ ] Spec: <funcionalidade A>  ← baseado nas regras RN-001, RN-002
[ ] Código: <funcionalidade A>
[ ] Testes: <funcionalidade A>
[ ] Spec: <funcionalidade B>  ← ...
...

Ordem: prioridade do TASKS.md (essencial → importante → pode esperar).
Confirma? (s para continuar, ou diga o que ajustar)
```

**Não comece a codar sem confirmação explícita.**

## 4. Para cada funcionalidade (em ordem de prioridade)

### 4a. Crie a spec (se ainda não existir)

Crie `docs/specs/SPEC-XXX-nome.md` com:
- Regras de negócio que a sustentam (RN-00x)
- Casos de borda obrigatórios — nunca deixe em branco
- Critérios de aceite → cada um mapeado a um teste futuro

### 4b. Implemente seguindo as regras

- Siga os princípios da skill `principios-de-codigo` e as 14 regras de `docs/REGRAS-DE-CODIGO.md`
- Construa **só o que a spec diz** — sem features extras (YAGNI)
- Deixe âncoras COMENT-AI onde a intenção não for óbvia
- Acione o subagente `guardiao` antes de criar módulo ou dependência nova
- Em ambiguidade: máx. 3 tentativas, depois monte um quiz e espere resposta — não gaste tokens explorando

### 4c. Crie os testes

- Um teste por critério de aceite da spec
- Casos de borda cobertos
- Critério sem teste = não concluído

### 4d. Acione o subagente `revisor`

Antes de marcar a funcionalidade como pronta, o `revisor` verifica qualidade, segurança e conformidade com regras e spec.

## 5. Ao concluir cada funcionalidade

```bash
date '+%Y-%m-%d %H:%M'
```
- Marque `[x]` no TASKS.md
- Acrescente entrada no PROGRESS.md com data/hora
- Atualize o MAPA.md se criou arquivos novos
- Commit: `git add -A && git commit -m "feat(<escopo>): <descrição curta>"`

## 6. Ao finalizar tudo

- Rode `/provar` nas specs implementadas (subagente `avaliador` dá a nota)
- Mostre ao usuário:
  - O que foi construído (lista com arquivo:linha principal)
  - O que ficou de fora e por quê
  - Próximo passo sugerido (próxima tarefa do TASKS.md ou `/reconciliar` se a estrutura mudou)

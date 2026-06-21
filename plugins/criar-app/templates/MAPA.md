# 🗺️ MAPA — índice de navegação do projeto

> **Atualizado em:** AAAA-MM-DD · Mantido pelo agente (comando **/mapa** regenera).
> Leia este arquivo **primeiro** ao navegar. Para buscar, use **/buscar <termo>** ou delegue ao subagente **explorador** (ele lê no contexto dele e devolve só o resumo — essencial quando o projeto cresce).
>
> **Cadeia do projeto:** Problema (`PROBLEMA.md`) → Regras → Specs → Skills/Subagentes → Código.

## Onde está cada coisa
| O quê | Onde |
|---|---|
| **A dor (raiz de tudo)** | `PROBLEMA.md` |
| Contrato do agente | `CLAUDE.md` |
| Stack do app | `docs/STACK.md` |
| Rodar / ambientes | `docs/SETUP.md` · `.env.example` |
| Manual visual do pipeline | `docs/pipeline-manual.html` |
| Guardrails determinísticos | `.claude/settings.json` · `.claude/hooks/block-dangerous.sh` |
| Norte + checklist + recuperação | `TASKS.md` |
| Memória (diário com data/hora) | `PROGRESS.md` |
| Regras de negócio | `REGRAS-DE-NEGOCIO.md` |
| Specs (por funcionalidade) | `docs/specs/` |
| Modelo de dados / IA | `docs/dados/modelo-de-dados.md` |
| Decisões (ADRs) | `docs/decisoes/` |
| Convenção de âncoras | `docs/COMENT-AI.md` |
| Regras de código (14 leis) | `docs/REGRAS-DE-CODIGO.md` |
| Skills do projeto | `.claude/skills/` |
| Subagentes | `.claude/agents/` |
| Comandos | `.claude/commands/` |
| Código | `src/` (ajuste conforme a stack) |

## Specs
*(lista gerada por /mapa — id + 1 linha)*

## Skills
- **principios-de-codigo** (MIT) — 4 princípios anti-erro de LLM em código; **sempre** em vigor (ver CLAUDE.md).
*(demais: lista gerada por /mapa — nome + 1 linha)*

## Subagentes
- **explorador** — busca/localiza no repo e resume (read-only).
- **revisor** — revisa código + conformidade com regras e spec (marca critério sem teste).
- **avaliador** — **prova** que uma spec foi cumprida, critério a critério (implementado + testado), com nota. Via /provar.
- **advogado-do-problema** — desafia se a feature serve à dor validada.
- **guardiao** — (sob demanda) evita código desnecessário/errado ao criar.
- **debatedor** — resolve ambiguidade pesando opções; sem loop.

## Comandos
- **/problema** · **/dividir** · **/retomar** · **/regra** · **/regras** · **/spec** · **/provar** · **/skill** · **/adicionar-subagente** · **/buscar** · **/mapa** · **/reconciliar** · **/custo**

## Módulos de código
*(lista gerada por /mapa — pasta + 1 linha)*

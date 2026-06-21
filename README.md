# Marketplace `criar-app`

Empacota o **harness de criação de apps** (cadeia viva *Problema → Regras → Specs → Skills/Subagentes → Código*) como um plugin do Claude Code.

## O que o plugin entrega
Depois de instalado, ficam disponíveis em **qualquer pasta**:

- **15 comandos:** `/novo-projeto`, `/problema`, `/dividir`, `/retomar`, `/regra`, `/regras`, `/spec`, `/provar`, `/skill`, `/adicionar-subagente`, `/buscar`, `/mapa`, `/reconciliar`, `/custo`, `/ajuda`.
- **6 subagentes:** `advogado-do-problema`, `avaliador`, `debatedor`, `explorador`, `guardiao`, `revisor`.
- **1 skill:** `principios-de-codigo`.

## Como instalar

No Claude Code:

```
/plugin marketplace add "E:\Google Drive INNTD\...\plugin-para-criar-app"
/plugin install criar-app@criar-app-marketplace
```

> Use o caminho **da pasta `plugin-para-criar-app`** (a que contém `.claude-plugin/marketplace.json`). Se você publicar num repositório Git, pode usar a URL no lugar do caminho local: `/plugin marketplace add usuario/repo`.

Confirme com `/plugin` (deve aparecer `criar-app` como enabled) e digite `/` para ver os comandos.

## Como criar um app novo

1. Crie/abra uma **pasta vazia** para o app e abra o Claude Code nela.
2. Rode:
   ```
   /novo-projeto
   ```
   Isso copia para a pasta: `CLAUDE.md`, os arquivos de estado (`PROBLEMA.md`, `TASKS.md`, `PROGRESS.md`, `REGRAS-DE-NEGOCIO.md`, `MAPA.md`), `docs/`, e a **camada determinística** (`.claude/settings.json` + `.claude/hooks/`).
3. `git init`, edite o `CLAUDE.md` (nome + descrição) e comece com `/problema`.

## Arquitetura (por que dividido assim)

| Parte | Onde vive | Por quê |
|---|---|---|
| Comandos, subagentes, skill | **Plugin** (global) | Atualiza num lugar só; todos os apps herdam a versão nova |
| CLAUDE.md, estado, docs | **Copiado** por `/novo-projeto` | São arquivos do projeto — plugin não os injeta na pasta |
| `settings.json` + hooks (permissions, block-dangerous, checkpoint, resume-context) | **Copiado** local em cada app | Guardrails autocontidos e portáteis; evita `[auto]` commits em repos não relacionados |

## Atualizar o harness
Edite os arquivos em `plugins/criar-app/` e rode `/plugin marketplace update criar-app-marketplace`. Apps já criados herdam comandos/subagentes/skill novos automaticamente (a camada determinística, por ser local, só muda em apps novos ou via `/reconciliar`).

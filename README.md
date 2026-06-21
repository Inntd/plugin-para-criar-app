# Marketplace `criar-app`

Empacota o **harness de criação de apps** (cadeia viva *Problema → Regras → Specs → Skills/Subagentes → Código*) como um plugin do Claude Code.

## O que o plugin entrega

Rodando `/criar-app:novo-projeto` numa pasta vazia, o projeto fica com:

- **15 comandos locais:** `/novo-projeto`, `/problema`, `/dividir`, `/retomar`, `/regra`, `/regras`, `/spec`, `/provar`, `/skill`, `/adicionar-subagente`, `/buscar`, `/mapa`, `/reconciliar`, `/custo`, `/ajuda` — todos sem prefixo, em `.claude/commands/`.
- **6 subagentes locais** em `.claude/agents/`: `advogado-do-problema`, `avaliador`, `debatedor`, `explorador`, `guardiao`, `revisor`.
- **1 skill local** em `.claude/skills/`: `principios-de-codigo`.
- **Camada determinística** em `.claude/`: `settings.json` (permissions) + hooks `block-dangerous`, `checkpoint`, `resume-context`.
- **Arquivos de estado:** `CLAUDE.md`, `PROBLEMA.md`, `TASKS.md`, `PROGRESS.md`, `REGRAS-DE-NEGOCIO.md`, `MAPA.md`, `docs/`.

---

## Como instalar (uma vez por máquina)

**Passo 1 — Terminal: configurar git para usar HTTPS**

```bash
git config --global url."https://github.com/".insteadOf "git@github.com:"
git config --global url."https://github.com/".insteadOf "ssh://git@github.com/"
```

**Passo 2 — Claude Code: adicionar marketplace e instalar**

```
/plugin marketplace add Inntd/plugin-para-criar-app
/plugin install criar-app@criar-app-marketplace
```

Confirme com `/plugin` — deve aparecer `criar-app` como *enabled*.

---

## Como criar um app novo (uma vez por projeto)

1. Crie uma **pasta vazia** para o app e abra o Claude Code nela.
2. Rode o único comando com prefixo que você vai precisar:
   ```
   /criar-app:novo-projeto
   ```
3. O plugin copia para a pasta tudo — arquivos de estado, docs, `.claude/commands/`, `.claude/agents/`, `.claude/skills/` e os guardrails.
4. A partir daí, todos os comandos funcionam **sem prefixo**:
   ```
   git init
   /problema      ← define a dor que o app resolve
   /dividir       ← quebra objetivo em tarefas
   /regra         ← registra regras de negócio
   /spec          ← formaliza funcionalidades
   /provar        ← prova que a spec foi cumprida
   ```

---

## Fluxo resumido

```
[instalar — uma vez por máquina]
  terminal:     git config --global ...   (2 linhas)
  Claude Code:  /plugin marketplace add Inntd/plugin-para-criar-app
                /plugin install criar-app@criar-app-marketplace

[novo projeto — uma vez por pasta]
  Claude Code:  /criar-app:novo-projeto

[trabalhar no projeto — dia a dia, sem prefixo]
  /problema · /dividir · /regra · /spec · /provar · /reconciliar ...
```

---

## Atualizar o harness

Edite os arquivos em `plugins/criar-app/` e rode:
```
/plugin marketplace update criar-app-marketplace
```
Projetos novos criados depois do update já recebem a versão mais recente via `/criar-app:novo-projeto`. Projetos existentes: copie manualmente os arquivos atualizados de `.claude/commands/` e `.claude/agents/` caso queira a versão nova.

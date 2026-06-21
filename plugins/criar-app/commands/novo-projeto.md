---
description: Cria o esqueleto completo de um app novo (CLAUDE.md, arquivos de estado, docs e camada deterministica) na pasta atual, a partir do template do plugin criar-app.
allowed-tools: Bash, Read
---
Você vai **inicializar um projeto novo** com o harness "criar-app" **na pasta atual**. Os arquivos vêm do template do plugin; os comandos, subagentes e a skill já estão disponíveis pelo próprio plugin (não são copiados).

## 1. Localize os templates do plugin
```bash
TPL="$CLAUDE_PLUGIN_ROOT/templates"
[ -d "$TPL" ] || TPL="$(find "$HOME/.claude/plugins" -type d -path '*criar-app/templates' 2>/dev/null | head -1)"
echo "Templates: $TPL"
[ -d "$TPL" ] && ls -A "$TPL" || echo "NAO ENCONTRADO"
```
Se `TPL` não existir, **PARE** e avise que o plugin `criar-app` não está instalado/encontrado.

## 2. Não sobrescreva um projeto existente
```bash
{ [ -e CLAUDE.md ] || [ -d .claude ]; } && echo "JA_EXISTE" || echo "PASTA_LIVRE"
```
Se imprimir `JA_EXISTE`, **pare e pergunte ao usuário** se é para mesclar/sobrescrever antes de continuar. Só prossiga com confirmação explícita.

## 3. Copie o esqueleto para a pasta atual
```bash
set -e
cp -r "$TPL/." .
# dotfiles são guardados sem o ponto no template; renomeia agora:
[ -e _gitignore ]   && mv -f _gitignore .gitignore
[ -e _env.example ] && mv -f _env.example .env.example
# _claude/ vira .claude/ (camada deterministica local: settings.json + hooks)
if [ -d _claude ]; then
  mkdir -p .claude
  cp -r _claude/. .claude/
  rm -rf _claude
  chmod +x .claude/hooks/*.sh 2>/dev/null || true
fi
# Copia o manual HTML da raiz do plugin (fonte única)
HTML_SRC="$CLAUDE_PLUGIN_ROOT/../../como usar a skill de criacao de app.html"
[ -f "$HTML_SRC" ] && cp "$HTML_SRC" "./como usar a skill de criacao de app.html" || true
echo "=== RESULTADO ==="; ls -A
```

## 4. Confirme e oriente
Verifique que foram criados: `CLAUDE.md`, `PROBLEMA.md`, `TASKS.md`, `PROGRESS.md`, `REGRAS-DE-NEGOCIO.md`, `MAPA.md`, `docs/`, `.claude/settings.json` e `.claude/hooks/`.

Depois diga ao usuário, curto:
- **Estrutura criada:** comandos em `.claude/commands/`, subagentes em `.claude/agents/`, skill em `.claude/skills/`, guardrails em `.claude/settings.json` + `.claude/hooks/`.
- **Próximo passo:** rode `git init` (se ainda não houver repo), edite o `CLAUDE.md` trocando `<nome do projeto>` e a descrição do app, e comece com `/problema` para definir a dor que o app resolve.

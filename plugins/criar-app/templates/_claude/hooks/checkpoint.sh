#!/usr/bin/env bash
# Stop hook — CHECKPOINT automático.
# Ao fim de cada resposta, se houver mudanças, faz um commit [auto] com data/hora.
# Protege contra desligamento abrupto. NUNCA bloqueia a sessão (exit 0).
# Antes de commitar, faz um SCAN heurístico de segredos e ABORTA o commit se achar.
set -uo pipefail

cd "${CLAUDE_PROJECT_DIR:-.}" 2>/dev/null || exit 0
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0
[ -z "$(git status --porcelain)" ] && exit 0

git add -A
staged="$(git diff --cached --name-only)"

# (a) arquivos sensíveis por nome (permite .env.example)
secret_files="$(printf '%s\n' "$staged" | grep -Ei '(^|/)\.env($|\.)|\.pem$|\.key$|(^|/)secrets/' | grep -v '\.env\.example$' || true)"
# (b) conteúdo: atribuição de valor longo a nome sensível
secret_content="$(git diff --cached -U0 2>/dev/null | grep -Ei '(api[_-]?key|secret|password|passwd|token|private[_-]?key|aws_secret|bearer)[^=:]{0,24}[:=][[:space:]]*[A-Za-z0-9/+_=.-]{16,}' || true)"

if [ -n "$secret_files" ] || [ -n "$secret_content" ]; then
  git reset -q >/dev/null 2>&1 || true   # tira do stage; não commita segredo
  {
    echo "⛔ checkpoint ABORTADO: possível segredo no stage."
    [ -n "$secret_files" ] && echo "  arquivos: $(printf '%s ' $secret_files)"
    [ -n "$secret_content" ] && echo "  conteúdo suspeito detectado no diff."
    echo "  Resolva (mova para variável de ambiente / ajuste .gitignore) e commite manualmente."
  } >&2
  exit 0
fi

ts="$(date '+%Y-%m-%d %H:%M:%S')"
git commit -q -m "checkpoint: ${ts} [auto]" >/dev/null 2>&1 || true
exit 0

#!/usr/bin/env bash
# SessionStart hook — injeta o estado do projeto no contexto ao iniciar/retomar.
# O stdout do SessionStart é VISTO pelo Claude. Mantenha curto.
set -uo pipefail

cd "${CLAUDE_PROJECT_DIR:-.}" 2>/dev/null || exit 0

echo "### Retomada de contexto (hook) — onde paramos ###"

# "Retomar aqui" do TASKS.md (ajuste o caminho se estiver em docs/)
if [ -f TASKS.md ]; then
  echo
  echo "## TASKS.md — Retomar aqui:"
  awk '/Retomar aqui/{f=1} f&&/^## /&&!/Retomar aqui/{exit} f' TASKS.md
fi

# últimas 3 entradas do PROGRESS.md
if [ -f PROGRESS.md ]; then
  echo
  echo "## PROGRESS.md — últimas entradas:"
  grep -m 3 '^## \[' PROGRESS.md || true
fi

# estado do git
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo
  echo "## git status:"; git status -s
  echo "## últimos commits:"; git log --oneline -5 2>/dev/null || true
fi
exit 0

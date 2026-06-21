#!/usr/bin/env bash
# PreToolUse hook (matcher: Bash) — rede de segurança contra comandos obviamente perigosos.
# stdin = JSON do tool. exit 2 = BLOQUEIA (texto vai ao Claude). exit 0 = permite.
# ⚠️ NÃO é sandbox: um shell determinado tem como driblar. É um freio para footguns óbvios.
#    Funciona melhor com `jq` ou `python3` instalado (extração robusta do comando).
#    Regex pensada para bash + grep GNU; ajuste se seu ambiente diferir.
set -uo pipefail
input="$(cat)"

cmd=""
if command -v jq >/dev/null 2>&1; then
  cmd="$(printf '%s' "$input" | jq -r '.tool_input.command // empty' 2>/dev/null)"
elif command -v python3 >/dev/null 2>&1; then
  cmd="$(printf '%s' "$input" | python3 -c "import sys,json; print(json.load(sys.stdin).get('tool_input',{}).get('command',''))" 2>/dev/null)"
else
  cmd="$(printf '%s' "$input" | grep -o '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"command"[[:space:]]*:[[:space:]]*"//; s/"$//')"
fi
[ -z "$cmd" ] && exit 0

c="$(printf '%s' "$cmd" | tr -s ' ')"
W='(^|[[:space:];&|])'   # início de "palavra" de comando, de forma portável
deny(){ printf '⛔ Guardrail bloqueou (%s). Se for mesmo intencional, rode você fora do agente.\n' "$1" >&2; exit 2; }

# 1) rm recursivo/forçado em alvo perigoso
if printf '%s' "$c" | grep -Eq "${W}rm([[:space:]]|$)"; then
  if printf '%s' "$c" | grep -Eq '\-[a-zA-Z]*r[a-zA-Z]*f|\-[a-zA-Z]*f[a-zA-Z]*r|\-r([[:space:]]|$)[^|;&]*\-f|\-f([[:space:]]|$)[^|;&]*\-r'; then
    printf '%s' "$c" | grep -Eq '[[:space:]](/|~|\$HOME|\*|\.\.?)([[:space:]]|$)|[[:space:]]/[[:space:]]*$|--no-preserve-root' && deny "rm recursivo em caminho perigoso"
  fi
fi
# 2) fork bomb
printf '%s' "$c" | grep -Eq ':\(\)[[:space:]]*\{[[:space:]]*:[[:space:]]*\|[[:space:]]*:?[[:space:]]*&[[:space:]]*\}[[:space:]]*;[[:space:]]*:' && deny "fork bomb"
# 3) baixar e executar direto da rede
printf '%s' "$c" | grep -Eq "${W}(curl|wget|fetch)([[:space:]])[^|]*\|[[:space:]]*(sudo[[:space:]]+)?(sh|bash|zsh)([[:space:]]|$)" && deny "download | shell (execução remota)"
# 4) chmod 777 recursivo
printf '%s' "$c" | grep -Eq "${W}chmod([[:space:]])[^|;&]*(\-R|\-\-recursive)[^|;&]*0?777([[:space:]]|$)" && deny "chmod 777 recursivo"
# 5) git push forçado (permite --force-with-lease)
if printf '%s' "$c" | grep -Eq "${W}git[[:space:]]([^|;&]*[[:space:]])?push([[:space:]]|$)"; then
  if printf '%s' "$c" | grep -Eq '(\-\-force([^-]|$)|[[:space:]]\-f([[:space:]]|$))'; then
    printf '%s' "$c" | grep -Eq 'force-with-lease' || deny "git push --force"
  fi
fi
# 6) escrita em disco bruto / formatar partição
printf '%s' "$c" | grep -Eq "${W}dd([[:space:]])[^|;&]*of=/dev/|${W}mkfs|>[[:space:]]*/dev/(sd|nvme|hd)" && deny "escrita em disco bruto / mkfs"

exit 0

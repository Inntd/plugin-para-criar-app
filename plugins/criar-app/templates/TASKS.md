# TASKS — <nome do projeto>

> Norte do projeto + checklist de trabalho. O agente (Claude Code) **lê este arquivo no início de toda sessão** e o **mantém atualizado**. Em caso de desligamento abrupto, comece pelo **▶️ Retomar aqui** e pelo **🧯 Protocolo de recuperação** (no fim).

## 🎯 Norte (o que estamos construindo)
<1–3 frases: o app, para quem, e o resultado esperado>
> A **dor** que isto resolve está em PROBLEMA.md (a raiz da cadeia).

## 🧭 Princípios / guarda-corpos
- <ex.: stack e padrões a seguir>
- <ex.: nada de segredo no repo; chaves só em variável de ambiente>
- <ex.: LGPD nos dados pessoais; minimizar o que é guardado>
- <ex.: rodar testes/lint antes de cada commit>

## ▶️ Retomar aqui (estado atual — manter sempre atualizado)
- **Marco atual:** <ex.: MVP do cadastro>
- **Última tarefa concluída:** <descrição> (detalhe em PROGRESS.md)
- **Em andamento agora:** <a tarefa que estava em curso>
- **Próximo passo imediato:** <a 1ª coisa a fazer ao voltar>
- **Branch / arquivos tocados:** <ex.: feature/login — src/auth/*>

## ✅ Checklist do marco atual
> Prioridade: 🔴 essencial · 🟡 importante · ⚪ pode esperar · cada tarefa com *sucesso:* (como verificar)
- [ ] 🔴 <tarefa> — *sucesso:* <checagem/teste>
- [ ] 🟡 <tarefa> — *sucesso:* <checagem/teste>
- [ ] ⚪ <tarefa>

## 🗺️ Marcos (roadmap)
> Gere/atualize a quebra com **/dividir <objetivo>**.
- [ ] **Marco 1** — <objetivo>
- [ ] **Marco 2** — <objetivo>
- [ ] **Marco 3** — <objetivo>

## 🧯 Protocolo de recuperação (após desligamento abrupto)
Antes de escrever qualquer código, faça **nesta ordem**:
1. Ler este **TASKS.md** (Norte + "▶️ Retomar aqui") e as **últimas entradas do PROGRESS.md**.
2. `git status` e `git log --oneline -5` — ver o que mudou e o que **não** foi commitado.
3. `git diff` — inspecionar trabalho a meio (arquivos modificados não salvos).
4. Rodar **build/testes** para descobrir o estado real do código.
5. Retomar pelo **"Próximo passo imediato"**. Ao concluir algo, **registrar no PROGRESS.md com data/hora** e atualizar este arquivo.

> Regra: **TASKS.md** é sempre o *estado atual* (sobrescreve). **PROGRESS.md** é o *histórico* (só acrescenta).

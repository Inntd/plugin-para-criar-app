# Template de projeto de app (Claude Code)

Repositório-modelo para iniciar **qualquer app web** com o Claude Code já configurado para: manter **memória** do que foi feito, capturar **regras de negócio** que dão o norte, gerar **specs** e **skills** conforme as regras crescem, **navegar** sem se perder mesmo quando o projeto fica grande, e **se recuperar** de um desligamento abrupto. Clone, renomeie e comece.

> 📘 **Manual visual:** abra **`docs/pipeline-manual.html`** no navegador para ver o pipeline, os comandos e as regras de forma interativa (funciona offline).

> Método adaptado do padrão "LLM Wiki": aqui o contexto é **vivo** e mora **dentro do repo**, onde o Claude Code lê sozinho — não é um vault separado. O núcleo de *como fazer* (técnicas de IA, RAG, etc.) fica na wiki **CRIAR COM IA**; este repo cuida **deste app** e a referencia.
>
> **A base do app é uma cadeia viva, não um PRD estático:** **Problema (a dor) → Regras → Specs → Skills/Subagentes → Código**, com descoberta contínua no topo. Apaixone-se pelo problema, não pela solução.

## Estrutura
```
.
├── CLAUDE.md                 # contrato do agente (enxuto, com as rotinas)
├── PROBLEMA.md               # a dor que o app resolve (raiz da cadeia)
├── TASKS.md                  # norte + checklist + protocolo de recuperação
├── PROGRESS.md               # memória: diário com data/hora
├── REGRAS-DE-NEGOCIO.md      # regras de negócio (autoridade)
├── MAPA.md                   # índice de navegação/busca
├── .gitignore                # protege segredos (o checkpoint roda git add -A)
├── .env.example              # modelo de variáveis de ambiente (sem segredos)
├── docs/
│   ├── STACK.md              # a stack completa do app
│   ├── SETUP.md              # como rodar + ambientes
│   ├── pipeline-manual.html  # manual visual do pipeline (abre no navegador)
│   ├── specs/                # uma spec por funcionalidade (gerada das regras)
│   ├── dados/                # o que guardar/filtrar e onde a IA entra (LGPD)
│   ├── decisoes/             # ADRs
│   ├── COMENT-AI.md          # convenção de comentários âncora (contexto no código)
│   └── REGRAS-DE-CODIGO.md    # 14 regras de engenharia (segurança, testes, REST, commits...)
└── .claude/
    ├── settings.json         # registra os hooks
    ├── hooks/                # checkpoint (Stop) · retomada (SessionStart) · block-dangerous (PreToolUse)
    ├── commands/             # /retomar /regra /regras /spec /provar /skill /buscar /mapa
    ├── agents/               # explorador (busca) · revisor (qualidade) · avaliador (prova) · guardiao · debatedor
    └── skills/               # skills do projeto (criadas via skill-creator)
        └── principios-de-codigo/  # (MIT) princípios anti-erro de LLM — sempre ativos
```

## Comandos
| Comando | Para quê |
|---|---|
| **/problema** | Entender/refinar a dor que o app resolve (apaixone-se pelo problema) |
| **/retomar** | Briefing do que foi feito e "continuar ou começar do zero?" |
| **/dividir** `<objetivo>` | Quebrar um objetivo grande em marcos + tarefas pequenas com prioridade (grava no TASKS.md) |
| **/regra** `<texto>` | Inserir uma regra de negócio a qualquer momento |
| **/regras** `[foco]` | O agente sugere/pergunta regras que faltam |
| **/spec** `<func.>` | Criar/atualizar a spec: casos de borda obrigatórios + **cada critério de aceite vira um teste** |
| **/provar** `<spec>` | **Provar** que uma spec foi cumprida: cada critério implementado **e testado**, com nota |
| **/skill** `<p/ quê>` | Criar uma skill (usa a skill **skill-creator**) |
| **/adicionar-subagente** `<p/ quê>` | Criar um subagente em `.claude/agents/` com frontmatter válido |
| **/buscar** `<termo>` | Busca facilitada (delega ao explorador se for fundo) |
| **/mapa** | Regenerar o índice MAPA.md |
| **/reconciliar** `[o que mudou]` | Após mudanças (até manuais), atualiza o MAPA e aponta inconsistências |
| **/custo** | Custo/uso de tokens da sessão e onde se gasta mais (usa /usage + ccusage) |

## Subagentes (cruciais em projeto grande)
- **explorador** — localiza e entende coisas no repo e devolve só um **resumo** (read-only, roda no Haiku). Mantém o contexto principal limpo.
- **revisor** — revisa código por qualidade, **segurança** e **conformidade com as regras/spec** antes de concluir (marca critério de aceite sem teste).
- **avaliador** — **prova** que uma spec foi cumprida, critério a critério (implementado + testado), com nota (via **/provar**).
- **advogado-do-problema** — desafia se uma funcionalidade serve à **dor validada** e aponta suposições não testadas (freio contra apaixonar-se pela solução).
- **guardiao** — (acionado **só quando necessário**) evita **código desnecessário** e sobre-engenharia ao criar; alerta ok/cuidado/pare. Economiza tokens entrando apenas em momentos que importam.
- **debatedor** — quando o pedido é ambíguo, pesa 2-3 abordagens e recomenda uma; trava de **3 tentativas** e então pergunta ao humano (sem loop).

## Hooks
- **Stop → checkpoint.sh**: a cada parada com mudanças, faz commit `[auto]` (protege contra desligamento abrupto).
- **SessionStart → resume-context.sh**: ao abrir/retomar, injeta TASKS/PROGRESS/git no contexto.
- **PreToolUse → block-dangerous.sh**: barra comandos obviamente perigosos (`rm -rf` em caminho perigoso, `curl|sh`, fork bomb, `chmod -R 777`, `git push --force`, escrita em disco bruto).

### Guardrails determinísticos (a camada que *impede*, não só aconselha)
Diferente das instruções (que o agente segue), estes são **enforcement**: o `.claude/settings.json` tem um bloco `permissions` que **nega ler segredos** (`.env`, `secrets/`, `*.key`, `*.pem`) e **pede confirmação antes de `git push`**; o hook `block-dangerous.sh` bloqueia comandos destrutivos; e o `checkpoint.sh` **aborta o commit automático** se detectar segredo no stage.
⚠️ **Honestidade:** não é um sandbox — um shell determinado pode driblar; o scan de segredos é heurístico (pega o óbvio, não tudo); o hook funciona melhor com `jq` ou `python3` e `grep` GNU. **Confirme o schema do settings.json em code.claude.com/docs** (evolui).

## Como usar (a cada novo app)
1. Copie/cleie esta pasta e renomeie. `git init && git add -A && git commit -m "scaffold"`.
2. `chmod +x .claude/hooks/*.sh`.
3. Preencha **`docs/STACK.md`** (stack), **`docs/SETUP.md`** + `.env.example` (rodar), o **CLAUDE.md** (o app) e o **Norte** no TASKS.md.
4. Comece a soltar regras com **/regra**; deixe o agente sugerir mais com **/regras**.
5. Conforme as regras firmam, gere specs com **/spec** e skills com **/skill**.
6. Use **/buscar** e o **explorador** para navegar; **revisor** antes de concluir.
7. (Opcional) Abra a pasta no **Obsidian** para navegar os .md.

## Skill embutida: principios-de-codigo
Vem com a skill **principios-de-codigo** (MIT): *Pensar antes de codar · Simplicidade primeiro · Mudanças cirúrgicas · Execução orientada a metas*. O CLAUDE.md manda **segui-la sempre**; os subagentes `guardiao` e `debatedor` a operacionalizam. Crédito ao autor original e licença em `.claude/skills/principios-de-codigo/FONTE.md`.

## Adicionar peças (na mão ou por comando)
Skills (`.claude/skills/`) e subagentes (`.claude/agents/`) são **descobertos automaticamente** — você pode criá-los **manualmente** e depois rodar **/reconciliar** para o template se ajustar (MAPA, validação de frontmatter, ligação às regras). Ou use os comandos: **/spec**, **/skill**, **/adicionar-subagente**. E o **/regra** não só registra a regra de negócio: ele **propaga pela cadeia** (propõe ajustes em specs, skills, regras de código e âncoras).

## Regras de código (14 leis)
O template traz **14 regras de engenharia** (`docs/REGRAS-DE-CODIGO.md`): isolamento de segurança, multi-tenant, async, segredos, sessão, arquitetura limpa, credenciais, erros com contexto, dependências, testes-first, REST, commits convencionais, ambientes e docs-as-code. Cada regra tem um **gatilho** (quando aplicar). ⚠️ As leis nasceram de uma stack específica (Next.js + FastAPI + Supabase + Celery, multi-tenant) — as que citam tecnologia valem **se** o app usa essa stack; senão, vale o **princípio**. Defina sua stack no `CLAUDE.md`.

## Comentários âncora (COMENT-AI)
O template adota a convenção **COMENT-AI** (`docs/COMENT-AI.md`): marcadores como `COMENT-AI-SECURITY`, `COMENT-AI-NEVER-ALTER`, `COMENT-AI-PERFORMANCE` etc. dão **contexto local** para a LLM/harness ler no meio do código. O CLAUDE.md manda **sempre procurá-las antes de editar, respeitá-las e nunca removê-las sem ordem explícita**; o subagente `revisor` sinaliza violações.

## ⚠️ Avisos
- **Segredos**: nunca no repo (o `.gitignore` cobre `.env`/chaves). O checkpoint roda `git add -A`.
- Hooks, comandos e subagentes **executam ações na sua máquina** — revise antes de usar.
- A **skill-creator** precisa estar instalada para o /skill usá-la; senão, o comando segue o formato SKILL.md embutido.
- **Testes provam, não decoram:** o template trata teste como parte da entrega — cada critério de aceite vira um teste e **/provar** dá a nota. Isso veio de um benchmark de frameworks spec-driven onde o peso dos testes decidiu o vencedor; aqui valem os **princípios**, não os números exatos do estudo (LLM-como-juiz tem ~2-3% de variação).
- **O harness do repositório importa tanto quanto o framework:** um bom CLAUDE.md/skills/agents é o que faz um modelo bom render. Par recomendado: **Opus planeja, Sonnet implementa**.
- Claude Code evolui — confirme caminhos/sintaxe em `code.claude.com/docs` (hooks, slash-commands, sub-agents, skills).

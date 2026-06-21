# Regras de código (14 leis) — a LLM respeita ao criar código e app

> O `CLAUDE.md` manda **seguir estas regras sempre**. Cada lei tem um **gatilho** — aplique a lei quando o gatilho disparar (não precisa reler tudo a cada vez). Estas são regras de **como construir** (engenharia); as regras de **o que o app faz** ficam em `REGRAS-DE-NEGOCIO.md`.
>
> 📈 **Documento vivo:** as 14 leis são a **base**; regras específicas do projeto crescem na seção "Regras do projeto" conforme surgem regras de negócio, specs e skills.
>
> ⚠️ **Escopo de stack:** estas leis nasceram de uma stack específica — **Next.js (front) + FastAPI (back) + Supabase + Redis/Celery**, app **multi-tenant (SaaS)** com Iron Session. Leis que citam uma tecnologia (Supabase, FastAPI, Celery, Iron Session, `company_id`, bcrypt…) **valem quando o projeto usa essa stack**. Se a stack do seu app for diferente, **aplique o princípio** (o "porquê"), não a API literal — e ajuste/defina a stack real no `CLAUDE.md`.

## Regras do projeto (vivas) — crescem com o domínio
> Além das 14 leis-base abaixo, **regras de código específicas deste app** entram aqui conforme o domínio amadurece — nascem de **regras de negócio**, **specs** e **skills**. O agente **propõe**; você **confirma** (mesmo fluxo das regras de negócio).
> Formato: `RC-00N — <regra testável>` · status `ativa`/`proposta`/`revogada` · *origem:* (RN-00x / SPEC-00x / skill / decisão).

- *(exemplo)* **RC-001 — Todo valor monetário usa tipo decimal, nunca float.** Status: proposta · *origem:* RN-001 (cálculo de pedido).

## ❓ A decidir (regras de código)
> Dúvidas técnicas recorrentes que dependem da sua decisão.
- [ ] *(exemplo)* padrão de paginação para listas grandes (offset vs cursor)?

---

## LEI 01 — Isolamento de segurança (cliente)
**Gatilho:** criar/modificar arquivos em `/app`, `/components` ou código client-side que toque banco/Supabase.
- **Proibição de Service Role no front:** nunca usar `SUPABASE_SERVICE_ROLE_KEY` em `/app` ou `/components`.
- **Zero escrita direta no banco pelo front:** nada de `insert/update/delete` via cliente no client-side; toda alteração de estado passa por rota `/api/*` que **valida a sessão**.
- **Headers de segurança:** toda rota/middleware mantém CSP e anti-clickjacking (`frame-ancestors 'none'` p/ admin; `'*'` só p/ `/embed`).
- **Autenticação:** usar `getIronSession` com AES-256-GCM para verificar identidade no Next.js.

## LEI 02 — Performance e concorrência async
**Gatilho:** criar/modificar `/backend/app/api` ou `/backend/app/services`.
- **Async first:** toda I/O (banco, Redis, APIs externas — OpenAI/Anthropic/Gemini) DEVE ser `async`.
- **Sem bloqueio:** nunca `time.sleep()` nem libs síncronas (`requests`) em rotas FastAPI; use `asyncio.sleep()` e `httpx.AsyncClient()`.
- **Background tasks:** operações longas (billing, PDFs, treino de agentes) vão para **Celery Workers** standalone.

## LEI 03 — Blindagem multi-tenant
**Gatilho:** qualquer query a banco em app multi-tenant; criar tabelas/migrações.
- **Cláusula de empresa:** toda query DEVE incluir `.eq('company_id', company_id)`.
- **Origem da identidade:** `company_id` **nunca** vem do front (JSON body); extrair sempre da sessão autenticada (`require_authenticated_user` / Iron Session).
- **RLS:** novas tabelas com `ENABLE ROW LEVEL SECURITY` e políticas por `auth.uid()`/`company_id`.

## LEI 04 — Cofre de segredos
**Gatilho:** manipular API keys/tokens/credenciais ou criar logs que possam conter dado sensível.
- **Cripto em repouso:** API keys de provedores salvas em `agents`/`companies` criptografadas via `EncryptionService` antes do `INSERT`.
- **Sanitização de logs:** proibido logar env vars sensíveis ou PII (e-mail, CPF).
- **Validação de env:** toda env var crítica validada no startup (ex.: `ENCRYPTION_KEY` Base64 URL-safe).
> (Reforça o guardrail geral do template: **segredo nunca no repo**; só em variável de ambiente.)

## LEI 05 — Hardening de sessão
**Gatilho:** configurar cookies/sessão/middleware de auth ou login/logout.
- **Cookies:** `httpOnly: true`, `secure: true` (prod), `sameSite: 'lax'`.
- **Expiração dinâmica:** diferenciar sessão curta de "lembrar-me".
- **Cleanup no middleware:** sessão inválida/expirada → `cookies().delete()`.

## LEI 06 — Arquitetura limpa
**Gatilho:** criar routers/services ou adicionar lógica de negócio.
- **Services:** regras complexas (preço, RAG, WhatsApp) só em `/app/services/`.
- **Routers:** apenas validam input e chamam services.
- **DRY:** lógica repetida (tokens, billing) centralizada (`UsageService`/`BillingCore`).

## LEI 07 — Higiene de credenciais
**Gatilho:** cadastro/login/reset de senha ou manuseio de senhas/tokens.
- **Hashing:** `bcrypt` custo 12; hashes SHA-256 legados → migrar no próximo login.
- **Complexidade:** 8+ caracteres, 1 maiúscula, 1 minúscula, 1 número.
- **Tokens:** convite/reset com `crypto.getRandomValues` (entropia criptográfica).

## LEI 08 — Tratamento de erros com contexto
**Gatilho:** criar/modificar try/catch, handlers de exceção ou middleware de erro.
- **Zero swallow:** nunca capturar sem logar/relançar; `except: pass` e `catch(e){}` proibidos.
- **Correlation ID:** toda requisição carrega `X-Request-ID` propagado entre serviços e em todos os logs.
- **Separação de audiência:** mensagem amigável p/ usuário; log técnico com stack trace + contexto + timestamp ISO8601.
- **Fail fast:** validar inputs no início; não processar dado inválido para falhar depois.

## LEI 09 — Higiene de dependências
**Gatilho:** sugerir `npm/pip/cargo install` ou alterar package.json/requirements.txt/Cargo.toml.
- **Freshness:** só pacotes com release < 12 meses.
- **Popularidade:** preferir >1000 downloads/semana (npm) ou >500 stars (GitHub).
- **Security scan:** rodar `npm audit`/`pip-audit`/`cargo audit`; rejeitar CVEs críticos/altos.
- **Footprint mínimo:** sem dependência para trivialidade (`left-pad`, `is-odd`).
> (Casa com o subagente `guardiao`: dependência só quando necessária.)

## LEI 10 — Testes antes da implementação (TDD)
**Gatilho:** quando o usuário pedir nova feature/endpoint/função de negócio.
- **Red → Green → Refactor:** teste falha primeiro → código mínimo p/ passar → refatora mantendo verde.
- **Cobertura:** funções de negócio 80%; edge cases obrigatórios (null/undefined, array/string vazia, limites); ≥1 teste de exceção por função que pode falhar.
> (É a forma forte do princípio **Execução orientada a metas** da skill `principios-de-codigo`. Lembrete do template: humanos revisam testes; aqui a LLM os escreve sob orientação — confirme a política do projeto.)

## LEI 11 — Consistência de API REST
**Gatilho:** criar routers/controllers/endpoints.
- **Rotas:** GET `/resources` → 200+array · GET `/resources/:id` → 200+obj · POST `/resources` → 201+obj · PATCH `/resources/:id` → 200+obj · PUT `/resources/:id` → 200+obj · DELETE `/resources/:id` → 204.
- **Erro:** JSON com `error` contendo `code`, `message`, `field`, `request_id`.

## LEI 12 — Disciplina de commits (Conventional Commits)
**Gatilho:** gerar mensagens de commit ou preparar releases.
- **Formato:** `<type>(<scope>): <description>` + opcional `[body]`/`[footer]`.
- **Types:** `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`.
- **Regras:** description em minúsculo, sem ponto final, ≤72 chars na 1ª linha; body diz "o quê" e "por quê", não "como".
> (Vale para os commits "de verdade". Os checkpoints automáticos do hook são `[auto]` e devem ser esmagados/squashed no commit final.)

## LEI 13 — Isolamento de ambientes
**Gatilho:** configurar env vars, connection strings ou deploy.
- **Bancos separados** por ambiente (dev/staging/prod) — nunca compartilhar.
- **Prefixos** `DEV_`/`STAGING_`/`PROD_`.
- **Feature flags** para código não finalizado — nunca direto em main/master.
- **Proibido:** hardcode de URL de produção; dado real de cliente em dev; local conectado a banco de produção.

## LEI 14 — Documentação como código
**Gatilho:** criar funções/classes/módulos ou README.
- **Nomes descritivos** (`user_email` > `ue`; `calculate_monthly_revenue` > `calc`).
- **Funções pequenas:** uma coisa só; se precisar de "e" na descrição, quebre.
- **Docstrings** em toda função pública (funcionalidade, parâmetros, retornos, exceções).
- **README vivo** (setup, exemplos, arquitetura).
- **Proibido:** comentário óbvio que repete o código; código morto comentado (use git); `TODO` sem ticket/issue.
> (Coerente com o COMENT-AI: nada de comentar o óbvio; e `COMENT-AI-TODO` sempre com ticket.)

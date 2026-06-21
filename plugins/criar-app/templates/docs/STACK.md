# STACK — tecnologias deste app

> Defina aqui a **stack completa**. Isto é o **passo zero**: enquanto estiver em branco, as 14 regras de código (`docs/REGRAS-DE-CODIGO.md`) ficam em modo "se aplicável" e o agente assume coisas. Preenchido, as regras que citam tecnologia passam a valer de forma concreta. O *porquê* de cada escolha vai num ADR em `docs/decisoes/`.

## Front-end
- Framework / linguagem: ____
- Estilo / UI: ____
- Estado / dados: ____

## Back-end
- Framework / linguagem / runtime: ____
- Estrutura: ____ (ver Lei 06 — services/routers)

## Banco de dados
- Tecnologia: ____ (ex.: PostgreSQL)
- Acesso: ____ (ORM/driver)
- Migrações: ____ (ferramenta; migration é **imutável** — corrija com uma nova)
- Multi-tenant? ____ (se sim, ver Lei 03 — isolamento por tenant + RLS)
- Entidades e campos detalhados em `docs/dados/modelo-de-dados.md`

## Autenticação / autorização
- Método: ____ (ex.: sessão, JWT, OAuth)
- Sessão / cookies: ____ (ver Lei 05 — hardening; Lei 07 — credenciais)

## Infra / hospedagem
- Onde roda (front / back / banco): ____
- CI/CD: ____

## Filas / jobs (background)
- Tecnologia: ____ (ex.: Celery, BullMQ) — operações longas fora da request (Lei 02)

## IA / provedores (se aplicável)
- Modelos / provedores: ____ (OpenAI / Anthropic / Gemini / local)
- Padrão: ____ (RAG, embeddings — técnicas na wiki CRIAR COM IA)
- Chaves: só em variável de ambiente; criptografadas em repouso se persistidas (Lei 04)

## Integrações externas
- ____ (pagamento, e-mail, storage, etc.) — contratos em `docs/api/` se houver

## Observabilidade
- Logs / monitoramento: ____ (Lei 08 — erros com contexto, `X-Request-ID`)

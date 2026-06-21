# SETUP — como rodar e ambientes

> Como subir o projeto localmente e a separação de ambientes (Lei 13). Mantenha atualizado (Lei 14 — docs vivos).

## Pré-requisitos
- ____ (runtimes + versões: ex.: Node 20, Python 3.12)
- ____ (ferramentas: banco local, docker, etc.)

## Instalação
1. Clonar o repositório.
2. Instalar dependências: ____ (ex.: `npm install` / `pip install -r requirements.txt`)
3. Copiar `.env.example` → `.env` e preencher (ver abaixo).
4. Banco: ____ (criar/migrar — ex.: `npm run migrate`)

## Variáveis de ambiente
- Documentadas em `.env.example` (versionado, **sem segredos reais**). Copie para `.env` (ignorado pelo git).
- **Nunca** comite segredo (Lei 04).
- **Ambientes separados** (Lei 13): prefixos `DEV_`/`STAGING_`/`PROD_` e **bancos diferentes** por ambiente — nunca local ligado a produção.

## Rodar local
- Front: ____ (ex.: `npm run dev`)
- Back: ____ (ex.: `uvicorn app.main:app --reload`)
- Jobs: ____ (ex.: `celery -A app worker`)

## Testes
- Rodar: ____ (ex.: `npm test` / `pytest`)
- Cobertura mínima e edge cases obrigatórios: ver Lei 10.

## Build / deploy
- Build: ____
- Deploy por ambiente: ____ (código não finalizado atrás de feature flag — Lei 13)

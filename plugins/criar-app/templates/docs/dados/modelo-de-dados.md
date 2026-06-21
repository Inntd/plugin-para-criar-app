---
tipo: dados
atualizada: AAAA-MM-DD
---

# Modelo de dados — o que guardar, filtrar e onde a IA entra

> Decisão deliberada, não despejo de dados. Guarde só o necessário (minimização).

## Entidades persistidas
| Entidade | Campos principais | Por que guardar | Retenção / filtragem |
|---|---|---|---|
| <ex.: Usuário> | <id, nome, email> | <autenticação> | <enquanto ativo> |

## Dados pessoais (LGPD)
- O que é dado pessoal, base legal, retenção e anonimização.
- ⚠️ **Nada de segredo no repositório** (chaves/tokens só em variável de ambiente).

## Onde a IA agrega valor (e onde NÃO)
- **Bom para IA:** busca semântica/RAG sobre <...>, classificação de <...>, sugestão de <...>.
- **Melhor sem IA:** <consulta/relatório que SQL comum resolve — mais barato, previsível e auditável>.
- (Para técnicas de RAG/embeddings, ver a wiki **CRIAR COM IA**.)

## Banco de dados
- Tecnologia, schema/migrações, índices, backups.

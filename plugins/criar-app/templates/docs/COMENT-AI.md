# Convenção COMENT-AI — comentários âncora

> A **LLM escreve** estes comentários **enquanto cria o código**, escolhendo o tipo certo para aquele momento, de modo que **a própria LLM no futuro** (e, em segundo plano, um humano) entenda *por que* o trecho é como é. São "sinais de trânsito" para a máquina ler no meio do código — não documentação tradicional. Convenção **obrigatória**; o `CLAUDE.md` manda respeitá-la e mantê-la **sempre**.
>
> **Por que existe:** um humano experiente comenta pouco (código bom se explica). A LLM tem o problema oposto — **esquece o contexto entre sessões** e erra por não saber o porquê. A âncora é **memória de contexto no próprio código**, no formato que a máquina lê melhor.

## Regras de uso
- Prefixo padrão: **`COMENT-AI-`** (sempre em MAIÚSCULAS). Variante em PT quando útil (ex.: `COMENT-AI-CRÍTICO`).
- Mantenha **concisos** — máximo **120 caracteres**.
- **Antes de modificar** qualquer código, SEMPRE **procure** âncoras existentes nos arquivos relevantes.
- **Atualize** a âncora quando modificar o código relacionado.
- **NUNCA remova** uma âncora sem instrução humana **explícita**.
- **Autoridade**: o contexto de uma âncora vale **acima** de preferências gerais — abaixo apenas da **Segurança**.

## Tipos

### 🚨 COMENT-AI-CRITICAL / COMENT-AI-CRÍTICO
Código extremamente sensível, crítico para performance, ou com consequências graves se alterado (hot paths, segurança crítica, pagamentos).
`// COMENT-AI-CRITICAL: 🚨 Hot path - 100k req/sec. NO database calls. NO blocking operations.`
**Ação:** NÃO modificar sem aprovação explícita. Se precisar, apresentar justificativa detalhada primeiro.

### 💡 COMENT-AI-NOTE / COMENT-AI-NOTA
Contexto importante, decisões arquiteturais, explicação de lógica complexa (o "porquê" não óbvio).
`// COMENT-AI-NOTE: 💡 Uses virtual scrolling for 10k+ items. Don't convert to regular map.`
**Ação:** ler, entender e seguir. Perguntar se algo não estiver claro.

### ⚠️ COMENT-AI-WARNING / COMENT-AI-ADVERTENCIA
Alertas sobre armadilhas, problemas conhecidos, efeitos colaterais não óbvios.
`// COMENT-AI-WARNING: ⚠️ This function mutates input. Clone before calling if original needed.`
**Ação:** cuidado extra; verificar que modificações não introduzem os problemas alertados.

### ℹ️ COMENT-AI-INFO
Informação contextual, notas históricas, limitações de sistemas legados, contexto de requisito de negócio.
`// COMENT-AI-INFO: ℹ️ This approach required by legacy system constraints from 2022 migration.`
**Ação:** considerar o contexto ao modificar. Não "modernizar" sem entender implicações.

### 🚫 COMENT-AI-NEVER-ALTER / COMENT-AI-NÃO-ALTERAR
Código que NUNCA deve ser modificado sem instrução humana direta (contratos de API públicos, criptografia, compliance, código auditado).
`// COMENT-AI-NEVER-ALTER: 🚫 API Contract v2.3.1. ANY change requires version bump + migration plan.`
**Ação:** NÃO TOCAR. Se a modificação parecer necessária, apenas **reportar** ao desenvolvedor.

### 📝 COMENT-AI-TODO / COMENT-AI-TAREFA
Tarefas futuras ou melhorias que podem ser trabalhadas.
`// COMENT-AI-TODO: 📝 Implement pagination (ticket: FEED-123). Need cursor-based for infinite scroll.`
**Ação:** pode trabalhar quando solicitado. Referenciar o ticket, se houver.

### ❓ COMENT-AI-QUESTION / COMENT-AI-PERGUNTA  (e COMENT-AI-ANSWER)
Dúvidas sobre a intenção do código que precisam de esclarecimento.
`// COMENT-AI-QUESTION: ❓ Why filter here instead of in cache layer?`
`// COMENT-AI-ANSWER: Historical - privacy rules can change between cache updates`
**Ação:** se encontrar perguntas sem resposta, pode tentar responder ou escalar ao desenvolvedor.

### ✏️ COMENT-AI-MODIFIED / COMENT-AI-MODIFICADO
Rastrear modificações recentes com contexto (após otimizações, correções de segurança, refatorações).
`// COMENT-AI-MODIFIED: ✏️ Optimized 15/01/2025 - reduced from 200ms to 50ms by caching`
**Ação:** ADICIONAR este comentário ao fazer modificações significativas — incluir **data** e **motivo**.

### 🗑️ COMENT-AI-DEPRECATED / COMENT-AI-DESCONTINUADO
Marcar código obsoleto ou que será removido.
`// COMENT-AI-DEPRECATED: 🗑️ Replaced by getUserDataV2() - check dependencies before removal`
**Ação:** não usar código deprecado em novos desenvolvimentos; pode ajudar a mapear usos para remoção.

### 🔒 COMENT-AI-SECURITY / COMENT-AI-SEGURANÇA
Código relacionado a segurança que requer atenção especial (validação de entrada, autenticação/autorização, criptografia, sanitização).
`// COMENT-AI-SECURITY: 🔒 Input sanitization for SQL injection prevention. Do not remove or bypass.`
**Ação:** NUNCA remover ou enfraquecer. Se precisar modificar, **adicionar** proteções — não remover.

### ⚡ COMENT-AI-PERFORMANCE / COMENT-AI-PERFORMANCE
Código otimizado para performance que não deve ser "simplificado".
`// COMENT-AI-PERFORMANCE: ⚡ Using Set instead of Array for O(1) lookup. Do not convert to Array.filter()`
**Ação:** manter a otimização. Se parecer "estranho", provavelmente é intencional.

### 🔌 COMENT-AI-HARDWARE / COMENT-AI-HARDWARE
Código que interage com hardware físico (timing crítico, limites de segurança física).
`// COMENT-AI-HARDWARE: 🔌 Motor speed limit 3000 RPM. Exceeding causes physical damage.`
**Ação:** EXTREMO CUIDADO — erros podem causar dano físico; SEMPRE verificar limites.
> *Incluído por completude da convenção. Em apps web costuma não se aplicar — use apenas se o app realmente controlar hardware.*

## Quando vale uma âncora (equilíbrio)
A âncora existe para o que o código **não** diz sozinho — nem mais, nem menos.
- **Deixe a âncora se** alguém (LLM ou humano) poderia **mudar ou quebrar** o trecho por não saber o porquê: otimização que parece "estranha", validação que parece removível, limite, contrato, efeito colateral, decisão contraintuitiva, gambiarra temporária.
- **Não deixe se** o código já é claro (nomes/estrutura explicam) — comentar o óbvio é ruído.
- **Teste rápido:** *"o próximo a ler ficaria surpreso, ou faria uma mudança errada, sem esta nota?"* Sim → âncora com o tipo mais específico. Não → deixe o código falar.
- Uma âncora por motivo; curta (≤120 chars); no ponto exato do trecho.

## Quando adicionar (resumo)
- Decisão não óbvia → **NOTE**/**INFO** · efeito colateral/armadilha → **WARNING**
- Validação/auth/cripto → **SECURITY** · trecho otimizado → **PERFORMANCE**
- Contrato/algoritmo intocável → **NEVER-ALTER** · hot path → **CRITICAL**
- Otimizou/corrigiu algo relevante → **MODIFIED** (com data e motivo)
- Pendência → **TODO** (com ticket) · obsoleto → **DEPRECATED** · dúvida → **QUESTION**

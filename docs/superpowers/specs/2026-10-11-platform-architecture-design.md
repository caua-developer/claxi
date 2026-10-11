# Arquitetura da Plataforma Claxi

Date: 2026-10-11
Status: Living document — movido de `guia-tecnico.md` (raiz do repo) para esta pasta de specs; reconciliado com [`2026-10-11-student-performance-platform-design.md`](./2026-10-11-student-performance-platform-design.md)

> Documento de referência para desenvolvimento, decisões de arquitetura e uso de ferramentas de IA para auxiliar na implementação.
>
> **Escopo:** plataforma SaaS para professores criarem e organizarem questões, listas de exercícios e avaliações com apoio de IA. Este documento não cobre naming, identidade visual ou estratégia de marca.

## 1. Objetivo do produto

O produto ajuda o professor a preparar materiais pedagógicos de qualidade em menos tempo. O principal fluxo é:

1. Criar uma avaliação ou lista de exercícios.
2. Definir disciplina, série/ano, tópicos, quantidade e dificuldade.
3. Gerar questões com IA ou selecionar questões do banco.
4. Revisar, editar, duplicar, excluir e reordenar questões.
5. Definir pontuação e instruções.
6. Exportar PDF com cabeçalho/identidade da instituição ou do professor.
7. Gerar gabarito separado.

### Princípios do MVP

- Resolver muito bem o fluxo de criação e exportação de avaliações.
- Priorizar confiabilidade, rapidez e qualidade do PDF.
- Manter a IA assistiva: o professor revisa e aprova o conteúdo.
- Não construir um ERP escolar, LMS ou sistema de gestão acadêmica geral.
- Não adicionar funcionalidades sem evidência de necessidade.
- O estudante não terá conta de login própria (sem senha/e-mail) — ele é identificado por um código pessoal (matrícula interna, CPF ou matrícula externa) ao acessar uma avaliação, conforme [`2026-10-11-student-performance-platform-design.md`](./2026-10-11-student-performance-platform-design.md).

### Fora do MVP

- Diário, notas, frequência e boletim (fora do que já é coberto pelos snapshots de desempenho da spec de alunos).
- Matrícula, financeiro escolar e comunicação com responsáveis.
- Cursos em vídeo, gamificação e aplicativo nativo.
- Marketplace de questões.
- Diagnóstico avançado de aprendizagem alheio ao fluxo de habilidades BNCC já modelado.
- Integrações extensas com sistemas de terceiros.

> **Atualização (2026-10-11):** "Aplicação e correção online de avaliações" deixou de estar fora do escopo — o registro de alunos (independentes ou em turmas), a liberação de avaliações por link público e a resposta/correção dentro da plataforma foram aprovados e detalhados em [`2026-10-11-student-performance-platform-design.md`](./2026-10-11-student-performance-platform-design.md). O princípio "o estudante não terá conta própria" continua válido no sentido de login/senha — o acesso é por código pessoal, não por autenticação completa.

## 2. Funcionalidades do MVP

### 2.1 Usuários e permissões

Papéis previstos:

- `PLATFORM_ADMIN`: administração global da plataforma.
- `TENANT_ADMIN`: administração de uma instituição/conta contratante.
- `TEACHER`: criação e gestão dos próprios materiais dentro do tenant.

Um usuário pode pertencer a mais de um tenant. A associação e o papel são representados por `tenant_users`, em vez de guardar um único `tenant_id` na tabela `users`.

### 2.2 Banco de questões

Cada questão pode conter:

- disciplina;
- série/ano;
- tópico;
- dificuldade;
- tipo;
- enunciado;
- alternativas, quando aplicável;
- resposta correta ou resposta esperada;
- explicação/resolução;
- origem (manual, IA ou importação);
- autor e timestamps.

Tipos iniciais:

- `MULTIPLE_CHOICE`
- `TRUE_FALSE`
- `OPEN_ENDED`

Dificuldades iniciais:

- `EASY`
- `MEDIUM`
- `HARD`

### 2.3 Avaliações e listas

Uma avaliação contém título, instruções, estado e uma lista ordenada de questões. Cada ocorrência de questão na avaliação pode ter pontuação própria.

Operações essenciais:

- criar, editar, duplicar e arquivar avaliação;
- adicionar questão do banco ou gerar questão com IA;
- remover, substituir e reordenar questões;
- editar uma questão sem perder a versão original do banco, se necessário;
- definir pontuação;
- exportar prova e gabarito em PDF.

Tipos iniciais de documento:

- `TEST`
- `EXERCISE_LIST`
- `SIMULATED_EXAM`

Estados:

- `DRAFT`
- `PUBLISHED`
- `ARCHIVED`

### 2.4 PDF

PDF é parte central do MVP, não um detalhe secundário.

Requisitos iniciais:

- cabeçalho configurável;
- nome do professor/instituição;
- título e instruções;
- paginação consistente;
- questões e alternativas sem cortes;
- espaço adequado para respostas abertas;
- gabarito separado;
- suporte a caracteres acentuados e fórmulas conforme a necessidade real;
- visualização e nova exportação após alterações.

A solução técnica para geração de PDF deve ser validada com protótipos cedo. Não deixar essa decisão para o fim.

### 2.5 IA e créditos

Unidade de cobrança sugerida:

> 1 crédito = geração ou regeneração de uma questão completa, incluindo enunciado, alternativas quando aplicável, resposta e explicação.

Exemplo: gerar uma prova com 10 questões consome 10 créditos. Regenerar uma questão consome mais 1 crédito.

O servidor é responsável por validar saldo e registrar consumo. Nunca confiar em um contador enviado pelo frontend.

O sistema deve registrar, no mínimo:

- tenant e usuário;
- operação e identificador da questão gerada;
- provedor/modelo;
- versão do prompt;
- tokens de entrada e saída, quando disponíveis;
- créditos cobrados;
- custo estimado/real;
- estado da operação;
- data e eventual erro.

Não oferecer geração ilimitada no MVP. Limites e pacotes devem ser configuráveis no backend.

## 3. Stack tecnológica definida

### 3.1 Frontend web

- **TanStack Start**
- **React**
- **TypeScript**
- **TanStack Router**, conforme a integração do Start
- **TanStack Query** para estado remoto quando necessário
- CSS com variáveis de design tokens; Tailwind CSS pode ser usado se acelerar a implementação sem prejudicar a clareza.

Motivos:

- aplicação React com suporte a rotas e recursos de servidor;
- possibilidade de resolver tenant e configuração visual a partir do hostname;
- uma única aplicação pode servir vários tenants;
- TypeScript compartilhado no frontend para tipos e contratos gerados.

Evitar criar uma camada de abstração própria para cada biblioteca. Usar os recursos do framework de forma convencional.

### 3.2 Aplicativo móvel

- **React Native + Expo**, apenas quando houver necessidade validada.

O app móvel não faz parte do MVP. Não manter duas interfaces antes de validar a versão web. Reutilizar contratos de API e regras de negócio no backend; não tentar compartilhar toda a UI entre web e mobile.

### 3.3 Backend

- **Java + Spring Boot**
- API REST
- OpenAPI para documentar os contratos
- Spring Security para autenticação/autorização
- JDBC API
- Bean Validation para validação de entrada
- Spring Modulith, usado para verificar fronteiras entre módulos, sem transformar a arquitetura em burocracia.

Arquitetura: **monólito modular organizado por funcionalidade**. Não começar com microsserviços.

### 3.4 Banco de dados

- **Neon PostgreSQL** como PostgreSQL gerenciado.

O banco não deve rodar na VM da aplicação inicialmente. Usar migrações versionadas no repositório e executar alterações de schema de maneira controlada.

### 3.5 Armazenamento de arquivos

- **Cloudflare R2** para PDFs exportados, logos e outros arquivos.

Guardar no PostgreSQL apenas metadados e a chave do objeto. Não armazenar arquivos binários grandes como dados normais de tabelas.

### 3.6 Infraestrutura

Plano inicial considerado:

- **Locaweb Cloud Medium:** 2 vCPU, 4 GB RAM e 80 GB SSD.
- IP público adicional, se necessário.
- Docker para empacotar e executar os serviços.
- **Caddy** como reverse proxy.
- **Cloudflare** para DNS, proxy, TLS, proteção e rate limiting.

Arquitetura inicial:

```text
Navegador
   |
   v
Cloudflare (DNS / proxy / proteção)
   |
   v
VM Locaweb
   |
   +-- Caddy
   |    +-- app.seudominio.com -> TanStack Start
   |    +-- api.seudominio.com -> Spring Boot
   |
   +-- TanStack Start (Node.js)
   |
   +-- Spring Boot
          |
          +-- Neon PostgreSQL
          |
          +-- Cloudflare R2
          |
          +-- Provedor de IA
```

Uma única VM reduz a complexidade inicial. Separar frontend e backend apenas quando métricas, disponibilidade ou carga justificarem. A VM de 4 GB é um ponto de partida, não uma garantia de capacidade: medir memória, CPU, latência e uso real.

Não adicionar Redis inicialmente. Introduzi-lo apenas quando houver necessidade demonstrada de cache compartilhado, rate limiting distribuído, filas, locks ou outro caso concreto.

### 3.7 Domínios e multi-tenancy

Modelo inicial:

- `app.seudominio.com`: acesso genérico;
- `{tenant}.seudominio.com`: acesso por tenant;
- domínio próprio do cliente: fase posterior.

O backend deve resolver o tenant com base no hostname validado e no contexto de autenticação. **Nunca confiar em `tenant_id` enviado livremente pelo frontend** como prova de autorização.

O hostname não substitui autorização. Toda operação de dados deve verificar se o usuário pertence ao tenant e possui a permissão necessária.

## 4. Arquitetura do backend

Organizar o código por módulo de negócio, evitando diretórios globais enormes de `controllers`, `services` e `repositories`.

Estrutura de referência:

```text
com.example.product
├── identity/
│   ├── api/
│   ├── application/
│   ├── domain/
│   └── infrastructure/
├── tenant/
│   ├── api/
│   ├── application/
│   ├── domain/
│   └── infrastructure/
├── question/
│   ├── api/
│   ├── application/
│   ├── domain/
│   └── infrastructure/
├── assessment/
│   ├── api/
│   ├── application/
│   ├── domain/
│   └── infrastructure/
├── catalog/
├── file/
├── ai/
└── shared/
```

Módulos iniciais:

- `identity`: identidade, autenticação e associação de usuários;
- `tenant`: tenants, configurações e resolução do tenant;
- `question`: banco e ciclo de vida de questões;
- `assessment`: avaliações e ordenação de questões;
- `catalog`: disciplinas, séries/anos e tópicos;
- `file`: metadados e integração com R2;
- `ai`: integração com o provedor, prompts, custo e créditos.

Diretrizes:

- Dependências entre módulos devem ser explícitas.
- Evitar relações bidirecionais entre entidades JPA de módulos diferentes.
- Usar IDs e contratos de aplicação quando isso reduzir acoplamento.
- Não criar interfaces para tudo; abstrair quando houver uma fronteira real, como o provedor de IA ou armazenamento.
- Não aplicar DDD tático completo a todo CRUD.
- Manter controllers finos; regras de negócio ficam na camada de aplicação/domínio apropriada.
- Transações devem ter fronteiras claras, principalmente ao consumir créditos e salvar avaliações.

## 5. Modelo de dados inicial

- Schema real e versionado em `database/` (um arquivo `.sql` por entidade — consultar esse diretório como fonte da verdade, não este guia).
- Specs de design das extensões maiores ficam em `docs/superpowers/specs/`.

### Regras de modelagem

- Usar UUIDs ou outro padrão de IDs consistente em toda a aplicação.
- Incluir `organization_id` nas tabelas pertencentes a uma organização.
- Usar constraints para proteger integridade referencial.
- Definir estratégia para remoção/arquivamento de questões que já aparecem em avaliações.
- Considerar snapshot do conteúdo da questão dentro da avaliação se alterações posteriores na questão não puderem modificar avaliações já preparadas/publicadas.
- Campos do tipo enum (`status`, `type`, `difficulty`, etc.) usam tabelas auxiliares de lookup (`id TEXT` + `description`) referenciadas por `FOREIGN KEY`, em vez de `CHECK (... IN (...))` — ver convenções completas no [`README.md`](../../../README.md#banco-de-dados).

> **Atualização (2026-10-11):** BNCC já foi modelado (`bncc_curricular_components`, `bncc_skills`, `question_bncc_skills`) e é a base da análise de habilidades por aluno e da geração adaptativa de questões por IA — ver [`2026-10-11-student-performance-platform-design.md`](./2026-10-11-student-performance-platform-design.md). A recomendação original de "não adicionar BNCC no primeiro corte" não se aplica mais.

## 6. Frontend: organização e white-label

Estrutura de referência:

```text
src/
├── app/
├── components/
├── features/
│   ├── assessments/
│   ├── questions/
│   ├── catalog/
│   └── settings/
├── tenant/
│   ├── TenantProvider.tsx
│   ├── tenantApi.ts
│   └── tenantResolver.ts
└── theme/
    ├── tokens.css
    └── applyTenantTheme.ts
```

### White-label

- Uma única aplicação/build deve servir vários tenants.
- Separar configuração do tenant de tema visual.
- Resolver o tenant a partir do hostname no servidor sempre que possível.
- Buscar a configuração pública do tenant e aplicar tokens por CSS custom properties.
- Não usar o tema visual como mecanismo de segurança.
- Não duplicar a aplicação ou o código por cliente.

Exemplo conceitual de tokens:

```css
:root {
  --color-primary: #3155a0;
  --color-secondary: #28776b;
  --radius-control: 0.5rem;
}
```

Os valores acima são placeholders, não decisões finais de identidade visual.

## 7. Integração de IA

Criar uma fronteira de aplicação para o provedor de IA. Não espalhar chamadas ao SDK do fornecedor por controllers e componentes.

Fluxo recomendado:

1. Receber os parâmetros e validar autorização.
2. Validar o saldo de créditos.
3. Registrar a operação de geração.
4. Construir prompt com versão identificável.
5. Chamar o provedor por uma interface interna.
6. Validar a saída estruturada e os campos obrigatórios.
7. Registrar modelo, tokens, custo, latência e resultado.
8. Cobrar créditos de forma consistente com a política definida.
9. Retornar a questão para revisão humana.

Requisitos:

- Chaves de API somente no backend.
- Timeouts e tratamento de indisponibilidade.
- Limites de tamanho de entrada/saída.
- Validação de JSON e regras específicas por tipo de questão.
- Não assumir que uma resposta gerada está pedagogicamente correta.
- Evitar cobrar duas vezes em retries; usar idempotência onde necessário.
- Não registrar conteúdo sensível ou segredos nos logs.
- Manter modelo e versão de prompt configuráveis.
- Monitorar custo real por operação antes de definir limites comerciais definitivos.

O valor de R$ 0,03 por crédito discutido anteriormente é apenas uma hipótese de planejamento, não um custo garantido. O custo real depende do modelo, tokens, retries e formato da saída.

## 8. Segurança e isolamento entre tenants

Requisitos obrigatórios desde o início:

- Autenticação e autorização no backend.
- Verificação de associação do usuário ao tenant em cada operação.
- Nunca usar o `tenant_id` enviado pelo browser como autorização.
- Consultas e comandos limitados ao tenant autorizado.
- Proteção contra acesso horizontal indevido a IDs de outras contas.
- Validação de entrada com Bean Validation.
- Rate limiting para login, geração por IA e endpoints caros.
- Segredos via variáveis de ambiente ou gerenciador apropriado; nunca no Git.
- CORS restritivo e cookies/sessões configurados corretamente.
- Logs sem senhas, tokens ou chaves de API.
- Backups e teste periódico de restauração do PostgreSQL.
- URLs assinadas e de curta duração para arquivos privados no R2, quando aplicável.
- Política de retenção e exclusão de dados.

Adicionar testes explícitos que comprovem que um usuário do tenant A não consegue ler, alterar ou excluir dados do tenant B.

## 9. Testes e qualidade

Priorizar testes que protegem regras de negócio e dados:

- testes unitários para regras de avaliação, pontuação, créditos e validação de questões;
- testes de integração para persistência e transações;
- testes de API para autenticação, autorização e isolamento entre tenants;
- testes de contrato/validação para respostas do provedor de IA;
- testes de geração de PDF com casos longos, acentos, muitas alternativas e respostas abertas;
- testes de migrações Flyway;
- teste de restauração de backup antes de produção.

Ferramentas indicadas:

- JUnit 5;
- Spring Boot Test;
- Testcontainers;
- testes do framework escolhido para o frontend;
- lint, formatter e verificação de tipos no pipeline de CI.

Não perseguir cobertura percentual isolada. Testar primeiro caminhos críticos e falhas com impacto financeiro ou de isolamento de dados.

## 10. Deploy e operação

### Ambientes

Manter, no mínimo:

- desenvolvimento local;
- ambiente de staging/validação;
- produção.

Não executar migrações destrutivas diretamente em produção sem backup e plano de reversão.

### Docker

Separar serviços em containers:

- frontend TanStack Start;
- backend Spring Boot;
- Caddy.

Neon, R2 e o provedor de IA são serviços externos. Não é necessário colocar Redis ou PostgreSQL dentro da VM inicialmente.

### Observabilidade mínima

- logs estruturados;
- health checks;
- métricas de CPU, memória e disco;
- latência e taxa de erro da API;
- latência e falhas de geração por IA;
- custo de IA por período;
- falhas e duração de exportação PDF;
- alertas de disco, memória e indisponibilidade.

A estimativa inicial de infraestrutura não substitui teste de carga. Medir antes de aumentar a capacidade ou separar serviços.

## 11. Uso de assistentes de código

Usar ferramentas de IA como apoio à implementação, não como autoridade final sobre arquitetura ou segurança.

### Contexto que deve acompanhar tarefas importantes

Fornecer ao assistente:

- este guia;
- a funcionalidade específica;
- a estrutura atual dos diretórios relevantes;
- contratos de API e modelo de dados existentes;
- restrições e critérios de aceitação;
- testes já existentes e comandos para executá-los.

### Instruções recomendadas para tarefas de código

1. Pedir que inspecione os arquivos relevantes antes de propor alterações.
2. Solicitar uma solução pequena e coerente com a arquitetura existente.
3. Pedir lista de arquivos a alterar e justificativa breve.
4. Exigir tratamento de erros e validação de entradas.
5. Pedir testes para regras de negócio e caminhos de falha.
6. Solicitar execução de formatter, lint, testes e build disponíveis.
7. Revisar manualmente migrações, autenticação, isolamento multi-tenant e operações de cobrança.
8. Não aceitar APIs, dependências ou funções inventadas pelo assistente sem verificação na documentação.
9. Não permitir que o assistente remova testes ou enfraqueça validações apenas para fazer o build passar.
10. Revisar o diff antes de integrar.

### Exemplo de prompt para uma tarefa

```text
Leia o guia técnico do projeto e inspecione a implementação existente antes de alterar arquivos.

Tarefa: [descrever uma funcionalidade pequena e específica]

Restrições:
- Respeitar a arquitetura atual e os limites entre módulos.
- Não introduzir dependências sem justificar.
- Não alterar contratos públicos sem apontar o impacto.
- Validar entrada e autorização no backend.
- Considerar isolamento entre tenants.
- Adicionar ou atualizar testes relevantes.

Antes de concluir:
- Execute os testes, formatter, lint e build disponíveis.
- Informe os arquivos alterados.
- Resuma decisões e riscos.
- Informe comandos que não conseguiu executar e o motivo.
- Não declare testes aprovados se não foram executados.
```

### Como dividir o trabalho

Preferir tarefas verticais pequenas, por exemplo:

- implementar criação de questão com testes;
- adicionar filtros ao banco de questões;
- implementar reordenação de questões em uma avaliação;
- gerar PDF de uma avaliação;
- registrar consumo de créditos com idempotência.

Evitar pedidos vagos como “implemente todo o backend” ou “construa o SaaS inteiro”. A revisão e a depuração ficam mais difíceis quando muitas fronteiras mudam ao mesmo tempo.

## 12. Ordem de implementação sugerida

1. Criar repositório, aplicações, Docker e ambientes.
2. Configurar CI, formatter, lint e testes.
3. Implementar tenants, identidade e autorização.
4. Implementar disciplinas, séries e tópicos.
5. Implementar CRUD e busca de questões.
6. Implementar avaliações e ordenação de questões.
7. Implementar exportação de PDF e gabarito.
8. Implementar integração de IA com saída estruturada.
9. Implementar créditos, limites e registro de custos.
10. Implementar armazenamento R2.
11. Implementar configuração white-label por tenant.
12. Adicionar monitoramento, backups, segurança e testes de carga.
13. Validar o fluxo completo com professores antes de ampliar o escopo.
14. Implementar alunos, turmas, liberação/acesso público, respostas dentro da plataforma, correção híbrida (automática/IA/professor) e snapshots de desempenho — ver [`2026-10-11-student-performance-platform-design.md`](./2026-10-11-student-performance-platform-design.md).
15. Implementar geração adaptativa de questões e análise de desempenho por IA a partir dos snapshots.

A ordem pode mudar conforme dependências técnicas descobertas, mas o fluxo de criação e exportação deve ser validado cedo. Os itens 14 e 15 dependem do fluxo original (1–13) já estar estável.

## 13. Decisões ainda abertas

Não tratar como decisão fechada até testar:

- biblioteca e abordagem exatas para gerar PDF;
- provedor/modelo de IA e estratégia de fallback;
- provedor de autenticação ou autenticação própria com Spring Security;
- biblioteca de componentes e estratégia definitiva de CSS;
- política de versionamento/snapshot das questões usadas em avaliações;
- política de cobrança em caso de falha parcial da IA;
- mecanismo de cobrança e emissão de notas fiscais;
- domínio customizado por tenant;
- limites e métricas de capacidade da VM.

Registrar decisões arquiteturais relevantes em ADRs curtos, contendo contexto, decisão, alternativas e consequências.

## 14. Critério de sucesso do MVP

Um professor deve conseguir, sem ajuda manual da equipe:

1. entrar na plataforma;
2. criar ou selecionar questões;
3. gerar uma questão com IA e revisar o resultado;
4. montar e reorganizar uma avaliação;
5. exportar uma prova legível e seu gabarito;
6. voltar e editar a avaliação;
7. manter seus dados isolados dos dados de outros tenants.

A prioridade é tornar esse fluxo confiável, rápido e fácil de usar antes de ampliar a plataforma.

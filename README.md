# Claxi

SaaS multi-tenant que ajuda professores a criar, organizar e exportar questões, listas de exercícios e avaliações, com apoio de geração por IA.

## Stack

- **Backend**: Java 25 + Spring Boot (monólito modular com Spring Modulith), API REST documentada via OpenAPI/springdoc.
- **Banco de dados**: PostgreSQL (Neon gerenciado).
- **Armazenamento de arquivos**: Cloudflare R2 (metadados no Postgres, binário no R2).
- **Frontend** (planejado): TanStack Start + React + TypeScript.
- **Autenticação**: schema compatível com Better Auth (tabelas `organization`, `user`, `session`, `member`, etc.).

Detalhes completos de arquitetura, decisões e restrições estão em [`docs/superpowers/specs/2026-10-11-platform-architecture-design.md`](./docs/superpowers/specs/2026-10-11-platform-architecture-design.md).

## Estrutura do repositório

```text
.
├── api/                  # Backend Spring Boot (Maven)
├── database/             # Schema SQL, um arquivo por entidade
├── docs/
│   └── superpowers/
│       └── specs/        # Specs de design (arquitetura geral + features/subsistemas)
└── README.md
```

## Banco de dados

Os arquivos em `database/` seguem estas convenções:

- Uma entidade (tabela) por arquivo, nomeado igual ao nome da tabela (ex.: `questions.sql`, `assessment_submissions.sql`).
- Identificadores em `snake_case`, sem aspas — exceto `"user"`, que é palavra reservada no Postgres e precisa ficar entre aspas.
- IDs são `UUID` gerados pela aplicação (não pelo banco).
- Campos do tipo enum (`status`, `type`, `difficulty`, etc.) são resolvidos por **tabelas auxiliares de lookup** (`id TEXT PRIMARY KEY` + `description TEXT NOT NULL`), referenciadas por `FOREIGN KEY`, em vez de `CHECK (... IN (...))`. Os valores possíveis já vêm populados via `INSERT ... ON CONFLICT (id) DO NOTHING` no próprio arquivo da tabela auxiliar.
- Relações N:N usam tabela de junção com chave primária composta (ex.: `question_bncc_skills`, `class_enrollments`), sem `id` próprio.
- `FOREIGN KEY` sem nome, declarada ao final da lista de colunas (sem `CONSTRAINT fk_... `).

**Ordem de execução**: como várias tabelas referenciam outras por `FOREIGN KEY`, os arquivos precisam ser executados respeitando as dependências (ex.: `organization` e `user` antes de `session`; tabelas de lookup antes das tabelas que as referenciam). Ainda não há uma ferramenta de migração formal (ex.: Flyway) configurada — isso está listado como decisão aberta no guia técnico.

## Documentação de design

Decisões de arquitetura (gerais ou de um subsistema específico) são registradas como specs em `docs/superpowers/specs/`, no formato `YYYY-MM-DD-<assunto>-design.md`:

- [`2026-10-11-platform-architecture-design.md`](./docs/superpowers/specs/2026-10-11-platform-architecture-design.md) — arquitetura geral do produto, stack, módulos do backend, multi-tenancy e roadmap do MVP.
- [`2026-10-11-student-performance-platform-design.md`](./docs/superpowers/specs/2026-10-11-student-performance-platform-design.md) — alunos, turmas, aplicação de avaliações dentro da plataforma, correção híbrida e desempenho adaptativo por IA.

## Como rodar o backend

```bash
cd api
./mvnw spring-boot:run
```

Requer Java 25 e uma instância PostgreSQL acessível (configuração de conexão ainda não documentada neste README — ver `api/src/main/resources` quando existir `application.yml`/`.properties`).

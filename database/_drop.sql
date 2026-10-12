-- ==============================================================================
-- Claxi — Drop do banco de dados
-- Remove todas as tabelas na ordem inversa de _setup.sql, respeitando as
-- dependencias (FOREIGN KEY). Nao editar diretamente: se uma nova tabela for
-- adicionada em database/, inclua o DROP correspondente aqui tambem.
-- ==============================================================================

DROP TABLE IF EXISTS credit_transactions;
DROP TABLE IF EXISTS ai_generation_operations;
DROP TABLE IF EXISTS assessment_questions;
DROP TABLE IF EXISTS question_bncc_skills;
DROP TABLE IF EXISTS question_alternatives;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS bncc_skills;
DROP TABLE IF EXISTS topics;
DROP TABLE IF EXISTS refresh_tokens;
DROP TABLE IF EXISTS audit_logs;
DROP TABLE IF EXISTS assessments;
DROP TABLE IF EXISTS bncc_curricular_components;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS files;
DROP TABLE IF EXISTS credit_accounts;
DROP TABLE IF EXISTS organization_settings;
DROP TABLE IF EXISTS invitations;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS providers;
DROP TABLE IF EXISTS question_types;
DROP TABLE IF EXISTS question_statuses;
DROP TABLE IF EXISTS question_sources;
DROP TABLE IF EXISTS question_difficulties;
DROP TABLE IF EXISTS file_purposes;
DROP TABLE IF EXISTS education_stages;
DROP TABLE IF EXISTS credit_transaction_types;
DROP TABLE IF EXISTS assessment_types;
DROP TABLE IF EXISTS assessment_statuses;
DROP TABLE IF EXISTS ai_operation_types;
DROP TABLE IF EXISTS ai_operation_statuses;
DROP TABLE IF EXISTS verifications;
DROP TABLE IF EXISTS organizations;
DROP TABLE IF EXISTS users;

# Equilibragem API

API de equilíbrio financeiro construída com Ruby on Rails 8 (modo API).

## Requisitos

- Ruby `3.2.2` (use `.ruby-version` como referência).
- Bundler `>= 2.5`.
- PostgreSQL 14+ local para testes.
- Redis (opcional em desenvolvimento, obrigatório em produção para Action Cable).

## Setup local rápido

1. Instale as dependências Ruby:
   ```bash
   bundle install
   ```
2. Configure variáveis sensíveis via credentials:
   ```bash
   bin/rails credentials:edit
   ```
   Garanta que `config/master.key` **não** seja versionado.
3. Prepare o banco:
   ```bash
   bin/rails db:setup
   ```
4. Execute a aplicação:
   ```bash
   bin/rails server
   ```

Para validar antes do deploy, execute com configuração de produção apontando para um banco PostgreSQL acessível:
```bash
RAILS_ENV=production DATABASE_URL=postgres://... RAILS_MASTER_KEY=... bundle exec rails db:prepare
RAILS_ENV=production DATABASE_URL=postgres://... RAILS_MASTER_KEY=... bundle exec rails server
```

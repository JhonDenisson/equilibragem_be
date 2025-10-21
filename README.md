# Equilibragem API

API de equilíbrio financeiro construída com Ruby on Rails 8 (modo API). Este guia descreve o processo completo para preparar e realizar o deploy no [Render.com](https://render.com/).

## Requisitos

- Ruby `3.2.2` (use `.ruby-version` como referência).
- Bundler `>= 2.5`.
- PostgreSQL 14+ local para testes.
- Redis (opcional em desenvolvimento, obrigatório em produção para Action Cable).
- Node.js/Yarn não são necessários (aplicação API).

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

## Deploy no Render.com

A infraestrutura necessária está descrita em `render.yaml`. Siga os passos abaixo.

### 1. Preparação do repositório

- Confirme que `Procfile` e `render.yaml` estão presentes na branch principal.
- Faça push das alterações para o repositório conectado ao Render (GitHub/GitLab).
- Verifique se as migrations estão aplicadas e o `db/schema.rb` está atualizado.

### 2. Criar banco de dados PostgreSQL

1. Acesse **Render Dashboard → Databases → New Database**.
2. Escolha **PostgreSQL**, plano `Starter` (ou superior).
3. Nome sugerido: `equilibragem-be-db`.
4. Copie o `Internal Database URL`; ele será preenchido automaticamente pelo `render.yaml`.

### 3. Criar instância Redis

1. Em **Render Dashboard → New → Redis**.
2. Plano sugerido: `Starter`.
3. Nome sugerido: `equilibragem-redis`.
4. O `render.yaml` associa a URL ao `REDIS_URL`.

### 4. Criar serviço Web

1. Em **Render Dashboard → New → Web Service**.
2. Conecte o repositório e selecione a branch principal.
3. Verifique as configurações sugeridas automaticamente pelo Render (serão lidas do `render.yaml`):
   - `buildCommand`: `bundle install`
   - `startCommand`: `bundle exec puma -C config/puma.rb`
   - Plano: escolha um plano com memória suficiente (Starter+).
4. Confirme a criação; o Render aplicará as configurações do YAML.

### 5. Variáveis de ambiente obrigatórias

No painel do serviço Web, ajuste/adicione as variáveis:

| Chave                    | Valor / Observação                                                                               |
|-------------------------|---------------------------------------------------------------------------------------------------|
| `RAILS_ENV`             | `production` (já definido)                                                                        |
| `RAILS_MASTER_KEY`      | Cole o conteúdo de `config/master.key` ou utilize Secret File (campo `sync: false` no YAML)      |
| `RAILS_LOG_TO_STDOUT`   | `enabled`                                                                                         |
| `RAILS_SERVE_STATIC_FILES` | `enabled` (necessário apenas se publicar ativos estáticos)                                      |
| `SOLID_QUEUE_IN_PUMA`   | `1` para rodar Solid Queue dentro do processo do Puma                                             |
| `DATABASE_URL`          | Preenchido automaticamente a partir da base `equilibragem-be-db`                                 |
| `CACHE_DATABASE_URL`    | Preenchido automaticamente (aponta para o mesmo Postgres; ajuste caso use instâncias separadas)  |
| `QUEUE_DATABASE_URL`    | Idem acima                                                                                        |
| `CABLE_DATABASE_URL`    | Idem acima                                                                                        |
| `REDIS_URL`             | Preenchido com a instância Redis criada                                                           |
| `APP_HOST`              | Opcional, defina se quiser forçar host personalizado                                              |
| `ACTIVE_STORAGE_SERVICE`| Opcional. Use `local` (default) ou configure serviços externos via credentials                    |

Outros segredos (SMTP, integrações, etc.) devem ser adicionados conforme necessidade do projeto.

### 6. Primeiro deploy

1. Após criar o serviço, o Render iniciará o build e deploy automaticamente.
2. As migrations são executadas via item `postDeploy` (ver `render.yaml`). Acompanhe os logs para garantir sucesso.
3. Caso precise reaplicar migrations manualmente:
   ```bash
   bundle exec rails db:migrate
   ```
   (Executado via Shell da instância ou `render.yaml` → `manualDeploy`).
4. Quando o deploy terminar, acesse a URL pública fornecida pelo Render.

### 7. Verificações pós-deploy

- Acesse `/up` para checar o health check (deve retornar 200).
- Utilize `rails console` pelo Render Shell para validar criação de dados básicos se necessário.
- Monitore os logs (`Render Dashboard → Logs`) para garantir que não há erros de conexão com banco/redis.

### 8. Deploys subsequentes

1. Faça commit/push das mudanças na branch monitorada.
2. Render detectará e iniciará novo build automaticamente.
3. Migrations serão executadas novamente pelo `postDeploy`.

## Dicas e resolução de problemas

- **Erro de master key**: confirme `RAILS_MASTER_KEY` ou habilite `config/master.key` usando Secret File (Upload na aba *Secret Files*).
- **Tempo excedido nas migrations**: migre manualmente via Shell antes de subir alterações pesadas.
- **Redis opcional?**: Para uso de Action Cable em produção a configuração Redis é necessária. Ajuste `config/cable.yml` caso use outro provedor.
- **Pool de conexões**: ajuste `RAILS_MAX_THREADS` ou `WEB_CONCURRENCY` via variáveis de ambiente se perceber saturação do Postgres.

## Recursos úteis

- Documentação oficial Render: <https://render.com/docs>
- Deploy de Rails no Render: <https://render.com/docs/deploy-rails>
- Guides Rails Credenciais: <https://guides.rubyonrails.org/security.html#custom-credentials>

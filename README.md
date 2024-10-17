# Projeto C2S_Task_Management

Este é um projeto de gerenciamento de tarefas simples em Ruby on Rails.
Abaixo estão as instruções para configurar o ambiente, instalar as dependências e acessar a documentação das APIs.

## Requisitos

- **Ruby** 2.7.5 (linguagem de programação usada)
- **Rails** 7.0.8 (framework web usado)
- **MySql** (banco de dados usado)
- **Docker e Docker Compose** (opcional, mas recomendado para gerenciamento de ambiente)
- **Node.js e Yarn** (para gerenciamento de pacotes de front-end)

## Instalação

1. **Instale as dependências:**

   ```bash
   bundle install
   yarn install
   ```

2. **Configure o banco de dados:**

   Crie e migre o banco de dados PostgreSQL:

   ```bash
   rails db:create
   rails db:migrate
   ```

3. **Configure o arquivo `.env`:**

   Crie um arquivo `.env` na raiz do projeto com a seguinte chave:

   ```
   SECRET_KEY_BASE=<sua_chave_secret_key_base>
   ```

   A chave `SECRET_KEY_BASE` será usada para permitir a integração com os outros projetos. Para gerar uma chave, você pode usar o seguinte comando:

   ```bash
   rails secret
   ```

   Copie o valor gerado e cole no arquivo `.env`.

4. **Configure o arquivo `.env`:**

   Altere um arquivo `.env` na raiz do projeto com a seguinte chave:

   ```
   URL_MS_AUTH=http://localhost:3001
   ```
   A chave `URL_MS_AUTH` será usada para acessar as APIs do microserviço de autenticação.
   ```
   URL_MS_NOTIFICATION=http://localhost:3002
   ```
   A chave `URL_MS_NOTIFICATION` será usada para acessar as APIs do microserviço de notificação.
   ```
   URL_MS_SCRAPING=http://localhost:3003
   ```
   A chave `URL_MS_SCRAPING` será usada para acessar as APIs do microserviço de web scraping.

## Executando o Servidor
1. Clonando os Microserviços

Para rodar o sistema com os microserviços, você precisa clonar os repositórios de cada um dos microserviços. Siga os comandos abaixo para clonar todos eles:

```bash
# Clonar o repositório principal (Task Management)
git clone https://github.com/usuario/c2s_task_management.git
```
```bash
# Clonar o microserviço de autenticação (Auth Service)
git clone https://github.com/usuario/c2s_auth.git
```
```bash
# Clonar o microserviço de notificações (Notification Service)
git clone https://github.com/usuario/c2s_notification.git
```
```bash
# Clonar o microserviço de scraping (Scraping Service)
git clone https://github.com/usuario/c2s_scraping.git
```

2. Executando o Docker

Depois de clonar todos os repositórios, você pode rodar todos os serviços juntos com o Docker. Navegue até o diretório do projeto principal c2s_task_management e execute o comando abaixo para levantar os serviços:

```bash
# Acesse o diretório do projeto principal
cd c2s_task_management
```
``` bash
# Construa e suba os containers usando Docker Compose
docker-compose up --build
```
Esse comando irá:

Construir as imagens Docker para cada um dos microserviços.
Subir os containers para task_management, auth, notification, e scraping.
3. Acessando os Serviços

Depois de executar o comando docker-compose up, você pode acessar os serviços nos seguintes endpoints:

```
Task Management: http://localhost:3000
Auth Service: http://localhost:3001
Notification Service: http://localhost:3002
Scraping Service: http://localhost:3003
```
Certifique-se de que o Docker está corretamente instalado na sua máquina para executar os comandos acima.

Acesse o aplicativo no navegador em `http://localhost:3000`.

## Documentação das APIs

A documentação das APIs do projeto pode ser acessada através do Swagger. O Swagger está configurado para exibir as rotas e os métodos das APIs em uma interface amigável.

1. **Acesse a documentação em:**

   ```
   http://localhost:3000/api-docs
   ```

   Aqui, você encontrará todas as rotas da API disponíveis, incluindo os endpoints dos microserviços de autenticação, notificações e web scraping.

2. **Testes e Desenvolvimento:**

   Durante o desenvolvimento, você pode adicionar ou atualizar os endpoints, e a documentação será atualizada automaticamente.

## Testes

O projeto inclui testes para os microserviços e funcionalidades internas. Para rodar os testes, execute:

```bash
rspec
```

## Contribuição

Se desejar contribuir com este projeto, siga estas etapas:

1. Faça um fork do repositório
2. Crie uma nova branch (`git checkout -b feature/sua-feature`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`)
4. Envie sua branch (`git push origin feature/sua-feature`)
5. Abra um Pull Request

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

---

Se precisar de mais detalhes ou ajustes, estou à disposição!
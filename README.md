
# Tech Challenge Stone

O principal propósito por trás de um arquivo readme num repositório do GitHub é apresentar a ferramenta a um possível novo contributor e servir de guia de referência para um contributor regular. Poucas coisas são necessárias para alcançar isso, as quais estão listadas abaixo. Adições ao arquivo são sempre bem-vindas, mas estamos atentos para que o documento não fique muito bagunçado e desorganizado.

Repositorio para apresentar solução ao teste proposta pelo # **[tech-challenge](https://github.com/stone-payments/tech-challenge)** da stone pagamentos. Utilizando Elixir para o desenvolvimento da plataforma.

## [](https://github.com/stone-payments/stoneco-best-practices/blob/master/readme/README_pt.md#o-projeto)O projeto:

### [](https://github.com/stone-payments/stoneco-best-practices/blob/master/readme/README_pt.md#plataforma)Plataforma

A plataforma foi desenvolvida utilizando Elixir + Phoenix Framework, além da biblioteca javascript React para criação de componentes dinâmicos. Tem como principal objetivo a criação de "contas" para usuários e operações de transferências e conversão de moedas.

## [](https://github.com/stone-payments/stoneco-best-practices/blob/master/readme/README_pt.md#depend%C3%AAncias)Dependências

	Elixir >= 1.6.4
	Phoenix Framework >= 1.4
	PostgreSQL >= 9.0

	Instalação Elixir: https://elixir-lang.org/install.html
	Instalação Phoenix Framework: https://hexdocs.pm/phoenix/installation.html
	
-   [EctoSql](https://github.com/elixir-ecto/ecto_sql)  - SQL-based adapters for Ecto and database migrations.
-   [Postgrex](https://github.com/elixir-ecto/postgrex)  - PostgreSQL driver for Elixir.
-   [Httpotion](https://github.com/myfreeweb/httpotion)  - HTTP client for Elixir.
-   [Poison](https://github.com/devinus/poison)  - An incredibly fast, pure Elixir JSON library.
-   [Phoenix](https://github.com/phoenixframework/phoenix)  - A productive web framework that does not compromise speed or maintainability.
-   [React](https://github.com/facebook/react) - A declarative, efficient, and flexible JavaScript library for building user interfaces.
-   [Tailwindcss](https://github.com/tailwindcss/tailwindcss)  - A utility-first CSS framework for rapid UI development.

## [](https://github.com/stone-payments/stoneco-best-practices/blob/master/readme/README_pt.md#como-come%C3%A7ar)Como Começar

### Atualizar Dependências

```
mix deps.get
cd apps/financial_system_web/assets && yarn && node node_modules/webpack/bin/webpack.js --mode development && cd ../../..
```

### Banco de dados

Alterar configurações de banco no arquivo /config/dev.exs:

```
 config :app, APP.Repo,
	username:  "user",
	password:  "password",
	database:  "app_dev",
	hostname:  "localhost",
	pool_size:  10
```
### Criar Banco de Dados

```
mix ecto.create

```
### Migrações Banco de Dados

```
mix ecto.migrate

```

### Semear Banco de Dados

```
cd apps/financial_system_web && mix run priv/repo/seeds.exs && cd ../..
```

### Iniciar Servidor

```
mix phx.server
```
### [](https://github.com/stone-payments/stoneco-best-practices/blob/master/readme/README_pt.md#lan%C3%A7amentos-principais)Lançamentos Principais

- Cadastro e gerenciamento de Contas
- Transferências entre contas
- Conversor de moedas

## License

[![License](https://camo.githubusercontent.com/107590fac8cbd65071396bb4d04040f76cde5bde/687474703a2f2f696d672e736869656c64732e696f2f3a6c6963656e73652d6d69742d626c75652e7376673f7374796c653d666c61742d737175617265)](http://badges.mit-license.org/)

-   **[MIT license](http://opensource.org/licenses/mit-license.php)**
-   Copyright 2019 ©  [Nelson junior](http://github.com/juniornelson123).

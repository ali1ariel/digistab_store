# Digistab Store

Um sistema de vendas digitais com inserção, edição e visualização de produtos.

a mesma aplicação se encontra online em:

```
a definir 
```

## Inicializando

### Pré-requisitos
```
  * Elixir 1.13
  * Erlang
  * Postgres
```

### First Run
Para iniciar a aplicação é necessário:

  * Instalar as dependências com `mix deps.get`
  * criar e migrar o banco de dados com `mix ecto.setup`
  * Para iniciar de fato a aplicação pode-se utilizar o comando `mix phx.server` ou `iex -S mix phx.server`, este último rodando um terminal Iex em conjunto.


A partir do browser acesse:
[`localhost:4000/products`](http://localhost:4000/products) 

### Já implementado:

* Criação de produtos, com utilização de campos e componentes LiveView.

* Visualização dos produtos, podendo organizá-los em Status ou Categoria.

* Início de uma versão responsiva, onde é possível visualizar os produtos de forma fácil no aparelho móvel.

### Bugs conhecidos:
* A integração com um editor WYSIWYG é feita através de Hooks JS, no momento não foi possível carregar os dados já salvos da descrição do produto para editar no próprio editor. porém é possível escrever uma informação do zero para substituí-la.

* O componente de form renderiza maior do que a tela no mobile, necessitando um aperfeiçoamento.



Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

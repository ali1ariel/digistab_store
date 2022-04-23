# Digistab Store

Um sistema de vendas digitais com inserção, edição e visualização de produtos.

a mesma aplicação se encontra online em: <b>[https://www.alissonmachado.social/products](https://www.alissonmachado.social/products)</b>
<br/><br/>

## Inicializando
<br/>

### Pré-requisitos
```
  * Elixir 1.13
  * Erlang
  * Postgres
```
<br/>

### First Run
Para iniciar a aplicação é necessário:

  * Instalar as dependências com `mix deps.get`
  * criar e migrar o banco de dados com `mix ecto.setup`
  * Para iniciar de fato a aplicação pode-se utilizar o comando `mix phx.server` ou `iex -S mix phx.server`, este último rodando um terminal Iex em conjunto.


A partir do browser acesse:
[`localhost:4000/products`](http://localhost:4000/products) 

### Implementado:

* Criação de produtos, com utilização de campos e componentes LiveView. Onde é possível anexar até 5 arquivos.

* Visualização dos produtos, podendo organizá-los em Status ou Categoria e ainda buscar pelo nome do produto, e também há 2 modos de visualização dos produtos: 
  * Lista: É possível ordenar os itens por nome, status ou categoria.
  * Grid: É possível visualizar com mais detalhes os itens como a sua descrição.

* Visualização de cada produto: É possível visualizar individualmente cada produto clicando no mesmo, nesta tela é possível navegar entre as imagens, e também visualizar cada uma das tags. Aqui é possível deletar o produto sem problemas. Sobre edição leia Bugs Conhecidos.

### Componentes LiveView interagíveis:
* Tela inicial
  * É possível filtrar os produtos com base na categoria e no status, através da coluna de filtragem.
  * Campo de busca em tempo real aos produtos.
  * Botão de alteração entre o modo Lista e Grid de visualização de produtos.
  * No modo lista é possível selecionar os produtos, e deletar em lote também. 
    * Foi optado por remover os produtos apenas da lista de visualização, ao recarregar a página o produto retorna a lista, não se trata de um erro e sim de uma escolha para facilitar os testes. Para deletar de verdade um produto, delete na tela de visualização do mesmo.

* Criação de produto:  
  * Na tela de criação a seleção de Status, Categoria e Tags são feitas através de LiveView. As imagens podem ser anexadas pelo botão de busca ou arrastando as mesmas até o componente.
  
### Bugs conhecidos:
* Formulário de Edição:
  * A integração com um editor WYSIWYG é feita através de Hooks JS, no momento não foi possível carregar os dados já salvos da descrição do produto para editar no próprio editor. porém é possível escrever uma informação do zero para substituí-la.
  * O sistema não carrega automaticamente as fotos já obtidas nos produtos, algo simples de ser implementado, mas fica para atualização futura.
  
### Outros:
  * Foi iniciada a implementação de um modo responsivo, porém não foi o foco deste lançamento, pelo celular é possível realizar todas as ações consntantes aqui porém com grande quantidade de problemas visuais, caso deseje testar, a melhor opção é listar os produtos em grid.
    * O formulário de criação utiliza um modal que ultrapassa as dimensões da tela mobile, funciona, mas não é o mais adequado.

### Deploy:
  * O deploy foi realizado em uma máquina virtual do Google Cloud, utilizando docker-compose. 

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

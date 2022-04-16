[
  %{
    name: "Quarto",
    description: "Móveis para o conforto do seu quarto."
  },
  %{
    name: "Cozinha",
    description: "Utensílios para ajudar nas suas refeições."
  },
  %{
    name: "Limpeza",
    description: "Produtos para deixar sua casa limpa e perfumada."
  },
  %{
    name: "Decoração",
    description: "Enfeites para deixar a sua casa mais linda que nunca."
  },
]
|> Enum.map(&DigistabStore.Store.create_category/1)

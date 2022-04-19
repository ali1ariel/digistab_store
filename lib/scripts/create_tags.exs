[
  %{
    name: "limitado",
    description: "Produtos limitados, é de quem chegar primeiro!"
  },
  %{
    name: "promoção",
    description: "Produtos com preços imperdíveis."
  },
  %{
    name: "frágil",
    description: "Produtos frágeis, para ter cuidado."
  },
  %{
    name: "destaque",
    description: "Produtos em área de destaque no site."
  },
  %{
    name: "presentes",
    description: "Coleção de produtos perfeitos para presentear."
  }
]
|> Enum.map(&DigistabStore.Store.create_tag/1)

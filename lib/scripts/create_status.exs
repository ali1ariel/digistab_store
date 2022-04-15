[
  %{
    name: "Ativo",
    description: "O produto estará visível e disponível para compra."
  },
  %{
    name: "Rascunho",
    description:
      "O produto não será disponibilizado após salvar, podendo ser feito posteriormente."
  },
  %{
    name: "Desativado",
    description: "O produto está atualmente indisponível."
  }
]
|> Enum.map(&DigistabStore.Store.create_status/1)

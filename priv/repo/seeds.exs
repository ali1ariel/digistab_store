alias DigistabStore.Store.Product

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
] |> Enum.map(&DigistabStore.Store.create_status/1)


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
  }
] |> Enum.map(&DigistabStore.Store.create_category/1)


[{:ok, tag1}, {:ok, tag2}, {:ok, tag3}, {:ok, tag4}, {:ok, tag5}] = [
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
] |> Enum.map(&DigistabStore.Store.create_tag/1)

[{:ok, product1}, {:ok, product2}, {:ok, product3}, {:ok, product4}] = [
  %{
    "name" => "Ovo de pascoa ben 10 80G delicce",
    "description" => "Ovo de pascoa ben 10 80G delicce ovo ben 10 80G delicce",
    "price" => 1999,
    "quantity" => 5,
    "media" => ["https://images-americanas.b2w.io/produtos/32030780/imagens/ovo-de-pascoa-ben-10-80g-delicce/32030780_1_xlarge.jpg", "https://images-americanas.b2w.io/produtos/32030780/imagens/ovo-de-pascoa-ben-10-80g-delicce/32030780_2_xlarge.jpg"],
    "status" => DigistabStore.Store.list_status() |> List.first(),
    "category" => DigistabStore.Store.list_categories() |> List.first(),
  },

  %{
    "name" => "Tablete de Chocolate ao Leite com Ovomaltine 87g - Hersheys",
    "description" => "A vida é muito melhor com chocolate! Delicioso chocolate ao leite Hersheys com Ovomaltine. Alimento com extrato de cereal (cevada e malte) sabor chocolate. Peso Líquido 87g.",
    "price" => 499,
    "quantity" => 9,
    "media" => ["https://images-americanas.b2w.io/produtos/50983211/imagens/tablete-de-chocolate-ao-leite-com-ovomaltine-87g-hersheys/50983209_1_xlarge.jpg", "https://www.havan.com.br/media/catalog/product/cache/73a52df140c4d19dbec2b6c485ea6a50/t/a/tablete-hersheys-de-ovomaltine_322228.jpg"],
    "status" => DigistabStore.Store.list_status() |> List.last(),
    "category" => DigistabStore.Store.list_categories() |> List.last(),
  },
  %{
    "name" => "Caixa de Bombom Garoto 250g",
    "description" => "A Caixa de Bombom Garoto - é um presente que encanta aos olhos, uma surpresa e uma troca de carinho. Para qualquer momento e qualquer lugar, possui uma diversidade de sabores que agradam a todos os gostos.",
    "price" => 999,
    "quantity" => 25,
    "media" => ["https://images-americanas.b2w.io/produtos/01/00/img/1417116/1/1417116105_1GG.jpg", "https://www.carone.com.br/media/catalog/product/cache/1/image/580x580/9df78eab33525d08d6e5fb8d27136e95/1/3/132918_1_1.jpg", "https://a-static.mlcdn.com.br/1500x1500/caixa-bombom-250g-garoto/magazinetambem/7766312aba7911eba3864201ac18500e/c376d18e5e7e0f82f8c7797b7be18171.jpg", "https://d3ddx6b2p2pevg.cloudfront.net/Custom/Content/Products/10/83/1083845_bombom-garoto-sortido-250g_m4_637534037046871030.jpg", "https://zonasul.vtexassets.com/arquivos/ids/3065093/VF4qT-qqCUAAAAAAAAK3cw.jpg?v=637794351451730000"],
    "status" => DigistabStore.Store.list_status() |> List.first(),
    "category" => DigistabStore.Store.list_categories() |> List.last(),
  },
  %{
    "name" => "Tablet Samsung Galaxy S6 Lite 64GB Wi-Fi 4G Tela 10.4\" Android Octa-Core - Cinza",
    "description" => "O novo Galaxy Tab S6 Lite é o seu companheiro de anotações super portátil. Com uma tela grande de 10,4 polegadas em um design fino e leve. One UI 2 no Android, S Pen ergônomica e capa protetora inclusas e prontas para uso. O Tablet perfeito para mudar o seu jeito de aprender, criar, ver o mundo e se divertir.",
    "price" => "129990",
    "quantity" => 3,
    "media" => ["https://images-americanas.b2w.io/produtos/01/00/img/1720331/8/1720331801_1GG.jpg", "https://images.samsung.com/is/image/samsung/br-galaxy-tab-s6-lite-p615-sm-p615nzavzto-frontgray-249168448?$720_576_PNG$", "https://cdn.pocket-lint.com/r/s/1200x/assets/images/152213-tablets-review-samsung-galaxy-tab-s6-lite-review-image133-f96hb1xqji.jpg", "https://images.samsung.com/is/image/samsung/br-galaxy-tab-s6-lite-p615-sm-p615nzavzto-dynamicgray-249168417?$PD_GALLERY_JPG$"],
    "status" => DigistabStore.Store.list_status() |> List.last(),
    "category" => DigistabStore.Store.list_categories() |> List.first(),
  }
] |> Enum.map(&DigistabStore.Store.create_product(%Product{}, &1))

DigistabStore.Store.assoc_product_tag(product1, tag1)
DigistabStore.Store.assoc_product_tag(product2, tag2)
DigistabStore.Store.assoc_product_tag(product3, tag3)
DigistabStore.Store.assoc_product_tag(product1, tag2)
DigistabStore.Store.assoc_product_tag(product2, tag4)
DigistabStore.Store.assoc_product_tag(product3, tag1)
DigistabStore.Store.assoc_product_tag(product1, tag4)
DigistabStore.Store.assoc_product_tag(product2, tag5)
DigistabStore.Store.assoc_product_tag(product3, tag3)

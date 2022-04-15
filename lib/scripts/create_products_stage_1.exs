products = [
  %{
    name: "Ovo de pascoa ben 10 80G delicce",
    description: "Ovo de pascoa ben 10 80G delicce ovo ben 10 80G delicce",
    price: 1999,
    quantity: 5,
    media:
      "https://images-americanas.b2w.io/produtos/32030780/imagens/ovo-de-pascoa-ben-10-80g-delicce/32030780_1_xlarge.jpg"
  },
  %{
    name: "Tablete de Chocolate ao Leite com Ovomaltine 87g - Hersheys",
    description:
      "A vida é muito melhor com chocolate! Delicioso chocolate ao leite Hersheys com Ovomaltine. Alimento com extrato de cereal (cevada e malte) sabor chocolate. Peso Líquido 87g.",
    price: 499,
    quantity: 9,
    media:
      "https://images-americanas.b2w.io/produtos/50983211/imagens/tablete-de-chocolate-ao-leite-com-ovomaltine-87g-hersheys/50983209_1_xlarge.jpg"
  },
  %{
    name: "Caixa de Bombom Garoto 250g",
    description:
      "A Caixa de Bombom Garoto - é um presente que encanta aos olhos, uma surpresa e uma troca de carinho. Para qualquer momento e qualquer lugar, possui uma diversidade de sabores que agradam a todos os gostos.",
    price: 999,
    quantity: 25,
    media: "https://images-americanas.b2w.io/produtos/01/00/img/1417116/1/1417116105_1GG.jpg"
  },
  %{
    name: "Tablet Samsung Galaxy S6 Lite 64GB Wi-Fi 4G Tela 10.4\" Android Octa-Core - Cinza",
    description:
      "O novo Galaxy Tab S6 Lite é o seu companheiro de anotações super portátil. Com uma tela grande de 10,4 polegadas em um design fino e leve. One UI 2 no Android, S Pen ergônomica e capa protetora inclusas e prontas para uso. O Tablet perfeito para mudar o seu jeito de aprender, criar, ver o mundo e se divertir.",
    price: "129990",
    quantity: 3,
    media: "https://images-americanas.b2w.io/produtos/01/00/img/1720331/8/1720331801_1GG.jpg"
  }
]

Enum.map(products, &DigistabStore.Store.create_product/1)

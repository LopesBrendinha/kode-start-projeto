# Desafio Técnico – Kode Start 2025 🚀

Este repositório contém a solução do desafio técnico proposto pela Kobe Apps para o programa **Kode Start 2025**. O desafio consiste no desenvolvimento de um aplicativo Flutter que consome a API REST pública de **Rick and Morty**, apresentando uma listagem de personagens, seus detalhes e aplicando boas práticas de desenvolvimento mobile.

---

## 📱 Funcionalidades

- Listagem de personagens com nome e imagem.
- Tela de detalhes com mais informações do personagem selecionado.
- Navegação entre telas.
- Tratamento de erros e carregamento.
- Consumo de API REST com parsing de JSON.
- Responsividade e usabilidade amigável.

---

## 🧠 Decisões Técnicas e Justificativas

### 🌐 Arquitetura - MVC (Model-View-Controller)
Optei por utilizar o padrão **MVC** pela sua clareza na separação de responsabilidades:

- **Model:** Responsável por representar os dados (ex: `CharacterModel`).
- **View:** Interface com o usuário, implementada com `Widgets` declarativos.
- **Controller:** Lógica de negócio e mediação entre modelo e visualização.

Essa estrutura torna o código mais organizado, reutilizável e de fácil manutenção — facilitando testes, leitura e escalabilidade.

### 📡 Requisições HTTP
Utilizei o pacote `http` para realizar chamadas REST à API do Rick and Morty, por ser leve, simples e suficiente para este desafio.

### 🛠️ Gerenciamento de Estado
O estado foi mantido simples (com `setState`) devido à natureza do desafio e foco em boas práticas fundamentais. Em projetos maiores, considero o uso de soluções como `Provider` ou `Riverpod`.

### 📄 Organização do Projeto
O projeto foi dividido em pastas conforme o padrão MVC:

lib/
│
├── models/
│ └── character_model.dart
├── controllers/
│ └── character_controller.dart
├── views/
│ ├── home_page.dart
│ └── character_detail_page.dart
├── services/
│ └── api_service.dart
└── main.dart


Essa divisão visa facilitar a manutenção, entendimento e escalabilidade do projeto.

---

## 📋 Avaliação e Qualidade da Entrega

Busquei garantir uma **entrega completa e bem documentada**, conforme orientações recebidas:

- Código limpo e legível, com nomes de variáveis e métodos autoexplicativos.
- Comentários nos pontos importantes das decisões de lógica.
- Projeto funcional e testado.
- README explicativo com arquitetura, decisões técnicas e estrutura do projeto.

---

## 🔧 Tecnologias Utilizadas

- **Flutter** 3.x
- **Dart**
- **API REST** pública [Rick and Morty API](https://rickandmortyapi.com/)
- **http** package
- **MVC** como padrão arquitetural

---

## 📸 Capturas de Tela

> Adicione aqui prints do app em funcionamento, tanto da tela de listagem quanto da tela de detalhes, para ilustrar a entrega visualmente.

---

## 📌 Observações Finais

Estou extremamente entusiasmada com essa oportunidade na Kobe Apps. Desenvolver esse desafio foi uma experiência muito enriquecedora, pois pude aplicar meus conhecimentos em Flutter, reforçar conceitos de arquitetura e boas práticas de desenvolvimento mobile.

Além disso, admirei muito a proposta do desafio em valorizar não só o código, mas também a clareza das decisões e o cuidado com a entrega. Isso me incentivou a buscar uma entrega mais fundamentada e alinhada com um ambiente profissional real.

---

## ✨ Autora

**Brenda Lopes Levandoski**  
Estudante de Ciência da Computação – UNICENTRO  
Flutter | Frontend | UI/UX | Firebase  
[LinkedIn](https://www.linkedin.com/in/brenda-lopes-levandoski/) | [GitHub](https://github.com/lopesbrendinha)

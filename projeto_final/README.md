# Desafio Técnico – Kode Start 2025 🚀

Este repositório contém a solução do desafio técnico proposto pela Kobe Apps para o programa **Kode Start 2025**. O desafio consiste no desenvolvimento de um aplicativo Flutter que consome a API REST pública de **Rick and Morty**, apresentando uma listagem de personagens, seus detalhes e aplicando boas práticas de desenvolvimento mobile.

---

## 📱 Funcionalidades Implementadas

### ✅ Funcionalidades Obrigatórias (Fidelidade ao Figma)

#### 🎯 Navegação e Exibição dos Personagens

- A lista permite navegação contínua por meio de scroll, facilitando o acesso a todos os personagens.
- Cada card exibe o nome e a imagem do personagem seguindo fielmente o design do Figma, com a tipografia replicada exatamente, além do posicionamento preciso da imagem no card e o espaçamento adequado entre os elementos e o tamanho dos mesmo, para manter a harmonia visual do layout original.
- Os cards são organizados verticalmente, proporcionando uma rolagem suave e intuitiva.

![HomePage](../Imgs&Gifs/Home.gif)

#### 🔍 Tela de Detalhes do Personagem

- Apresenta o nome, a imagem, a espécie, o gênero, o status, a origem, a última localização e a primeira aparição do personagem.
- A imagem fica sobreposta ao card, exatamente como no layout do Figma, garantindo uma aparência fiel ao design original.
- O status do personagem é indicado por um circulo colorido: verde quando está vivo, vermelho se estiver morto e cinza quando o status é desconhecido.
- Todas as informações são exibidas de forma clara e organizada, seguindo fielmente o design do Figma, com tipografia replicada exatamente, incluindo estilos como blalck, medium, regular e light, além do espaçamento preciso entre palavras e linhas, garantindo a mesma harmonia visual do projeto original.

![Card com Detalhes](../Imgs&Gifs/CardCharacter.gif)

#### 🔄 Navegação entre Telas

- Navegação fluida e intuitiva entre a lista de personagens e a tela de detalhes.
- Ao tocar em um card, o usuário é direcionado para a tela com informações detalhadas do personagem.
- Transições suaves mantêm a consistência visual e uma experiência agradável.
- Foi adicionada uma forma prática de voltar para a lista clicando no logo, facilitando a navegação.

![Navegacao](../Imgs&Gifs/Navegacao.gif)
---


### 💡 Recursos Extras

#### 🌅 Tela de Splash
- Implementação de uma splash screen elegante que aparece ao abrir o aplicativo.
- A tela inicial exibe a logo e uma img do tema do app, criando uma primeira impressão profissional.
- A splash screen tem duração controlada para garantir carregamento suave dos recursos.
- Essa funcionalidade contribui para uma experiência de usuário mais fluida e agradável desde o início.

![Tela de Splash](../Imgs&Gifs/SplashScreen.gif)

#### 🔍 Busca por Nome
- Permite pesquisar personagens digitando o nome completo ou apenas parte dele.
- O sistema retorna resultados em tempo real, facilitando a localização do personagem desejado.
- A busca é sensível a trechos do nome, tornando a experiência mais prática e eficiente.

![Pesquisa](../Imgs&Gifs/Navegacao.gif)


#### 🗂️ Filtro Avançado de Personagens
- Permite refinar a lista de personagens aplicando filtros combinados para facilitar a busca.
- Status: Filtra pelos estados Alive, Dead ou Unknown.
- Species: Mostra apenas personagens da espécie selecionada.
- Type: Exibe resultados de acordo com o tipo especificado.
- Gender: Filtra conforme o gênero escolhido.
- Os filtros podem ser utilizados junto com a busca por nome, seja parcial ou completa, tornando a localização dos personagens ainda mais rápida e precisa.

![Filtro](../Imgs&Gifs/Filtro.gif)

#### 📖 Telas de Introdução (Intro Pages)
- Apresenta um conjunto de páginas introdutórias que guiam o usuário ao abrir o app pela primeira vez.
- Cada página contém título, descrição e imagem ilustrativa, transmitindo as principais funcionalidades e propósitos do app.
- Possui navegação simples com botões para avançar, voltar ou pular a introdução a qualquer momento.
- Utiliza indicadores visuais para mostrar o progresso da navegação pelas páginas.
- Após finalizar a introdução, o usuário é redirecionado automaticamente para a tela de login, iniciando a experiência principal do app.

![IntroPages](../Imgs&Gifs/IntroPages.gif)

#### 🔐 Tela de Login e Cadastro

- **Login:** Permite autenticação do usuário via email e senha com integração ao Firebase Authentication, além de login social com Google. Inclui campos com controle para mostrar/ocultar senha, validação de entradas e mensagens claras de erro. Após login bem-sucedido, redireciona para a HomePage e salva dados no Firestore. A interface é responsiva, multilíngue e mantém consistência visual com o app.

- **Cadastro:** Permite criar nova conta com nome, email, senha e foto de perfil opcional, escolhida da galeria e convertida para base64 para armazenamento seguro no Firestore. Realiza validações e exibe mensagens de erro amigáveis. Durante o cadastro, apresenta diálogo de progresso e confirma sucesso com alerta. Inclui controle para mostrar/esconder senha e adapta cores para modo claro/escuro, garantindo uma experiência fluida para novos usuários.

![LoginPage&SignupPage](../Imgs&Gifs/Login&Cadastro.gif)  

#### 🌐 Internacionalização, Troca de Tema e Navigation Drawer

- **Troca de Linguagem:** O app suporta internacionalização com arquivos JSON para português (pt_BR) e inglês (en_US), permitindo alternar facilmente entre os idiomas. A troca é feita de forma dinâmica, atualizando todos os textos da interface sem reiniciar o app, garantindo acessibilidade para usuários de diferentes idiomas.

- **Troca de Tema:** Implementa um sistema de tema claro e escuro gerenciado pelo `ThemeController`. O usuário pode alternar entre os temas via um switch no menu lateral, e a interface responde instantaneamente às mudanças, mantendo a consistência visual e melhorando a experiência conforme a preferência do usuário. Importante destacar que a troca não foi implementada da maneira tradicional, pois ao usar o Material 3, há uma leve alteração automática no tom das cores, o que exige cuidados para manter a harmonia visual desejada no app.

- **NavigationDrawerComponent:** O menu lateral é um componente personalizado que oferece navegação rápida e organizada. Exibe foto e email do usuário (carregados do Firestore), controles para alternar tema e idioma, além de botão para logout integrado ao Firebase Auth. Utiliza `Provider` para gerenciamento reativo do estado e adapta o visual conforme o tema ativo, garantindo usabilidade e manutenção facilitadas.

![NavigationDrawer](../Imgs&Gifs/Theme&language.gif)

#### 👤 Tela de Perfil e Favoritos

- Exibe as informações do usuário autenticado, email e foto de perfil (armazenada em base64 no Firestore), garantindo uma experiência personalizada.   
- A interface adapta-se aos modos claro e escuro, mantendo a consistência visual. Também apresenta indicadores de carregamento e tratamento de erros para garantir uma navegação fluida e confiável.  
- Lista os personagens favoritos do usuário em uma seção expansível, onde os favoritos são marcados com um ícone de coração nos cards exibidos na HomePage ou na tela de detalhes.  
- Ao favoritar um personagem, ele é salvo no Firestore associado ao usuário autenticado. Na tela de perfil, esses personagens favoritos aparecem organizados em uma lista expansível, permitindo que o usuário visualize rapidamente seus favoritos e acesse os detalhes com facilidade.  
- Essa funcionalidade oferece uma experiência personalizada e mantém o usuário engajado com seus personagens preferidos.

![NavigationDrawer](../Imgs&Gifs/TelaPerfil.gif)


---

## 🧠 Decisões Técnicas e Justificativas

### 🌐 Arquitetura - MVC (Model-View-Controller)
Optei por utilizar o padrão **MVC** pela sua clareza na separação de responsabilidades e também foi o padrão que mais estudei:

- **Model:** Responsável por representar os dados (ex: 'detailed_character.dart').
- **View:** Interface com o usuário, implementada com `Widgets` declarativos.
- **Controller:** Lógica de negócio e mediação entre model e view.

Essa estrutura torna o código mais organizado, reutilizável e de fácil manutenção, assim facilitando testes, leitura e escalabilidade.

### 📡 Requisições HTTP
Utilizei o pacote `http` para realizar chamadas REST à API do Rick and Morty, por ser leve, simples e foi o método que estudei na faculdade, assim estava mais familiarizado com ele.

### 🛠️ Gerenciamento de Estado
O estado foi mantido simples (com `setState`) devido à natureza do desafio, que prioriza boas práticas fundamentais. Essa abordagem também foi utilizada no meu TCC, o que torna mais natural e eficiente para eu aplicá-la neste projeto.

### 📄 Organização do Projeto
O projeto foi dividido em pastas conforme o padrão MVC:

<pre style="background:#f5f5f5; padding:10px; border-radius:5px; font-family: monospace;">
projeto_final/
├── assets/
│   ├── fonts/
│   ├── imgs/
│   └── i18n/
│   
├── lib/
│   │
│   ├── components/
│   │   ├── appbar_component.dart
│   │   ├── card_character_component.dart
│   │   ├── detailed_character_card_component.dart
│   │   └── navigation_drawer_component.dart
│   │
│   ├── models/
│   │   ├── detailed_character.dart
│   │   ├── detailed_episode.dart
│   │   └── paginated_characters.dart
│   │
│   ├── controllers/
│   │   ├── rickandmorty_controller.dart
│   │   ├── theme_controller.dart
│   │   └── character_controller.dart
│   │
│   ├── views/
│   │   ├── details_page.dart
│   │   ├── home_page.dart
│   │   ├── intro_pages.dart
│   │   ├── login_page.dart
│   │   ├── profile_page.dart
│   │   ├── signup_page.dart
│   │   └── splash_page.dart
│   │
│   ├── theme/
│   │   ├── app_colors.dart
│   │   └── app_images.dart
│   │
│   └── main.dart
└── pubspec.yaml
</pre>


Essa divisão visa facilitar a manutenção, entendimento e escalabilidade do projeto.

---

### 🔍 Explicação das Camadas do Projeto

O projeto segue o padrão **MVC (Model-View-Controller)**, garantindo separação clara de responsabilidades. Abaixo, a descrição de cada camada:

---

#### **assets/**  
- **fonts/**  
  Contém as fontes usadas no projeto, seguindo o padrão visual do Figma:  
  `Lato-Black.ttf`, `Lato-Light.ttf`, `Lato-Medium.ttf` e `Lato-Regular.ttf`.  
  Isso assegura consistência e fidelidade ao design.

- **i18n/**  
  Arquivos de tradução para suporte multilíngue, com `en_US.json` e `pt_BR.json`.  
  Facilita a adaptação do app para diferentes idiomas.

- **imgs/**  
  Centraliza todas as imagens do projeto, como ícones, logos e recursos visuais.

---

#### **lib/components/**  
Contém componentes reutilizáveis (widgets customizados) para manter o código organizado e consistente.

- **appbar_component.dart**  
  Componente da AppBar customizada que adapta ícones, funcionalidades e tema conforme a tela.  
  Integra tradução e mantém a identidade visual em todas as páginas.

- **card_character_component.dart**  
  Exibe um card simples com nome e imagem do personagem. Usa widgets nativos para sombra, bordas e interatividade.

- **detailed_character_card_component.dart**  
  Card detalhado com imagem, nome, status, espécie, gênero, origem e localização.  
  Carrega dados assíncronos (ex: episódios) e adapta-se ao tema claro/escuro.

- **navigation_drawer_component.dart**  
  Menu lateral com foto e email do usuário (carregados do Firestore), opções de tema, idioma e logout.  
  Utiliza gerenciamento de estado e suporte a temas para melhor experiência.

---

#### **lib/models/**  
Modelos de dados que representam as entidades da aplicação, facilitando manipulação e integração com APIs.

- **detailed_character.dart**  
  Representa detalhes completos do personagem, incluindo atributos e métodos de serialização JSON.

- **detailed_episode.dart**  
  Representa episódios com dados como nome, data, código e personagens relacionados.

- **paginated_characters.dart**  
  Estrutura para lidar com respostas paginadas da API, organizando dados e paginação.

---

#### **lib/controllers/**  
Controladores que gerenciam a lógica do app, comunicação com API e estado.

- **rickandmorty_controller.dart**  
  Faz requisições à API Rick and Morty, buscando personagens, detalhes e episódios.  
  Trata dados e os converte para modelos do app.

- **theme_controller.dart**  
  Gerencia o estado do tema (claro/escuro) com notificação reativa para atualização da UI.

- **character_controller.dart**  
  Controla operações CRUD de personagens no Firestore, vinculados ao usuário autenticado.

---

#### **lib/views/**  
Telas do app que compõem a interface e experiência do usuário.

- **details_page.dart**  
  Exibe detalhes completos de um personagem, permite favoritar, e trata carregamento e erros.  
  Usa FutureBuilder para dados assíncronos e adapta visual ao tema.

- **home_page.dart**  
  Lista paginada de personagens com busca, filtros e scroll infinito. Navega para detalhes ao tocar em cards.

- **intro_pages.dart**  
  Tela de introdução com páginas informativas, usando pacote IntroductionScreen e suporte a múltiplos idiomas.

- **login_page.dart**  
  Tela de login com autenticação via email/senha e Google, integração com Firebase Auth e Firestore.

- **profile_page.dart**  
  Mostra informações do usuário e lista personagens favoritos, adaptando visual e tratando estados de carregamento.

- **signup_page.dart**  
  Tela para cadastro de usuário, com validações, upload opcional de foto e feedback visual.

- **splash_page.dart**  
  Tela inicial com logo e animação, navegando automaticamente para as intro pages após 3 segundos.

---

#### **lib/theme/**  
Centraliza as definições visuais do app.

- **app_colors.dart**  
  Define as paletas de cores para temas claro e escuro, facilitando a manutenção e consistência visual.

- **app_images.dart**  
  Centraliza os caminhos dos recursos gráficos, evitando strings espalhadas no código e facilitando manutenção.


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

## 📌 Observações Finais

Estou extremamente entusiasmada com essa oportunidade na Kobe Apps. Desenvolver esse desafio foi uma experiência muito enriquecedora, pois pude aplicar meus conhecimentos em Flutter, reforçar conceitos de arquitetura e boas práticas de desenvolvimento mobile.

Além disso, admirei muito a proposta do desafio em valorizar não só o código, mas também a clareza das decisões e o cuidado com a entrega. Isso me incentivou a buscar uma entrega mais fundamentada e alinhada com um ambiente profissional real.

---

## ✨ Autora

**Brenda Lopes Levandoski**  
Estudante de Ciência da Computação – UNICENTRO  
Flutter | Frontend | UI/UX | Firebase  
[LinkedIn](https://www.linkedin.com/in/brenda-lopes-levandoski/) | [GitHub](https://github.com/lopesbrendinha)

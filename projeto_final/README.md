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

![Tela de Splash](Endereço da IMG)

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

O projeto segue o padrão MVC (Model-View-Controller), proporcionando uma melhor separação de responsabilidades. Abaixo está a explicação de cada camada:

#### **assets/**  
##### **fonts/** 
Pasta dedicada às fontes utilizadas no projeto, seguindo exatamente o padrão visual definido no Figma. Contém os arquivos Lato-Black.ttf, Lato-Light.ttf, Lato-Medium.ttf e Lato-Regular.ttf. A escolha e padronização das fontes reforçam a consistência visual e a fidelidade ao design original, além de manter a identidade visual coerente em toda a aplicação.

##### **i18n/**
Pasta responsável pela internacionalização do app, permitindo suporte a múltiplos idiomas. Contém os arquivos en_US.json e pt_BR.json, que armazenam as traduções em inglês e português, respectivamente.

##### **imgs/**
Pasta que reúne todas as imagens utilizadas no projeto, como ícones, logotipos e recursos visuais.

#### **lib/components/**
Pasta destinada a armazenar todos os componentes reutilizáveis da aplicação, como cards, botões, modais, app bars e outros widgets customizados. 

##### **appbar_component.dart**
Componente personalizado que constrói a AppBar do app utilizando o widget nativo AppBar do Flutter, garantindo compatibilidade e performance. Ajusta ícones, funcionalidades e estilo conforme o contexto da página e o tema (claro ou escuro). Integra tradução e recursos visuais centralizados para manter a identidade visual. Modular e reutilizável, facilita a manutenção e assegura uma experiência consistente para o usuário.

##### **card_character_component.dart**
Componente personalizado que exibe um card para personagens, usando o widget nativo Card do Flutter para estilização com sombra e bordas arredondadas. Contém uma imagem carregada via Image.network com tratamento de carregamento e erro, e o nome do personagem em destaque. Adapta cores conforme o tema (claro/escuro) usando AppColors. O InkWell envolve o card para detectar toques e executar ação. Modular, garante reaproveitamento e mantém padrão visual consistente, facilitando manutenção e experiência uniforme.

##### **detailed_character_card_component.dart**
Componente que exibe um card detalhado de personagem, usando o widget nativo Card do Flutter para estrutura visual com bordas arredondadas. Contém uma imagem no topo, informações como nome, status, espécie, localizações e gênero, além de um botão para favoritar com ícones dinâmicos. Usa FutureBuilder para carregar dados assíncronos de episódios, garantindo feedback visual durante o carregamento. Adapta cores e estilos conforme o tema (claro/escuro) usando AppColors. A modularidade facilita a manutenção, reutilização e melhora a experiência do usuário com uma interface rica e responsiva.

##### **navigation_drawer_component.dart**
Componente que implementa o menu lateral (Drawer) do app, utilizando o widget nativo Drawer do Flutter para navegação consistente. Exibe cabeçalho com foto do usuário (decodificada de Base64 via MemoryImage) e email, carregados de forma assíncrona do Firestore. Contém opções para alternar tema claro/escuro com Switch integrado ao ThemeController, trocar idioma via dropdown usando flutter_translate e botão para logout com integração Firebase Auth. O design responsivo ao tema escuro/claro e o uso de Provider para gerenciamento de estado garantem experiência fluida e manutenção facilitada.

#### **lib/models/**
Contém as classes que definem os modelos de dados do aplicativo, representando as entidades do domínio como personagens, localizações e origens. Cada model inclui atributos, métodos para serialização e desserialização JSON.

##### **detailed_character.dart**
Modelo que representa os detalhes completos de um personagem, encapsulando atributos como nome, status, espécie, gênero, origem e localização, além de URLs e episódios relacionados. Inclui métodos para serialização/deserialização JSON e mapeamento para facilitar integração com APIs externas. As classes auxiliares Origin e Location estruturam dados aninhados. Essa modelagem clara e robusta facilita o manuseio dos dados no app, garantindo coerência, fácil manutenção e alinhamento com o domínio do problema.

##### **detailed_episode.dart**
Modelo que representa um episódio, contendo atributos como nome, data de exibição, código do episódio, lista de personagens, URL e data de criação. Inclui métodos para conversão entre JSON e objeto, facilitando integração com APIs e manipulação dos dados no app. Essa modelagem contribui para a organização clara dos dados e manutenção eficiente da aplicação.

##### **paginated_characters.dart**
Modelo que representa uma resposta paginada de personagens, contendo informações de paginação (Info) e uma lista de resultados (Result). Essa estrutura facilita o consumo organizado de APIs que retornam dados paginados, promovendo clareza e robustez no manejo dos dados do app.

#### **lib/controllers/**
Agrupa os controladores responsáveis pela lógica de negócio do aplicativo, como a comunicação com APIs, manipulação de dados e controle de estado. Exemplos incluem rickandmorty_controller.dart, que gerencia chamadas à API externa e processamento dos dados recebidos, e theme_controller.dart, que controla o tema claro/escuro do app.

##### **rickandmorty_controller.dart**
Controlador responsável por interagir com a API pública Rick and Morty, executando buscas paginadas e filtradas de personagens, além de carregar detalhes específicos e dados de episódios via URLs. Utiliza requisições HTTP e trata respostas JSON para converter em objetos DetailedCharacter. Essa separação da lógica de acesso à API favorece o reaproveitamento, manutenção, e abstrai detalhes técnicos do consumo dos serviços externos, assegurando código mais limpo e testável.

##### **theme_controller.dart**
Controlador simples que gerencia o estado do tema do aplicativo (claro ou escuro) utilizando ChangeNotifier para notificar as mudanças. Fornece getter para o modo atual e método para alternar o tema, permitindo que widgets escutem e reajam às alterações. Essa abordagem garante um gerenciamento centralizado e reativo do tema, facilitando consistência visual e manutenção.

##### **character_controller.dart**
Controlador responsável por gerenciar as operações CRUD dos personagens armazenados no Firestore, vinculados ao usuário autenticado via Firebase Auth. Encapsula métodos para adicionar, deletar, buscar, atualizar e verificar existência de personagens, garantindo segurança ao validar propriedade pelo userId. Essa camada abstrai a complexidade do acesso a dados, facilitando manutenção, testes e garantindo integridade e segurança das operações no backend.

#### **lib/views/**
Agrupa as telas (pages) do aplicativo que compõem a interface visível ao usuário. Cada arquivo representa uma tela distinta, implementando a UI e a interação específicas para diferentes fluxos e funcionalidades do app. Essa separação por telas facilita a organização do projeto, melhora a legibilidade e torna o gerenciamento da navegação mais claro.

##### **details_page.dart**
DetailsPage é uma tela que carrega e exibe detalhes completos de um personagem da API Rick and Morty. Ela usa FutureBuilder para buscar os dados de forma assíncrona e mostra um card com as informações do personagem. Também verifica se o personagem está favoritado no Firebase e permite ao usuário favoritar ou desfavoritar, atualizando o banco e a interface. A tela adapta cores para modo claro e escuro e trata erros e carregamentos com mensagens e indicadores visuais. O AppBar é customizado para navegação.

##### **home_page.dart**
HomePage é uma tela que carrega e exibe uma lista paginada de personagens da API Rick and Morty. Ela permite buscar personagens por nome, aplicar filtros avançados (status, espécie, tipo e gênero) e carrega mais personagens automaticamente ao chegar no fim da lista (scroll infinito). A tela mostra indicadores de carregamento e mensagens de erro, além de adaptar as cores para modo claro e escuro. Também possibilita navegar para a página de detalhes do personagem ao tocar em um item da lista. O AppBar é customizado, incluindo ações de abrir o menu lateral e atualizar a lista.

##### **intro_pages.dart**
IntroPages é uma tela de introdução que apresenta quatro páginas com título, texto e imagem, usando o pacote IntroductionScreen. Ela permite pular ou avançar pelas páginas e, ao finalizar, redireciona para a tela de login. A interface usa tradução para textos e aplica um estilo consistente com cores e fontes personalizadas, além de indicadores visuais de progresso (dots) com cores adaptadas ao tema.

##### **login_page.dart**
LoginPage é uma tela de login que permite autenticação via email/senha com Firebase Authentication e login social com Google. Ela usa um formulário com campos para email e senha, inclui opção para mostrar/ocultar a senha, e botões para login, cadastro e login com Google. Após login, salva dados do usuário no Firestore (incluindo foto convertida em base64, se disponível) e navega para a HomePage. A interface usa tradução para textos, cores personalizadas e layout responsivo. Trata erros comuns do Firebase com mensagens traduzidas.

##### **profile_page.dart**
ProfilePage é uma tela que exibe informações do usuário logado, como nome, email e foto (armazenada em base64 no Firestore). Também lista os personagens favoritos do usuário obtidos do banco local, mostrando-os em um ExpansionTile clicável para detalhes. A página adapta cores para modo claro e escuro, mostra indicador de carregamento enquanto busca dados e trata erros de carregamento e decodificação da imagem. O AppBar é customizado para perfil.

##### **signup_page.dart**
SignupPage é uma tela de cadastro que permite ao usuário criar uma conta com nome, email, senha e foto de perfil opcional. A foto pode ser escolhida da galeria, convertida em base64 e armazenada no Firestore junto com os dados do usuário. O cadastro valida os campos, exibe mensagens de erro específicas, mostra um diálogo de progresso durante o processo e confirma sucesso com alerta. A interface tem controle para mostrar/esconder a senha, e o design adapta cores para modo escuro.

##### **splash_page.dart**
SplashPage é uma tela inicial que exibe o logo do app, uma mensagem de carregamento e uma imagem animada girando. A animação usa um AnimationController que faz a imagem girar continuamente. Após 3 segundos, a tela navega automaticamente para a IntroPages, iniciando a introdução do app. A interface utiliza cores e fontes personalizadas para manter a identidade visual.


#### **lib/theme/**
Contém arquivos que definem as configurações visuais do aplicativo, como paletas de cores (app_colors.dart) e recursos gráficos (app_images.dart). Esses arquivos centralizam a customização visual, promovendo consistência, facilitando alterações de design e garantindo que os elementos visuais sejam reutilizados e mantidos de forma organizada em todo o app.

##### **app_colors.dart**
Classe estática que centraliza as definições da paleta de cores do aplicativo para os modos claro e escuro. Fornece cores primárias, de fundo, texto, barras de app, entre outras, com métodos para selecionar a cor adequada conforme o tema ativo. Essa centralização facilita a manutenção do design visual, garante consistência e simplifica a adaptação do app para temas diferentes, melhorando a experiência do usuário.

##### **app_images.dart**
Classe estática que centraliza os caminhos dos recursos de imagem usados no app, como logos, ícones e imagens de introdução. Utiliza constantes para evitar strings hardcoded espalhadas pelo código, garantindo facilidade na manutenção e troca das imagens. Essa organização contribui para um código mais limpo, consistente e seguro contra erros de digitação nos caminhos dos assets.

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

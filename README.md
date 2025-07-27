# 🎬 Movies App

Aplicativo Flutter para exibir filmes populares e realizar buscas, utilizando a API do [The Movie Database (TMDB)](https://www.themoviedb.org/).

---

## 📱 Funcionalidades:

- 📽️ Lista de filmes populares com pôster, título e nota
- 🔍 Busca por nome do filme
- 🧭 Scroll infinito com carregamento de mais filmes
- ⚠️ Tratamento de erros e mensagens de feedback
- 🎨 Interface responsiva para diferentes tamanhos de tela

---

## 

## 📦 Instalação

### ✅ 1. Baixe o APK

Acesse a aba de **Releases** do GitHub:

👉 [🔗 Página de Releases](https://github.com/nicolasvitorino/movies-app/releases)

E faça o download do arquivo:
movies-app.apk


---

### 📲 2. Instale no dispositivo Android

1. Transfira o APK para seu celular (via cabo USB, WhatsApp Web, e-mail, etc)
2. No celular, toque no arquivo `.apk`
3. Pode ser necessário permitir instalação de fontes desconhecidas
4. Aguarde a instalação e abra o app 🎉


---

## 💻 Rodando o projeto localmente
Caso deseje rodar o projeto Flutter localmente:

### 1. Clone o repositório:
git clone https://github.com/nicolasvitorino/movies-app.git
cd movies-app


---

### 2. Cadastre-se no TMDB:
Acesse https://www.themoviedb.org/

Crie uma conta gratuita

Vá até https://www.themoviedb.org/settings/api

Crie uma nova API Key (Token de Acesso v4 - Bearer Token)


---

### 3. Crie um arquivo .env na raiz do projeto
Na raiz do projeto, crie um arquivo chamado .env (sem nome antes do ponto) com o seguinte conteúdo:

TMDB_API_KEY=SUA_CHAVE_AQUI

Substitua SUA_CHAVE_AQUI pelo token Bearer obtido no site da TMDB.


---

### 4. Instale as dependências e rode:
flutter pub get
flutter run


---

## 🛠 Tecnologias utilizadas

- Flutter (última versão estável)
- Dart
- Cubit
- Dio
- GoRouter
- TMDB API
  

---

## 🚧 Observações

Este projeto foi desenvolvido como parte de um **teste técnico**.  
O repositório está **privado** e a API Key é gerenciada internamente.  
Por isso, o código não está configurado para ser executado publicamente.

---

## 🧑‍💻 Autor

- Nicolas Vitorino(https://github.com/nicolasvitorino)

---

## 📝 Licença

MIT License © Nicolas Vitorino


<div align="center">

# 🧢 CapyLoot - Desafio Capyba

## 💻 Sobre o Projeto

**CapyLoot** é um aplicativo mobile desenvolvido em Flutter como parte do **Desafio Capyba**.  
A proposta do app é proporcionar uma experiência divertida e casual em estilo *gacha*,  
onde o usuário pode rodar uma "roda da sorte" e colecionar diferentes capivaras com raridades variadas.

O app conta com um sistema de autenticação usando Firebase (por e-mail/senha e Google),  
verificação de e-mail para liberar funcionalidades completas como criar registros e rodar a roda de capivaras,  
além de integração com a galeria e câmera para que o usuário possa personalizar seu perfil.

</div>

---

<div align="center">

## ✨ Tecnologias

Este projeto foi desenvolvido com:

</div>

<div align="center">

| Tecnologia | Descrição |
|-----------|-----------|
| [Flutter](https://flutter.dev/) | Versão 3.27.3 |
| [Dart](https://dart.dev/) | Linguagem base do Flutter |
| [Firebase Auth e Firestore](https://firebase.google.com/) | Autenticação e banco de dados |
| [Provider](https://pub.dev/packages/provider) | Gerenciamento de estado |
| [image_picker](https://pub.dev/packages/image_picker) | Captura de imagem via câmera/galeria |
| [cached_network_image](https://pub.dev/packages/cached_network_image) | Cache de imagens para performance |
| [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) | Customização de ícones do app |

</div>

---

<div align="center">

## 📱 Plataforma

Atualmente, apenas a plataforma **Android** está disponível.  
As demais plataformas podem ser geradas automaticamente, mas podem estar com configurações incompletas de dependências.

</div>

---

<div align="center">

## 🎨 Layout

O layout da aplicação foi inteiramente idealizado por mim, sem base em protótipos externos.

</div>

---

<div align="center">

## ⚙️ Funcionalidades Implementadas

</div>

<div align="center">

 Autenticação com **e-mail/senha** e **Google** (Firebase)  
 **Verificação de e-mail** obrigatória para acesso completo  
 Criação de registros com imagem e raridade  
 Roda de gacha com 4 níveis de raridade:  
   Comum 🟢  
   Raro 🔵  
   Épica 🟣  
   Lendária 🟡  
 Upload e seleção de imagem por **câmera ou galeria**  
 **Rotas nomeadas** para gerenciamento de navegação  
 Imagens cacheadas com `cached_network_image` para performance

</div>

<h1 align="center">:sparkles: Pré-Requisitos</h1>

<p align="center">Antes de rodar a aplicação, você precisará atender aos seguintes pré-requisitos:</p>

1. **Instalar e configurar o Flutter**
   <p align="center">Este projeto foi desenvolvido utilizando a versão <strong>Flutter 3.24.3</strong>. Você pode seguir as instruções de instalação no link abaixo:</p>

   <li><a href="https://flutter.dev/docs/get-started/install">Instalação do Flutter</a> (incluindo o SDK do Dart)</li>

   <p align="center">Certifique-se também de ter um emulador ou dispositivo físico configurado para rodar aplicativos Flutter.</p>
2. **Pastas da Plataforma (Ios, Mac, Linux e Windows)**
   <p align="center">O projeto atualmente não inclui os diretórios para as plataformas Ios, Mac, Linux e Windows. Se você precisar criá-los, pode executar o seguinte comando:</p>
   <pre><strong>$ flutter create .</strong></pre>

   <p align="center">Isso irá regenerar as pastas ausentes para as plataformas necessárias.</p>


<h1 align="center">:rocket: Executando o Projeto</h1>
<p align="center">Comece clonando o repositório para sua máquina, usando:</p>
<pre><strong>$ git clone https://github.com/Joao-Kleber-Linhalis/desafio_capyba</strong></pre>

<p align="center">Após isso, vá até a pasta do projeto:</p>
<pre><strong>$ cd Desafio-Capyba</strong></pre>

<p align="center">Instale todas as dependências, usando o seu gerenciador de pacotes preferido:</p>
<pre><strong>$ flutter pub get</strong></pre>

<p align="center">Para rodar o projeto, certifique-se de que um dispositivo ou emulador está conectado e configurado corretamente. Para iniciar o projeto, use:</p>
<pre><strong>$ flutter run</strong></pre>

<p align="center">Agora, o projeto está pronto para ser utilizado!</p>

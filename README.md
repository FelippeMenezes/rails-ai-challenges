# 🧠 Rails AI Challenges

Uma aplicação web educativa que integra inteligência artificial para auxiliar estudantes da Le Wagon AI Software Development Bootcamp. A plataforma oferece um sistema de challenges com assistente virtual powered by OpenAI.

## 📋 Índice

- [Tecnologias](#-tecnologias)
- [Arquitetura](#-arquitetura)
- [Funcionalidades](#-funcionalidades)
- [Instalação](#-instalação)
- [Configuração](#-configuração)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Contribuição](#-contribuição)
- [Licença](#-licença)

## 🚀 Tecnologias

### Core Framework & Linguagem
- **Ruby 3.3.5** - Linguagem de programação principal
- **Rails 7.1.3.4** - Framework web full-stack
- **Puma** - Servidor web de alta performance

### Backend & Database
- **PostgreSQL** - Banco de dados relacional
- **Active Record** - ORM (Object-Relational Mapping)
- **Devise** - Sistema de autenticação completo
- **Simple Form** - Builder de formulários estilizados

### Frontend & UI/UX
- **Bootstrap 5.2** - Framework CSS responsivo
- **SCSS/Sass** - Preprocessador CSS
- **Font Awesome 6.1** - Ícones vetoriais
- **Autoprefixer** - Extensão automática de vendor prefixes

### JavaScript & Frontend Interativo
- **Import Maps** - Gerenciador de módulos JavaScript moderno
- **Hotwire Turbo** - Aceleração de páginas SPA-like
- **Hotwire Stimulus** - Framework JavaScript minimalista
- **Popper.js** - Biblioteca de posicionamento
- **Bootstrap JavaScript** - Componentes interativos

### Integração com IA
- **RubyLLM** - Gem para integração com LLMs
- **OpenAI API** - Serviço de IA para chat assistant
- **System Prompts** - Configuração customizada de prompts

### Processamento de Conteúdo
- **Kramdown** - Parser Markdown otimizado
- **Rouge** - Syntax highlighter para código
- **Kramdown Parser GFM** - Parser GitHub Flavored Markdown

### Performance & Cache
- **Bootsnap** - Otimização de boot da aplicação

### Desenvolvimento & Testes
- **Web Console** - Console interativo para desenvolvimento
- **Capybara** - Framework de testes de aceitação
- **Selenium Webdriver** - Automação de navegador para testes
- **Debug Gem** - Ferramenta de debugging avançada
- **Error Highlight** - Destacar erros no código

### DevOps & Deploy
- **Docker** - Containerização da aplicação
- **Dockerfile** - Configuração de imagem Docker otimizada
- **.dockerignore** - Otimização de build Docker
- **Dotenv Rails** - Gerenciamento de variáveis de ambiente

## 🏗️ Arquitetura

### Padrão MVC
```
Model (Active Record)
├── User (Autenticação via Devise)
├── Challenge (Desafios educativos)
└── Message (Conversas do chat)

Controller (ActionController)
├── ApplicationController
├── ChallengesController
├── MessagesController
└── Devise Controllers

View (ERB Templates)
├── challenges/ (Index e Show)
├── messages/ (Index e New)
├── shared/ (Navbar e Flashes)
└── layouts/ (Application layout)
```

### Integração com IA
```ruby
# Fluxo de comunicação com IA
User Question → MessagesController → RubyLLM → OpenAI API
                                           ↓
AI Response → Message Model → Database → View
```

### Autenticação & Autorização
```ruby
# Sistema completo de autenticação
Devise Modules:
├── database_authenticatable
├── registerable
├── recoverable
├── rememberable
└── validatable
```

## ✨ Funcionalidades

### 🎯 Sistema de Challenges
- **Gestão de Desafios**: CRUD completo de challenges educativos
- **Categorização**: Challenges organizados por módulo
- **Conteúdo Rich**: Suporte a Markdown e syntax highlighting

### 🤖 Assistente Virtual com IA
- **Chat Interativo**: Interface de conversa com IA
- **Context Awareness**: IA conhece o contexto do challenge
- **Teaching Assistant**: Prompt system otimizado para ensino
- **Persistência**: Histórico completo de conversas

### 👤 Sistema de Usuários
- **Registro/Login**: Autenticação completa via Devise
- **Perfil**: Gestão de conta do usuário
- **Segurança**: Senhas encriptadas e reset via email

### 📱 Interface Responsiva
- **Mobile-First**: Design responsivo com Bootstrap
- **Navegação Intuitiva**: Navbar compartilhada
- **Feedback Visual**: Sistema de flashes para ações

## 📦 Instalação

### Pré-requisitos
- Ruby 3.3.5
- PostgreSQL 12+
- Docker (opcional)

### Setup Local
```bash
# Clone o repositório
git clone https://github.com/seu-usuario/rails-ai-challenges.git
cd rails-ai-challenges

# Instale as dependências
bundle install

# Configure as variáveis de ambiente
cp .env.example .env
# Edite .env com suas credenciais

# Setup do banco de dados
rails db:create db:migrate db:seed

# Inicie o servidor
rails server
```

### Setup com Docker
```bash
# Build da imagem
docker build -t rails-ai-challenges .

# Run do container
docker run -p 3000:3000 rails-ai-challenges
```

## ⚙️ Configuração

### Variáveis de Ambiente
```bash
# .env
DATABASE_URL=postgresql://username:password@localhost:5432/rails_ai_challenges_dev
OPENAI_API_KEY=sua_chave_api_openai

# Opcional: Azure OpenAI
GITHUB_TOKEN=seu_token_github
GITHUB_AZURE_OPENAI_BASE=https://models.inference.ai.azure.com
```

### Configuração RubyLLM
```ruby
# config/initializers/ruby_llm.rb
RubyLLM.configure do |config|
  config.openai_api_key = ENV["OPENAI_API_KEY"]
  # Configurações adicionais para outros provedores
end
```

## 📁 Estrutura do Projeto

```
rails-ai-challenges/
├── app/
│   ├── controllers/          # Controllers MVC
│   ├── models/              # Models Active Record
│   ├── views/               # Templates ERB
│   ├── assets/              # CSS, JS, Imagens
│   ├── javascript/          # Módulos JS (Import Maps)
│   └── helpers/             # Helpers de view
├── config/                  # Configurações Rails
├── db/                      # Migrations e Schema
├── lib/                     # Código customizado
├── public/                  # Assets estáticos
├── test/                    # Testes automatizados
├── Dockerfile              # Configuração Docker
├── docker-compose.yml      # Orquestração Docker
└── .github/                 # GitHub Actions e templates
```

## 🔧 Scripts Disponíveis

```bash
# Desenvolvimento
rails server          # Inicia servidor de desenvolvimento
rails console         # Console Rails interativo
rails db:migrate      # Executa migrations
rails db:seed         # Popula banco com dados iniciais

# Testes
rails test            # Executa toda suíte de testes
rails test:system     # Testes de sistema com Capybara

# Code Quality
rubocop              # Linting de código Ruby
rails eslint         # Linting de JavaScript

# Docker
docker-compose up    # Inicia aplicação com Docker
docker-compose down  # Para containers
```

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

### Padrões de Código
- Siga as convenções do Rails
- Utilize Rubocop para linting
- Escreva testes para novas features
- Documente mudanças complexas

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 🙏 Reconhecimentos

- [Le Wagon](https://www.lewagon.com) - Coding Bootcamp
- [Rails](https://rubyonrails.org/) - Web Framework
- [OpenAI](https://openai.com/) - AI Services
- [Bootstrap](https://getbootstrap.com/) - CSS Framework
- [RubyLLM](https://github.com/jeromegn/ruby_llm) - LLM Integration

## 📊 Estatísticas do Projeto

- **Linguagens**: Ruby (70%), JavaScript (20%), CSS (10%)
- **Dependências**: 25+ gems especializadas
- **Testes**: Testes de sistema com Capybara + Selenium
- **Container**: Docker-ready com otimizações multi-stage
- **AI Ready**: Integração completa com OpenAI GPT

---

**Desenvolvido com ❤️ pela comunidade Le Wagon AI**

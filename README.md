# Digio Store App

Este projeto é parte de um desafio técnico para a vaga de iOS Developer. O aplicativo consiste em duas telas: uma lista de produtos da Digio Store e uma tela de detalhes de um produto.

## Desafio

### Objetivo

Desenvolver um app com duas telas:
1. Uma tela que exibe uma lista de produtos da Digio Store.
2. Uma tela que exibe o detalhe do produto (layout livre).

### Requisitos Técnicos

- **Linguagem:** Swift
- **Deployment Target:** iOS 12
- **Layout:** Autolayout
- **Linting:** SwiftLint
- **Testes:** Testes unitários

### Regras

- Tempo: Até 5 dias úteis para completar a tarefa.
- Repositório: Projeto deve ser disponibilizado via repositório público.
- Documentação: README documentando arquitetura, libs, decisões, execução do projeto, etc.
- Justificação: Uso de todas as libs deve ser justificado no README.

### Bônus

- **URLSession + Codable**
- **Tratamento de erros**

### O que Esperamos

- Design Patterns
- Boas práticas de Orientação a Objetos
- Qualidade do código

## Solução

### Arquitetura

Para este projeto, utilizei a arquitetura **MVVM (Model-View-ViewModel)** para separar claramente as responsabilidades dentro do aplicativo:

- **Model:** Representa os dados e a lógica de negócios.
- **View:** Representa a interface do usuário.
- **ViewModel:** Atua como um intermediário entre a View e o Model, lidando com a lógica de apresentação.

### Bibliotecas Utilizadas

- **SwiftLint:** Para manter a consistência do código e seguir as melhores práticas do Swift. Instalado via Homebrew.
  - Justificativa: Ajuda a garantir a qualidade e a uniformidade do código.

### Ferramentas

- **URLSession + Codable:** Utilizado para realizar a conexão com a API e para o parsing dos dados JSON.
  - Justificativa: Simplicidade e eficiência na comunicação de rede e no mapeamento de dados.

### Tratamento de Erros

Implementei tratamento de erros para garantir que o aplicativo lide graciosamente com falhas de rede e outros possíveis problemas.

### Testes

Utilizei **XCTest** para criar testes unitários para as principais funcionalidades do app, garantindo a confiabilidade do código.

Claro, aqui está o README completo a partir da seção "Execução do Projeto", com todas as tags Markdown incluídas, incluindo as tags de código para os passos 2, 3 e 4:

### Execução do Projeto

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/digio-store-app.git
   ```
2. Instale as dependências (SwiftLint):
   ```bash
   brew install swiftlint
   ```
3. Abra o projeto no Xcode:
   ```bash
   open DigioStoreApp.xcodeproj
   ```
4. Compile e execute o aplicativo no simulador ou dispositivo.

### Decisões de Implementação

- **MVVM:** Escolhi a arquitetura MVVM para facilitar a testabilidade e a manutenção do código.
- **URLSession + Codable:** Utilizados para simplificar a implementação de chamadas de rede e parsing de JSON.
- **Tratamento de erros:** Implementado para melhorar a robustez do aplicativo.
- **SwiftLint:** Para assegurar a qualidade e a consistência do código.

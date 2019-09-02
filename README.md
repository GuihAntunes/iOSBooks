# iOSBooks
# Requisitos
- Xcode 10
- Swift 5
- Cocoapods

# Antes de rodar o projeto
Antes de rodar o projeto, por favor, rode 'pod install' dentro da pasta onde se encontra o Podfile através do terminal e abra o arquivo .xcworkspace após a instalação das dependências.

# Arquitetura
- **Model:** Representa os dados da aplicação
- **View:** Camada de apresentação visual
- **ViewModel:** Camada de regras de apresentação e regras de negócio (se houver alguma no frontend)
- **Service:** Camada que busca os dados da internet
- **Coordinator:** Camada que orquestra os fluxos de apresentação do app
- **Injector:** Camada que injeta as dependências de cada tela/view model do app

# Fluxo de camadas do app (Como as camadas se comunicam)

AppDelegate -> Coordinator (Injector) <-> ViewModel (Service) <-> View

# Dependencias
- **Kingfisher:** Biblioteca de image loader e cacher para baixar as imagens da Internet
- **PromisesKit:** Biblioteca para tratar código assíncrono com mais facilidade
- **SwiftLint:** Linter para análise de code style
- **Quick:** Biblioteca para auxiliar em criação de cenários em testes unitários
- **Nimble:** Biblioteca para auxiliar em criação de cenários em testes unitários

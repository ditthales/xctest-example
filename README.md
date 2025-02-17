# 📌 FizzBuzzGame

## 🎯 Sobre o Projeto
O **FizzBuzzGame** foi criado para auxiliar os alunos da **Apple Developer Academy - UFPE** a terem um projeto de base para entender **testes automatizados** em Swift. Ele implementa o clássico jogo do **FizzBuzz**, mas com um foco especial na **testabilidade do código**.

Aqui, você encontrará exemplos de **testes unitários** e **testes de interface (UI Tests)** usando **XCTest** e **Swift Testing**.

## 🛠 Tecnologias Utilizadas
- **Swift**
- **XCTest** (para testes unitários e de UI)
- **Swift Testing** (nova abordagem de testes unitários)

## 🧪 Testes no Projeto

O projeto contém **testes unitários** e **testes de interface (UITests)** para garantir que o comportamento do jogo seja validado corretamente.

### ✅ Testes Unitários
Foram criados dois tipos de testes unitários:

1. **Usando XCTest** nos arquivos:
   - `FizzBuzzBrainTest.swift`
   - `FizzBuzzGameTest.swift`
   - `FizzBuzzViewModelTest.swift`
   
2. **Usando Swift Testing** no arquivo:
   - `FizzBuzzSwiftTesting.swift`

### 🧩 Uso de BrainSpy e GameSpy
Para os testes unitários, utilizamos **BrainSpy** e **GameSpy**, que são **dublês de teste** (test doubles). Eles implementam os protocolos **BrainProtocol** e **GameProtocol**, permitindo que possamos testar o comportamento do código sem depender diretamente das implementações reais.

Isso é importante porque:
- **Evita efeitos colaterais** nos testes
- **Facilita a simulação de diferentes cenários**
- **Garante que os testes sejam mais rápidos e confiáveis**

### 📱 Testes de UI (UITests)
Os **UITests**, conhecidos como **end-to-end tests**, foram escritos usando **XCTest**. Esses testes verificam a interface do usuário e interações no app, garantindo que tudo funcione corretamente do ponto de vista do usuário final.

No projeto, testamos:
- Se a tela inicial carrega corretamente
- Se os botões respondem ao toque
- Se o jogo termina corretamente ao perder todas as vidas

Os UITests são essenciais porque ajudam a detectar problemas que podem passar despercebidos nos testes unitários, como erros na interface ou interações incorretas.

## 🚀 Como Rodar os Testes
Para executar os testes, siga os passos abaixo:

1. Abra o projeto no **Xcode**
2. No menu superior, clique em **Product > Test** (`⌘ + U`)
3. Acompanhe os resultados no painel de testes do Xcode

## 🎓 Conclusão
Este projeto serve como uma **introdução prática** ao mundo dos testes em Swift, utilizando tanto **XCTest** quanto **Swift Testing**. Ele demonstra como escrever testes eficientes, como usar **dublês de teste (test doubles)** para tornar os testes mais robustos e como automatizar a verificação da interface do usuário.

💡 **Dica:** Experimente modificar os testes e observar os resultados para consolidar seu aprendizado!

Se tiver dúvidas, sinta-se à vontade tirá-las no Slack. 🚀


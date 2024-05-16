# GistsTest

## Visão Geral
GistsTest é um projeto Swift que explora a funcionalidade da API do GitHub para exibir gists. O projeto é compatível com a versão **15.3 do Xcode** e requer **iOS 17.4** ou superior.

## Configuração
Para rodar o projeto, clone o repositório e abra `GistsTest.xcodeproj` no Xcode 15.3 ou superior.
Para consumir os gists da api do Github deve ser setado um valor para `AUTH_TOKEN` e para `BASE_URL` dentro do arquivo `Config.xcconfig`

** BASE_URL**: utilize o valor `api.github.com`

## Funcionalidades
- **Busca Remota**: O projeto está configurado para buscar gists diretamente da API do GitHub.
- **Busca Local**: Para facilitar o desenvolvimento e testes, um arquivo JSON está incluído no projeto para simular respostas da API.

Para chavear entre a busca remota ou local modifique no arquivo GistListRequestManager a api podendo ser `getGistsFromRemote` ou `getGistsFromLocal`

## Padrão de arquitetura
Foi utilizado o padrão MVVM-C que é uma variação do MVVM, muito utilizada pra projetos de pequena / media escala e que permite a codificação de Testes Unitários com facilidade.

## Licença
Este projeto está licenciado sob a MIT License - veja o arquivo LICENSE.md para detalhes.

## Contato
Se você tiver alguma dúvida ou feedback sobre o projeto, não hesite em abrir uma issue aqui no GitHub.


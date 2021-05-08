*** Settings ***
Resource              ../resources/ResourceAPI.robot
Documentation         Documentação da API: https://fakerestapi.azurewebsites.net/index.html
Suite Setup           Conectar a minha API

### SETUP ele roda keyword antes da suíte ou antes de um Teste
### TEARDOWN ele roda keyword depois de uma suíte ou um teste

*** Test Case ***
Buscar a listagem de todos os livros (GET em todos os livros)
      Requisitar todos os livros
      Conferir status code    200
      Conferir o reason       OK
      Conferir se retorna uma lista com "200" livros

Buscar um livro específico (GET em um livro específico)
      Requisitar o livro "15"
      Conferir status code    200
      Conferir o reason       OK
      Conferir se retorna todos os dados do livro 15

Cadastrar um novo livro (POST)
      Cadastrar um novo livro
      Conferir status code    200
      Conferir o reason       OK
      Conferir se retorna todos os dados cadastrados do livro "777"
Alterar um livro (PUT)
      Alterar o livro "150"
      Conferir status code    200
      Conferir se retorna todos os dados alterados do livro "666"
#TO-DO: Deletar um livro (DELETE)
#     - Conferir se deleta o livro 200 (o response body deve ser vazio)

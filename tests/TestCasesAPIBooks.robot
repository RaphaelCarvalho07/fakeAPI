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
      # Conferir se retorna uma lista com 200 livros

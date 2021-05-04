*** Settings ***
Documentation     Documentação da API: https://fakerestapi.azurewebsites.net/index.html
Library           RequestsLibrary
Library           Collections


*** Variables ***
${URL_API}         https://fakerestapi.azurewebsites.net/api/v1/



*** Keywords ***
######## SETUP E TEARDOWNS
Conectar a minha API
    Create Session    fakeAPI    ${URL_API}


######## AÇÕES
Requisitar todos os livros
    ${RESPOSTA}       GET On Session     fakeAPI      Books
    Log               ${RESPOSTA.text}



######### Conferências
Conferir status code
    [Arguments]        ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]        ${REASON_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.reason}    ${REASON_DESEJADO}

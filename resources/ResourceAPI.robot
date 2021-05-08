*** Settings ***
Documentation     Documentação da API: https://fakerestapi.azurewebsites.net/index.html
Library           RequestsLibrary
Library           Collections


*** Variables ***
${URL_API}         https://fakerestapi.azurewebsites.net/api/v1/
&{BOOK_15}         ID=15
...                Title=Book 15
...                PageCount=1500

&{BOOK_777}        ID=777
...                Title=Teste Robot Framework
...                Description=Robot Framework
...                PageCount=200
...                Excerpt=Da-lhe
...                PublishDate=2021-05-07T20:37:15.409Z

&{BOOK_666}        ID=666
...                Title=Book 666 From Hell
...                Description=Devil's Book
...                PageCount=666
...                Excerpt=Hello Satan
...                PublishDate=2017-04-26T15:58:14.765Z


*** Keywords ***
######## SETUP E TEARDOWNS
Conectar a minha API
    Create Session    fakeAPI    ${URL_API}
    ${HEADERS}     Create Dictionary    content-type=application/json
    Set Suite Variable    ${HEADERS}

######## AÇÕES
Requisitar todos os livros
    ${RESPOSTA}          GET On Session     fakeAPI      Books
    Set Test Variable    ${RESPOSTA}
    Log                  ${RESPOSTA.text}

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}          GET On Session     fakeAPI      Books/${ID_LIVRO}
    Set Test Variable    ${RESPOSTA}
    Log                  ${RESPOSTA.text}

Cadastrar um novo livro
    ${RESPOSTA}          Post On Session      fakeAPI      Books
    ...                                       data={"id": ${BOOK_777.ID},"title": "${BOOK_777.Title}","description": "${BOOK_777.Description}","pageCount": ${BOOK_777.PageCount},"excerpt": "${BOOK_777.Excerpt}","publishDate": "${BOOK_777.PublishDate}"}
    ...                                       headers=${HEADERS}
    Log                                       ${RESPOSTA.text}
    Set Test Variable                         ${RESPOSTA}

Alterar o livro "${ID_LIVRO}"
    ${RESPOSTA}          Put On Session       fakeAPI      Books/${ID_LIVRO}
    ...                                       data={"id": ${BOOK_666.ID},"title": "${BOOK_666.Title}","description": "${BOOK_666.Description}","pageCount": ${BOOK_666.PageCount},"excerpt": "${BOOK_666.Excerpt}","publishDate": "${BOOK_666.PublishDate}"}
    ...                                       headers=${HEADERS}
    Log                                       ${RESPOSTA.text}
    Set Test Variable                         ${RESPOSTA}


######### Conferências
Conferir status code
    [Arguments]                     ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings      ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]                   ${REASON_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.reason}    ${REASON_DESEJADO}

Conferir se retorna uma lista com "${QTDE_LIVRO}" livros
    Length Should Be              ${RESPOSTA.json()}    ${QTDE_LIVRO}

Conferir se retorna todos os dados do livro 15
    Dictionary Should Contain Item      ${RESPOSTA.json()}     id             ${BOOK_15.ID}
    Dictionary Should Contain Item      ${RESPOSTA.json()}     title          ${BOOK_15.Title}
    Dictionary Should Contain Item      ${RESPOSTA.json()}     pageCount      ${BOOK_15.PageCount}

    Should Not Be Empty                 ${RESPOSTA.json()["description"]}
    Should Not Be Empty                 ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty                 ${RESPOSTA.json()["publishDate"]}

Conferir se retorna todos os dados cadastrados do livro "${ID_LIVRO}"
    Conferir livro    ${ID_LIVRO}

Conferir livro
    [Arguments]   ${ID_LIVRO}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id             ${BOOK_${ID_LIVRO}.ID}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title          ${BOOK_${ID_LIVRO}.Title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    description    ${BOOK_${ID_LIVRO}.Description}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount      ${BOOK_${ID_LIVRO}.PageCount}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    excerpt        ${BOOK_${ID_LIVRO}.Excerpt}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    publishDate    ${BOOK_${ID_LIVRO}.PublishDate}

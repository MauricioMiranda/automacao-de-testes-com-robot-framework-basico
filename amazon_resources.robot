*** Settings ***
Library            SeleniumLibrary

*** Variables ***
${BROWSER}                     chrome
${URL}                         http://www.amazon.com.br
${MENU_ELETRONICOS}            //a[contains(.,'Eletrônicos')]
${HEADER_ELETRONICOS}          //h1[contains(.,'Eletrônicos e Tecnologia')]
${BTN_ADD_CARRINHO}            add-to-cart-button
${CARRINHO}                    //span[@aria-hidden='true'][contains(.,'Carrinho')]
${ADD_AO_CARRINHO}             //input[contains(@name,'submit.add-to-cart')]
${ADICIONADO_NO_CARRINHO}      //span[@class='a-size-medium-plus a-color-base sw-atc-text a-text-bold'][contains(.,'Adicionado ao carrinho')]
${CARRINHO_DE_COMPRAS}         //h1[contains(.,'Carrinho de compras')]
${EXCLUIR}                     //input[contains(@value,'Excluir')]
${MSG_CARRINHO_VAZIO}          //h1[@class='a-spacing-mini a-spacing-top-base'][contains(.,'Seu carrinho de compras da Amazon está vazio.')]

*** Keywords ***
Abrir o navegador
    Open Browser    browser=${BROWSER}
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser

Acessar a home page site Amazon.com.br
    Go To   ${URL}
    Wait Until Element Is Visible   ${MENU_ELETRONICOS}    # procura um elemento!

Entrar no menu "Eletrônicos"
    Click Element    ${MENU_ELETRONICOS}

Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains    ${FRASE}    # procura um texto!
    Element Should Be Visible    ${HEADER_ELETRONICOS}

Verificar se o título da página fica "${TIULO}"
    Title Should Be    title=${TIULO}

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=//img[contains(@alt,'${NOME_CATEGORIA}')]    # O elemento deve estar habilitado.. desabilitado...
    # Não precisa aguardar a página ser carregada com um WAIT, pq ja foi caregada, agora é validar se esta presente.

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text    locator=twotabsearchtextbox    text=${PRODUTO}

Clicar no botão de pesquisa
    Double Click Element    locator=nav-search-submit-button

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Wait Until Element Is Visible    locator=(//span[contains(.,'${PRODUTO}')])[2]

Adicionar o produto "${PRODUTO}" no carrinho
    Click Element   locator=//img[contains(@alt,'${PRODUTO}')]
    Wait Until Element Is Visible    locator=${ADD_AO_CARRINHO}
    Click Button    locator=${BTN_ADD_CARRINHO}

Verificar se o produto "${PRODUTO}" foi adicionado com sucesso
    Wait Until Element Is Visible    locator=${ADICIONADO_NO_CARRINHO}
    Click Element    locator=${CARRINHO}
    Wait Until Element Is Visible    locator=${CARRINHO_DE_COMPRAS}

Remover o produto "Console Xbox Series S" do carrinho
    Click Element    locator=${EXCLUIR}

Verificar se o carrinho fica vazio
    Wait Until Element Is Visible    locator=${MSG_CARRINHO_VAZIO}

#Gherkin Steps
Dado que estou na home page da Amazon.com.br
    Acessar a home page site Amazon.com.br
    Verificar se o título da página fica "Amazon.com.br | Tudo pra você, de A a Z."

Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"

Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o título da página fica "Eletrônicos e Tecnologia | Amazon.com.br"

E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"

E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"
    Verificar se aparece a categoria "Tablets"

Quando pesquisar pelo produto "Xbox Series S"
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa

Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    Verificar se o título da página fica "Amazon.com.br : Xbox Series S"

E um produto da linha "${PRODUTO}" deve ser mostrado na página
    Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"

Quando adicionar o produto "Console Xbox Series S" no carrinho
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"
    Adicionar o produto "Console Xbox Series S" no carrinho

Então o produto "Console Xbox Series S" deve ser mostrado no carrinho
    Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso

E existe o produto "Console Xbox Series S" no carrinho
    Quando adicionar o produto "Console Xbox Series S" no carrinho
    Então o produto "Console Xbox Series S" deve ser mostrado no carrinho

Quando remover o produto "Console Xbox Series S" do carrinho
    Remover o produto "Console Xbox Series S" do carrinho

Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio
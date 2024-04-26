Feature: Actualizar productos

  Background:
    * def responseLogin = call read("classpath:bdd/auth/loginAuth.feature@automation-api-login")
    * def token = responseLogin.token
    * url urlBase
    * header Authorization = 'Bearer ' + token
    * header Accept = "application/json"

  @automation-api-update

  Scenario: Caso 01 - Actualizar producto en el precio

       * def body =
     """
        {
    "codigo": "TC07",
    "nombre": "ALTERNADOR PL200NS",
    "medida": "UND ",
    "marca": "Generico",
    "categoria": "Repuestos",
    "precio": "80.00",
    "stock": "48",
    "estado": "3",
    "descripcion": "ALTERNADOR PL200NS"
        }
     """
    * def id = 705
    Given path "api/v1/producto/" + id
    And request body
    When method put
    Then status 200
    And match response.precio == "80.00"
    And match response.id == 705


  Scenario: Caso 02 - Actualizar producto

       * def id = "704"
      * def nombre = "ALTERNADOR PL200NS"

    Given path "api/v1/producto/" + id
    And  form field codigo = "TC06"
    And  form field nombre = "ALTERNADOR PL200NS"
    And  form field medida = "UND "
    And  form field marca = "Generico"
    And  form field categoria = "Repuestos"
    And  form field precio = "35.00"
    And  form field stock = "600"
    And  form field estado = "3"
    And  form field descripcion = "ALTERNADOR PL200NS"
    When method put
    Then status 200
    And match responseType =="json"
    And match $.nombre == nombre
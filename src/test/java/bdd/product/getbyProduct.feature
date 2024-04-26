Feature: Listar producto por id

  Background:
    * def responseLogin = call read("classpath:bdd/auth/loginAuth.feature@automation-api-login")
    * def token = responseLogin.token
    * url urlBase
    * header Authorization = 'Bearer ' + token
    * header Accept = "application/json"

  @automation-api-get

  Scenario: Caso 01 - Lista producto por id simple

    Given path "/api/v1/producto/3"
    When method get
    Then status 200


  Scenario: Caso 2 - Consultar usuario por id
    * def id = 1
    Given path "/api/v1/producto/" + id
    When method get
    Then status 200
    And match response.id == id
    And match response.nombre == "Cuadernote"
    * print response

  Scenario: Caso 3 - Consultar usuario por id
    * def id = 4
    Given path "/api/v1/producto/" + id
    When method get
    Then status 200
    And match response.id == id
    * print response.codigo

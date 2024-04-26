Feature: Registrar un nuevo usuario completando todo

  Background:
    * url urlBase
    * header Accept = "application/json"
  @automation-api-register
  Scenario: Caso 01 - REGISTRAR USUARIO
    Given path "api/register"
    And request {"email": "qateam40@gmail.com","password":"12345678", "nombre": "Carlos","tipo_usuario_id":1,"estado":1 }
    When method post
    Then status 200
    And match response.data.nombre == "Carlos"

  Scenario: Caso 02 - REGISTRAR USUARIO con docString en variable
    * def body = read('classpath:resources/json/auth/bodyLogin.json')
    Given path "api/register"
    And request body
    When method post
    Then status 200
    And match response.data.estado == 1
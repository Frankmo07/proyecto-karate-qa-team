Feature: Logear al usuario al sistema

    Background:
    * url urlBase
    * header Accept = "application/json"

  @automation-api-login

  Scenario: Caso 01 - Login OK
    Given path "api/login"
    And request {email: "carlosz@gmail.com", password: "12345678"}
    When method post
    Then status 200
    And match response.access_token != null
      * def token = response.access_token


  Scenario Outline: Caso 02 - Login OK CSV
    Given path 'api/login'
    And request { email: '#(email)', password: '#(password)' }
    When method post
    Then status <status>
    And match response.access_token != null
    * def token = response.access_token

       Examples:
     | read('classpath:resources/csv/auth/dataLogin.csv')|


   Scenario Outline: Caso 3- Login NO exitoso
    * def body =
     """
        {
         "email": <email>,
          "password": <password>
        }
     """
    Given path "/api/login"
    And request body
    When  method post
    Then status 401
    * print response
    And match response == { "message": "Datos incorrectos" }

    Examples:
      | email | password|
      |eve.holt@reqres.in| pistol|

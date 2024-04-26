Feature: Añadir un producto

    Background:
        * def responseLogin = call read("classpath:bdd/auth/loginAuth.feature@automation-api-login")
        * def token = responseLogin.token
        * url urlBase
        * header Authorization = 'Bearer ' + token
        * header Accept = "application/json"

    @automation-api-add

    Scenario: Caso 01 - Añadir producto
        * def body =
     """
        {
    "codigo": "TC02",
    "nombre": "ALTERNADOR PL200NS",
    "medida": "UND ",
    "marca": "Generico",
    "categoria": "Repuestos",
    "precio": "35.00",
    "stock": "48",
    "estado": "3",
    "descripcion": "ALTERNADOR PL200NS"
        }
     """
        Given path "api/v1/producto"
        And request body
        When method post
        Then status 200
        And match response.codigo == "TC02"
        And match response.nombre == "ALTERNADOR PL200NS"
        And match response.medida == "UND"


    Scenario: Caso 02 - Crear un producto con docString en variable
        * def body = read('classpath:resources/json/auth/bodyAdd.json')
        Given path "api/v1/producto"
        And request body
        When method post
        Then status 200
        And match response.codigo == "TC04"
        And match response.nombre == "ALTERNADOR PL200NS"
        And match response.medida == "UND"


  Scenario Outline: Caso 03 - Crear un producto con OK CSV
        Given path "api/v1/producto"
        And request
  """
  {
   codigo: '#(codigo)',
   nombre: '#(nombre)',
   medida: '#(medida)',
   marca: '#(marca)',
   categoria: '#(categoria)',
   precio: '#(precio)',
   stock: '#(stock)',
   estado: '#(estado)',
   descripcion: '#(descripcion)'
    }
  """
        When method post
        Then status 200
        And match response.codigo == "TC07"
        And match response.nombre == "ALTERNADOR PL200NS"
        And match response.medida == "UND"

    Examples:
      | read('classpath:resources/csv/auth/dataAdd.csv')|


  Scenario: Caso 04 - Crear un producto Duplicado con docString en variable- caso negativo
    * def body = read('classpath:resources/json/auth/bodyAdd.json')
    Given path "api/v1/producto"
    And request body
    When method post
    Then status 500
    And match response contains { "error": "#regex .*Duplicate entry.*"}
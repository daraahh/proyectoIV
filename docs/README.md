[![Build Status](https://travis-ci.com/daraahh/proyectoIV.svg?branch=master)](https://travis-ci.com/daraahh/proyectoIV)
[![CircleCI](https://circleci.com/gh/daraahh/proyectoIV.svg?style=svg)](https://circleci.com/gh/daraahh/proyectoIV)

## Lista de contenidos
- [Descripción general](#descripción-general)
- [Motivacion](#motivación)
- [Implementación](#implementación)
- [Herramientas de construcción, prueba, arranque y parada](#herramientas-de-construcción-prueba-arranque-y-parada)
- [Integración continua](#integración-continua)
- [API-REST](#api-rest)

_________

## Descripción general

Microservicio para gestionar la información relativa a los horarios de las asignaturas del Grado en Ingeniería Informática.


## Motivación

Principalmente, permitir a una posible futura aplicación acceder a la información relativa a las asignaturas de forma sencilla con el fin de poder crear horarios con facilidad para, por ejemplo, **detectar conflictos** entre dos asignaturas.

Adicionalmente, podría permitir **exportar** el horario creado por un usuario a un archivo PDF o como una imagen en formato JPEG, PNG...  

## Implementación

Se usará el lenguaje ***Ruby*** para desarrollar el microservicio, principalmente para reforzar lo aprendido en asignaturas previas.
- Framework para desarrollo web: [Sinatra](http://sinatrarb.com/). Ya que el microservicio a desarrollar es bastante simple con este framework será suficiente y no será necesario usar frameworks algo más robustos como Padrino o Ruby on Rails. Además la documentación sobre este framework me ha parecido exepcional.
- Entorno virtual de desarrollo: [rbenv](https://github.com/rbenv/rbenv). Porque permite manejar distintas versiones de Ruby de forma sencilla.

Como base de datos se usará [CouchDB](http://couchdb.apache.org/), principalmente para indagar un poco sobre bases de datos NoSQL y porque usa JSON para almacenar los datos, algo que creo se va a ajustar a lo que quiero hacer.

Como sistema de log se usará [Logstash](https://www.elastic.co/products/logstash).
- Haciendo uso de [LogStashLogger](https://github.com/dwbutler/logstash-logger), que extiende la clase `Logger` de Ruby para dar soporte a Logstash.

## Herramientas de construcción, prueba, arranque y parada

### Prerrequisitos

El proyecto es desarrollado en la versión 2.6.4 de Ruby. Para evitar posibles problemas podemos establecer la versión de Ruby del proyecto de forma local haciendo uso de **rbenv**:

`rbenv local 2.6.4`

Aunque para instalar las dependencias no será necesario ya que la versión del lenguaje está indicada en el archivo `Gemfile`, como se ve en el siguiente apartado.

### Instalación de dependencias

Necesitamos instalar las gemas de las que depende el proyecto para garantizar su correcto funcionamiento. Para ello, usamos la herramienta **bundle**:

`bundle install`

Esto instalará de forma automática las gemas indicadas en el fichero [Gemfile](https://github.com/daraahh/proyectoIV/blob/master/Gemfile) en el directorio raíz del repositorio.

### Prueba

Para automatizar la ejecución de tests hago uso de `rake`. Esta herrramienta de automatización está escrita en Ruby y el archivo `Rakefile`, que contiene las tareas a ejecutar, sigue la sintaxis de Ruby.

La gran ventaja que encuentro en el uso de `rake` y `Rakefile` es que al tratarse Ruby de un lenguaje de alto nivel, nos permite abstraer de forma más cómoda las tareas a realizar y definir patrones fácilmente para identificar y ejecutar las diferentes tareas que definamos.

Para ejecutar los tests, nos situamos en el directorio raíz del repositorio y ejecutamos:

`rake`

### Arranque y parada del servicio

Para llevar a cabo estas tareas hago uso de `Rack`, que nos permite levantar el servicio de forma sencilla con la configuración indicada en el fichero [config.ru](https://github.com/daraahh/proyectoIV/blob/master/config.ru). De esta forma, solo tendremos que usar `rackup` para levantar un servidor [thin](https://github.com/macournoyer/thin) (aunque *rackup* permite otros servidores he elegido este porque es simple y ligero) y poner en funcionamiento el servicio.

He definido dos tareas nuevas en el archivo [Rakefile](https://github.com/daraahh/proyectoIV/blob/master/Rakefile) para arrancar y parar el servicio de forma sencilla:

```ruby
desc "Arranca la aplicación"
task :start do
	exec "rackup -D -s thin -p 9292 config.ru"
end

desc "Para la aplicación"
task :stop do
	exec "kill $(lsof -i :9292 -t)"
end
```

Para arrancar la aplicación, ejecuta `rackup` demonizando el proceso con `-D`, indica el servidor de tipo `thin` e indica el puerto de escucha seguido del fichero de configuración que indica la aplicación a ejecutar.

Para para la apliación, localizamos con `lsof` el PID del proceso que está escuchando en el puerto 9292, nuestro servidor, y matamos dicho proceso con `kill`.

El uso es sencillo y es el siguiente:

Arranca el servicio de forma local, ejecución en segundo plano y escuchando en el puerto 9292:

`rake start`

Para detener el servicio:

`rake stop`

##### ¿Qué se testea actualmente?
- Clase SchedManager, gestora de las operaciones de recuperación, adición y eliminación de información que se realizan sobre el fondo de datos, actualmente un archivo json con datos de prueba. [Tests unitarios](https://github.com/daraahh/proyectoIV/blob/master/t/unit_test.rb)
	- Que se recupere un elemento localizable por un identificador.
	- Que se añada un elemento de forma adecuada al conjunto de datos.
	- Que se elimine un elemento de forma adecuada del conjunto de datos.

- Clase App, aplicación Sinatra, una API REST que recoge las funcionalidades del servicio y atiende las peticiones. [Tests funcionales](https://github.com/daraahh/proyectoIV/blob/master/t/functional_test.rb)
	- Que se devuelve un estado correcto como respuesta, ya sea de tipo 200 o 400.
	- Que la respuesta es de tipo JSON.
	- Que los datos recuperados son los adecuados.
	- Que se añade una asignatura de forma adecuada.
	- Que se elimina una asignatura de forma correcta.

## Integración continua

Como sistemas de integración continua he decidido usar TravisCI y CircleCI.

### TravisCI

TravisCI permite una configuración rápida y sencilla para la automatización de tests cuando se hace un push al repositorio.

El archivo de configuración en uso es el mostrado abajo. Se especifica el lenguaje en uso y la versión del mismo, en mi caso 2.6.4.

Por defecto, en el caso de Ruby, Travis ejecutará ls comandos `bundle install` para instalar las dependencias y `rake unit_tests` para lanzar los tests unitarios:

```yml
language: ruby
rvm:
    - 2.6.4
script: rake unit_tests
```


### CircleCI

La configuración de Circle no es tan inmediata pero es bastante intuitiva y de fácil lectura debido a que sigue un formato `YAML`.

Una de las ventajas que le encuentro frente a Travis es que Circle tiene un sistema de cache para los requerimientos de instalación por lo que las builds son más rápidas.

```yaml
version: 2
jobs:
  build:
    docker:
    #Definimos el lenguaje y la versión. El OS por defecto es Ubuntu.
      - image: circleci/ruby:2.6.4
    # Lista de los pasos que se van a llevar a cabo en el job
    steps:
    # Clona nuestro repositorio
      - checkout
    # Indicamos los comandos a ejecutar
      - run:
    # Instalar las dependencias
        name: Dependencias
        command: bundle install
      - run:
    #Ejecutar los tests
        name: Tests
        command: rake test
```

## API REST

Actualmente, la api dispone de las siguientes rutas:

- GET
	- `/` y `/status` : Devuelven un estado 200 y `{ "status": "OK" }`
	- `/asignaturas` : Devuelve todas las asignaturas que residen en el fondo de datos.
	- `/asignaturas/<id>` : Devuelve la asignatura identificada por el valor `id`
- PUT
	- `/asignaturas` : Añade la asignatura que acompaña a la petición en formato JSON al pull de datos.
- DELETE
	- `/asignaturas` : Elimina la asignatura identificada por el valor `id`

El atributo `id` cobrará más importancia en un futuro con nuevas funcionalidades. Este parámetro es una numérica compuesta por cuatro dígitos que permitirá identificar a que curso y cuatrimestre pertenece dicha asignatura.

Ejemplo: "1104", asignatura del primer curso, primer cuatrimestre, identificada con un 4. "1203", asignatura del primer curso, segundo cuatrimestre, identificada con un 3. "3205", asignatura del tercer curso, segundo cuatrimestre, identificada con un 5...

Esto permitirá al servicio organizar de una mejor manera las asginaturas (por cursos y cuatrimestres) y poder recuperar la información de una forma más sencilla.

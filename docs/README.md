[![Build Status](https://travis-ci.com/daraahh/proyectoIV.svg?branch=master)](https://travis-ci.com/daraahh/proyectoIV)
[![CircleCI](https://circleci.com/gh/daraahh/proyectoIV.svg?style=svg)](https://circleci.com/gh/daraahh/proyectoIV)

## Lista de contenidos
- [Descripción general](#descripción-general)
- [Motivacion](#motivación)
- [Implementación](#implementación)
- [Herramientas de construcción, prueba, arranque y parada](#herramientas-de-construcción-prueba-arranque-y-parada)
- [Integración continua](#integración-continua)
- [API-REST](#api-rest)
- [Despliegue PaaS](#despliegue-paas)
- [DockerHub](#dockerhub)

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

Necesitamos instalar las gemas de las que depende el proyecto para garantizar su correcto funcionamiento. Para ello, usamos la herramienta de construcción `rake`, desde la que se ejecutará **bundle**:

`rake install`

```ruby
desc "Instalar las dependencias necesarias"
task :install do
	exec "bundle install"
end
```

Esto instalará de forma automática las gemas indicadas en el fichero [Gemfile](https://github.com/daraahh/proyectoIV/blob/master/Gemfile) en el directorio raíz del repositorio.

### Prueba

Para automatizar la ejecución de tests hago uso de `rake`. Esta herrramienta de automatización está escrita en Ruby y el archivo `Rakefile`, que contiene las tareas a ejecutar, sigue la sintaxis de Ruby.

La gran ventaja que encuentro en el uso de `rake` y `Rakefile` es que al tratarse Ruby de un lenguaje de alto nivel, nos permite abstraer de forma más cómoda las tareas a realizar y definir patrones fácilmente para identificar y ejecutar las diferentes tareas que definamos.

Para ejecutar los tests, nos situamos en el directorio raíz del repositorio y ejecutamos:

`rake test`

Si quisieramos ejecutar sólo los tests unitarios o sólo los tests funcionales, podemos usar comandos independientes:

`rake unit_tests`

`rake functional_tests`

### Arranque y parada del servicio

Para llevar a cabo estas tareas hago uso de `Rack`, que nos permite levantar el servicio de forma sencilla con la configuración indicada en el fichero [config.ru](https://github.com/daraahh/proyectoIV/blob/master/config.ru). De esta forma, solo tendremos que usar `rackup` para levantar un servidor [thin](https://github.com/macournoyer/thin) (aunque *rackup* permite otros servidores he elegido este porque es simple y ligero) y poner en funcionamiento el servicio.

He definido dos tareas nuevas en el archivo [Rakefile](https://github.com/daraahh/proyectoIV/blob/master/Rakefile) para arrancar y parar el servicio de forma sencilla. Actualmente, hago uso del gestor de procesos `pm2` que me permitirá gestionar y guardar los PID de los procesos que se arrancan.

Tras probar numerosos gestores de procesos para Ruby, como `Invoker`, `Procman`, `Procodile`, `Foreman`... He decidido usar `pm2` porque *funciona* y se ajusta de una forma más cómoda a lo que buscaba. Además, la última versión estable es relativamente reciente y no de hace 5 años, a parte de que funciona con la versión de Ruby en la que estoy desarrollando el proyecto.

```ruby
desc "Arranca la aplicación"
task :start do
  exec "pm2 start sinatra_app.json"
end

desc "Para la aplicación"
task :stop do
  exec "pm2 stop sinatra-app-IV"
end
```
Fichero sinatra_app.json:

```json
{
	"apps": [
		{
			"name": "sinatra-app-IV",
			"env": {
				"PORT": 8080
			},
			"script": "rackup -s thin -p $PORT config.ru",
			"exec_mode": "fork_mode"
		}
		]
}
```


Para arrancar la aplicación, ejecuta `rackup`, indica el servidor de tipo `thin` e indica el puerto de escucha mediante una variable de entorno `PORT`, seguido del fichero de configuración que indica la aplicación a ejecutar.

Para para la aplicación, indicamos a `pm2` que pare el proceso identificándolo mediante el nombre que proporcionamos al arrancarlo `sinatra-app-IV`.

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

Por defecto, en el caso de Ruby, Travis ejecutará los comandos `bundle install` para instalar las dependencias y `rake test` para lanzar los tests unitarios:

```yml
language: ruby
rvm:
    - 2.6.4
install: bundle install
script: rake test
```

### CircleCI

La configuración de Circle no es tan inmediata pero es bastante intuitiva y de fácil lectura debido a que sigue un formato `YAML`.

Una de las ventajas que le encuentro frente a Travis es que Circle tiene un sistema de cache para los requerimientos de instalación por lo que las builds son más rápidas.

Incluyo node en la imagen predefinida ya que necesito instalar `npm` para posteriormente instalar `pm2`. El autoinstalador en la documentación de `pm2` que descarga pm2 sin que sea necesario `npm`, no me ha funcionado en la build de CircleCI y por ello he tenido que optar por instalar todo, aunque el 85% no lo necesito.

```yaml
version: 2
jobs:
  build:
    docker:
    #Definimos el lenguaje y la versión. El OS por defecto es Ubuntu.
      - image: circleci/ruby:2.6.4-node
    # Lista de los pasos que se van a llevar a cabo en el job
    steps:
      - run:
    # Instalar pm2 para arrancar la aplicación más adelante
          name: Instalar pm2
          command: |
            sudo apt install -y npm
            sudo npm install -g pm2
    # Clona nuestro repositorio
      - checkout
    # Indicamos los comandos a ejecutar
      - run:
    # Instalar las dependencias
          name: Dependencias
          command: bundle install
      - run:
    # Ejecutar los tests
          name: Tests
          command: rake test
      - run:
    # Poder en funcionamiento el servicio
          name: Arrancar el servicio
          command: rake start
```

## API REST

Actualmente, la API dispone de las siguientes rutas:

- GET
	- `/` y `/status` : Devuelven un estado 200 y `{ "status": "OK" }`
	- `/asignaturas` : Devuelve todas las asignaturas que residen en el fondo de datos.
	- `/asignaturas/<id>` : Devuelve la asignatura identificada por el valor `id`
- PUT
	- `/asignaturas` : Añade la asignatura que acompaña a la petición en formato JSON al pull de datos.
- DELETE
	- `/asignaturas/<id>` : Elimina la asignatura identificada por el valor `id`

El atributo `id` cobrará más importancia en un futuro con nuevas funcionalidades. Este parámetro es una numérica compuesta por cuatro dígitos que permitirá identificar a que curso y cuatrimestre pertenece dicha asignatura.

Ejemplo: "1104", asignatura del primer curso, primer cuatrimestre, identificada con un 4. "1203", asignatura del primer curso, segundo cuatrimestre, identificada con un 3. "3205", asignatura del tercer curso, segundo cuatrimestre, identificada con un 5...

Esto permitirá al servicio organizar de una mejor manera las asginaturas (por cursos y cuatrimestres) y poder recuperar la información de una forma más sencilla.

## Despliegue PaaS

Como *PaaS* he elegido Azure, el despliegue de la aplicación, después de una primera aproximación, ha sido relativamente sencillo. A continuación explicaré a lo que me refiero con esto:

### Primer aproximación: Web APP sin contenedor

En una primera maniobra para desplegar la aplicación intenté crear el servicio directamente con el stack de desarrollo que proporciona Azure, pensado para el despliegue de aplicaciones *Ruby on Rails*.

Aunque en la documentación, Azure advierte de que sólo hay soporte para este tipo de aplicaciones decidí ignorar dicha advertencia e intentar colar mi aplicación Sinatra. Esto propició que me encontrara con diversos problemas:

- La versión de Ruby más reciente que proporcionan es `2.6.2`, un detalle que desencadenaba numerosos errores en el arranque de mi aplicación, desarrollada con la versión `2.6.4`.

- No es posible (no he encontrado la forma) ejecutar la aplicación Sinatra ya que Azure ejecuta por defecto la orden para arrancar una aplicación de tipo Ruby on Rails.

### Segunda aproximación: Web APP en un contenedor Docker

Después de trastear un poco más e intentar que se desplegara la aplicación, decidí crear un contenedor para crear un entorno aislado que contuviese todo lo necesario y que no me creara problemas a la hora del despliegue. Esto es posible porque Azure permite desplegar desde un contenedor Docker por lo que quedaban solucionados todos los problemas descritos en la primera aproximación.

Debido a que el uso de Docker está relacionado con el siguiente hito, no tenía claro si debía usarlo para hacer el despliegue en el PaaS, pero dadas las circunstancias, era la opción más clara. Dicho esto, estoy bastante contento con el resultado, ya que he automatizado la construcción del contenedor y su posterior e inmediato despliegue.

#### Proceso creación de aplicación a partir de contenedor Docker.

Desde la web de Azure, podemos clickar en añadir recurso y elegir *Web App*. Después nos aparecerá un formulario como el siguiente.

Como en mi caso voy a desplegar desde un contenedor la configuración sería como la indicada en la captura. Básicamente hay que marcar *Docker container* y rellenar los campos que nos pide sobre el nombre de la aplicación, el grupo de recursos y otros datos.

![Docker 1](img/docker.png)

Habiendo hecho click en *Next: Docker*, nos aparecerá la siguiente pantalla en la que nos pedirá información sobre dónde tenemos alojada la imagen, en mi caso es un repositorio público de DockerHub. El contenedor está identificado por *darahh/proyectoiv*.

![Docker 2](img/docker2.png)

Hecho esto, Azure empezará a crear la aplicación, descargará la imagen del repositorio en DockerHub y tendremos listo nuestro servicio.

Estos pasos son reproducibles desde CLI de la siguiente forma:

`az webapp create -n proyecto-iv -g IV -p F1 -i darahh/proyectoiv`

También habrá que activar el despliegue continuo para poder desplegar directamente desde DockerHub:

`az webapp deployment container config -n proyecto-iv -g IV -e true`

Nos devolverá la url del webhook que habrá que guardar para indicárselo a DockerHub más tarde.

Esto se puede activar desde la web en el apartado *Container settings*.

## DockerHub

Para integrar los cambios del proyecto en Github directamente y que se vean reflejados de forma automática en el despliegue de Azure, he usado DockerHub.

Primero he añadido un [Dockerfile](https://github.com/daraahh/proyectoIV/blob/master/Dockerfile) para la creación del contenedor y tras haber creado el repositorio en DockerHub, activo la automatización de builds de la siguiente forma:

![DockerHub 1](img/dockerhub1.png)

Es necesario enlazar nuestra cuenta de GitHub con la de DockerHub.

Para terminar de configurar la cadena de eventos, configuro el webhook en DockerHub para que al crear una nueva build del contenedor se despliegue de forma automática en Azure.

![DockerHub 2](img/dockerhub2-redacted.png)

**tl;dr:** Cuando se haga push al repositorio en GitHub, se lanzarán los tests en CircleCI y TravisCI, además, se disparará una build en DockerHub que creará una imagen nueva con los últimos cambios. Cuando la build acabe, mediante el webhook, se avisará a Azure de la actualización y desplegará el contenedor nuevo.

[![Build Status](https://travis-ci.com/daraahh/proyectoIV.svg?branch=master)](https://travis-ci.com/daraahh/proyectoIV)
[![CircleCI](https://circleci.com/gh/daraahh/proyectoIV.svg?style=svg)](https://circleci.com/gh/daraahh/proyectoIV)

## Lista de contenidos
- [Descripción general](#descripción-general)
- [Motivacion](#motivación)
- [Implementación](#implementación)
- [Herramientas de construcción y prueba](#herramientas-de-construcción-y-prueba)
- [Integración continua](#integración-continua)

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

## Herramientas de construcción y prueba

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

##### ¿Qué se testea actualmente?
- Clase SchedManager, gestora de las operaciones de recuperación, adición y eliminación de información que se realizan sobre el fondo de datos, actualmente un archivo json con datos de prueba.
	- Que se recupere un elemento localizable por un identificador.
	- Que se añada un elemento de forma adecuada al conjunto de datos.
	- Que se elimine un elemento de forma adecuada del conjunto de datos.

## Integración continua

Como sistemas de integración continua he decidido usar TravisCI y CircleCI.

### TravisCI

TravisCI permite una configuración rápida y sencilla para la automatización de tests cuando se hace un push al repositorio.

El archivo de configuración en uso es el mostrado abajo. Se especifica el lenguaje en uso y la versión del mismo, en mi caso 2.6.4.

Por defecto, en el caso de Ruby, Travis ejecutará ls comandos `bundle install` para instalar las dependencias y `rake` para lanzar lo que tengamos configurado, en mi caso los tests. De este modo, no hace falta indicarlos en el fichero de configuración:

```yml
language: ruby
rvm:
    - 2.6.4
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
        command: rake
```

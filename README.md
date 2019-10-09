# proyectoIV

[![Build Status](https://travis-ci.com/daraahh/proyectoIV.svg?branch=master)](https://travis-ci.com/daraahh/proyectoIV)
[![CircleCI](https://circleci.com/gh/daraahh/proyectoIV.svg?style=svg)](https://circleci.com/gh/daraahh/proyectoIV)

Repositorio para el proyecto de la asignatura Infraestructura Virtual, curso 2019-20.

## Descripción general

Microservicio para gestionar la información relativa a los horarios de las asignaturas del Grado en Ingeniería Informática.

El microservicio permitirá recuperar la información de las asignaturas por cursos y cuatrimestres. Un usuario con el rol de administrador podrá actualizar la información asociada a una asignatura y eliminar o añadir asignaturas.

## Motivación

Principalmente, permitir a una posible futura aplicación acceder a la información relativa a las asignaturas de forma sencilla con el fin de poder crear horarios con facilidad para, por ejemplo, **detectar conflictos** entre dos asignaturas. Adicionalmente, podría permitir **exportar** el horario creado por un usuario a un archivo PDF o como una imagen en formato JPEG, PNG...   

## Implementación

Se usará el lenguaje ***Ruby*** para desarrollar el microservicio.
- Framework para desarrollo web: [Sinatra](http://sinatrarb.com/)
- Entorno virtual de desarrollo: [rbenv](https://github.com/rbenv/rbenv)

Como base de datos se usará  [CouchDB](http://couchdb.apache.org/).

Como sistema de log se usará [Logstash](https://www.elastic.co/products/logstash).
- Haciendo uso de [LogStashLogger](https://github.com/dwbutler/logstash-logger), que extiende la clase `Logger` de Ruby para dar soporte a Logstash.

La documentación adicional sobre las razones por las que se usarán dichos servicios y herramientas [se encuentra en el GitHub Pages del repositorio.](https://daraahh.github.io/proyectoIV/#implementación)


## Instrucciones de instalación y prueba

Descarga el repositorio mediante `git clone`.

### Instalar dependencias

Instala las dependencias indicadas en el [Gemfile](https://github.com/daraahh/proyectoIV/blob/master/Gemfile).

`bundle install`

### Ejecuta los tests

Ejecuta el archivo [Rakefile](https://github.com/daraahh/proyectoIV/blob/master/Rakefile) para iniciar los tests:

`rake`

La documentación adicional sobre [herramientas de instalación y prueba](https://daraahh.github.io/proyectoIV/#herramientas-de-construcción-y-prueba) se encuentra en el GitHub Pages del repositorio.


## Documentación adicional
- [Página principal](https://daraahh.github.io/proyectoIV/)
	- [Implementación](https://daraahh.github.io/proyectoIV/#implementación)
	- [Herramientas de construcción y prueba](https://daraahh.github.io/proyectoIV/#herramientas-de-construcción-y-prueba)
	- [Integración continua](https://daraahh.github.io/proyectoIV/#integración-continua)

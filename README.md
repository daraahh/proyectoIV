# proyectoIV

[![Build Status](https://travis-ci.com/daraahh/proyectoIV.svg?branch=master)](https://travis-ci.com/daraahh/proyectoIV)
[![CircleCI](https://circleci.com/gh/daraahh/proyectoIV.svg?style=svg)](https://circleci.com/gh/daraahh/proyectoIV)

Repositorio para el proyecto de la asignatura Infraestructura Virtual, curso 2019-20.

## Descripción general

Microservicio para gestionar la información relativa a los horarios de las asignaturas del Grado en Ingeniería Informática.

El microservicio permitirá recuperar la información de las asignaturas por cursos y cuatrimestres y se podrá eliminar o añadir asignaturas.

## Motivación

Principalmente, permitir a una posible futura aplicación acceder a la información relativa a las asignaturas de forma sencilla con el fin de poder crear horarios con facilidad para, por ejemplo, **detectar conflictos** entre dos asignaturas. Adicionalmente, podría permitir **exportar** el horario creado por un usuario a un archivo PDF o como una imagen en formato JPEG, PNG...   

## API REST

Actualmente, la api dispone de las siguientes rutas:

- GET
	- `/` y `/status` : Devuelven un estado 200 y `{ "status": "OK" }`
	- `/asignaturas` : Devuelve todas las asignaturas que residen en el fondo de datos.
	- `/asignaturas/<id>` : Devuelve la asignatura identificada por el valor `id`
- PUT
	- `/asignaturas` : Añade la asignatura que acompaña a la petición en formato JSON al pull de datos.
- DELETE
	- `/asignaturas/<id>` : Elimina la asignatura identificada por el valor `id`

La documentación adicional sobre [API REST](https://daraahh.github.io/proyectoIV/#api-rest) se encuentra en el GitHub Pages del repositorio.

## Instrucciones de instalación y prueba

Descarga el repositorio mediante `git clone`:

`git clone https://github.com/daraahh/proyectoIV.git`

### Instalar dependencias

Instala las dependencias indicadas en el [Gemfile](https://github.com/daraahh/proyectoIV/blob/master/Gemfile).

`rake install`

### Ejecuta los tests

Ejecuta el archivo [Rakefile](https://github.com/daraahh/proyectoIV/blob/master/Rakefile) para iniciar los tests:

`rake test`


### Prueba el servicio en local

Arranca el servicio de forma local, ejecución en segundo plano y escuchando en el puerto 9292:

`rake start`

```
$ curl http://localhost:9292
{"status":"OK", ... }
$ curl http://localhost:9292/status
{"status":"OK", ... }
```

Para detener el servicio:

`rake stop`

La documentación adicional sobre [herramientas de instalación y prueba](https://daraahh.github.io/proyectoIV/#herramientas-de-construcción-y-prueba) se encuentra en el GitHub Pages del repositorio.

	buildtool: Rakefile


## Despliegue PaaS

### Azure

	Despliegue: https://proyecto-iv.azurewebsites.net/

La documentación adicional sobre [el despliegue en PaaS](https://daraahh.github.io/proyectoIV/#despliegue-paas) se encuentra en el GitHub Pages del repositorio.

## DockerHub

Contenedor de la aplicación en DockerHub: https://hub.docker.com/r/darahh/proyectoiv

Para probar el contenedor en local: `docker run --rm -p 8080:80 darahh/proyectoiv:latest`

La documentación adicional sobre [la dockerización de la aplicación](https://daraahh.github.io/proyectoIV/#dockerhub) se encuentra en el GitHub Pages del repositorio.

## Documentación adicional
- [Página principal](https://daraahh.github.io/proyectoIV/)
	- [Implementación](https://daraahh.github.io/proyectoIV/#implementación)
	- [Herramientas de construcción, prueba, arranque y parada](https://daraahh.github.io/proyectoIV/#herramientas-de-construcción-prueba-arranque-y-parada)
	- [Integración continua](https://daraahh.github.io/proyectoIV/#integración-continua)
	- [API REST](https://daraahh.github.io/proyectoIV/#api-rest)
	- [Despligue PaaS](https://daraahh.github.io/proyectoIV/#despliegue-paas)
	- [DockerHub](https://daraahh.github.io/proyectoIV/#dockerhub)

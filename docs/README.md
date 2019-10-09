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

TO-DO

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

rake vs make + justificacion. TO-DO

`rake`

##### ¿Qué se testea actualmente?
- Clase SchedManager, gestora de las operaciones de recuperación, adición y eliminación de información que se realizan sobre el fondo de datos, actualmente un archivo json con datos de prueba.
	- Que se recupere un elemento localizable por un identificador.
	- Que se añada un elemento de forma adecuada al conjunto de datos.
	- Que se elimine un elemento de forma adecuada del conjunto de datos.

## Integración continua

TO-DO

### TravisCI

```
language: ruby
rvm:
    - 2.6.4
```


### CircleCI

```
version: 2
jobs:
    build:
        docker:
            - image: circleci/ruby:2.6.4
        steps:
            - checkout
            - run:
                name: Dependencias
                command: bundle install
            - run:
                name: Tests
                command: rake
```

# Toma una imagen con ruby como base
FROM ruby:2.6.4

# Instalar herramientas esenciales
RUN apt-get update -qq && apt-get install -y build-essential

# Crea una variable de entorno que define el directorio raiz de la aplicacion
ENV APP_HOME /app
# Crea el directorio raiz
RUN mkdir $APP_HOME
# Establece el directorio raiz como el directorio de trabajo
WORKDIR $APP_HOME

# Copia el Gemfile y el Gemfile.lock al contenedor e instalamos las dependencias
ADD Gemfile* $APP_HOME/
RUN bundle install

# Copia el resto de archivos
ADD . $APP_HOME

# Indica el puerto en el que va a escuchar el contenedor
EXPOSE 80

# Arranca la aplicación en el puerto 80 escuchando en todas las interfaces
CMD ["rackup","--host", "0.0.0.0", "-p","80", "config.ru"]

# Toma una imagen de alpine con ruby como base para hacerlo lo más pequeño posible.
FROM ruby:2.6.4-alpine3.9

# Crea una variable de entorno que define el directorio raiz de la aplicacion
ENV APP_HOME /app

# Crea el directorio raiz
RUN mkdir $APP_HOME
# Establece el directorio raiz como el directorio de trabajo
WORKDIR $APP_HOME

# Copiar solo archivos necesarios
ADD src/ $APP_HOME/src
ADD sampledata/ $APP_HOME/sampledata
ADD config.ru $APP_HOME

# Copia el Gemfile y el Gemfile.lock al contenedor e instalamos las dependencias
ADD Gemfile* $APP_HOME/
RUN bundle install

# Indica el puerto en el que va a escuchar el contenedor
EXPOSE 80

# Arranca la aplicación en el puerto 80 escuchando en todas las interfaces
CMD ["rackup","--host", "0.0.0.0", "-p","80", "config.ru"]

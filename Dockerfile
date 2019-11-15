FROM ruby:2.6.4

RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME

EXPOSE 80

CMD ["rackup","--host", "0.0.0.0", "-p","80", "config.ru"]

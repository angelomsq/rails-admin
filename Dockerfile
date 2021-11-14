FROM ruby:2.6.5-slim-stretch

RUN apt-get update \
  && apt-get install -y \
  build-essential \
  libpq-dev \
  mysql-client \
  default-libmysqlclient-dev \
  curl \
  git \
  nano
RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y \
  imagemagick \
  nodejs

RUN npm install -g yarn -y
RUN mkdir -p /app 
WORKDIR /app

COPY . .
# COPY ./start.sh ./

RUN gem install bundler && bundle install --jobs 20 --retry 5

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

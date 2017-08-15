FROM elixir:1.5.1

MAINTAINER Richard KEMP <richard@kemp.fr>

# Installing packages
RUN apt-get update -q && \
    apt-get -y install git curl make gcc sudo postgresql-client && \
    apt-get clean -y && \
    rm -rf /var/cache/apt/*

# Elixir Tools
RUN mix local.hex --force && \
    mix local.rebar --force

RUN mkdir -p /app
WORKDIR /app

COPY .env /app/

COPY mix.* /app/

RUN env $(cat /app/.env | grep -v -e '^#' -e '^$' | xargs) mix deps.get

COPY . /app/

RUN env $(cat /app/.env | grep -v -e '^#' -e '^$' | xargs) mix deps.compile

CMD mix katalyst.start

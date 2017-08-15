# Katalyst

_**DISCLAIMER : This application is still a work in progress
and is not ready for use**_

------

Katalyst is an API server application aimed to cover all the needs for modern
mobile and web applications. At its core it is designed to be highly modular
and scalable, with the goal to make it easily extensible. To do so, it uses
all the power of Elixir/Erlang OTP Applications.

Katalyst was built from the begin with some principles and methodologies
in mind :

- DDD
- CQRS
- ES
- ReSTful / HATEOAS
- DRY
- KISS

## Use Katalyst for your application

> TODO

## Katalyst apps

- Core : Main Library (Utils, ...)
- Router : App router with macros and helpers (supp) - CQRS etc
- Event : Event Sourcing app (supp)
- Reloader : Hot Code Reloader for dev environment (supp)
- DB : Databases management app + macros/helpers (supp ?)

## Contribute to the framework 

- Fork a new project from this repository
- Create a default `.env` file for your project

```sh
mix katalyst.gen.env
```

### Install your local dev architecture

#### With Docker

This section is to follow only once.
You could have to rebuild your container if modifications occurs in :

- `mix.exs`
- `Dockerfile`
- `docker-compose.yml`

##### Install Docker

Follow [Docker Documentation][1] to install docker on your host,
depending on your OS.

Don't forget to add your user to the `docker` group to be able to run docker
command without `sudo`.

[1]: https://docs.docker.com/engine/installation/

##### Build the project

```sh
docker-compose build
```

##### Docker useful commands

Here's a compilation of some useful commands to use with the project
on a daily basis.

###### Run the application

```sh
docker-compose up
```

###### Execute a command inside the app container

```sh
docker-compose run --rm app ls
```

###### Open a shell inside the app container

```sh
docker-compose run --rm app bash
```

#### Local Install without any container

##### System Dependencies

Based on your system, you will need to install some dependencies :

- PostgreSQL Server
- Redis

##### Mix environment

In order to work properly, `mix` needs to install some packages locally

```sh
mix local.hex --force
mix local.rebar --force
```

##### Mix dependencies

At last, you need to build the `mix` project dependencies.

```sh
mix deps.get
mix deps.compile
```
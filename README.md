# Time Manager (MSC-PRO EPITECH)
## _The Best Time Manager App, Ever 👀_

[![N|Solid](https://upload.wikimedia.org/wikipedia/commons/thumb/2/2d/Epitech.png/320px-Epitech.png)](https://www.epitech.eu/)

[![Build Status](https://app.travis-ci.com/splyters/miniproject01.svg?branch=master)](https://travis-ci.org/splyters/miniproject01)

Time Manager is a nice and useful time tracking application.

## Features

- Feature 1
- Feature 2

## Tech

Time Manager uses a number of open source projects to work properly:

- [VueJS](https://vuejs.org/) - VueJS for the front end.
- [Elixir](https://elixir-lang.org/) Elixir for the bad end.
- [Phoenix](https://www.phoenixframework.org/) Phoenix framework for Elixir.
- [Node JS](https://nodejs.org/)
- [Docker](https://www.docker.com/) Docker for portability and deployment.

## Travis CI

Everytime code is pushed to the repository a new build is created and deployed to AWS Elastic Container Service.

You can visit our website [Time Manager](http://minip-LoadB-1DLJK7SX4PZU7-67c7b3409686a1f1.elb.eu-west-3.amazonaws.com)

## Local Installation

Time Manager is very easy to install and deploy in a Docker container.

You need those variables set in your environment in order to build the project:
- DATABASE_URL (postgres URL)
- POSTGRES_DB
- POSTGRES_PASSWORD
- POSTGRES_USER
- SECRET_KEY_BASE

To deploy those variables are needed :
- AWS_ACCESS_KEY_ID
- AWS_DEFAULT_REGION
- AWS_SECRET_ACCESS_KEY
- DOCKER_HUB_PASS
- DOCKER_HUB_USER
- VUE_APP_AWS_DNS_NAME

Build 3 images:

- Front end (PORT: 80).
- Back end (PORT: 4000).
- Postgres DATABASE (PORT: 5432).

```sh
# Build the project
docker-compose build

# This will create the Time Manager images and pull in the necessary dependencies.

# Start the project
docker-compose up
```

Once done you can verify if everything is working properly by navigating to your server address in your preferred browser.

```sh
127.0.0.1:80
# OR
http://localhost:80
```

[AWS Deployment](http://minip-LoadB-1DLJK7SX4PZU7-67c7b3409686a1f1.elb.eu-west-3.amazonaws.com)

## License

MIT

**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [VueJS]: <(https://vuejs.org/>
   [Elixir]: <(https://elixir-lang.org/)>
   [Phoenix]: <(https://www.phoenixframework.org/)>
   [Node JS]: <(https://nodejs.org/)>
   [Docker]: <(https://www.docker.com/)>


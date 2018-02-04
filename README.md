# MongoDB NodeJS Dockerfile

Docker image running MongoDB and nodemon on /var/www/index.js on startup

Usage:

`docker build -t mongodb-nodejs .`

`docker run -d -p 27017:27017 -p 28017:28017 -p 4000:4000 -v /Users/mountain/Sites/express-rest-api:/var/www --name mongodb-nodejs mongodb-nodejs`


Usage with docker-compose:

`docker-compose up`

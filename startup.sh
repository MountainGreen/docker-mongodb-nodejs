#!/usr/bin/env bash

mongod --fork --rest --httpinterface --logpath /var/log/mongo.log

cd /var/www && nodemon index

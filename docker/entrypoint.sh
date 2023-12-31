#!/bin/bash

if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction
fi

if [ ! -f ".env" ]; then
    echo "Creating .env file"
    cp .env.example .env
fi

if [ ! -f "node_modules" ]; then
    echo "Installing node dependencies"
    npm install
fi

php-fpm -D
nginx -g "daemon off;"

#!/bin/sh

if [[ ! -f package.json ]]; then
    echo "The file package.json doesn't exist! Please make sure you are in the correct directory and that the corresponding file is copied to it."
    exit
fi

if [[ ! -d node_modules ]]; then
    echo "NPM modules are not installed inside the folder. Running npm install..."
    npm install
fi

if [[ -z "$@" ]]; then
    pm2-runtime npm -- start
else
    echo "Running custom command $@"
    $@
fi

#/bin/bash

docker build -t react_postgres .
docker run --rm -p 5432:5432 react_postgres
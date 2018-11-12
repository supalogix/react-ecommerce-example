#/bin/bash

docker build -t react_postgres .
docker run --rm react_postgres
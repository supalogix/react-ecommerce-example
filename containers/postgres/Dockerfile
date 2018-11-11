FROM postgres:latest

ENV POSTGRES_DB=postgres
ENV POSTGRES_USER=user
ENV POSTGRES_PASSWORD=mysecretpassword

ADD ./1-init-db.sql /docker-entrypoint-initdb.d
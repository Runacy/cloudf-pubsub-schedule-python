FROM python:3.9.10-slim-buster

RUN apt update -y && apt upgrade -y
RUN apt install -y sudo git curl
RUN pip install poetry


WORKDIR /application/src
COPY ./src/pyproject.toml /application/src
COPY ./src/poetry.lock /application/src
RUN poetry install

WORKDIR /application
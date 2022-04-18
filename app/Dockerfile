FROM python:3.8-slim as app
COPY . /src
WORKDIR /src/lib
RUN pip install .
WORKDIR /src

EXPOSE 5000

ENTRYPOINT ["python", "main.py"]
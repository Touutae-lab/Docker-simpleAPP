FROM --platform=$BUILDPLATFORM python:3.10-alpine3.15 as builder

WORKDIR /app
COPY requirement.txt /app
RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install -r requirement.txt

COPY . /app
RUN chown -R 1000 /app/
RUN chmod 755 /app/gunicorn_starter.sh
ENTRYPOINT [ "./gunicorn_starter.sh" ]

FROM builder as dev-envs

RUN apk update
RUN apk add git

RUN addgroup -S docker
RUN adduser -S --shell /bin/bash --ingroup docker vscode

COPY --from=gloursdocker/docker / /
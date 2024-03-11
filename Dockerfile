FROM golang:latest

ARG GIT_NAME

ENV GIT_NAME=$GIT_NAME

ARG GIT_EMAIL

ENV GIT_EMAIL=$GIT_EMAIL

RUN mkdir /usr/src/app

WORKDIR /usr/src/app

RUN git config --global --add safe.directory /usr/src/app

RUN git config --global --add user.name "$GIT_NAME"

RUN git config --global --add user.email "$GIT_EMAIL"

RUN go install golang.org/x/lint/golint@latest

CMD ["tail", "-f", "/dev/null"]

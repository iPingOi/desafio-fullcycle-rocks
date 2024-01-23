FROM golang:1.21.6 AS builder

WORKDIR /usr/src/app

COPY . /usr/src/app

RUN CGO_ENABLED=0 GOOS=linux go build -o build main.go

# Multi stage build
FROM scratch

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/build ./

ENTRYPOINT [ "./build" ]
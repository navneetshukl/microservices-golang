FROM golang:1.22.3-alpine as builder

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 go build -o brokerApp ./cmd/api

RUN chmod +x /app/brokerApp


# build the tiny docker image

FROM alpine:latest

COPY --from=builder /app/brokerApp /brokerApp

CMD ["/brokerApp"]
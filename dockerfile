FROM golang:1.23 AS builder
WORKDIR /web
COPY . .
RUN CSG_ENABLED=0 GOOS=linux GOARH=amd64 go build -o app . #/web/app

FROM alpine:3.20
WORKDIR /srv
COPY --from=builder /web/app .
COPY --from=builder /web/templates ./templates

EXPOSE 80
CMD ["./app"]
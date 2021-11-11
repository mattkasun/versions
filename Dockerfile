From golang:latest AS builder
ARG VERSION=testing
WORKDIR /go/src/app
COPY main.go go.* ./
RUN go build -o main -ldflags='-X=main.version=${VERSION}' .

FROM debian:buster-slim
COPY --from=builder /go/src/app/main /go/bin/main
ENV PATH="go/bin:${PATH}"
CMD ["main"]

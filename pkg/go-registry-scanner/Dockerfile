FROM golang:alpine

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY *.go ./
RUN go build -o /registry-scanner

CMD ["/registry-scanner"]

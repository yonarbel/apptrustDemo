# Build
FROM golang:1.22-alpine AS build
WORKDIR /src
COPY go.mod ./
RUN go mod download
COPY . .
RUN go build -o /app/kitchen-worker
# Run
FROM alpine:3.20
WORKDIR /app
COPY --from=build /app/kitchen-worker /usr/local/bin/kitchen-worker
CMD ["kitchen-worker"]

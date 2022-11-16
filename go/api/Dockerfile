FROM golang:1.18 as build

WORKDIR /go/src/app

COPY . .
RUN go mod download

RUN go build -o /go/bin/app ./cmd/server/main.go ./cmd/server/controller.go


FROM gcr.io/distroless/base-debian11
COPY --from=build /go/bin/app /app
EXPOSE 8080
CMD ["/app"]

all: fmt build test

fmt:
  go mod tidy
  go fmt ./...

build:
  go build ./...

test:
  go test -race ./...

release-local:
  goreleaser release --snapshot --clean

release-snapshot:
  goreleaser release --snapshot

release:
  goreleaser release

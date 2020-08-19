.PHONY: test
test:
	@docker run --rm -v "$(PWD)":/usr/src/myapp:Z -w /usr/src/myapp golang:1.15 go test ./...


build:
	@docker run --rm -v "$(PWD)":/usr/src/myapp:Z -w /usr/src/myapp \
	-e CGO_ENABLED=0 -e GOOS=linux \
	golang:1.15 go build -a -installsuffix nocgo -o deadmanswatch .

docker:
	docker build -t deadmanswatch .
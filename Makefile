TAG=elasticsearch

build:
	docker build -t $(TAG) .

bash:
	docker run -it --rm --entrypoint="/bin/bash" $(TAG)

test: clean-test start-test curl-test clean-test

curl-test:
	sleep 10 # pathetic, but let elasticsearch to boot
	docker run --rm --link $(TAG)-test:elasticsearch --entrypoint="/bin/bash" $(TAG) -c 'curl "$${ELASTICSEARCH_PORT_9300_TCP_ADDR}:9200"'

start-test:
	docker run -d --name $(TAG)-test $(TAG)

clean-test:
	- docker rm -f $(TAG)-test

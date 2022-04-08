FROM crystallang/crystal:latest-alpine as builder

WORKDIR /app

COPY ./shard.yml ./shard.lock ./
RUN shards install --production

COPY . ./
RUN shards build --static --no-debug --release --production

FROM alpine:latest

WORKDIR /

COPY --from=builder /app/bin/main .

ENTRYPOINT ["/main"]

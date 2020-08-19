FROM alpine:latest AS builder

LABEL maintainer="kierranm@gmail.com" \
      description="Forwards prometheus DeadMansSwitch alerts to CloudWatch" \
      version="0.0.3"

RUN adduser -D -u 10001 -g 10001 deadmanswatch
COPY ./deadmanswatch ./
RUN apk add --update ca-certificates

FROM scratch
COPY --from=builder /deadmanswatch ./
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

USER deadmanswatch
WORKDIR /
ENTRYPOINT ["./deadmanswatch"]

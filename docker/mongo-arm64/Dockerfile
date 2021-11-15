FROM registry.bookmyshow.org/alpine/golang:1.16.5-arm64 as builder

RUN apk --no-cache add curl git make perl ca-certificates
RUN curl -s https://glide.sh/get | sh
COPY ./mongodb_exporter-master /mongodb_exporter/
RUN     mkdir -p /go/src/github.com/dcu && \
        mv /mongodb_exporter/ /go/src/github.com/dcu/mongodb_exporter && \
        cd /go/src/github.com/dcu/mongodb_exporter && \
        make release

WORKDIR /go/src/github.com/dcu/mongodb_exporter

EXPOSE 9001

ENTRYPOINT [ "./release/mongodb_exporter-linux-arm64" ]
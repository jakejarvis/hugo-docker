FROM alpine:latest

ENV HUGO_VERSION 0.41

LABEL "com.github.actions.name"="Hugo Build"
LABEL "com.github.actions.description"="Hugo as an action. Includes legacy versions."
LABEL "com.github.actions.icon"="edit"
LABEL "com.github.actions.color"="gray-dark"

LABEL version="${HUGO_VERSION}"
LABEL repository="https://github.com/jakejarvis/hugo-build-action"
LABEL homepage="https://jarv.is/"
LABEL maintainer="Jake Jarvis <jake@jarv.is>"

RUN apk update && \
    apk add --no-cache ca-certificates && \
    update-ca-certificates && \
    wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_checksums.txt && \
    grep hugo_${HUGO_VERSION}_Linux-64bit.tar.gz hugo_${HUGO_VERSION}_checksums.txt | sha256sum -c && \
    tar xf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    mv ./hugo /usr/bin && \
    chmod +x /usr/bin/hugo && \
    rm -rf hugo_${HUGO_VERSION}_*

ENTRYPOINT ["hugo"]

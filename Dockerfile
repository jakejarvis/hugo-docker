FROM node:12-alpine

ENV HUGO_VERSION 0.68.2
# remove/comment the following line completely to build with vanilla Hugo:
ENV HUGO_EXTENDED 1

LABEL "com.github.actions.name"="Hugo Build"
LABEL "com.github.actions.description"="Hugo as an action, with extended support and legacy versions"
LABEL "com.github.actions.icon"="edit"
LABEL "com.github.actions.color"="gray-dark"

LABEL version="${HUGO_VERSION}${HUGO_EXTENDED:+-extended}"
LABEL repository="https://github.com/jakejarvis/hugo-build-action"
LABEL homepage="https://jarv.is/"
LABEL maintainer="Jake Jarvis <jake@jarv.is>"

# only install libc6-compat & libstdc++ if we're building extended Hugo
# https://gitlab.com/yaegashi/hugo/commit/22f0d5cbd6114210ba7835468facbdee60609aa2
RUN apk update && \
    apk add --no-cache \
      ca-certificates \
      git \
      asciidoctor \
      python3 \
      py3-pygments \
      ${HUGO_EXTENDED:+libc6-compat libstdc++} && \
    update-ca-certificates && \
    wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_EXTENDED:+extended_}${HUGO_VERSION}_Linux-64bit.tar.gz && \
    wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_checksums.txt && \
    grep hugo_${HUGO_EXTENDED:+extended_}${HUGO_VERSION}_Linux-64bit.tar.gz hugo_${HUGO_VERSION}_checksums.txt | sha256sum -c && \
    tar xf hugo_${HUGO_EXTENDED:+extended_}${HUGO_VERSION}_Linux-64bit.tar.gz && \
    mv ./hugo /usr/bin && \
    chmod +x /usr/bin/hugo && \
    rm -rf hugo_*

# make sure everything's okay
RUN hugo version

ENTRYPOINT ["hugo"]

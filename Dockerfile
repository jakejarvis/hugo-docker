# Hugo doesn't require Go to run, *except* if you're using Hugo Modules. It's
# much easier to install Node on the Go base image than vice-versa.
FROM golang:1.16-alpine AS build

# the following version can be overridden at image build time with --build-arg
ARG HUGO_VERSION=0.81.0
# remove/comment the following line completely to build with vanilla Hugo:
ARG HUGO_BUILD_TAGS=extended

LABEL version="${HUGO_VERSION}"
LABEL repository="https://github.com/jakejarvis/hugo-docker"
LABEL homepage="https://jarv.is/"
LABEL maintainer="Jake Jarvis <jake@jarv.is>"

# https://docs.github.com/en/free-pro-team@latest/packages/managing-container-images-with-github-container-registry/connecting-a-repository-to-a-container-image#connecting-a-repository-to-a-container-image-on-the-command-line
LABEL org.opencontainers.image.source https://github.com/jakejarvis/hugo-docker

ARG CGO=1
ENV CGO_ENABLED=${CGO}
ENV GOOS=linux
ENV GO111MODULE=on

WORKDIR /go/src/github.com/gohugoio/hugo

# gcc/g++ are required to build SASS libraries for extended version
RUN apk update && \
    apk add --no-cache \
      gcc \
      g++ \
      musl-dev && \
    go get github.com/magefile/mage

RUN wget https://github.com/gohugoio/hugo/archive/v${HUGO_VERSION}.tar.gz && \
    tar xf v${HUGO_VERSION}.tar.gz --strip-components=1 && \
    rm v${HUGO_VERSION}.tar.gz

RUN mage hugo && mage install

# fix potential stack size problems on Alpine
# https://github.com/microsoft/vscode-dev-containers/blob/fb63f7e016877e13535d4116b458d8f28012e87f/containers/hugo/.devcontainer/Dockerfile#L19
RUN go get github.com/yaegashi/muslstack && \
    muslstack -s 0x800000 /go/bin/hugo

# ---

FROM alpine:3.13

COPY --from=build /go/bin/hugo /usr/local/bin/hugo

# libc6-compat & libstdc++ are required for extended SASS libraries
# ca-certificates are required to fetch outside resources (like Twitter oEmbeds)

RUN apk update && \
    apk add --no-cache \
      ca-certificates \
      git \
      nodejs \
      npm \
      yarn \
      go \
      python3 \
      py3-pip \
      ruby \
      libc6-compat \
      libstdc++ && \
    update-ca-certificates

# download Hugo and miscellaneous optional dependencies
RUN npm install --global postcss postcss-cli autoprefixer @babel/core @babel/cli && \
    gem install asciidoctor && \
    pip3 install --upgrade Pygments==2.*

# verify everything's OK, exit otherwise
RUN hugo env && \
    go version && \
    node --version && \
    postcss --version && \
    autoprefixer --version && \
    babel --version && \
    pygmentize -V && \
    asciidoctor --version

# add site source as volume
VOLUME /src
WORKDIR /src

# expose live-refresh server
EXPOSE 1313

ENTRYPOINT ["hugo"]

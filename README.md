# ✏️ [Hugo](https://github.com/gohugoio/hugo) via Docker 

[![Build docs](https://img.shields.io/docker/cloud/build/jakejarvis/hugo-extended?label=Docker%20Hub&logo=docker&logoColor=%23fff)](https://hub.docker.com/r/jakejarvis/hugo-extended)

A base image to ease local development of Hugo sites, including [Hugo Extended](https://gohugo.io/troubleshooting/faq/#i-get-tocss-this-feature-is-not-available-in-your-current-hugo-version) (with SASS/SCSS support) and third-party tools [listed below](#third-party-software).

## Usage

### Command line

```bash
docker run -v $(pwd):/src -p 1313:1313 jakejarvis/hugo-extended:latest server --buildDrafts --buildFuture --bind 0.0.0.0
```

### `docker-compose.yml`

```yaml
version: 3

services:
  hugo:
    image: jakejarvis/hugo-extended:latest
    ports:
      - 1313:1313
    volumes:
      - ./:/src
    command: server --buildDrafts --buildFuture --bind 0.0.0.0
```

### Live server

When using Docker to run a live server (via `hugo server`), you must pass `--bind 0.0.0.0` as an argument to fix some networking quirks between Hugo, the container, and the host.

## Third-party software

Just in case, the final container includes a few small third-party tools that are required by certain optional Hugo features:

- [PostCSS (CLI)](https://github.com/postcss/postcss-cli)
- [Autoprefixer](https://github.com/postcss/autoprefixer)
- [Babel (CLI)](https://babeljs.io/)
- [Pygments](https://pygments.org/)
- [Asciidoctor](https://asciidoctor.org/)

Node (with NPM and Yarn) and Go (for [Hugo Modules](https://gohugo.io/hugo-modules/) support) are also pre-installed.

## Licenses

This action is distributed under the [MIT License](LICENSE.md). Hugo is distributed under the [Apache License 2.0](https://github.com/gohugoio/hugo/blob/master/LICENSE).

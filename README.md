# GitHub Action for [Hugo](https://github.com/gohugoio/hugo) ✏️ 

> **⚠️ Note:** To use this action, you must have access to the [GitHub Actions](https://github.com/features/actions) feature. GitHub Actions are currently only available in public beta. You can [apply for the GitHub Actions beta here](https://github.com/features/actions/signup/).

This is a simple GitHub Action that contains [Hugo](https://github.com/gohugoio/hugo), the popular static site generator. Unlike other actions, this action includes releases going back to [v0.27](https://github.com/gohugoio/hugo/releases/tag/v0.27) (Sept. 11, 2017) for any compatibility requirements.

## Usage

### `workflow.yml` Example

This example simply uploads the `./public` directory (the built Hugo website) as an artifact. You can replace the last `actions/upload-artifact` step with another action, like my [s3-sync-action](https://github.com/jakejarvis/s3-sync-action), to upload the built static site somewhere accessible.

Replace the `master` in `uses: jakejarvis/hugo-build-action@master` to specify the Hugo version, back to [v0.27](https://github.com/gohugoio/hugo/releases/tag/v0.27), like `hugo-build-action@v0.27`. This might be necessary if a recent version broke compatibility with your site. Otherwise, you'll get the [latest version](https://github.com/gohugoio/hugo/releases).

The `with: args:` portion holds any [optional flags](https://gohugo.io/commands/hugo/). You can remove those two lines for a vanilla build.

```
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: jakejarvis/hugo-build-action@master
      with:
        args: --minify --buildDrafts
    - uses: actions/upload-artifact@master
      with:
        name: website
        path: './public'
```


## License

[![CC0](http://mirrors.creativecommons.org/presskit/buttons/88x31/svg/cc-zero.svg)](https://creativecommons.org/publicdomain/zero/1.0/)

To the extent possible under law, [Jake Jarvis](https://jarv.is/) has waived all copyright and related or neighboring rights to this work.

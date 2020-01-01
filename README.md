# GitHub Action for [Hugo](https://github.com/gohugoio/hugo) ✏️ 

This is a simple GitHub Action that contains [Hugo](https://github.com/gohugoio/hugo), the popular static site generator. The [extended version](https://gohugo.io/troubleshooting/faq/#i-get-tocss-this-feature-is-not-available-in-your-current-hugo-version) is now bundled by default. Unlike other actions, this action includes releases going back to [v0.27](https://github.com/gohugoio/hugo/releases/tag/v0.27) (September 2017) for any compatibility requirements.

## Usage

### `workflow.yml` Example

This example simply uploads the `./public` directory (the built Hugo website) as an artifact. You can replace the last `actions/upload-artifact` step with another action, like James Ives' [GitHub Pages deploy action](https://github.com/JamesIves/github-pages-deploy-action) or my [S3 sync action](https://github.com/jakejarvis/s3-sync-action), to upload the built static site somewhere accessible.

Replace the `master` in `uses: jakejarvis/hugo-build-action@master` to specify the Hugo version, back to [v0.27](https://github.com/gohugoio/hugo/releases/tag/v0.27), like `hugo-build-action@v0.27`. This might be necessary if a recent version broke compatibility with your site. Otherwise, you'll get the [latest version](https://github.com/gohugoio/hugo/releases).

The `with: args:` portion holds any [optional flags](https://gohugo.io/commands/hugo/). You can remove those two lines for a vanilla build.

```yaml
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


## Licenses

This action is distributed under the [MIT License](LICENSE.md). Hugo is distributed under the [Apache License 2.0](https://github.com/gohugoio/hugo/blob/master/LICENSE).

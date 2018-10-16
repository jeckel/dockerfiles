# Static site minifier

This image is a command line tool to minify static files of a website, using common tools:
- [html-minifier](https://github.com/kangax/html-minifier)
- [csso](https://github.com/css/csso)
- [uglify-js](https://github.com/mishoo/UglifyJS2)

# Usage

By default, it will look for all files within the `src` folder, and minify them into the same directory structure into the `dist` folder.

```bash
docker run --rm \
    -v $(pwd):/project \
    -u $(id -u):$(id -g) \
    jeckel/minifier
```

- mount your project in the `/project` folder in the container
- force user as the current user
- And... that's it

# Environment variables

You can override some variable to customize behavior

- `SRC_DIR`: change the source folder within the container (by default: `/project/src`)
- `DIST_DIR`: change the destination folder within the container (by default: `/project/dist`)

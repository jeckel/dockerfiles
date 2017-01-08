[![](https://images.microbadger.com/badges/image/jeckel/codeception.svg)](https://microbadger.com/images/jeckel/codeception "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/jeckel/codeception.svg)](https://microbadger.com/images/jeckel/codeception "Get your own version badge on microbadger.com") [![Twitter](https://img.shields.io/badge/Twitter-%40jeckel4-blue.svg)](https://twitter.com/intent/user?screen_name=jeckel4)

## Jeckel/Codeception

This image is proposing codeception running with the mounted local user. It avoid generating file under the root user.

It's based on the official [Codeception](https://hub.docker.com/r/codeception/codeception/) image

## Usage

You can run every codeception commands like this :

```bash
docker run --rm -it -v `pwd`:/project jeckel/codeception [command]
```

For example, to bootstrap a new codeception project :
```bash
docker run --rm -it -v `pwd`:/project jeckel/codeception bootstrap
```

## Add shell alias

Create shell alias

```bash
$ echo "alias codecept='docker run --rm -it -v \$(pwd):/project jeckel/codeception'" >> ~/.bashrc
$ source ~/.bashrc
```
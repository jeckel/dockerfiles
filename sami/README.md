# SAMI on Docker

This Dockerfile allow to use [Sami](https://github.com/FriendsOfPHP/Sami) (a PHP API documentation generator) over docker.

# Usage

First, you need a Sami configuration file... see [Sami's documentation](https://github.com/FriendsOfPHP/Sami)

```bash
docker run --rm -u `id -u`:`id -g` \
	-v `pwd`:/build
	jeckel/sami update /build/samiConfig.php
```

Default working directory is `/build`.

Default docker entrypoint is `sami`, then all additional parameters will be directly used on sami command.
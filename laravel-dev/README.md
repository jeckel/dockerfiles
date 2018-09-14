# Laravel Dev

## Usage

**Create new project:**

```bash
docker run -v $(pwd):/project \
    --user $(id -u):$(id -g) \
     --rm -it \
     jeckel/laravel-dev laravel --ansi new --force . 
```
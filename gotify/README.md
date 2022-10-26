# Gotify

# Requirements
- Docker
- Docker-compose
- Traefik as a reverse proxy in front of it

# Setup
## `.env` file
Change the domain in the `.env` file to your domain.
```yaml
DOMAIN="example.com"
```
```sh
$ cd gotify
$ docker-compose up -d
```
or use the script in the root directory of this repo
```sh
./docker.sh -S proxy -r
./docker.sh -S gotify -r
```

Done. Now open https://push.example.com. Default login: username: `admin` password: `admin`

# Source
- [Gotify docs](https://gotify.net/)
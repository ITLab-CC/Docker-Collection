# GitLab

# Requirements
- Docker
- Docker-compose
- traefik as a reverse proxy in front of it

# Setup
## `.env` file
Change the domain in the `.env` file.
```yaml
DOMAIN="example.com"
```

## Start
```sh
$ cd gitlab
$ docker-compose up -d
```
or
```sh
./docker.sh -S gitlab -r
```

Done. Now open  https://git.example.com

# Source
- [linuxserver.io docs](https://docs.gitlab.com/ee/install/docker.html)
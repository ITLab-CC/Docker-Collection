# Openproject

# Requirements
- Docker
- Docker-compose
- traefik as a reverse proxy in front of it

# Setup
## `.env` file
Change the domain in the `.env` file to your domain and the password of the database.
```yaml
DOMAIN="example.com"

TAG=13
OPENPROJECT_HTTPS=true
OPENPROJECT_HSTS=true
OPENPROJECT_RAILS__RELATIVE__URL__ROOT=
RAILS_MIN_THREADS=4
RAILS_MAX_THREADS=16
IMAP_ENABLED=false
POSTGRES_PASSWORD=p4ssw0rd
```
```sh
$ cd openproject
$ docker-compose up -d
```
or
```sh
./docker.sh -S proxy -r
./docker.sh -S openproject -r
```

## Login
It will take some time until the server is up and running. Open https://openproject.example.com and login with user `admin` and password `admin`
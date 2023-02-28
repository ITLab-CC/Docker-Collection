# Mailcow
# This is from "https://github.com/mailcow/mailcow-dockerized"

# Requirements
- Docker
- Docker-compose
- traefik as a reverse proxy in front of it

# Setup
<!-- Change the variables in the `.env` file to your need.
```yaml
DOMAIN="example.com"                # (line 1)
MAILCOW_HOSTNAME="mail.example.com" # (line 9)
``` -->
Execute `generate_config.sh`
```sh
$ sudo chmod +x ./generate_config.sh
$ ./generate_config.sh
```
Check newsted version from "https://hub.docker.com" and add it to `.env`
[mailcow/dovecot as DOVECOT='VERISON'](https://hub.docker.com/r/mailcow/dovecot/tags)
[mailcow/netfilter as NETFILTER='VERISON'](https://hub.docker.com/r/mailcow/netfilter/tags)
[mailcow/watchdog as WATCHDOG='VERISON'](https://hub.docker.com/r/mailcow/watchdog/tags)
[mailcow/dockerapi as DOCKERAPI='VERISON'](https://hub.docker.com/r/mailcow/dockerapi/tags)
[mailcow/solr as SOLR='VERISON'](https://hub.docker.com/r/mailcow/solr/tags)
[mailcow/olefy as OLEFY='VERISON'](https://hub.docker.com/r/mailcow/olefy/tags)
<!-- DOVECOT='1.22'
NETFILTER='1.51'
WATCHDOG='1.97'
DOCKERAPI='2.01'
SOLR='1.8.1'
OLEFY='1.11' -->
```sh
$ cd Mailcow
$ docker-compose up -d
```
or
```sh
./docker.sh -S proxy -r
./docker.sh -S Mailcow -r
```
Done. Now open https://mail.example.com
#Follow now this manuel "https://www.bennetrichter.de/anleitungen/mailcow-dockerized/" to configurate Mailcow
# Duplicati

# Requirements
- Docker
- Docker-compose
- traefik as a reverse proxy in front of it

# Setup
## `.env` file
Change the domain and the time zone in the `.env`.
```yaml
DOMAIN="example.com"
TimeZone='Europe/Berlin'
```
```sh
$ cd duplicati
$ docker-compose up -d
```
or
```sh
./docker.sh -S duplicati -r
```

Done. Now open https://backup.example.com\
Click no if you have a password infront of Duplicati. Like Authelia does.
![setup1](img/setup1.png)
![setup2](img/setup2.png)
![setup3](img/setup3.png)
Chose your preferred backup destination type. There is a lot to choose from. I chose onedrive. Then cklick on the word `AuthID`. It will redirect you to a new page where you have to login into onedrive.\
![setup4](img/setup4.png)
![setup5](img/setup5.png)
![setup6](img/setup6.png)
![setup7](img/setup7.png)
![setup8](img/setup8.png)
![setup9](img/setup9.png)

## Start a backup
![backup1](img/backup1.png)
![backup2](img/backup2.png)
The backup will automaticly uploaded to the cloud. It will also be encrypted.

## Restore
![restore1](img/restore1.png)
![restore2](img/restore2.png)
![restore3](img/restore3.png)

# Source
- [linuxserver.io docs](https://docs.linuxserver.io/images/docker-heimdall)
<div align="left">
      <a href="https://www.youtube.com/watch?v=JoA6Bezgk1c">
         <img src="https://img.youtube.com/vi/JoA6Bezgk1c/0.jpg" style="width:40%;">
      </a>
</div>
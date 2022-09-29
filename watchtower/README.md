# Watchtower

# Requirements
- Docker
- Docker-compose

# Setup
## `.env` file
Change the time zone in the `.env` file.
```yaml
TimeZone='Europe/Berlin'
```

## Start
```sh
$ cd watchtower
$ docker-compose up -d
```
or
```sh
./docker.sh -S watchtower -r
```

Done. It will now start updating your containers every day.

## Change intervall
You can change the intervall by edeting this line: `command: --interval 86400`. Write here your new time in seconds.

# Gotify notification
Everytime a container gets updated you can send a push message to your phone. This is works with the push service `Gotify`. You just have to add those lines to your environment variables.
```yaml
      - notifications-level=trace
      - WATCHTOWER_NOTIFICATIONS=gotify
      - WATCHTOWER_NOTIFICATION_GOTIFY_URL=http://gotify
      - WATCHTOWER_NOTIFICATION_GOTIFY_TOKEN=XXXXXXXXXXXXXXX
      - WATCHTOWER_NOTIFICATION_GOTIFY_TLS_SKIP_VERIFY=true
```
Replace the `WATCHTOWER_NOTIFICATION_GOTIFY_TOKEN` with a generated one from `Gotify`.\
Also Replace `WATCHTOWER_NOTIFICATION_GOTIFY_URL` with the name of your gotify container.\
Both containers must be in the same network!!!

# Source
- [Watchtower docs](https://containrrr.dev/watchtower/)
- [Watchtower Gotify docs](https://containrrr.dev/watchtower/notifications/#gotify)
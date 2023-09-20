# Craterapp - Embedded Invoicing & Bill Pay for platforms.

origin: https://crater.financial/

## How to Install:

Clone the repository by running this command: 

```sh
$ git clone https://github.com/crater-invoice/crater
```

Change your current working directory and run your app using below commands:

```sh
$ cd crater
$ cp .env.example .env
```

edit .env for your needs.

```sh
code .env
```

continue with

```sh
$ cp docker-compose.yml crater/docker-compose.yml
$ docker-compose up -d
$ ./docker-compose/setup.sh
```

Update Docker-Compose for your needs:

```yml
nginx:
    container_name: crater-nginx
    image: nginx:1.17-alpine
    restart: unless-stopped
    #ports:
      #- 8083:80
    volumes:
      - ./:/var/www
      - ./docker-compose/nginx:/etc/nginx/conf.d/
    networks:
      - crater
      - proxy
    labels:
      - "traefik.enable=true"                                                       #<== Enable traefik
      - "traefik.http.routers.crater-secured.rule=Host(`finance.${DOMAIN}`)"    #<== Set domain
      - "traefik.http.routers.crater-secured.entrypoints=websecure"            #<== Set entry point for HTTPS
      - "traefik.http.routers.crater-secured.tls.certresolver=mytlschallenge"  #<== Set certsresolvers for https
      #- "traefik.http.routers.crater-secured.middlewares=authelia"             #<== Add Authelia middlewares to protect login
      - "traefik.http.routers.crater-secured.service=crater-service"      #<== Set service
      - "traefik.http.services.crater-service.loadbalancer.server.port=80"     #<== Set target port on container
```

watch out for 

```yml
- "traefik.http.routers.crater-secured.middlewares=authelia"
```

if you want to be protected by authelia and make sure, you've added DOMAIN to your .env and customized for your needs. 

```yml
- "traefik.http.routers.crater-secured.rule=Host(`finance.${DOMAIN}`)"
```


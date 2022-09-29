# Hedgedoc
# Requirements
- Docker
- Docker-compose
- traefik as a reverse proxy in front of it
- (Authelia for OIDC (Advanced))

# Setup
## `.env` file
Change the informations in the `.env` file.
```yaml
DOMAIN="example.com"
TimeZone='Europe/Berlin'
MYSQL_ROOT_PASSWORD='XXXXXXXXXXXXXXXXXXXXXXXX'
MYSQL_DATABASE=hedgedoc
MYSQL_USER=hedgedoc
MYSQL_PASSWORD='XXXXXXXXXXXXXXXXXXXXXXXX'
```
## Start
```sh
$ cd heimdall
$ docker-compose up -d
```
or
```sh
./docker.sh -S heimdall -r
```

Done. Now open https://docs.example.com

# Advanced
## Add Authelia as OIDC
To login through Authelia you have to add the following lines to the environment variables section at the hedgedoc container.
```
    environment:
      #Authelia as OIDC
      - CMD_OAUTH2_CLIENT_ID=hedgedoc
      - CMD_OAUTH2_CLIENT_SECRET=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      - CMD_OAUTH2_AUTHORIZATION_URL=https://auth.${DOMAIN}/api/oidc/authorization
      - CMD_OAUTH2_TOKEN_URL=https://auth.${DOMAIN}/api/oidc/token
      - CMD_OAUTH2_USER_PROFILE_URL=https://auth.${DOMAIN}/api/oidc/userinfo
      - CMD_OAUTH2_USER_PROFILE_USERNAME_ATTR=preferred_username
      - CMD_OAUTH2_USER_PROFILE_DISPLAY_NAME_ATTR=name
      - CMD_OAUTH2_USER_PROFILE_EMAIL_ATTR=email
      - "CMD_OAUTH2_SCOPE=openid profile groups email"
```
In Authelia you have to add this to the identity_providers: and clients: section in the `configuration` file of Authelia:
```yaml
identity_providers:
    ...
    clients:
        ...
        - id: hedgedoc
          description: Hedgedoc wants some information to log you in.
          secret: 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
          public: false
          authorization_policy: one_factor
          audience: []
          scopes:
            - openid
            - profile
            - groups
            - email
          redirect_uris:
            - https://docs.kropp.link/auth/oauth2/callback
          userinfo_signing_algorithm: none
        ...
```
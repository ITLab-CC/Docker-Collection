# Docker-Collection

This is a summary of many Docker setups. In each folder, there is an instruction to setup this docker configuration. Be aware that most containers work with traefik as a reverse proxy in front of it. For an easy setup and to tell traefik where to route the traffic we use traefik labels on each container and one network named "proxy" for all containers. We know that this isn't the securest way, but the most flexible and easiest way to implement.

# Setup
## Docker
### 1. Update and Upgrade
- `sudo apt-get update && sudo apt-get upgrade -y`

### 2. Install Docker
Docker provides a install script. Just run:

- `curl -sSL https://get.docker.com | sh`

### 3. Add a Non-Root User to the Docker Group
By default, only users who have administrative privileges (root users) can run containers.
You could also add your non-root user to the Docker group which will allow it to execute docker commands.

To add the current user to the Docker group run:
- `sudo usermod -aG docker ${USER}`

Reboot the server to let the changes take effect.
### 4. Install Docker-Compose
Docker-Compose usually gets installed using pip3. For that, we need to have python3 and pip3 installed.
- `sudo apt-get install libffi-dev libssl-dev -y`
- `sudo apt install python3-dev -y`
- `sudo apt-get install python3 python3-pip -y`

Now we can install Docker-Compose.
- `sudo pip3 install docker-compose`

### 5. Enable Docker to start your containers on boot

You can configure your server to automatically run the Docker system service, whenever it boots up.
- `sudo systemctl enable docker`

### 6. Enable IPv6
Edit or create this file: `sudo nano /etc/docker/daemon.json`
```json
{
  "ipv6": true,
  "fixed-cidr-v6": "2001:db8:1::/64",
  "experimental": true,
  "ip6tables": true
}
```
Now restart docker with: `sudo service docker restart`

### Test IPv6:
To test IPv4 and IPv6 you can use thw whoami container (which is in the proxy/docker-compose.yaml file) without a password  protection (no Authelia) and open this webside through this one below:
- https://www.wormly.com/test-http-request/url/


# Docker script
For an easy start of the containers, there is a script with which you can start and stop all of them or only chosen stacks. A stack is a combination of multiple containers which are all in one folder/docker-compose.yml file.\
Example:
## Help
`./docker.sh -h`
## List all stacks
`./docker.sh -l`

## Create a new Stack
`./docker.sh -c [StackName]`

## Run a specific stack
`./docker.sh -S [StackName] -r`
## Stop a specific stack
`./docker.sh -S [StackName] -s`

## Run all containers/stacks
`./docker.sh -r`
## Stop all containers/stacks
`./docker.sh -s`

## .stackignore
If you run `./docker.sh -r` or `./docker.sh -s` the script will look into each folder in this directory and look for a file named `docker-composed.yml`. If it exists it will deploy this stack. If you want to ignore a folder you have to write the name of the folder in the `.stackignore` file. It works similarly to the .gitignore file.\
Example:
```
nextcloud
onedrive
#portainer
#traefik
webtop
```
When you now run `./docker.sh -r` or `./docker.sh -s` all the stacks will start/stop except `nextcloud`, `onedrive` and `webtop`
## global.env
Every time you run `docker.sh` it will check that all the environment variables in the `global.env` file are present in each `.env` file in each folder in this directory. The `.stackignore` file doesn't have any impact on this function. This means it will update also the `.env` file even if this stack is in the `.stackignore` file. If you delete or update a variable from the `global.env` file, it will detect this and will remove it from each `.env` file.
Example:
```
Domain='example.com'
ServerIPv4='123.456.789.123'
ServerIPv6='abcd:efgh:123:456:789:0000:0000:0001'
TimeZone='Europe/Berlin'
```

# File structure and documentation rules
1. Pls use the `docker.sh` script to generate new stacks. It will automaticly create a new stack with the following structure (example):
    ```
    .
    ├── example
    │   ├── build (optional)
    │   │   └── dockerfile (optional)
    │   ├── data (folder)
    │   ├── docker-compose.yml
    │   ├── .env
    │   ├── .gitignore
    │   └── README.md
    │
    ...
    ```
    - If you need a `Dockerfile` to build your own container pls manually add a folder named `build` with the `Dockerfile` inside (optional).
2. In each folder there should be a README with setup instructions about this stack. 
3. For clean and nice emojis in the git commits pls have a look at [gitmoji.dev](https://gitmoji.dev/)
4. Feel free to extend the docker collection :D

# Source
- Docker:
    - [How To Install Docker and Docker-Compose On Raspberry Pi ](https://dev.to/elalemanyo/how-to-install-docker-and-docker-compose-on-raspberry-pi-1mo)
    - [Traefik v2.1.4: X-Forwarded-For header doet not pass visitor IP when using IPv6](https://community.traefik.io/t/traefik-v2-1-4-x-forwarded-for-header-doet-not-pass-visitor-ip-when-using-ipv6/4803/8)
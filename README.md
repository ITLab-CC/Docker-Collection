# Docker-Collection

This is a summary of many Docker setups. In each folder, there is an instruction to setup this docker configuration. Be aware that most containers work with traefik as a reverse proxy in front of it. For an easy setup and to tell traefik where to route the traffic we use traefik labels on each container and one network named "proxy" for all containers. We know that this isn't the securest way, but the most flexible and easiest way to implement.

# Setup
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
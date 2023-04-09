# Nextcloud
## .env add variable
You need in your `.env` this 3 varaible.
```.env
DOMAIN='EXAMPLE.com'
TimeZone='EXAMPLE/EXAMPLE'
Password='XXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
```
## Start the containers
```sh
$ cd nextcloud
$ docker-compose up -d
```
or use the shell script in the root directory of this repo
```sh
./docker.sh -S nextcloud -r
```
Done. Now open https://cloud.example.com and use your cloud
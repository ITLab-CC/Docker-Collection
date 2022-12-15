# sharelatex

## Quick Start Guide
- https://github.com/overleaf/overleaf/wiki/Quick-Start-Guide
- https://github.com/overleaf/overleaf/blob/old-master/docker-compose.yml

## Create Admin user
```
docker exec sharelatex /bin/bash -c "cd /var/www/sharelatex; grunt user:create-admin --email=joe@example.com"
```
OR Goto https://example.com/launchpad


<!-- ## Info: LaTeX Error
To save bandwidth, the Overleaf image only comes with a minimal install of TeXLive. To upgrade to a complete TeXLive installation, run the installation script in the Overleaf container with the following command:
```
$ docker exec sharelatex tlmgr install scheme-full
$ docker commit sharelatex sharelatex/sharelatex:with-texlive-full
```
- https://github.com/overleaf/overleaf/issues/731 -->
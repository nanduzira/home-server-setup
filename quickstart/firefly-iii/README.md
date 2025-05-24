# firefly-iii

This folder contains the sample reference of the docker compose files,

_Refer: [How to install Firefly III using Docker](https://docs.firefly-iii.org/how-to/firefly-iii/installation/docker/)_

## Start the container

```shell
cp example.env .env
docker compose -f docker-compose.yml up -d --pull=always
docker compose -f docker-compose.yml logs -f
```

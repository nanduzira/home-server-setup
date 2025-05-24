# home-server-setup

## Getting started

### ENV file

Add the proper `HOME_SERVER_BASE_DOMAIN` value(your base domain to host the server).

### Start the server

```shell
# On tower server
❯ docker compose --profile tower --env-file .env up -d

# On black-tower server
❯ docker compose --profile black-tower --env-file .env up -d
```

### Stop the server

```shell
# On tower server
❯ docker compose --profile tower down --remove-orphans

# On black-tower server
❯ docker compose --profile black-tower down --remove-orphans
```

## Servers

- tower
- black-tower

### Services in `tower` server

- Deployed:
  - swag
  - heimdall
  - code-server
  - myst
- ToDo:
  - firefly
  - bitwarden
  - pi-hole

### Services in `black-tower` server

- Deployed:
  - mariadb
  - nextcloud
  - jellyfin
- ToDo:
  - ente.io

## Volumes used by the Services

| Name               | Type | Service     | Local path (if any)    | Read Only | Description                  |
| ------------------ | ---- | ----------- | ---------------------- | --------- | ---------------------------- |
| Heimdall (config)  | Bind | heimdall    | `./heimdall/config`    | No        | Heimdall config path         |
| Myst (data)        | Bind | myst        | `./myst/data`          | No        | Myst data path               |
| MariaDB            | Bind | mariadb     | `./mariadb/config`     | No        | MariaDB data/config path     |
| Nextcloud (config) | Bind | nextcloud   | `./nextcloud/config`   | No        | Nextcloud config path        |
| Nextcloud (data)   | Bind | nextcloud   | `./nextcloud/data`     | No        | Nextcloud data path          |
| Code Server        | Bind | code-server | `./code-server/config` | No        | Code Server config/data path |
| Swag               | Bind | swag        | `./swag/config`        | No        | Swag config/data path        |

## Architecture

```mermaid
architecture-beta
    group homeNetwork(cloud)[Home Network]
    service towerHDD(disk)[Tower HDD] in homeNetwork
    service blackTowerHDD(disk)[Black Tower HDD] in homeNetwork

    group tower(server)[Tower] in homeNetwork
    service towerSD(disk)[Tower microSD] in tower
    service swag(server)[Swag] in tower
    service heimdall(server)[Heimdall] in tower
    service codeServer(server)[Code Server] in tower
    service myst(server)[myst] in tower
    service bitwarden(server)[bitwarden] in tower
    service piHole(server)[Pi Hole] in tower

    group blackTower(server)[Black Tower] in homeNetwork
    service blackTowerSD(disk)[Black Tower microSD] in blackTower
    service enteIO(server)[Ente IO] in blackTower
    service firefly(server)[firefly] in blackTower
    service jellyfin(server)[Jellyfin] in blackTower
    service nextcloud(server)[Nextcloud] in blackTower
    service mariadb(database)[Mariadb] in blackTower

    junction towerJunction11
    junction towerJunction12

    blackTowerSD:L --> R:mariadb
    blackTowerSD:T --> B:jellyfin
    blackTowerSD:R --> L:enteIO

    mariadb:L --> R:nextcloud
    mariadb:T --> B:firefly

    blackTowerHDD:L --> R:nextcloud
    blackTowerHDD:T --> B:jellyfin
    blackTowerHDD:T --> L:enteIO
```

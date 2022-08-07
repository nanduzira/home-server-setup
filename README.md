# home-server-setup

## ENV file
Add the proper `HOME_SERVER_BASE_DOMAIN` value(your base domain to host the server).

## Start the server
`docker compose --env-file .env -d up`

## Stop the server
`docker compose down --remove-orphans`

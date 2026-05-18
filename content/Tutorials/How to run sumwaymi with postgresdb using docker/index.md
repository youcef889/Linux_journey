+++
date = '2026-05-14T04:57:57+01:00'
draft = false
title = 'How to Run Sumwaymi With Postgresdb Using Docker'

+++

### The docker-compose.yml file 

```
---
services:
  suwayomi:
    image: ghcr.io/suwayomi/suwayomi-server:preview
    user: 1000:1000
    environment:
      - TZ=${TZ:-Etc/UTC} # Add a TZ variable to .env to change it
      - DATABASE_TYPE=POSTGRESQL
      - DATABASE_URL=postgresql://postgresql:5432/${POSTGRES_DB}
      - DATABASE_USERNAME=${POSTGRES_USER}
      - DATABASE_PASSWORD=${POSTGRES_PASSWORD}
      # - USE_HIKARI_CONNECTION_POOL=false # Hikari Connection Pool can cause issues with some installations, but it is much more performant.
      # Comment these out if you do not use the flaresolverr container at the bottom of this file
      - FLARESOLVERR_ENABLED=true
      - FLARESOLVERR_URL=http://flaresolverr:8191
#  #################################################################################################
#
#    !!! IMPORTANT !!!
#     - server settings can be changed during runtime in the WebUI
#     - providing an environment variable will OVERWRITE the current setting value when starting the container
#
#  #################################################################################################
#
#    example for setting env vars:
#
#      - BIND_IP=0.0.0.0
#      - BIND_PORT=4567
#      - SOCKS_PROXY_ENABLED=false
#      - DOWNLOAD_AS_CBZ=true
#      - AUTH_MODE=basic_auth
#      - AUTH_USERNAME=manga
#      - AUTH_PASSWORD=hello123
#      - EXTENSION_REPOS=["http://github.com/orginazation-name/repo-name", "http://github.com/orginazation-name-2/repo-name-2"]v
    depends_on:
      postgresql:
        condition: service_healthy
        #restart: true
    volumes:
      - ./data:/home/suwayomi/.local/share/Tachidesk
    ports:
      - "4567:4567"
    restart: on-failure:3

  postgresql:
    image: postgres:17.6
    environment:
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
      - PGDATA=/data/postgres
      - POSTGRES_DB=${POSTGRES_DB}
      - TZ=${TZ:-Etc/UTC}
      - PGTZ=${TZ:-Etc/UTC}
    volumes:
      - ./postgres:/data/postgres
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -d ${POSTGRES_DB} -U ${POSTGRES_USER}"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s
  
  flaresolverr:
    image: ghcr.io/thephaseless/byparr:latest
    environment:
      - TZ=${TZ:-Etc/UTC}
    restart: unless-stopped
```

### Env Example 

```
# ================================
# Global
# ================================
TZ=UTC

# ================================
# PostgreSQL Database
# ================================
POSTGRES_DB=suwayomi
POSTGRES_USER=suwayomi
POSTGRES_PASSWORD=Z9!aQ2Lk7rP#3dS

# ================================
# Optional (advanced)
# ================================
# If you later want to move DB to another server:
# DATABASE_HOST=postgresql
# DATABASE_PORT=5432
```

create this folder 

```
mkdir data
sudo chown -R 1000:1000 data
```

after that  run to pull docker images we need 

```docker composer pull```

then use this  to run containers 

```docker compser up -d```

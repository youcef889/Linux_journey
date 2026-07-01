+++
date = '2026-05-14T04:57:57+01:00'
draft = false
title = 'Deploy Suwayomi Server with PostgreSQL and Docker Compose'
description = 'Deploy Suwayomi Server with PostgreSQL using Docker Compose. This guide covers installation, configuration, persistent storage, troubleshooting, and verification.'
+++

In this guide, you'll learn how to deploy Suwayomi Server with PostgreSQL using Docker Compose. PostgreSQL provides better reliability and scalability than the default SQLite database, making it a good choice for larger libraries and long-term deployments.

By the end of this tutorial, you'll have a fully functional Suwayomi Server with persistent storage and a PostgreSQL backend

##  What you need (Prerequisites) :

Before you begin, make sure you have:

- Docker installed
- Docker Compose installed
- At least 2 GB RAM
- A Linux server (Ubuntu, Debian, Alpine, etc.)

## Docker Compose Overview
The compose file contains three services:

- Suwayomi Server
- PostgreSQL
- FlareSolverr (optional) 

### Suwayomi server

This container hosts the application.

### PostgreSQL

Stores metadata, users, and manga information.

### FlareSolverr

Optional. Required only if some extensions need Cloudflare bypass.

## Why Use PostgreSQL?

Suwayomi Server supports multiple database backends. While SQLite is suitable for testing and small libraries, PostgreSQL offers several advantages:

- Better performance with large libraries
- Improved reliability
- Concurrent database access
- Easier backup and recovery
- Better scalability for long-term use


## Create the docker-compose.yml File

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
      - FLARESOLVERR_ENABLED=true
      - FLARESOLVERR_URL=http://flaresolverr:8191

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

### Environment variable Example 
 environment variable 

| Variable          | Description         |
| ----------------- | ------------------- |
| TZ                | Container timezone  |
| POSTGRES_DB       | Database name       |
| POSTGRES_USER     | PostgreSQL username |
| POSTGRES_PASSWORD | Database password   |

## Create the .env File

```
touch .env 

```
copy  this   to .env 

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

## Create the Data Directory

This directory that will store Suwayomi's data outside the container.

```
mkdir data
sudo chown -R 1000:1000 data
```
### Directory layout
```
project/
├── docker-compose.yml
├── .env
├── data/
└── postgres/
```
| Path | Purpose |
|------|---------|
| docker-compose.yml | Defines all containers |
| .env | Stores environment variables |
| data/ | Suwayomi application data |
| postgres/ | PostgreSQL database files |


Pull the required container images:

```docker compose pull```

Start the services in detached mode:

```
docker compose up -d
```

## Verify the Deployment

Check that all containers are running:

```bash
docker compose ps
````

Example output:

```
NAME                      IMAGE                                      COMMAND                  SERVICE        CREATED         STATUS                             PORTS
suwayomi-flaresolverr-1   ghcr.io/thephaseless/byparr:latest         "uv run main.py"         flaresolverr   5 minutes ago   Up 23 seconds (health: starting)   8191/tcp
suwayomi-postgresql-1     postgres:17.6                              "docker-entrypoint.s…"   postgresql     5 minutes ago   Up 23 seconds (healthy)            5432/tcp
suwayomi-suwayomi-1       ghcr.io/suwayomi/suwayomi-server:preview   "tini -- /home/suway…"   suwayomi       5 minutes ago   Up 17 seconds                      0.0.0.0:4567->4567/tcp, [::]:4567->4567/tcp

```


Open your browser:

```
http://localhost:4567
```

or

```
http://YOUR_SERVER_IP:4567
```
## Conclusion

You have successfully deployed Suwayomi Server with PostgreSQL using Docker Compose.

This setup provides:

- Persistent storage
- A dedicated PostgreSQL database
- Optional Cloudflare bypass with FlareSolverr
- Easy upgrades using Docker Compose

For production deployments, consider placing Suwayomi behind an Nginx reverse proxy and enabling HTTPS with Let's Encrypt.


## Frequently Asked Questions

### Can I use SQLite instead?

Yes. SQLite is suitable for smaller libraries, but PostgreSQL is recommended for better reliability and scalability.

### Is FlareSolverr required?

No. It is only needed for extensions that require Cloudflare bypass.

### Can I change the PostgreSQL password later?

Yes. Update the `.env` file and restart the containers.

### Can I expose Suwayomi to the Internet?

Yes. Use a reverse proxy such as Nginx and enable HTTPS with Let's Encrypt.

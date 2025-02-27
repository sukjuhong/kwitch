#!/bin/bash

POSTGRES_USER="${POSTGRES_USER:-postgres}"
POSTGRES_PASSWORD="${POSTGRES_PASSWORD:-develop}"
POSTGRES_DB="${POSTGRES_DB:-kwitch}"
POSTGRES_PORT="${POSTGRES_PORT:-5432}"

REDIS_PASSWORD="${REDIS_PASSWORD:-develop}"
REDIS_PORT="${REDIS_PORT:-6379}"

check_port() {
    local port=$1
    if ss -tuln | grep ":$port" > /dev/null; then
        echo "Port $port is already in use."
        return 1
    else
        echo "Port $port is available."
        return 0
    fi
}

check_port $POSTGRES_PORT
if [ $? -eq 0 ]; then
    echo "Starting PostgreSQL..."
    docker run -d \
        --name postgres \
        -e POSTGRES_USER=$POSTGRES_USER \
        -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
        -e POSTGRES_DB=$POSTGRES_DB \
        -p $POSTGRES_PORT:$POSTGRES_PORT \
        -v $PWD/volumes/postgres-data:/var/lib/postgresql/data \
        --rm \
        postgres:17-alpine
fi

check_port $REDIS_PORT
if [ $? -eq 0 ]; then
    echo "Starting Redis..."
    docker run -d \
        --name redis \
        -p $REDIS_PORT:$REDIS_PORT \
        -v $PWD/volumes/redis-data:/data \
        --rm \
        redis:7-alpine redis-server --requirepass $REDIS_PASSWORD
fi
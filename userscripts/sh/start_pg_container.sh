#!/bin/bash

source ~/Projects/smart-home/.env

if podman container exists "$PG_CONTAINER"; then
    status=$(podman inspect -f '{{.State.Status}}' "$PG_CONTAINER")
    if [ "$status" = "running" ]; then
	echo "Container $PG_CONTAINER is already running."
    else
	echo "Starting existing container $PG_CONTAINER..."
	podman start "$PG_CONTAINER"
    fi
else
    echo "Creating and starting container $PG_CONTAINER..."
    podman run -d \
	--name "$PG_CONTAINER" \
	-e POSTGRES_USER="$PG_USER" \
	-e POSTGRES_PASSWORD="$PG_PASSWORD" \
	-e POSTGRES_DB="$PG_DB" \
	-v "$PG_DATA_DIR":/var/lib/postgresql/data:Z \
	-p "$PG_PORT":5432 \
        docker.io/library/postgres:15
fi

#!/bin/bash
set -e

# Start MongoDB in the background for initialization purposes
mongod --replSet rs0 --bind_ip_all &
mongo_pid=$!

# Wait for MongoDB to fully start
until mongo --eval "print('waiting for mongo to start')" &>/dev/null; do
    sleep 1
done

# Execute the replica set initiation script
mongo < /docker-entrypoint-initdb.d/mongo-init-replica.js

# Shut down the background MongoDB process
kill -SIGTERM "$mongo_pid"
wait "$mongo_pid"

# Now, restart MongoDB in the foreground for normal operations
exec mongod --replSet rs0 --bind_ip_all

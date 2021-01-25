#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid
rm -f /slimer/tmp/pids/server.pid

# Execute the containers main process
exec "$@"

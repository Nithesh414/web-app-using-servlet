#!/usr/bin/env bash
# Usage: ./run.sh [mysql_user] [port]   -> imports DB and starts the PHP site
U=${1:-root}; PORT=${2:-8000}
cd "$(dirname "$0")"
echo "Importing database (enter MySQL password if asked)..."
mysql -u "$U" -p < schema.sql || { echo "MySQL import failed"; exit 1; }
echo "Open http://localhost:$PORT  (first registered user = admin)"
php -S localhost:$PORT -t php

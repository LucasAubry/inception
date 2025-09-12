#!/bin/sh

set -e

echo "Starting MariaDB initialization..."

# Check data directory
ls -la /var/lib/mysql

# Try to initialize MariaDB database if not already done
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
fi

# Start MariaDB in safe mode
echo "Starting mariadbd-safe..."
/usr/bin/mariadbd-safe --datadir=/var/lib/mysql --user=mysql &

echo "Waiting for MariaDB to be ready..."
attempt=0
until mariadb-admin ping --silent 2>/dev/null; do
	attempt=$((attempt + 1))
	echo "MariaDB not ready yet, attempt $attempt..."
	if [ $attempt -ge 30 ]; then
		echo "MariaDB failed to start after 30 attempts"
		exit 1
	fi
	sleep 2
done

echo "MariaDB is responding to ping"

# Run the SQL script
if [ -f "/tools/init.sql" ]; then
	echo "Running initialization SQL script..."
	envsubst < /tools/init.sql | mariadb
	echo "SQL script completed"
fi

echo "MariaDB is ready"

wait

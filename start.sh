#!/bin/bash

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to be ready..."
while ! PGPASSWORD=$PGPASSWORD pg_isready -h $PGHOST -p $PGPORT -U $PGUSER; do
    sleep 1
done

echo "PostgreSQL is ready! Starting Odoo..."

# Start Odoo with Railway database configuration
exec python3 /usr/bin/odoo \
    --database $PGDATABASE \
    --db_host $PGHOST \
    --db_port $PGPORT \
    --db_user $PGUSER \
    --db_password $PGPASSWORD \
    --without-demo=all \
    --load=base,web \
    --stop-after-init

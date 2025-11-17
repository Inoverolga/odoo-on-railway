#!/bin/bash

echo "Waiting for PostgreSQL..."
until PGPASSWORD="$PGPASSWORD" psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -c '\q'; do
  sleep 1
done

echo "PostgreSQL is ready!"

# Check if database needs initialization
if ! PGPASSWORD="$PGPASSWORD" psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "$PGDATABASE" -c "SELECT 1 FROM ir_module_module LIMIT 1;" &> /dev/null; then
    echo "Database needs initialization. Installing base modules..."
    python3 /usr/bin/odoo \
        --database="$PGDATABASE" \
        --db_host="$PGHOST" \
        --db_port="$PGPORT" \
        --db_user="$PGUSER" \
        --db_password="$PGPASSWORD" \
        --without-demo=all \
        --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons \
        --data-dir=/var/lib/odoo \
        -i base --stop-after-init
    
    echo "Base modules installed successfully!"
fi

echo "Starting Odoo server..."
exec python3 /usr/bin/odoo \
    --database="$PGDATABASE" \
    --db_host="$PGHOST" \
    --db_port="$PGPORT" \
    --db_user="$PGUSER" \
    --db_password="$PGPASSWORD" \
    --without-demo=all \
    --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons \
    --data-dir=/var/lib/odoo

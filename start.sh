#!/bin/bash

echo "Waiting for PostgreSQL..."
until PGPASSWORD="$PGPASSWORD" psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -c '\q'; do
  sleep 1
done

echo "PostgreSQL is ready!"

# Start Odoo with command line parameters
exec python3 /usr/bin/odoo \
    --config=/etc/odoo/odoo.conf \
    --database="$PGDATABASE" \
    --db_host="$PGHOST" \
    --db_port="$PGPORT" \
    --db_user="$PGUSER" \
    --db_password="$PGPASSWORD" \
    --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons \
    --data-dir=/var/lib/odoo

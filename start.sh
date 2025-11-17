#!/bin/bash
export PGDATABASE=railway
python3 /usr/bin/odoo --without-demo=all --db_host=$PGHOST --db_port=$PGPORT --db_user=$PGUSER --db_password=$PGPASSWORD --database=$PGDATABASE
FROM odoo:16

USER root
RUN apt-get update && apt-get install -y postgresql-client

COPY ./inventory_module /mnt/extra-addons/inventory_module
RUN chown -R odoo:odoo /mnt/extra-addons/

USER odoo

# Используем shell форму для подстановки переменных
CMD python3 /usr/bin/odoo --without-demo=all --db_host=${PGHOST} --db_port=${PGPORT} --db_user=${PGUSER} --db_password=${PGPASSWORD} --database=${PGDATABASE}
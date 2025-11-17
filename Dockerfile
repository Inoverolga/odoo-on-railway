FROM odoo:16

USER root
RUN apt-get update && apt-get install -y postgresql-client

# Копируем конфиг (без переменных)
COPY ./odoo.conf /etc/odoo/

# Копируем модуль
COPY ./inventory_module /mnt/extra-addons/inventory_module
RUN chown -R odoo:odoo /mnt/extra-addons/

USER odoo

# Передаем переменные через командную строку
CMD ["python3", "/usr/bin/odoo", "--db_host=${PGHOST}", "--db_port=${PGPORT}", "--db_user=${PGUSER}", "--db_password=${PGPASSWORD}", "--database=${PGDATABASE}"]
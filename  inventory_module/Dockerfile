FROM odoo:16

USER root
RUN apt-get update && apt-get install -y postgresql-client
USER odoo

# Устанавливаем наш модуль
COPY ./inventory_module /mnt/extra-addons/inventory_module
RUN chown -R odoo:odoo /mnt/extra-addons/

CMD ["python3", "/usr/bin/odoo", "--without-demo=all"]
FROM odoo:16

USER root
RUN apt-get update && apt-get install -y postgresql-client

COPY ./inventory_module /mnt/extra-addons/inventory_module
COPY ./start.sh /start.sh
RUN chown -R odoo:odoo /mnt/extra-addons/
RUN chmod +x /start.sh

USER odoo

CMD ["/start.sh"]
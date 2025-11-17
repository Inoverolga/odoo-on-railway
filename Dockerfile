FROM odoo:16

USER root

# Install PostgreSQL client
RUN apt-get update && \
    apt-get install -y postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Create addons directory
RUN mkdir -p /mnt/extra-addons

# Copy test module
COPY ./custom-module /mnt/extra-addons/custom-module

# Copy configuration
COPY ./odoo.conf /etc/odoo/odoo.conf

# Copy start script
COPY ./start.sh /start.sh
RUN chmod +x /start.sh

# Set permissions
RUN chown -R odoo:odoo /mnt/extra-addons/

USER odoo

CMD ["/start.sh"]

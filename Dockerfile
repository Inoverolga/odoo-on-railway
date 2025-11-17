FROM odoo:16

USER root

# Install PostgreSQL client and other dependencies
RUN apt-get update && \
    apt-get install -y postgresql-client curl && \
    rm -rf /var/lib/apt/lists/*

# Create addons directory
RUN mkdir -p /mnt/extra-addons

# Copy test module
COPY ./custom-module /mnt/extra-addons/custom-module

# Copy start script
COPY ./start.sh /start.sh
RUN chmod +x /start.sh

# Copy Odoo configuration
COPY ./odoo.conf /etc/odoo/odoo.conf

# Set permissions
RUN chown -R odoo:odoo /mnt/extra-addons/

USER odoo

# Install Python dependencies
COPY ./requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

CMD ["/start.sh"]

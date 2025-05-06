FROM n8nio/n8n:latest

# Switch to root user to install global npm packages
USER root
# Install necessary system packages
RUN apk add --no-cache \
curl \ git \ build-base \ chromium \ bash \ tar \ xZ \
util linux \ coreutils
# Install Astral uv/uvx and make available system-wid
RUN curl -Ls https://astral.sh/uv/install.sh | bash '
8& chmod +x /root/.local/bin/uv \ && chmod +x /root/.local/bin/uvx \
8& ln -s /root/.local/bin/uv /usr/local/bin/uv \ ln -s /root/.local/bin/uvx /usr/local/bin/uvx
8& mkdir -p /data/mcp \
8& chown -R node:node /data/mcp
# Ensure uv & uvx are in the PATH
ENV PATH«"/usr/local/bin:/root/.local/bin:$(PATH}"
USER

# Revert to the node user for security purposes
USER node

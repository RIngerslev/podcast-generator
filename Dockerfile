FROM ubuntu:latest

# Install system dependencies and pipx
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-venv \
    git \
    && pip3 install pipx \
    && pipx ensurepath \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install PyYAML using pipx
RUN pipx install PyYAML

# Copy the necessary files
COPY feed.py /usr/bin/feed.py
COPY entrypoint.sh /entrypoint.sh

# Make sure entrypoint.sh is executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
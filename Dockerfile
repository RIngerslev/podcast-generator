FROM ubuntu:latest

# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set environment variables to ensure Python outputs everything to the console
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-venv \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a virtual environment
RUN python3 -m venv /opt/venv

# Activate the virtual environment and install PyYAML
RUN /opt/venv/bin/pip install --upgrade pip \
    && /opt/venv/bin/pip install PyYAML

# Copy the necessary files
COPY feed.py /usr/bin/feed.py
COPY entrypoint.sh /entrypoint.sh

# Make sure entrypoint.sh is executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
# BrainCast - Root Dockerfile
FROM alpine:3.16

# Install dependencies
RUN apk add --no-cache \
    docker \
    docker-compose \
    bash \
    curl

WORKDIR /app

# Copy the entire application
COPY . .

# Set environment variables
ENV COMPOSE_PROJECT_NAME=braincast

# Make entrypoint script executable
RUN chmod +x /app/entrypoint.sh

# Expose main ports
EXPOSE 3000 5000

ENTRYPOINT ["/app/entrypoint.sh"]

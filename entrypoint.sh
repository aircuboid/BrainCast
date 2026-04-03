#!/bin/bash
set -e

# Color definitions for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Log function
log() {
  echo -e "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Check for required environment variables
check_env_vars() {
  log "${YELLOW}Checking environment variables...${NC}"
  local required_vars=("YOUTUBE_API_KEY" "OPENAI_API_KEY")
  local missing_vars=0

  for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
      log "${RED}Error: Required environment variable $var is not set${NC}"
      missing_vars=$((missing_vars + 1))
    fi
  done

  if [ $missing_vars -gt 0 ]; then
    log "${RED}Missing $missing_vars required environment variables. Exiting.${NC}"
    exit 1
  fi
  
  log "${GREEN}Environment validation successful!${NC}"
}

# Initialize services
initialize() {
  log "${YELLOW}Initializing BrainCast services...${NC}"
  
  # Create necessary directories if they don't exist
  mkdir -p ./data/postgres
  mkdir -p ./data/prediction_cache
  mkdir -p ./logs
  
  # Set permissions
  chmod -R 755 ./data ./logs
  
  log "${GREEN}Initialization complete!${NC}"
}

# Start all services
start_services() {
  log "${YELLOW}Starting BrainCast services...${NC}"
  
  # Check if we should run in detached mode
  if [ "$1" = "-d" ] || [ "$1" = "--detach" ]; then
    log "Starting in detached mode..."
    docker-compose up -d
  else
    docker-compose up
  fi
}

# Handle graceful shutdown
graceful_shutdown() {
  log "${YELLOW}Shutting down BrainCast services...${NC}"
  docker-compose down
  log "${GREEN}All services stopped.${NC}"
  exit 0
}

# Main execution
main() {
  log "${GREEN}BrainCast Startup Script${NC}"
  
  # trap graceful shutdown
  trap graceful_shutdown SIGTERM SIGINT
  
  # Run initialization steps
  check_env_vars
  initialize
  
  # Start services with any arguments passed to the script
  start_services "$@"
}

main "$@"

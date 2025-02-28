#!/bin/bash

echo "Starting streaming service..."

# Start Xvfb virtual display
Xvfb :99 -screen 0 1920x1080x24 &
export DISPLAY=:99

echo "Virtual display started on $DISPLAY"

# Wait for web interface to be available
echo "Waiting for web interface to be available..."
while ! curl -s $WEB_INTERFACE_URL > /dev/null; do
    echo "Web interface not yet available, waiting..."
    sleep 5
done

echo "Web interface is available at $WEB_INTERFACE_URL"

# Start OBS with our configuration
echo "Starting OBS (simulated for now)..."
echo "In a real setup, we would launch OBS with:"
echo "obs-cli --scene 'Web Capture' --startstreaming"

# For now, just keep the container running
while true; do
    echo "Streaming service running... (press Ctrl+C to stop)"
    sleep 60
done

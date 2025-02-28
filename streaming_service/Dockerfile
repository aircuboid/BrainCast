FROM ubuntu:22.04

# Install OBS and dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:obsproject/obs-studio \
    && apt-get update \
    && apt-get install -y \
    obs-studio \
    python3 \
    python3-pip \
    xvfb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

# Start Xvfb and OBS in virtual display
CMD ["bash", "start_streaming.sh"]

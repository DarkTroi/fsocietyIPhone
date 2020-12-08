# Use Python 2.7 Slim
FROM python:2.7-slim

# Update Repos
RUN apk add update \
  && apk add build-essential sudo git wget curl nmap ruby \
  && apk clean

# Install Python dependecies
RUN pip install requests

# Install fsociety
RUN git clone https://github.com/Manisso/fsociety.git \
  && cd fsociety \
  && chmod +x install.sh \
  && ./install.sh

# Change workdir
WORKDIR /root/.fsociety/

# Hack to keep the container running
CMD python -c "import signal; signal.pause()"

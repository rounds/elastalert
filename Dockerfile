FROM rounds/10m-python
MAINTAINER David Bolshoy ROUNDS <david@rounds.com>

# add our files
COPY elastalert /opt/elastalert/elastalert
COPY requirements.txt /opt/elastalert/

WORKDIR /opt/elastalert

# install requirements
RUN \
  apt-get update && \
  apt-get install -y python-dev && \
  pip install --upgrade pip && \
  pip install -r requirements.txt && \
  rm requirements.txt && \
  pip install j2cli && \
  apt-get purge --yes --auto-remove python-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define default command.
CMD python -m elastalert.elastalert --verbose
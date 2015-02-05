#
# ElasticSearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image
FROM dockerfile/java:oracle-java7

ENV ELASTICSEARCH_VERSION 1.4.2
ENV ELASTICSEARCH_PATH /opt/elasticsearch

ENV PATH ${ELASTICSEARCH_PATH}/bin/:${PATH}

# Install ElasticSearch
RUN wget -qO- https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz \
  | tar xvz -C /tmp/ \
 && mv /tmp/elasticsearch-${ELASTICSEARCH_VERSION} ${ELASTICSEARCH_PATH}

# Define mountable directories
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml ${ELASTICSEARCH_PATH}/config/elasticsearch.yml

# Add a debugging plugin
RUN /opt/elasticsearch/bin/plugin --install polyfractal/elasticsearch-inquisitor

# Define working directory
WORKDIR /data

# Define default command
ENTRYPOINT ["elasticsearch"]

# Expose ports
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200/tcp 9300

#
# ElasticSearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

FROM java:8

ENV ELASTICSEARCH_VERSION=1.4.1 ELASTICSEARCH_PATH=/opt/elasticsearch

RUN wget -qO- https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz \
  | tar xvz -C /tmp/ \
 && mv /tmp/elasticsearch-${ELASTICSEARCH_VERSION} ${ELASTICSEARCH_PATH}

ENV PATH ${ELASTICSEARCH_PATH}/bin:${PATH} # has to be on own line, so it gets expanded, also it has to be done after install

RUN plugin --install polyfractal/elasticsearch-inquisitor

# Define mountable directories
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml ${ELASTICSEARCH_PATH}/config/elasticsearch.yml

# Define working directory
WORKDIR /data

# Define default command
ENTRYPOINT ["elasticsearch"]

# Expose ports
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200/tcp 9300

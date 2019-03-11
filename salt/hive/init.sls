hiveconfdir:
  file.directory:
    - name: /opt/so/conf/hive/etc
    - makedirs: True

hivelogdir:
  file.directory:
    - name: /opt/so/log/hive
    - makedirs: True

hiveconf:
  file.recurse:
    - name: /opt/so/conf/hive/etc
    - source: salt://hive/thehive/etc
    - template: jinja

# Install Elasticsearch

# Made directory for ES data to live in
hiveesdata:
  file.directory:
    - name: /nsm/hive/esdata
    - makedirs: True

so-thehive-es:
  docker_container.running:
    - image: docker.elastic.co/elasticsearch/elasticsearch:5.6.0
    - hostname: so-thehive-es
    - name: so-thehive-es
    - interactive: True
    - tty: True
    - binds:
      - /nsm/hive/esdata:/usr/share/elasticsearch/data:rw
      - /opt/so/conf/hive/etc/es/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml:ro
      - /opt/so/log/hive:/var/log/elasticsearch:rw
    - environment:
      - http.host=0.0.0.0
      - http.port=9400
      - transport.tcp.port=9500
      - transport.host=0.0.0.0
      - xpack.security.enabled=false
      - cluster.name=hive
      - script.inline=true
      - thread_pool.index.queue_size=100000
      - thread_pool.search.queue_size=100000
      - thread_pool.bulk.queue_size=100000
      - ES_JAVA_OPTS=-Xms2g -Xmx2g

# Install Cortex

so-cortex:
  docker_container.running:
    - image: thehiveproject/cortex:latest
    - hostname: so-cortex
    - name: so-cortex

so-thehive:
  docker_container.running:
    - image: thehiveproject/thehive:latest
    - hostname: so-thehive
    - name: so-thehive

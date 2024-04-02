# Copyright Security Onion Solutions LLC and/or licensed to Security Onion Solutions LLC under one
# or more contributor license agreements. Licensed under the Elastic License 2.0 as shown at 
# https://securityonion.net/license; you may not use this file except in compliance with the
# Elastic License 2.0.

{% from 'allowed_states.map.jinja' import allowed_states %}
{% if sls.split('.')[0] in allowed_states %}
{%   from 'vars/globals.map.jinja' import GLOBALS %}
{%   from 'docker/docker.map.jinja' import DOCKER %}

include:
  - kafka.sostatus
  - kafka.config
  - kafka.storage

so-kafka:
  docker_container.running:
    - image: so-kafka
    - hostname: so-kafka
    - name: so-kafka
    - networks:
      - sobridge:
        - ipv4_address: {{ DOCKER.containers['so-kafka'].ip }}
    - user: kafka
    - port_bindings:
      {% for BINDING in DOCKER.containers['so-kafka'].port_bindings %}
      - {{ BINDING }}
      {% endfor %}
    - binds:
      - /etc/pki/kafka.jks:/etc/pki/kafka.jks
      - /opt/so/conf/ca/cacerts:/etc/pki/java/sos/cacerts
      - /nsm/kafka/data/:/nsm/kafka/data/:rw
      - /opt/so/conf/kafka/server.properties:/kafka/config/kraft/server.properties

delete_so-kafka_so-status.disabled:
  file.uncomment:
    - name: /opt/so/conf/so-status/so-status.conf
    - regex: ^so-kafka$

{% else %}

{{sls}}_state_not_allowed:
  test.fail_without_changes:
    - name: {{sls}}_state_not_allowed

{% endif %}
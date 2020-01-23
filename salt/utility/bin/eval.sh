{%- set ES = salt['pillar.get']('master:mainip', '') -%}
# Wait for ElasticSearch to come up, so that we can query for version infromation
echo -n "Waiting for ElasticSearch..."
COUNT=0
ELASTICSEARCH_CONNECTED="no"
while [[ "$COUNT" -le 30 ]]; do
  curl --output /dev/null --silent --head --fail http://{{ ES }}:9200
  if [ $? -eq 0 ]; then
    ELASTICSEARCH_CONNECTED="yes"
    echo "connected!"
    break
  else
    ((COUNT+=1))
    sleep 1
    echo -n "."
  fi
done
if [ "$ELASTICSEARCH_CONNECTED" == "no" ]; then
  echo
  echo -e "Connection attempt timed out.  Unable to connect to ElasticSearch.  \nPlease try: \n  -checking log(s) in /var/log/elasticsearch/\n  -running 'docker ps' \n  -running 'sudo so-elastic-restart'"
  echo

  exit
fi

echo "Applying cross cluster search config..."
    curl -s -XPUT http://{{ ES }}:9200/_cluster/settings \
         -H 'Content-Type: application/json' \
         -d "{\"persistent\": {\"search\": {\"remote\": {\"{{ grains.id }}\": {\"seeds\": [\"127.0.0.1:9300\"]}}}}}"

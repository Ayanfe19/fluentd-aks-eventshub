Copy code
<source>
  @type tail
  path /var/log/containers/*.log
  pos_file /var/log/es-containers.log.pos
  tag kubernetes.*
  read_from_head true
  <parse>
    @type json
  </parse>
</source>

<match kubernetes.**>
  @type azureeventhubs
  connection_string CONNECTION_STRING
  eventhub_name EVENT_HUB_NAME
  partition_key ${record["kubernetes"]["namespace_name"]}-${record["kubernetes"]["pod_name"]}-${record["kubernetes"]["container_name"]}
  time_key time
  time_format %Y-%m-%dT%H:%M:%S.%N%z
  batch_size 10
  max_send_retries 10
  send_timeout 60s
</match>
# Replace the CONNECTION_STRING and EVENT_HUB_NAME placeholders with your Event Hub connection string and the name of your Event Hub instance, respectively.
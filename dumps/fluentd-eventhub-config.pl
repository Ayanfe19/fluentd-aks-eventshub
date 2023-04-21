<!-- An example Fluentd configuration file that reads logs from Docker containers and sends them to Azure EventsHub
Here's an example Fluentd configuration file that reads logs from Docker containers and sends them to Azure Event Hub: -->

<system>
  # Set the log level for Fluentd logs. This example sets the log level to info.
  log_level info
</system>

# Configure the input plugin to read logs from Docker.
<source>
  @type docker
  @log_level debug
  @container_logs true
  @read_timeout 60
  @docker_url unix:///var/run/docker.sock
  @tag docker.*
  # Set the Docker log driver to journald.
  # This is required for the docker input plugin to read logs from Docker.
  <docker>
    log_driver journald
  </docker>
</source>

# Configure the output plugin to send logs to Azure Event Hub.
<match docker.**>
  @type azureeventhubs
  @log_level debug
  # Set the Event Hub namespace and name.
  # Replace EVENT_HUB_NAMESPACE and EVENT_HUB_NAME with your own values.
  connection_string "Endpoint=sb://EVENT_HUB_NAMESPACE.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=YOUR_SHARED_ACCESS_KEY"
  hub_name EVENT_HUB_NAME
  # Set the Event Hub partition key to the Docker container ID.
  partition_key ${record["container_id"]}
  # Set the message payload to the Docker log message.
  message_key log
  # Set the message properties to include the Docker container ID and timestamp.
  # This allows you to filter and query logs based on these properties in Event Hub.
  <message>
    container_id ${record["container_id"]}
    time ${time.utc.iso8601}
  </message>
</match>
<!-- Replace EVENT_HUB_NAMESPACE, EVENT_HUB_NAME, and YOUR_SHARED_ACCESS_KEY with your own values.

This configuration file uses the Docker input plugin to read logs from Docker and the Azure Event Hubs output plugin to send logs to Azure Event Hub. It sets the partition key to the Docker container ID and includes the container ID and timestamp as message properties. This allows you to filter and query logs based on these properties in Event Hub. -->

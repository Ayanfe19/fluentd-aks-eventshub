kubectl create configmap my-eventhubs-config --from-literal=eventhubs-connection-string='Endpoint=sb://<eventhubs-namespace>.servicebus.windows.net/;SharedAccessKeyName=<eventhubs-policy>;SharedAccessKey=<eventhubs-primary-key>'

kubectl create configmap my-eventhubs-config --from-literal=eventhubs-connection-string='Endpoint=sb://kula-eventhub-ns.servicebus.windows.net/;SharedAccessKeyName=kula-qradar;SharedAccessKey=X8YoNaLdf4Myf0T0hzMcn+M5ByKkjW9DI+AEhGFDJ1g='


kubectl create deployment my-eventhubs-plugin --image=microsoft/azure-eventhubs-kubernetes:latest --env EVENTHUBS_CONFIG=my-eventhubs-config

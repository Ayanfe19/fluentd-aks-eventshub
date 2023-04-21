### To collect logs from Kubernetes containers and send them to Event Hub using Fluentd, follow these steps:

Install Fluentd on your Kubernetes cluster.

Set up Fluentd to read logs from Kubernetes containers. Fluentd has a Kubernetes input plugin that can be used to read logs from Kubernetes containers.

Configure Fluentd to format the logs into the JSON format that Event Hub expects. Fluentd has several built-in output plugins, including one for sending logs to Azure Event Hub.

Create an Azure Event Hub instance and configure it to receive logs from Fluentd. You will need to obtain the connection string for your Event Hub instance and configure your Fluentd output plugin with this information.

Start Fluentd and verify that logs are being read from Kubernetes containers and sent to Event Hub.

Once Fluentd is set up and running, you can use Azure Stream Analytics or other tools to analyze and visualize the logs collected from your Kubernetes containers.


### To install Fluentd on your Azure Kubernetes Cluster (AKS), you can follow the below steps:

Connect to your AKS cluster using the command "az aks get-credentials --resource-group --name ".
Once connected to your AKS cluster, create a new namespace for Fluentd by running the command "kubectl create namespace fluentd".

```
kubectl create -f fluentd-configmap-eventhub.yml
kubectl apply -f fluentd-daemonset-def.yml
```



Next, create a ConfigMap for Fluentd by running the command "kubectl create configmap fluentd-config --namespace=m36 --from-literal=fluent.conf=".

Now, create a Fluentd daemonset by running the command "kubectl apply -f https://raw.githubusercontent.com/fluent/fluentd-kubernetes-daemonset/master/fluentd-daemonset-elasticsearch.yaml".
The above command will download and deploy Fluentd daemonset on your AKS cluster.

Finally, verify the deployment of Fluentd by running the command "kubectl get pods --namespace=fluentd".
This should list all the pods running in the Fluentd namespace, and you should be able to see the Fluentd daemonset running on your AKS cluster.

Note: You can modify the Fluentd configuration file as per your requirements to customize the logging behavior of your AKS cluster.










###### Fluentd PLugin Installation guide

Add the Azure Event Hub plugin repository to Helm using the following command:

```
helm repo add azure-eventhub-plugin https://raw.githubusercontent.com/Azure/event-hubs-kubernetes-eventhubplugin/master/helm/plugins/

helm repo update

helm install <release-name> azure-eventhub-plugin/eventhub-plugin-installer --namespace <namespace-name>
```
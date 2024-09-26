controlplane ~ ➜  kubectl config set-context --current --namespace=elastic-stack
Context "kubernetes-admin@kubernetes" modified.

controlplane ~ ➜  kubectl get all
No resources found in elastic-stack namespace.

controlplane ~ ➜



Create a persistent volume:
------------------------------->

name: pv-elasticsearch
storage capacity: 5Gi
accessModes: ReadWriteOnce
host path: /data/elasticsearch





Create a service named elasticsearch to expose the ElasticSearch StatefulSet within the cluster.

Since elasticsearch uses ports 9200 and 9300 as defaults for REST HTTP API and inter-node communication,
respectively, add the following target ports to the service file:

9200: Name it as port1 and make it accessible on port 30200 of the node.
9300: Name it as port2 and make it accessible on port 30300 of the node.



Finally, create a StatefulSet named elasticsearch.

Use VolumeClaimTemplates to claim the Persistent Volume that we created in one of the previous steps.
Access it using any label here, but ensure that the specs are same as the volume that we created earlier.

Refer to the Overview tab to mount this volume to the correct path within the container.

Use the following image for the elasticsearch container:
docker.elastic.co/elasticsearch/elasticsearch:7.1.0

Add the discovery.type environment variable to this container with the value single-node.

Also, do not forget to fix the permissions for the elasticsearch data directory so that the directory is accessible to elasticsearch.


For now, skip using replicas.

Note: The statefulset might take some time before it starts running.



controlplane ~ ✖ kubectl get all
NAME                  READY   STATUS    RESTARTS   AGE
pod/elasticsearch-0   1/1     Running   0          39s

NAME                    TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE
service/elasticsearch   NodePort   10.103.167.172   <none>        9200:30200/TCP,9300:30300/TCP   3m9s

NAME                             READY   AGE
statefulset.apps/elasticsearch   1/1     39s

controlplane ~ ➜  kubectl get pvc -o wide
NAME                      STATUS   VOLUME             CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE   VOLUMEMODE
es-data-elasticsearch-0   Bound    pv-elasticsearch   5Gi        RWO                           <unset>                 46s   Filesystem

controlplane ~ ➜  kubectl get pv -o wide
NAME               CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                                   STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE     VOLUMEMODE
pv-elasticsearch   5Gi        RWO            Retain           Bound    elastic-stack/es-data-elasticsearch-0                  <unset>                          5m49s   Filesystem
controlplane ~ ➜




controlplane ~ ➜  curl -k http://10.103.167.172:9200/_cluster/health?pretty
{
  "cluster_name" : "docker-cluster",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 0,
  "active_shards" : 0,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}

controlplane ~ ➜


controlplane ~ ➜  curl -ks http://10.97.82.108:9200/_search?q=*:* | jq .
{
  "took": 0,
  "timed_out": false,
  "_shards": {
    "total": 0,
    "successful": 0,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 0,
      "relation": "eq"
    },
    "max_score": 0,
    "hits": []
  }
}


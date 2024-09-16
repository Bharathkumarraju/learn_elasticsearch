kubectl get svc elasticsearch -n efk -o jsonpath='{.spec.clusterIP}' | xargs -I {} curl -X GET "http://{}:9200/_cluster/health?pretty"


controlplane ~ ➜  kubectl get all -n efk
NAME                          READY   STATUS    RESTARTS   AGE
pod/elasticsearch-0           1/1     Running   0          5m40s
pod/fluent-bit-lmjdg          1/1     Running   0          5m39s
pod/kibana-6657dcdb97-99spd   1/1     Running   0          5m39s

NAME                    TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE
service/elasticsearch   NodePort   10.106.103.110   <none>        9200:30200/TCP,9300:30300/TCP   5m40s
service/kibana          NodePort   10.105.168.138   <none>        5601:30601/TCP                  5m39s

NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/fluent-bit   0         0         0       0            0           <none>          5m39s

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kibana   1/1     1            1           5m39s

NAME                                DESIRED   CURRENT   READY   AGE
replicaset.apps/kibana-6657dcdb97   1         1         1       5m39s

NAME                             READY   AGE
statefulset.apps/elasticsearch   1/1     5m40s

controlplane ~ ➜



controlplane ~ ➜  kubectl get svc elasticsearch -n efk -o jsonpath='{.spec.clusterIP}'
10.106.103.110
controlplane ~ ➜  kubectl get svc elasticsearch -n efk -o wide
NAME            TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE     SELECTOR
elasticsearch   NodePort   10.106.103.110   <none>        9200:30200/TCP,9300:30300/TCP   6m31s   app=elasticsearch

controlplane ~ ➜  kubectl get svc elasticsearch -n efk -o jsonpath='{.spec.clusterIP}' | xargs -I {}


controlplane ~ ➜  curl -X GET "http://{}:9200/_cluster/health?pretty"
curl: (3) empty string within braces in URL position 9:
http://{}:9200/_cluster/health?pretty
        ^

controlplane ~ ✖ curl -X GET "http://10.106.103.110:9200/_cluster/health?pretty"
{
  "cluster_name" : "docker-cluster",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 28,
  "active_shards" : 28,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}

controlplane ~ ➜  curl -X GET "http://10.106.103.110:9200/_cluster/health?pretty" | jq .
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   469  100   469    0     0   194k      0 --:--:-- --:--:-- --:--:--  229k
{
  "cluster_name": "docker-cluster",
  "status": "green",
  "timed_out": false,
  "number_of_nodes": 1,
  "number_of_data_nodes": 1,
  "active_primary_shards": 28,
  "active_shards": 28,
  "relocating_shards": 0,
  "initializing_shards": 0,
  "unassigned_shards": 0,
  "delayed_unassigned_shards": 0,
  "number_of_pending_tasks": 0,
  "number_of_in_flight_fetch": 0,
  "task_max_waiting_in_queue_millis": 0,
  "active_shards_percent_as_number": 100
}

controlplane ~ ➜




Question 2: Creating an Index
Create an Index:
Use the PUT method to create an index named "products".
The JSON data should be as below



{
    "settings": {
        "number_of_shards": 1,
        "number_of_replicas": 1
    },
    "mappings": {
        "properties": {
            "product_id": {
                "type": "integer"
            },
            "name": {
                "type": "text"
            },
            "description": {
                "type": "text"
            },
            "price": {
                "type": "float"
            },
            "category": {
                "type": "text"
            },
            "brand": {
                "type": "text"
            }
        }
    }
}






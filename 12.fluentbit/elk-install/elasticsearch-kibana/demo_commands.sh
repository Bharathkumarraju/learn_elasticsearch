controlplane efk-stack on  main ➜  kubectl taint node controlplane node-role.kubernetes.io/control-plane-
node/controlplane untainted

controlplane efk-stack on  main ➜



kubectl config set-context --current --namespace=efk



controlplane ~ ➜  kubectl get namespaces
NAME              STATUS   AGE
default           Active   45m
kube-flannel      Active   45m
kube-node-lease   Active   45m
kube-public       Active   45m
kube-system       Active   45m

controlplane ~ ➜  kubectl get nodes -o wide
NAME           STATUS   ROLES           AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane   45m   v1.29.0   192.25.35.9   <none>        Ubuntu 22.04.4 LTS   5.4.0-1106-gcp   containerd://1.6.26

controlplane ~ ➜


controlplane efk-stack on  main ➜  kubectl taint node controlplane node-role.kubernetes.io/control-plane-
node/controlplane untainted

controlplane efk-stack on  main ➜

controlplane efk-stack on  main ➜  kubectl create namespace efk
namespace/efk created

controlplane efk-stack on  main ➜  kubectl config set-context --current --namespace=efk
Context "kubernetes-admin@kubernetes" modified.

controlplane efk-stack on  main ➜



controlplane efk-stack/elasticsearch-kibana on  main ➜  ls -rtlh
total 24K
drwxr-xr-x 2 root root 4.0K Sep 12 13:24 scaling-ek-stack
-rw-r--r-- 1 root root  184 Sep 12 13:24 kibana-service.yaml
-rw-r--r-- 1 root root  354 Sep 12 13:24 kibana-deployment.yaml
-rw-r--r-- 1 root root 1.2K Sep 12 13:24 es-statefulset.yaml
-rw-r--r-- 1 root root  290 Sep 12 13:24 es-service.yaml
-rw-r--r-- 1 root root  185 Sep 12 13:24 es-pvolume.yaml

controlplane efk-stack/elasticsearch-kibana on  main ➜  kubectl apply -f es-pvolume.yaml
persistentvolume/pv-elasticsearch created

controlplane efk-stack/elasticsearch-kibana on  main ➜  kubectl apply -f es-statefulset.yaml
statefulset.apps/elasticsearch created

controlplane efk-stack/elasticsearch-kibana on  main ➜  kubectl apply -f es-service.yaml
service/elasticsearch created

controlplane efk-stack/elasticsearch-kibana on  main ➜



ontrolplane efk-stack/elasticsearch-kibana on  main ➜  kubectl get all -n efk
NAME                  READY   STATUS    RESTARTS   AGE
pod/elasticsearch-0   1/1     Running   0          43s

NAME                    TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)                         AGE
service/elasticsearch   NodePort   10.107.7.129   <none>        9200:30200/TCP,9300:30300/TCP   35s

NAME                             READY   AGE
statefulset.apps/elasticsearch   1/1     43s

controlplane efk-stack/elasticsearch-kibana on  main ➜  curl -ks http://10.107.7.129:9200/_cluster/health

controlplane efk-stack/elasticsearch-kibana on  main ✖ curl -k http://10.107.7.129:9200/_cluster/health
curl: (7) Failed to connect to 10.107.7.129 port 9200 after 0 ms: Connection refused

controlplane efk-stack/elasticsearch-kibana on  main ✖ curl -k https://10.107.7.129:9200/_cluster/health
curl: (35) error:0A00010B:SSL routines::wrong version number

controlplane efk-stack/elasticsearch-kibana on  main ✖ kubectl get pv
NAME               CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                         STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
pv-elasticsearch   5Gi        RWO            Retain           Bound    efk/es-data-elasticsearch-0                  <unset>                          2m2s

controlplane efk-stack/elasticsearch-kibana on  main ➜  kubectl get pvc
NAME                      STATUS   VOLUME             CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
es-data-elasticsearch-0   Bound    pv-elasticsearch   5Gi        RWO                           <unset>                 119s

controlplane efk-stack/elasticsearch-kibana on  main ➜



controlplane efk-stack/elasticsearch-kibana on  main ➜  curl http://localhost:30200
{
  "name" : "elasticsearch-0",
  "cluster_name" : "docker-cluster",
  "cluster_uuid" : "aCCvYtAmTom_uom_e8nhCA",
  "version" : {
    "number" : "8.13.0",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "09df99393193b2c53d92899662a8b8b3c55b45cd",
    "build_date" : "2024-03-22T03:35:46.757803203Z",
    "build_snapshot" : false,
    "lucene_version" : "9.10.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}

controlplane efk-stack/elasticsearch-kibana on  main ➜  curl http://localhost:30200/_cluster/health
{"cluster_name":"docker-cluster","status":"green","timed_out":false,"number_of_nodes":1,"number_of_data_nodes":1,"active_primary_shards":0,"active_shards":0,"relocating_shards":0,"initializing_shards":0,"unassigned_shards":0,"delayed_unassigned_shards":0,"number_of_pending_tasks":0,"number_of_in_flight_fetch":0,"task_max_waiting_in_queue_millis":0,"active_shards_percent_as_number":100.0}
controlplane efk-stack/elasticsearch-kibana on  main ➜  curl http://localhost:30200/_cluster/health | jq .
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   390  100   390    0     0  79754      0 --:--:-- --:--:-- --:--:-- 97500
{
  "cluster_name": "docker-cluster",
  "status": "green",
  "timed_out": false,
  "number_of_nodes": 1,
  "number_of_data_nodes": 1,
  "active_primary_shards": 0,
  "active_shards": 0,
  "relocating_shards": 0,
  "initializing_shards": 0,
  "unassigned_shards": 0,
  "delayed_unassigned_shards": 0,
  "number_of_pending_tasks": 0,
  "number_of_in_flight_fetch": 0,
  "task_max_waiting_in_queue_millis": 0,
  "active_shards_percent_as_number": 100
}

controlplane efk-stack/elasticsearch-kibana on  main ➜



controlplane ~ ➜  kubectl get all -n efk
NAME                  READY   STATUS    RESTARTS   AGE
pod/elasticsearch-0   1/1     Running   0          62s

NAME                    TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)                         AGE
service/elasticsearch   NodePort   10.100.9.108   <none>        9200:30200/TCP,9300:30300/TCP   62s

NAME                             READY   AGE
statefulset.apps/elasticsearch   1/1     62s

controlplane ~ ➜

controlplane ~ ➜  curl -ks http://localhost:30200/_cluster/health?pretty | jq .
{
  "cluster_name": "docker-cluster",
  "status": "green",
  "timed_out": false,
  "number_of_nodes": 1,
  "number_of_data_nodes": 1,
  "active_primary_shards": 0,
  "active_shards": 0,
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


controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE    VERSION
controlplane   Ready    control-plane   125m   v1.29.0

controlplane ~ ➜



controlplane ~ ➜  kubectl get nodes
NAME           STATUS   ROLES           AGE    VERSION
controlplane   Ready    control-plane   125m   v1.29.0

controlplane ~ ➜  kubectl config set-context --current --namespace=efk
Context "kubernetes-admin@kubernetes" modified.

controlplane ~ ➜  kubectl get all
NAME                  READY   STATUS    RESTARTS   AGE
pod/elasticsearch-0   1/1     Running   0          3m33s

NAME                    TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)                         AGE
service/elasticsearch   NodePort   10.100.9.108   <none>        9200:30200/TCP,9300:30300/TCP   3m33s

NAME                             READY   AGE
statefulset.apps/elasticsearch   1/1     3m33s

controlplane ~ ➜


controlplane efk-stack/elasticsearch-kibana on  main ➜  ls -rtlh
total 24K
drwxr-xr-x 2 root root 4.0K Sep 12 21:49 scaling-ek-stack
-rw-r--r-- 1 root root  184 Sep 12 21:49 kibana-service.yaml
-rw-r--r-- 1 root root  354 Sep 12 21:49 kibana-deployment.yaml
-rw-r--r-- 1 root root 1.2K Sep 12 21:49 es-statefulset.yaml
-rw-r--r-- 1 root root  290 Sep 12 21:49 es-service.yaml
-rw-r--r-- 1 root root  185 Sep 12 21:49 es-pvolume.yaml

controlplane efk-stack/elasticsearch-kibana on  main ➜  kubectl apply -f kibana-deployment.yaml
deployment.apps/kibana created

controlplane efk-stack/elasticsearch-kibana on  main ➜  kubectl apply -f kibana-service.yaml
service/kibana created

controlplane efk-stack/elasticsearch-kibana on  main ➜  kubectl get all
NAME                          READY   STATUS              RESTARTS   AGE
pod/elasticsearch-0           1/1     Running             0          4m36s
pod/kibana-6657dcdb97-rbx68   0/1     ContainerCreating   0          15s

NAME                    TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE
service/elasticsearch   NodePort   10.100.9.108     <none>        9200:30200/TCP,9300:30300/TCP   4m36s
service/kibana          NodePort   10.104.218.172   <none>        5601:30601/TCP                  8s

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kibana   0/1     1            0           15s

NAME                                DESIRED   CURRENT   READY   AGE
replicaset.apps/kibana-6657dcdb97   1         1         0       15s

NAME                             READY   AGE
statefulset.apps/elasticsearch   1/1     4m36s

controlplane efk-stack/elasticsearch-kibana on  main ➜




1. Secure Kubernetes CLUSTER
2. Enable SSL/TLS Encryption
3. Elastic Stack Security Features
4. Restrict Elasticsearch Access


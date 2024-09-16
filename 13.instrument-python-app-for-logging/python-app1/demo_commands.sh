bharathkumardasaraju@efk-stack$ kubectl config set-context k3d-poc-elastic-cluster
Context "k3d-poc-elastic-cluster" modified.
bharathkumardasaraju@efk-stack$

bharathkumardasaraju@efk-stack$ kubectl config use-context k3d-poc-elastic-cluster

Switched to context "k3d-poc-elastic-cluster".
bharathkumardasaraju@efk-stack$ kubectl config current-context
k3d-poc-elastic-cluster
bharathkumardasaraju@efk-stack$


bharathkumardasaraju@efk-stack$ kubectl get nodes -o wide
NAME                               STATUS   ROLES                  AGE     VERSION        INTERNAL-IP   EXTERNAL-IP   OS-IMAGE           KERNEL-VERSION    CONTAINER-RUNTIME
k3d-poc-elastic-cluster-agent-0    Ready    <none>                 5d22h   v1.30.3+k3s1   172.20.0.4    <none>        K3s v1.30.3+k3s1   6.6.16-linuxkit   containerd://1.7.17-k3s1
k3d-poc-elastic-cluster-agent-1    Ready    <none>                 5d22h   v1.30.3+k3s1   172.20.0.5    <none>        K3s v1.30.3+k3s1   6.6.16-linuxkit   containerd://1.7.17-k3s1
k3d-poc-elastic-cluster-server-0   Ready    control-plane,master   5d22h   v1.30.3+k3s1   172.20.0.3    <none>        K3s v1.30.3+k3s1   6.6.16-linuxkit   containerd://1.7.17-k3s1
bharathkumardasaraju@efk-stack$ kubectl describe node k3d-poc-elastic-cluster-server-0 | grep -i arch
Labels:             beta.kubernetes.io/arch=arm64
                    kubernetes.io/arch=arm64
  Architecture:               arm64
  elastic-system              elasticsearch-es-default-0         1 (12%)       2 (25%)     2Gi (20%)        4Gi (41%)      5d21h
bharathkumardasaraju@efk-stack$



---------------------------------------------------------------------------------------------------------------------------------------:

controlplane ~ ➜  kubectl get all -n efk
NAME                          READY   STATUS            RESTARTS   AGE
pod/elasticsearch-0           0/1     PodInitializing   0          75s
pod/fluent-bit-56xt8          1/1     Running           0          74s
pod/kibana-6657dcdb97-4lm8c   1/1     Running           0          73s

NAME                    TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)                         AGE
service/elasticsearch   NodePort   10.97.2.25     <none>        9200:30200/TCP,9300:30300/TCP   75s
service/kibana          NodePort   10.108.0.169   <none>        5601:30601/TCP                  74s

NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/fluent-bit   0         0         0       0            0           <none>          74s

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kibana   1/1     1            1           74s

NAME                                DESIRED   CURRENT   READY   AGE
replicaset.apps/kibana-6657dcdb97   1         1         1       74s

NAME                             READY   AGE
statefulset.apps/elasticsearch   0/1     75s

controlplane ~ ➜


controlplane efk-stack/event-generator on  main ➜  ls -rtlh
total 24K
-rw-r--r-- 1 root root  372 Sep 12 22:54 webapp-fluent-bit.yaml
-rw-r--r-- 1 root root 2.2K Sep 12 22:54 fluent-bit.yaml
-rw-r--r-- 1 root root  112 Sep 12 22:54 fluent-bit-sa.yaml
-rw-r--r-- 1 root root 1.4K Sep 12 22:54 fluent-bit-configmap.yaml
-rw-r--r-- 1 root root  181 Sep 12 22:54 fluent-bit-clusterrole.yaml
-rw-r--r-- 1 root root  260 Sep 12 22:54 fluent-bit-clusterrolebinding.yaml

controlplane efk-stack/event-generator on  main ➜  kubetl apply -f . -n efk
-bash: kubetl: command not found

controlplane efk-stack/event-generator on  main ✖ kubettl get pods -n efk
-bash: kubettl: command not found

controlplane efk-stack/event-generator on  main ✖ kubectl get pods -n efk
NAME                      READY   STATUS    RESTARTS   AGE
elasticsearch-0           1/1     Running   0          5m22s
fluent-bit-56xt8          1/1     Running   0          5m21s
kibana-6657dcdb97-4lm8c   1/1     Running   0          5m20s

controlplane efk-stack/event-generator on  main ➜  kubectl config set-context --current --namespace=efk
Context "kubernetes-admin@kubernetes" modified.

controlplane efk-stack/event-generator on  main ➜  kubectl apply -f .
clusterrole.rbac.authorization.k8s.io/fluent-bit unchanged
clusterrolebinding.rbac.authorization.k8s.io/fluent-bit unchanged
configmap/fluent-bit unchanged
serviceaccount/fluent-bit unchanged
daemonset.apps/fluent-bit unchanged
pod/app-event-simulator created

controlplane efk-stack/event-generator on  main ➜


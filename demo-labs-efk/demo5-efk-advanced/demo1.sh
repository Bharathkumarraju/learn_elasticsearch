controlplane ~ ➜  kubectl get all -A
NAMESPACE       NAME                                       READY   STATUS    RESTARTS   AGE
elastic-stack   pod/app                                    1/1     Running   0          52m
elastic-stack   pod/elasticsearch-0                        1/1     Running   0          52m
elastic-stack   pod/fluentd-qq4bf                          1/1     Running   0          52m
elastic-stack   pod/kibana-66b7879577-tt24d                1/1     Running   0          52m
kube-flannel    pod/kube-flannel-ds-sjbsd                  1/1     Running   0          83m
kube-system     pod/coredns-69f9c977-6ltsk                 1/1     Running   0          83m
kube-system     pod/coredns-69f9c977-brrqm                 1/1     Running   0          83m
kube-system     pod/etcd-controlplane                      1/1     Running   0          83m
kube-system     pod/kube-apiserver-controlplane            1/1     Running   0          83m
kube-system     pod/kube-controller-manager-controlplane   1/1     Running   0          83m
kube-system     pod/kube-proxy-ckrz5                       1/1     Running   0          83m
kube-system     pod/kube-scheduler-controlplane            1/1     Running   0          83m

NAMESPACE       NAME                    TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE
default         service/kubernetes      ClusterIP   10.96.0.1        <none>        443/TCP                         83m
elastic-stack   service/elasticsearch   NodePort    10.97.191.50     <none>        9200:30200/TCP,9300:30300/TCP   52m
elastic-stack   service/kibana          NodePort    10.101.181.105   <none>        5601:30601/TCP                  52m
kube-system     service/kube-dns        ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP          83m

NAMESPACE       NAME                             DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
elastic-stack   daemonset.apps/fluentd           1         1         1       1            1           <none>                   52m
kube-flannel    daemonset.apps/kube-flannel-ds   1         1         1       1            1           <none>                   83m
kube-system     daemonset.apps/kube-proxy        1         1         1       1            1           kubernetes.io/os=linux   83m

NAMESPACE       NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
elastic-stack   deployment.apps/kibana    1/1     1            1           52m
kube-system     deployment.apps/coredns   2/2     2            2           83m

NAMESPACE       NAME                                DESIRED   CURRENT   READY   AGE
elastic-stack   replicaset.apps/kibana-66b7879577   1         1         1       52m
kube-system     replicaset.apps/coredns-69f9c977    2         2         2       83m

NAMESPACE       NAME                             READY   AGE
elastic-stack   statefulset.apps/elasticsearch   1/1     52m

controlplane ~ ➜

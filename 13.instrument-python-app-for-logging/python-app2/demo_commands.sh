bharathkumardasaraju@efk-stack$ kubectl get all -n elastic-system
NAME                             READY   STATUS    RESTARTS   AGE
pod/bharath-test                 1/1     Running   0          5d22h
pod/elastic-operator-0           1/1     Running   0          5d22h
pod/elasticsearch-es-default-0   1/1     Running   0          5d21h
pod/kibana-kb-fc479df8-295v9     1/1     Running   0          5d21h

NAME                                     TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
service/elastic-operator-webhook         ClusterIP   10.43.94.81   <none>        443/TCP    5d22h
service/elasticsearch-es-default         ClusterIP   None          <none>        9200/TCP   5d22h
service/elasticsearch-es-http            ClusterIP   10.43.22.96   <none>        9200/TCP   5d22h
service/elasticsearch-es-internal-http   ClusterIP   10.43.96.15   <none>        9200/TCP   5d22h
service/elasticsearch-es-transport       ClusterIP   None          <none>        9300/TCP   5d22h
service/kibana-kb-http                   ClusterIP   10.43.122.9   <none>        5601/TCP   5d22h

NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kibana-kb   1/1     1            1           5d22h

NAME                                   DESIRED   CURRENT   READY   AGE
replicaset.apps/kibana-kb-7fc74f94bb   0         0         0       5d22h
replicaset.apps/kibana-kb-fc479df8     1         1         1       5d21h

NAME                                        READY   AGE
statefulset.apps/elastic-operator           1/1     5d22h
statefulset.apps/elasticsearch-es-default   1/1     5d22h
bharathkumardasaraju@efk-stack$


-------------------------------------------------------------------------------------------------------------------------
bharathkumardasaraju@fluentbit$ pwd
/Users/bharathkumardasaraju/git/abex-efk-app-poc/instrument-python-app-for-logging/python-app2/fluentbit
bharathkumardasaraju@fluentbit$


bharathkumardasaraju@fluentbit$ kubectl apply -f . -n elastic-system
clusterrole.rbac.authorization.k8s.io/fluent-bit created
clusterrolebinding.rbac.authorization.k8s.io/fluent-bit created
configmap/fluent-bit created
serviceaccount/fluent-bit created
daemonset.apps/fluent-bit created
bharathkumardasaraju@fluentbit$



bharathkumardasaraju@fluentbit$ kubectl get nodes -o wide
NAME                               STATUS   ROLES                  AGE     VERSION        INTERNAL-IP   EXTERNAL-IP   OS-IMAGE           KERNEL-VERSION    CONTAINER-RUNTIME
k3d-poc-elastic-cluster-agent-0    Ready    <none>                 5d22h   v1.30.3+k3s1   172.20.0.4    <none>        K3s v1.30.3+k3s1   6.6.16-linuxkit   containerd://1.7.17-k3s1
k3d-poc-elastic-cluster-agent-1    Ready    <none>                 5d22h   v1.30.3+k3s1   172.20.0.5    <none>        K3s v1.30.3+k3s1   6.6.16-linuxkit   containerd://1.7.17-k3s1
k3d-poc-elastic-cluster-server-0   Ready    control-plane,master   5d22h   v1.30.3+k3s1   172.20.0.3    <none>        K3s v1.30.3+k3s1   6.6.16-linuxkit   containerd://1.7.17-k3s1
bharathkumardasaraju@fluentbit$ docker exec -it k3d-poc-elastic-cluster-agent-0 /bin/sh
~ # touch /etc/machine-id
~ # exit
bharathkumardasaraju@fluentbit$ docker exec -it k3d-poc-elastic-cluster-agent-1 /bin/sh
~ # touch /etc/machine-id
~ # exit
bharathkumardasaraju@fluentbit$ docker exec -it k3d-poc-elastic-cluster-server-0 /bin/sh
~ # touch /etc/machine-id
~ # exit
bharathkumardasaraju@fluentbit$ kubectl rollout restart daemonset fluent-bit -n elastic-system

daemonset.apps/fluent-bit restarted
bharathkumardasaraju@fluentbit$



bharathkumardasaraju@efk-stack$ kubectl get pods -n elastic-system
NAME                         READY   STATUS    RESTARTS   AGE
bharath-test                 1/1     Running   0          5d22h
elastic-operator-0           1/1     Running   0          5d22h
elasticsearch-es-default-0   1/1     Running   0          5d22h
fluent-bit-fzxbj             1/1     Running   0          35s
fluent-bit-hm794             1/1     Running   0          35s
fluent-bit-rq5qb             1/1     Running   0          35s
kibana-kb-fc479df8-295v9     1/1     Running   0          5d22h
bharathkumardasaraju@efk-stack$

bharathkumardasaraju@efk-stack$ kubectl get all -n elastic-system
NAME                             READY   STATUS    RESTARTS   AGE
pod/bharath-test                 1/1     Running   0          5d22h
pod/elastic-operator-0           1/1     Running   0          5d22h
pod/elasticsearch-es-default-0   1/1     Running   0          5d22h
pod/fluent-bit-fzxbj             1/1     Running   0          22s
pod/fluent-bit-hm794             1/1     Running   0          22s
pod/fluent-bit-rq5qb             1/1     Running   0          22s
pod/kibana-kb-fc479df8-295v9     1/1     Running   0          5d22h

NAME                                     TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
service/elastic-operator-webhook         ClusterIP   10.43.94.81   <none>        443/TCP    5d22h
service/elasticsearch-es-default         ClusterIP   None          <none>        9200/TCP   5d22h
service/elasticsearch-es-http            ClusterIP   10.43.22.96   <none>        9200/TCP   5d22h
service/elasticsearch-es-internal-http   ClusterIP   10.43.96.15   <none>        9200/TCP   5d22h
service/elasticsearch-es-transport       ClusterIP   None          <none>        9300/TCP   5d22h
service/kibana-kb-http                   ClusterIP   10.43.122.9   <none>        5601/TCP   5d22h

NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/fluent-bit   3         3         3       3            3           <none>          7m51s

NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kibana-kb   1/1     1            1           5d22h

NAME                                   DESIRED   CURRENT   READY   AGE
replicaset.apps/kibana-kb-7fc74f94bb   0         0         0       5d22h
replicaset.apps/kibana-kb-fc479df8     1         1         1       5d22h

NAME                                        READY   AGE
statefulset.apps/elastic-operator           1/1     5d22h
statefulset.apps/elasticsearch-es-default   1/1     5d22h
bharathkumardasaraju@efk-stack$



bharathkumardasaraju@python-app2$ docker build -t bharathkumarraju/simple-login-page:latest .
[+] Building 12.7s (11/11) FINISHED                                                                                                                                                            docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                                                                           0.0s
 => => transferring dockerfile: 277B                                                                                                                                                                           0.0s
 => [internal] load metadata for docker.io/library/python:3.8-slim-buster                                                                                                                                      3.5s
 => [auth] library/python:pull token for registry-1.docker.io                                                                                                                                                  0.0s
 => [internal] load .dockerignore                                                                                                                                                                              0.0s
 => => transferring context: 2B                                                                                                                                                                                0.0s
 => [1/5] FROM docker.io/library/python:3.8-slim-buster@sha256:8799b0564103a9f36cfb8a8e1c562e11a9a6f2e3bb214e2adc23982b36a04511                                                                                4.5s
 => => resolve docker.io/library/python:3.8-slim-buster@sha256:8799b0564103a9f36cfb8a8e1c562e11a9a6f2e3bb214e2adc23982b36a04511                                                                                0.0s
 => => sha256:d191be7a3c9fa95847a482db8211b6f85b45096c7817fdad4d7661ee7ff1a421 25.92MB / 25.92MB                                                                                                               2.8s
 => => sha256:14aea17807c4c653827ca820a0526d96552bda685bf29293e8be90d1b05662f6 2.65MB / 2.65MB                                                                                                                 2.0s
 => => sha256:3fe349e029970270c77c6cc4e8c8159d6390de76a4c30666e585e9ac57e54212 12.98MB / 12.98MB                                                                                                               3.3s
 => => sha256:8799b0564103a9f36cfb8a8e1c562e11a9a6f2e3bb214e2adc23982b36a04511 988B / 988B                                                                                                                     0.0s
 => => sha256:23d7a8ad83a5dc0487d65a89ab61aa618e5b5d6379b6e429e0459be999b5b8fd 1.37kB / 1.37kB                                                                                                                 0.0s
 => => sha256:ebe69edfe405db3fc5cb36968a6f0359602992d8083c6674d9cf21af5362ca7e 6.88kB / 6.88kB                                                                                                                 0.0s
 => => sha256:7399277d91f4520aebebe70097c48af726818282fbbc79c1fb34b53f088eb090 243B / 243B                                                                                                                     2.7s
 => => sha256:35f10c4cf03d43a7afd688184e68c55cc3adc2049e78dffcc419a28f8ee8ac68 3.14MB / 3.14MB                                                                                                                 4.3s
 => => extracting sha256:d191be7a3c9fa95847a482db8211b6f85b45096c7817fdad4d7661ee7ff1a421                                                                                                                      0.6s
 => => extracting sha256:14aea17807c4c653827ca820a0526d96552bda685bf29293e8be90d1b05662f6                                                                                                                      0.1s
 => => extracting sha256:3fe349e029970270c77c6cc4e8c8159d6390de76a4c30666e585e9ac57e54212                                                                                                                      0.2s
 => => extracting sha256:7399277d91f4520aebebe70097c48af726818282fbbc79c1fb34b53f088eb090                                                                                                                      0.0s
 => => extracting sha256:35f10c4cf03d43a7afd688184e68c55cc3adc2049e78dffcc419a28f8ee8ac68                                                                                                                      0.1s
 => [internal] load build context                                                                                                                                                                              0.0s
 => => transferring context: 30.21kB                                                                                                                                                                           0.0s
 => [2/5] WORKDIR /app                                                                                                                                                                                         0.3s
 => [3/5] COPY requirements.txt requirements.txt                                                                                                                                                               0.0s
 => [4/5] RUN pip3 install -r requirements.txt                                                                                                                                                                 4.2s
 => [5/5] COPY . .                                                                                                                                                                                             0.0s
 => exporting to image                                                                                                                                                                                         0.2s
 => => exporting layers                                                                                                                                                                                        0.2s
 => => writing image sha256:6cf1785757db40ec85824214d799838a88d3ef0317d58cb9a5976698052ddd03                                                                                                                   0.0s
 => => naming to docker.io/bharathkumarraju/simple-login-page:latest                                                                                                                                           0.0s
bharathkumardasaraju@python-app2$



################################################# deploy the python login app ##############################################################


bharathkumardasaraju@python-app2$ cd k8s-deployment
bharathkumardasaraju@k8s-deployment$ ls -rtlh
total 56
-rw-r--r--@ 1 bharathkumardasaraju  staff   181B Sep 11 06:14 fluent-bit-clusterrole.yaml
-rw-r--r--@ 1 bharathkumardasaraju  staff   260B Sep 11 06:14 fluent-bit-clusterrolebinding.yaml
-rw-r--r--@ 1 bharathkumardasaraju  staff   282B Sep 13 07:33 python-app-service.yaml
-rw-r--r--@ 1 bharathkumardasaraju  staff   589B Sep 13 07:33 python-app-deployment.yaml
-rw-r--r--@ 1 bharathkumardasaraju  staff   1.4K Sep 13 07:38 fluent-bit-configmap.yaml
-rw-r--r--@ 1 bharathkumardasaraju  staff   123B Sep 13 07:38 fluent-bit-sa.yaml
-rw-r--r--@ 1 bharathkumardasaraju  staff   2.2K Sep 13 07:38 fluent-bit.yaml
bharathkumardasaraju@k8s-deployment$ kubectl apply -f python-app-deployment.yaml
deployment.apps/simple-webapp-deployment created
bharathkumardasaraju@k8s-deployment$ kubectl apply -f python-app-service.yaml
service/simple-webapp-service created
bharathkumardasaraju@k8s-deployment$


bharathkumardasaraju@k8s-deployment$ kubectl get pods -n elastic-system
NAME                                        READY   STATUS    RESTARTS   AGE
bharath-test                                1/1     Running   0          5d22h
elastic-operator-0                          1/1     Running   0          5d23h
elasticsearch-es-default-0                  1/1     Running   0          5d22h
fluent-bit-fzxbj                            1/1     Running   0          23m
fluent-bit-hm794                            1/1     Running   0          23m
fluent-bit-rq5qb                            1/1     Running   0          23m
kibana-kb-fc479df8-295v9                    1/1     Running   0          5d22h
simple-webapp-deployment-8685889bbb-79ggx   1/1     Running   0          39s
bharathkumardasaraju@k8s-deployment$ kubectl get svc -n elastic-system
NAME                             TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
elastic-operator-webhook         ClusterIP   10.43.94.81    <none>        443/TCP        5d23h
elasticsearch-es-default         ClusterIP   None           <none>        9200/TCP       5d22h
elasticsearch-es-http            ClusterIP   10.43.22.96    <none>        9200/TCP       5d22h
elasticsearch-es-internal-http   ClusterIP   10.43.96.15    <none>        9200/TCP       5d22h
elasticsearch-es-transport       ClusterIP   None           <none>        9300/TCP       5d22h
kibana-kb-http                   ClusterIP   10.43.122.9    <none>        5601/TCP       5d22h
simple-webapp-service            NodePort    10.43.172.25   <none>        80:30001/TCP   45s
bharathkumardasaraju@k8s-deployment$



bharathkumardasaraju@efk-stack$ kubectl get all -n elastic-system
NAME                                            READY   STATUS    RESTARTS   AGE
pod/bharath-test                                1/1     Running   0          5d23h
pod/elastic-operator-0                          1/1     Running   0          5d23h
pod/elasticsearch-es-default-0                  1/1     Running   0          5d23h
pod/fluent-bit-fzxbj                            1/1     Running   0          69m
pod/fluent-bit-hm794                            1/1     Running   0          69m
pod/fluent-bit-rq5qb                            1/1     Running   0          69m
pod/kibana-kb-fc479df8-295v9                    1/1     Running   0          5d23h
pod/simple-webapp-deployment-8685889bbb-79ggx   1/1     Running   0          46m

NAME                                     TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE
service/elastic-operator-webhook         ClusterIP   10.43.94.81   <none>        443/TCP        5d23h
service/elasticsearch-es-default         ClusterIP   None          <none>        9200/TCP       5d23h
service/elasticsearch-es-http            ClusterIP   10.43.22.96   <none>        9200/TCP       5d23h
service/elasticsearch-es-internal-http   ClusterIP   10.43.96.15   <none>        9200/TCP       5d23h
service/elasticsearch-es-transport       ClusterIP   None          <none>        9300/TCP       5d23h
service/kibana-kb-http                   ClusterIP   10.43.122.9   <none>        5601/TCP       5d23h
service/simple-webapp-service            NodePort    10.43.190.0   <none>        80:30009/TCP   10m

NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/fluent-bit   3         3         3       3            3           <none>          77m

NAME                                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kibana-kb                  1/1     1            1           5d23h
deployment.apps/simple-webapp-deployment   1/1     1            1           46m

NAME                                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/kibana-kb-7fc74f94bb                  0         0         0       5d23h
replicaset.apps/kibana-kb-fc479df8                    1         1         1       5d23h
replicaset.apps/simple-webapp-deployment-8685889bbb   1         1         1       46m

NAME                                        READY   AGE
statefulset.apps/elastic-operator           1/1     5d23h
statefulset.apps/elasticsearch-es-default   1/1     5d23h
bharathkumardasaraju@efk-stack$



bharathkumardasaraju@efk-stack$ kubectl get pods -n elastic-system
NAME                                        READY   STATUS    RESTARTS   AGE
bharath-test                                1/1     Running   0          5d23h
elastic-operator-0                          1/1     Running   0          5d23h
elasticsearch-es-default-0                  1/1     Running   0          5d23h
fluent-bit-fzxbj                            1/1     Running   0          70m
fluent-bit-hm794                            1/1     Running   0          70m
fluent-bit-rq5qb                            1/1     Running   0          70m
kibana-kb-fc479df8-295v9                    1/1     Running   0          5d23h
simple-webapp-deployment-8685889bbb-79ggx   1/1     Running   0          46m
bharathkumardasaraju@efk-stack$ kubectl get svc -n elastic-system
NAME                             TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE
elastic-operator-webhook         ClusterIP   10.43.94.81   <none>        443/TCP        5d23h
elasticsearch-es-default         ClusterIP   None          <none>        9200/TCP       5d23h
elasticsearch-es-http            ClusterIP   10.43.22.96   <none>        9200/TCP       5d23h
elasticsearch-es-internal-http   ClusterIP   10.43.96.15   <none>        9200/TCP       5d23h
elasticsearch-es-transport       ClusterIP   None          <none>        9300/TCP       5d23h
kibana-kb-http                   ClusterIP   10.43.122.9   <none>        5601/TCP       5d23h
simple-webapp-service            NodePort    10.43.190.0   <none>        80:30009/TCP   10m
bharathkumardasaraju@efk-stack$




bharathkumardasaraju@k8s-deployment$ kubectl port-forward svc/simple-webapp-service 8080:80 -n elastic-system

Forwarding from 127.0.0.1:8080 -> 5005
Forwarding from [::1]:8080 -> 5005
Handling connection for 8080
Handling connection for 8080
E0913 08:25:02.769038   19763 portforward.go:394] error copying from local connection to remote stream: read tcp6 [::1]:8080->[::1]:53710: read: connection reset by peer
Handling connection for 8080








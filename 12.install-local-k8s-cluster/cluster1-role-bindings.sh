bharathkumardasaraju@install-local-k8s-cluster$ kubectl delete ClusterRoleBinding elastic-agent
clusterrolebinding.rbac.authorization.k8s.io "elastic-agent" deleted
bharathkumardasaraju@install-local-k8s-cluster$ kubectl delete RoleBinding elastic-agent elastic-agent-kubeadm-config -n kube-system
rolebinding.rbac.authorization.k8s.io "elastic-agent" deleted
rolebinding.rbac.authorization.k8s.io "elastic-agent-kubeadm-config" deleted


bharathkumardasaraju@install-local-k8s-cluster$ kubectl delete ClusterRole elastic-agent
clusterrole.rbac.authorization.k8s.io "elastic-agent" deleted
bharathkumardasaraju@install-local-k8s-cluster$ kubectl delete Role elastic-agent  elastic-agent-kubeadm-config -n kube-system
role.rbac.authorization.k8s.io "elastic-agent" deleted
role.rbac.authorization.k8s.io "elastic-agent-kubeadm-config" deleted


bharathkumardasaraju@install-local-k8s-cluster$ kubectl apply -f cluster1-elastic-agent.yaml
daemonset.apps/elastic-agent unchanged
clusterrolebinding.rbac.authorization.k8s.io/elastic-agent created
clusterrole.rbac.authorization.k8s.io/elastic-agent created
serviceaccount/elastic-agent unchanged
bharathkumardasaraju@install-local-k8s-cluster$ cat cluster1-elastic-agent.yaml


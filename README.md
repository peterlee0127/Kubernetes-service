# Kubernetes-service
My Kubernetes-service

```shell
sudo kubeadm init --apiserver-advertise-address 192.168.2.104 --pod-network-cidr 10.32.0.0/16 --service-cidr 10.32.0.0/12 --ignore-preflight-errors all
```

## Manual set Kubernetes each node ip

```
# example of config, do this at every nodes.
/var/lib/kubelet/kubeadm-flags.env
KUBELET_KUBEADM_ARGS=--cgroup-driver=systemd --network-plugin=cni --pod-infra-container-image=k8s.gcr.io/pause:3.1 --node-ip=192.168.2.xxx

# restart kubelet
$ sudo systemctl restart kubelet
```



## Disable Swap

```
$ sudo swapoff -a
$ sudo vim /etc/fstab 
# disable swap partition.
```





```
├── LICENSE
├── README.md
├── elk
│   ├── elasticsearch-deploy.yml
│   ├── kibana-deploy.yml
│   └── kibana.yml
├── flannel
│   └── kube-flannel.yml
├── jenkins
│   ├── install_plugin.sh
│   └── jenkins.yml
├── nfs
│   ├── nfs-rbac.yaml
│   └── nfs-storage.yml
└── script
    └── prepare_k8s.sh
```





Get endpoint for services

```
$ kubectl get services

NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                        AGE
elasticsearch-service   NodePort    10.41.176.86   <none>        9200:31787/TCP                 4d17h
jenkins                 NodePort    10.38.18.18    <none>        80:31475/TCP,50000:30351/TCP   19d
kibana-service          NodePort    10.38.83.36    <none>        5601:31667/TCP                 4d17h
kubernetes              ClusterIP   10.32.0.1      <none>        443/TCP                        29d
```



Set subdomain Nginx redirect

```
server {
		server_name ci.xxx.com;
  		listen       443 ssl http2;
		ssl_session_cache shared:SSL:1m;
		ssl_session_timeout  10m;
		ssl_ciphers HIGH:!aNULL:!MD5;
		ssl_prefer_server_ciphers on;
		location / {
			proxy_set_header Host $host;
			proxy_set_header X-Real-IP $remote_addr;
			proxy_http_version 1.1;
	    	expires off;
    		proxy_buffering off;
    		chunked_transfer_encoding on;
			proxy_pass http://x.x.x.x;
		}

}
```






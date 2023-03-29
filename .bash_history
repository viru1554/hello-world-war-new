apt update && apt upgrade -y && apt dist-upgrade -y
apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg2 net-tools
hostnamectl set-hostname $(curl -s http://169.254.169.254/latest/meta-data/local-hostname)
apt install -y docker.io
cat << EOF > /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

systemctl stop docker
systemctl start docker
systemctl enable docker
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sysctl --system
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
apt update
apt install kubelet="1.22.17-00" 
apt install kubeadm="1.22.17-00"
apt install kubectl="1.22.17-00"
cat << EOF > /etc/kubernetes/aws.yaml
---
apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
kubernetesVersion: v1.22.17
networking:
  serviceSubnet: "10.100.0.0/16"
  podSubnet: "10.244.0.0/16"
apiServer:
  extraArgs:
    cloud-provider: "aws"
controllerManager:
  extraArgs:
    cloud-provider: "aws"
EOF

kubeadm init --config /etc/kubernetes/aws.yaml
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
kubectl get nodes
ls
kubectl get pods
kubectl get namespaces
kubectl delete -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/tigera-operator.yaml
wget https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/custom-resources.yaml
vi custom-resources.yaml 
kubectl apply -f custom-resources.yaml
ls
vi jenkinspod.yml
kubectl apply -f jenkinspod.yml 
kubectl get pods
vi jenkinspod.yml
kubectl apply -f jenkinspod.yml 
kubectl get pods
kubectl get pods -A
kubectl get pods
vi clusterip.yml
kubectl apply -f clusterip.yml
kubectl get svc
curl -v 10.100.219.160:8080
kubectl get pods -owide
curl -v 10.244.219.3:8080
kubectl get svc
curl -v 10.100.219.160:8080
kubectl get pods -owide
curl -v 10.244.219.4:8080
curl -v 10.244.219.3:8080
kubectl get svc
curl -v 10.100.219.160:8080
curl -v 10.100.0.1:8080
kubectl get svc
curl -v 10.100.219.160:8080
apt install awscli
aws configure
kubectl get svc
curl -v 10.100.219.160:8080
kubectl get svc
curl -v 10.100.219.160:80
curl -v 10.100.219.160:8080
kubectl get ns
kubectl create namespace myenv
kubectl get ns
vi myenv.yml
kubectl apply -f myenv.yml 
vi myenv.yml
kubectl apply -f myenv.yml 
kubectl get pods
vi myenv.yml
kubectl apply -f myenv.yml 
kubectl get pods
kubectl get pods -n myenv
vi jenkreplicaset.yml
ls
kubectl apply -f jenkreplicaset.yml
kubectl get pods
kubectl get replicaset
kubectl get nodes
kubectl get pods
kubectl get svc
kubectl get ns
kubectl get replicaset
kubectl delete pod myreplicaset-2dvcj myreplicaset-qj8t2
kubectl get pods -owide
kubectl delete pod myreplicaset-2dvcj myreplicaset-qj8t2 --force
kubectl get pods -owide
kubectl delete pod myreplicaset-25r44 myreplicaset-gkxr8
kubectl get pods -owide
kubectl delete pod myreplicaset-25r44 myreplicaset-gkxr8 --force
kubectl get pods -owide
kubectl get nodes
kubectl get pods -n myenv
kubectl get pods
kubectl get ns
kubectl get replicaset
kubectl get pods
kubectl get nodes
kubectl get replicaset
kubectl get nodes
kubectl get replicaset
kubectl get ns
kubectl get pods
kubectl get pods -n myenv
ls
cat myenv.yml 
kubectl apply -f myenv.yml 
kubectl get pods -n myenv
kubectl get pods
kubectl scale --replicas=3  rs myreplicaset
kubectl get svc
curl -v 10.100.219.160:8080
kubectl get nodes
kubectl get pods
kubectl get ns
kubectl get rs
kubectl scale --replicas=2  rs myreplicaset
kubectl get rs
kubectl get pods -n myenv
cat myenv.yml 
vi myenv.yml 
vi jenkreplicaset.yml 
vi myenv.yml 
ls
kubectl get svc
curl -v 10.100.219.160:8060
cat clusterip.yml 
curl -v 10.100.219.160:8080
kubectl get svc
cat clusterip.yml 
curl -v 10.100.219.160:8080
cat clusterip.yml 
vi clusterip.yml 
ls
cat jenkinspod.yml 
kubectl get pods -A
kubectl get pods -owide
curl -v 10.244.194.13:8080
ls
cat clusterip.yml 
rm clusterip.yml 
ls
vi clusterip.yml
cat clusterip.yml 
kubectl apply -f jenkinspod.yml 
kubectl get pods
kubectl get pods -owide
curl -v 10.244.219.12:8080
kubectl apply -f clusterip.yml 
kubectl get svc
curl -v 10.100.219.160:8080
vi clusterip.yml 
kubectl apply -f clusterip.yml 
kubectl get svc
curl -v 10.100.219.160:8080
kubectl get pods -owide
kubectl get endpoints
vi nodeport.yml
kubectl apply -f nodeport.yml 
kubectl get svc
kubectl get endpoints
vi loadbalancer.yml
kubectl get svc
curl -v 10.100.203.241:8080
curl -v 10.100.203.241:30123
kubectl get endpoints
cat jenkinspod.yml 
vi jenkischeck.yml
kubectl apply -f jenkinscheck.yml
ls
kubectl apply -f jenkischeck.yml 
kubectl get pods
kubectl get endpoints
ls
kubectl apply -f loadbalancer.yml
kubectl get svc
kubectl describe service loadbalancer
kubectl get svc
kubectl apply -f loadbalancer.yml
kubectl get svc
kubectl apply -f loadbalancer.yml
vi loadbalancer.yml 
kubectl apply -f loadbalancer.yml
kubectl get svc
kubectl apply -f loadbalancer.yml
kubectl get svc
ls
mv jenkreplicaset.yml replicaset.yml
ls
cat replicaset.yml 
cp replicaset.yml deployment.yml
ls
vi deployment.yml 
kubectl apply -f deployment.yml 
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods
kubectl get pods jenkins-pod --force
kubectl get pods -namespace jenkins-pod --force
kubectl get --help
kubectl get pod jenkins-pod --force
kubectl delete pod jenkins-pod --force
kubectl get pods
kubectl delete pod myreplicaset-brsm8 --force
kubectl delete pod myreplicaset-fknm4 --force
kubectl delete pod myreplicaset-qx9xr --force
kubectl delete pod myreplicaset-rcs9r --force
kubectl delete pod myreplicaset-tzgrp --force
kubectl delete pod myreplicaset-xc45w --force
kubectl get pods
kubectl delete pod second-pods  --force
kubectl get pods
kubectl get nodes
kubectl apply -f deployment.yml 
kubectl get nodes
kubectl get pods
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods
kubectl get deployment
kubectl get rs
vi deployment.yml 
kubectl get deployment
kubectl get pods
kubectl apply -f deployment.yml 
kubectl get deployment
kubectl get pods
kubectl get nodes
df -Th
kubectl get nodes
kubectl apply -f deployment.yml 
kubectl get pods
kubectl get deployment
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods
kubectl get rs
vi replicaset.yml 
kubectl apply -f replicaset.yml 
kubectl get pods
kubectl delete pod cat replicaset.yml 
cat replicaset.yml 
vi replicaset.yml 
kubectl apply -f replicaset.yml 
kubectl get pods
kubectl get rs
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods
vi replicaset.yml 
kubectl apply -f replicaset.yml 
kubectl get pods
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods
vi replicaset.yml 
kubectl apply -f replicaset.yml 
kubectl get pods
cat deployment.yml 
kubectl get pods
kubectl delete pod mydeployment-5d97fc7bb4-5nkh9
kubectl get pods
ls
vi deployment.yml 
kubectl get pods
kubectl apply -f deployment.yml 
kubectl get pods
vi deployment.yml 
vi replicaset.yml 
kubectl apply -f replicaset.yml 
kubectl get pods
ls
cat replicaset.yml 
l
ls
rm deployment.yml 
ls
cp replicaset.yml deployment.yml
ls
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods
rm deployment.yml 
ls
kubectl get pods
kubectl get nodes
kubectl get pods
ls
kubectl apply -f replicaset.yml 
kubectl get pods
cat replicaset.yml 
rm replicaset.yml 
ls
kubectl get pods
vi replicaset.yml
kubectl delete pods my-deployment-654c58cc4b-946hm my-deployment-654c58cc4b-xdljh
kubectl get pods
kubectl get nodes
kubectl get pods
ls
kubectl get nodes
kubectl get pods
ls
kubectl get pods
vi replicaset.yml 
kubectl apply -f replicaset.yml 
kubectl get pods
cp replicaset.yml deployment.yml
ls
kubectl apply -f deployment.yml
kubectl get pods
vi deployment.yml 
kubectl apply -f deployment.yml
kubectl get pods
vi deployment.yml 
vi replicaset.yml 
vi deployment.yml 
kubectl apply -f deployment.yml
kubectl get pods
vi deployment.yml 
kubectl apply -f deployment.yml
kubectl get pods
kubectl get rs
kubectl get deployment
kubectl get pods
kubectl get nodes
kubectl get pods
kubectl get nodes
kubectl get pods
kubectl get nodes
kubectl get pods
ls
kubectl get ns
kubectl get rs
kubectl get deployment
kubectl get pods
cat replicaset.yml 
cat deployment.yml 
vi replicaset.yml 
kubectl apply -f replicaset.yml 
kubectl get pods
kubectl delete pod my-replicaset-gx2d7
kubectl get pods
kubectl get rs
kubectl get deployment
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl get rs
kubectl get deployment
kubectl get rs
kubectl get nodes
kubectl get rs
kubectl get deployment
kubectl get nodes
kubectl get rs
kubectl get deployment
kubectl get ns
kubectl get pods
ls
kubectl get svc
kubectl get nodes
kubectl get ns
vi limitrange.yml
kubectl apply -f limitrange.yml
kubectl describe namespace myenv
ls
cp limitrange.yml limrangememory.yml
ls
vi limrangememory.yml 
kubectl apply -f limrangememory.yml 
kubectl describe namespace myenv
kubectl get pods
kubectl describe namespace myenv
kubectl get pods
kubectl delete deployment my-deployment
kubectl get pods
kubectl delete rs my-replicase
kubectl delete replicaset my-replicaset
kubectl get pods
kubectl get pods -n myenv
cat jenkinspod.yml 
kubectl apply -f jenkinspod.yml 
kubectl get pods -n myenv
kubectl get pods
kubectl delete deployment mydeployment
kubectl get pods
kubectl get pods -n myenv
kubectl get pods
kubectl get pods -n myenv
kubectl get ns
kubectl delete pod jenkins-pod
kubectl apply -f jenkinspod.yml 
kubectl get pods -n myenv
kubectl get pods
kubectl get pods -owide -n myenv
kubectl get pods -owide
kubectl get pod -n myenv
kubectl get pods
kubectl get pods -n myenv
vi resourcequota.yml
vi limrangememory.yml 
cat limitrange.yml 
kubectl apply -f resourcequota.yml 
kubectl describe ns myenv
cat deployment.yml 
kubectl apply -f deployment.yml -n myenv
kubectl get pod -n myenv
kubectl get deployment -n myenv
kubectl get rs -n myenv
kubectl describe namespace myenv
vi resourcequota.yml 
kubectl apply -f resourcequota.yml 
kubectl describe namespace myenv
kubectl get rs -n myenv
kubectl delete rs my-deployment-594677dbfc -n myenv
kubectl get rs -n myenv
kubectl get pods -n myenv
kubectl describe rs my-deployment-594677dbfc-578gg -n myenv
kubectl describe rs my-deployment-594677dbfc-578gg
kubectl describe rs my-deployment-594677dbfc-578gg -n myenv
kubectl get rs -n myenv
kubectl describe ns myenv
kubectl get quota -n myenv
kubectl get deployment -n myenv
kubectl delete deployment my-deployment -n myenv
kubectl get deployment -n myenv
kubectl get quota -n myenv
vi jenkinspod.yml 
kubectl apply -f jenkinspod.yml 
kubectl get quota -n myenv
cat resourcequota.yml 
ls
cat limrangememory.yml 
cat limitrange.yml 
kubectl get pods
kubectl get quota -n myenv
cp deployment.yml demonset.yml
vi demonset.yml 
kubectl apply -f demonset.yml 
kubectl get pods
kubectl get nodes
vi limitrange.yml 
vi demonset.yml 
kubectl apply -f demonset.yml 
kubectl get pods
kubectl delete pods my-daemonset1-t4fdm my-daemonset1-slksq my-daemonset-jtkr5
kubectl get pods
vi demonset.yml 
kubectl apply -f demonset.yml 
kubectl get pods
kubectl delete pods my-daemonset1-d9vd2 my-daemonset1-cflvz
kubectl get pods
kubectl delete pods my-daemonset1-d9vd2 my-daemonset1-cflvz -n myenv
kubectl delete pods jenkins-pod jenkins-pod1
kubectl get pods
kubectl get nodes
kubectl delete pods my-daemonset1-wsx2t my-daemonset1-5k7hm
kubectl get pods
kubectl apply -f demonset.yml 
kubectl get pods
kubectl get nodes
kubectl delete pods my-daemonset-9g762 my-daemonset-wtj9s
kubectl get pods
kubectl apply -f demonset.yml 
kubectl get pods
kubectl get nodes
kubectl get pods
kubectl delete daemonset my-daemonset1-qjncd

kubectl get pods
kubectl delete -f deployment deployment.yml 
kubectl delete -f  deployment.yml 
kubectl get pods
kubectl delete daemonset my-daemonset-2zdzr my-daemonset-kcwk6 my-daemonset1-2tlbz
kubectl delete daemonsets my-daemonset-2zdzr my-daemonset-kcwk6 my-daemonset1-2tlbz
kubectl get pods
kubectl delete pods my-daemonset-2zdzr my-daemonset-kcwk6
kubectl get pods
ls
cat demonset.yml 
mv demonset.yml daemonset.yml
ls
cat deployment.yml 
ls
cat jenkischeck.yml 
cat jenkinspod.yml 
mv jenkischeck.yml checkingjenk.yml
kubectl delete deployment.yml 
kubectl delete deployment deployment.yml 
kubectl delete -f deployment deployment.yml 
kubectl delete -f deployment.yml 
kubectl delete -f daemonset.yml 
kubectl get pods
ls
cat limrangememory.yml 
cat deployment.yml 
kubectl delete -f daemonset.yml 
vi daemonset.yml 
kubectl delete -f daemonset.yml 
kubectl get pods
kubectl get ns
kubectl get rs
kubectl get deployment
kubectl get deployment -n myenv
cat deployment.yml 
vi deployment.yml 
kubectl get nodes
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule
kubectl describe nodes ip-10-0-0-50.us-west-1.compute.internal
cat deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods
kubectl get pods -owide
kubectl delete -f deployment.yml 
kubectl get pods -owide
kubectl get pods
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods -owide
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule
kubectl describe nodes ip-10-0-0-50.us-west-1.compute.internal
kubectl get pods -owide
kubectl delete -f deployment.yml 
kubectl get pods -owide
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods -owide
vi deployment.yml 
kubectl apply -f deployment.yml 
vi deployment.yml 
kubectl apply -f deployment.yml 
vi deployment.yml 
kubectl get pods -owide
kubectl delete -f deployment.yml 
vi deployment.yml 
kubectl delete -f deployment.yml 
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods -owide
kubectl get nodes

kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
taint color=pink:NoSchedule
kubectl get pods -owide
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule
kubectl label nodes ip-10-0-0-50.us-west-1.compute.internal env=dev
kubectl delete -f deployment.yml 
cp deployment.yml label.yml
kubectl get pods -owide
vi label.yml 
kubectl apply -f label.yml 
kubectl get pods -owide
kubectl get nodes
kubectl get pods -owide
vi label.yml 
kubectl get pods -owid
kubectl get nodes
kubectl get pods -owide
kubectl label nodes ip-10-0-0-6.us-west-1.compute.internal env=dev
kubectl delete -f label.yml 
kubectl apply -f label.yml 
kubectl get pods -owide
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule
vi label.yml 
kubectl apply -f label.yml 
kubectl get pods -owide
kubectl describe nodes my-deployment-7f44c8f8bd-s8jxh
kubectl describe node my-deployment-7f44c8f8bd-s8jxh
kubectl get nodes
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule
kubectl get pods -owide
kubectl describe node ip-10-0-0-6.us-west-1.compute.internal
kubectl get nodes --show-labels
kubectl label nodes ip-10-0-0-142.us-west-1.compute.internal env=qa
vi label.yml 
cp label.yml affinity.yml
vi affinity.yml 
kubectl label nodes ip-10-0-0-142.us-west-1.compute.internal env=qa
vi affinity.yml 
kubectl get pods
kubectl delete deployment my-deployment
kubectl get pods
kubectl apply -f affinity.yml
kubectl get pods -owide
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
kubectl get pods -owide
kubectl taint nodes ip-10-0-0-142.us-west-1.compute.internal color=pink:NoSchedule-
kubectl get pods -owide
vi affinity.yml 
kubectl apply -f affinity.yml
kubectl get pods -owide
kubectl taint nodes ip-10-0-0-142.us-west-1.compute.internal color=pink:NoSchedule-
kubectl taint nodes ip-10-0-0-142.us-west-1.compute.internal color=pink:NoSchedule
kubectl taint nodes ip-10-0-0-142.us-west-1.compute.internal color=pink:NoSchedule-
kubectl get pods -owide
kubectl taint nodes ip-10-0-0-142.us-west-1.compute.internal color=pink:NoSchedule
kubectl get pods -owide
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
kubectl get pods -owide
kubectl delete -f affinity.yml 
kubectl get pods -owide
kubectl apply -f affinity.yml 
kubectl get pods -owide
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
kubectl taint nodes ip-10-0-0-142.us-west-1.compute.internal color=pink:NoSchedule-
kubectl get pods -owide
kubectl delete -f affinity.yml 
kubectl get pods -owide
kubectl apply -f affinity.yml 
kubectl taint nodes ip-10-0-0-142.us-west-1.compute.internal color=pink:NoSchedule-
kubectl taint nodes ip-10-0-0-142.us-west-1.compute.internal color=pink:NoSchedule
kubectl taint nodes ip-10-0-0-142.us-west-1.compute.internal color=pink:NoSchedule-
kubectl apply -f affinity.yml 
kubectl get pods -owide
kubectl get nodes
kubectl taint nodes 
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal color=pink:NoSchedule-
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal color=pink:NoSchedule
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal color=pink:NoSchedule-
kubectl get pods -owide
kubectl delete -f affinity.yml 
kubectl apply -f affinity.yml 
kubectl get pods -owide
kubectl get  nodes
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
kubectl get pods -owide
kubectl delete -f affinity.yml 
kubectl apply -f affinity.yml 
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
kubectl get pods -owide
kubectl decribe pod my-deployment-7d6c6c4898-6v2kq
kubectl describe pod my-deployment-7d6c6c4898-6v2kq
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule
kubectl describe pod my-deployment-7d6c6c4898-6v2kq
kubectl get pods -owide
kubectl describe pod my-deployment-7d6c6c4898-pr9bt
kubectl get nodes --show-labels
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
kubectl get pods -owide
kubectl describe pod my-deployment-7d6c6c4898-pr9bt
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal color=pink:NoSchedule-
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal color=pink:NoSchedule
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal color=pink:NoSchedule-
kubectl describe pod my-deployment-7d6c6c4898-pr9bt
kubectl get pods -owide
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule
kubectl describe pod my-deployment-7d6c6c4898-pr9bt
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
kubectl describe pod my-deployment-7d6c6c4898-pr9bt
kubectl get pods -owide
delete
kubectl get pods -owide
kubectl describe pod my-deployment-7d6c6c4898-pr9bt
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
ls
cat label.yml 
cat affinity.yml 
kubectl get pods -owide
kubectl apply -f affinity.yml
kubectl get pods -owide
vi affinity.yml 
kubectl apply -f affinity.yml
kubectl get pods -owide
kubectl delete -f affinity.yml
vi affinity.yml 
kubectl apply -f affinity.yml
kubectl get pods -owide
kubectl get nodes
vi deployment.yml 
kubectl get nodes
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl get pods -owide
kubectl delete -f affinity.yml
kubectl get pods -owide
kubectl delete -f affinity.yml
kubectl get pods -owide
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule-
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal color=pink:NoSchedule
kubectl get nodes
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl get nodes
kubectl taint nodes ip-10-0-0-50.us-west-1.compute.internal colour=pink:NoSchedule
kubectl get nodes -owide
kubectl describe nodes ip-10-0-0-50.us-west-1.compute.internal
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl get nodes -owide
kubectl get pods -owide
kubectl get nodes -o wide
kubectl get nodes 
kubectl getpods
kubectl get pods
kubectl get nodes 
kubectl get pods
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal colour=pink:NoSchedule
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl get nodes --show-labels
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods
kubectl get nods
kubectl get nodes
kubectl get pods
kubectl delete -f deployment.yml 
kubectl get pods
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal colour=pink:NoSchedule
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal colour=pink:NoSchedule-
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal colour=pink:NoSchedule
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl get nodes -o wide
kubectl get pods -o wide
cat affinity.yml 
kubectl delete -f deployment.yml 
kubectl get pods -o wide
kubectl apply -f affinity.yml 
kubectl get pods -o wide
kubectl delete -f deployment.yml 
kubectl get pods -o wide
kubectl get nodes -o wide
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl apply -f deployment.yml 
kubectl get pods -o wide
kubectl get nodes -o wide
kubectl get pods -o wide
kubectl describe nodes ip-10-0-0-142.us-west-1.compute.internal
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl delete -f deployment.yml 
kubectl get pods -o wide
cat affinity.yml 
vi affinity.yml 
kubectl apply -f affinity.yml 
kubectl get pods -o wide
kubectl delete -f affinity.yml 
kubectl get pods -o wide
kubectl delete -f affinity.yml 
kubectl get pods -o wide
kubectl delete -f affinity.yml 
kubectl get pods -o wide
kubectl delete -f affinity.yml
kubectl delete -f affinity.yml 
kubectl get pods -o wide
kubectl delete pods my-deployment-7d6c6c4898-4p2lz my-deployment-7d6c6c4898-jmx8g my-deployment-7d6c6c4898-vmrkj my-deployment-7d6c6c4898-z5f9g
kubectl get pods -o wide
kubectl apply -f deployment.yml 
kubectl get pods -o wide
kubectl get pods 
kubectl get pods -o wide
kubectl get pods -o wide myenv
kubectl get nodes 
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal colour=pink:NoSchedule-
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl get pods -o wide
kubectl apply -f deployment.yml 
kubectl get pods -o wide
kubectl delete -f deployment.yml 
kubectl get pods -o wide
kubectl apply -f affinity.yml 
kubectl get pods -o wide
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods -o wide
kubectl get nodeport.yml nodes
kubectl get nodes
vi deployment.yml 
kubectl delete -f deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods -o wide
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal colour=pink:NoSchedule
kubectl apply -f deployment.yml 
kubectl get pods -o wide
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal colour=pink:NoSchedule-
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal colour=pink:NoSchedule
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl delete -f deployment.yml 
vi deployment.yml 
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal colour=pink:NoSchedule
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal colour=pink:NoSchedule-
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal colour=pink:NoSchedule
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl apply -f deployment.yml 
kubectl get pods -o wide
vi  affinity.yml 
kubectl get nodes -o wide
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl apply -f deployment.yml 
kubectl get pods -o wide
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal colour=pink:NoSchedule-
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl get pods -o wide
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal colour=pink:NoSchedule
kubectl get pods -o wide
kubectl apply -f deployment.yml 
kubectl get pods -o wide
kubectl get pods -owide
kubectl get pods
kubectl get nodes
kubectl get pods -owide
kubectl apply -f affinity.yml 
kubectl get pods -owide
kubectl delete -f deployment.yml 
kubectl get pods -owide
kubectl apply -f affinity.yml 
kubectl get pods -owide
kubectl delete -f affinity.yml 
kubectl get nodes
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl taint nodes ip-10-0-0-6.us-west-1.compute.internal colour=pink:NoSchedule-
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl apply -f affinity.yml 
kubectl get nodes
kubectl get pods -owide
vi affinity.yml 
kubectl get pods -owide
kubectl delete -f affinity.yml 
vi affinity.yml 
kubectl apply -f affinity.yml 
vi affinity.yml 
kubectl apply -f affinity.yml 
vi affinity.yml 
kubectl apply -f affinity.yml 
kubectl get pods -owide
kubectl get nodes
kubectl get pods -owide
kubectl delete -f affinity.yml 
kubectl get pods -owide
vi a
vi affinity.yml 
kubectl apply -f affinity.yml 
kubectl get pods -owide
kubectl describe nodes ip-10-0-0-6.us-west-1.compute.internal
kubectl get pods -owide
kubectl get nodes -owide
kubectl get nodes 
kubectl delete -f affinity.yml 
kubectl get pods -owide
kubectl apply -f affinity.yml 
kubectl get pods -owide
kubectl delete -f affinity.yml 
kubectl get pods -owide
kubectl label nodes ip-10-0-0-142.us-west-1.compute.internal env=qa
kubectl get pods -owide
kubectl get nodes 
git status
git init
git status
git add .
git status
git commit -m "K8's files"
git status
git push https://github.com/viru1554/hello-world-war-new.git
git push https://github.com/viru1554/hello-world-war.git
git push
git push https://github.com/viru1554/hello-world-war-new.git
git pull https://github.com/viru1554/hello-world-war-new.git
git config --global
git config pull.rebase true
git config pull.rebase false
git config pull.ff only
ls
mv limrangememory.yml rangememory.yml
git pull https://github.com/viru1554/hello-world-war-new.git
git push https://github.com/viru1554/hello-world-war-new.git
apt get-update
apt get update
apt update
git push https://github.com/viru1554/hello-world-war-new.git
kubectl get pods -owide
vi affinity.yml 
kubectl apply -f affinity.yml 
kubectl get pods -owide
vi secrets_temp.yml 
kubectl apply -f secrets_temp.yml 
kubectl get secrets
vi pod_secrets.yml
kubectl apply -f pod_secrets.yml 
kubectl get secrets
kubectl get pods
kubectl exec -it secret-details /bin/sh
kubectl get nodes -owide
kubectl get pods -owide
kubectl delete -f affinity.yml 
kubectl get pods -owide
kubectl delete -f affinity.yml 
kubectl get pods -owide
kubectl apply -f affinity.yml 
kubectl get pods -owide
kubectl delete pods my-deployment-694dcf6b64-4mwk8 my-deployment-694dcf6b64-d6fph my-deployment-694dcf6b64-xcjpj
kubectl get pods -owide
kubectl apply -f affinity.yml 
kubectl get pods -owide
kubectl delete -f affinity.yml 
kubectl get pods -owide
kubectl apply -f affinity.yml 
kubectl get pods -owide
kubectl delete -f affinity.yml 
vi configmap.yml
kubectl apply -f configmap.yml
kubectl get configmap
vi Configmap_pod.yml
kubectl apply -f Configmap_pod.yml 
kubectl get nodes
kubectl get pods
kubectl exec -it configmap-demo-pod /bin/sh
vi Configmap_pod.yml 
vi configmap.yml 
kubectl apply -f configmap.yml 
kubectl exec -it configmap-demo-pod /bin/sh
kubectl delete -f configmap.yml 
kubectl apply -f configmap.yml 
kubectl exec -it configmap-demo-pod /bin/sh
vi configmap.yml 
kubectl delete -f Configmap_pod.yml 
kubectl apply -f Configmap_pod.yml 
kubectl grt pos
kubectl get pods
kubectl exec -it configmap-demo-pod /bin/sh
vi configmap.yml 
cat configmap.yml 
kubectl exec -it configmap-demo-pod /bin/sh
kubectl delete -f Configmap_pod.yml 
vi configmap.yml 
kubectl apply -f configmap.yml 
kubectl delete -f configmap.yml 
kubectl apply -f configmap.yml 
kubectl get pods
kubectl apply -f Configmap_pod.yml 
kubectl get pods
kubectl exec -it configmap-demo-pod /bin/sh
vi configmap.yml 
kubectl apply -f configmap.yml 
kubectl delete -f Configmap_pod.yml 
kubectl apply -f Configmap_pod.yml 
kubectl get pods
kubectl exec -it configmap-demo-pod /bin/sh
vi configmap.yml 
kubectl apply -f configmap.yml 
kubectl delete -f Configmap_pod.yml 
kubectl apply -f Configmap_pod.yml 
kubectl get pods
kubectl exec -it configmap-demo-pod /bin/sh
vi configmap.yml 
kubectl apply -f configmap.yml 
vi configmap.yml 
kubectl apply -f configmap.yml 
kubectl delete -f Configmap_pod.yml 
kubectl apply -f Configmap_pod.yml 
kubectl get pods
kubectl exec -it configmap-demo-pod /bin/sh
kubectl create secret generic db-user-pass     --from-literal=username=admin     --from-literal=password='S!B\*d$zDsb='
kubectl get secrets
kubectl get secrets db-user-pass -o yml
kubectl get secrets db-user-pass -o yaml
echo YWRtaW4= | base64 --decode
echo UyFCXCpkJHpEc2I9 | base64 --decode
vi secrets_temp.yml
vi Configmap_pod.yml 
vi Configmap_pod.yml 
vi configmap.yml 
vi Configmap_pod.yml 
vi configmap.yml 
kubectl get secrets
kubectl get nodes
kubectl get pods
kubectl get nodes
kubectl label node ip-10-0-0-50.us-west-1.compute.internal env=dev
kubectl label node ip-10-0-0-50.us-west-1.compute.internal env=qa
kubectl label node ip-10-0-0-6.us-west-1.compute.internal env=dev
kubectl describe node ip-10-0-0-6.us-west-1.compute.internal
kubectl describe node ip-10-0-0-50.us-west-1.compute.internal
ls
kubectl delete -f Configmap_pod.yml 
kubectl get pods
kubectl delete -f configmap.yml 
kubectl get pods
ls
kubectl delete -f pod_secrets.yml 
kubectl get pods
kubectl label node ip-10-0-0-6.us-west-1.compute.internal env=dev
vi deployment.yml 
ls
cat jenkinspod.yml 
vi deployment.yml 
cp deployment.yml Deployment.yml
vi Deployment.yml 
vi Deployment.yml 
kubectl label node ip-10-0-0-50.us-west-1.compute.internal
kubectl label node ip-10-0-0-50.us-west-1.compute.internal env-
kubectl label node ip-10-0-0-50.us-west-1.compute.internal env
kubectl label nodes ip-10-0-0-50.us-west-1.compute.internal environment-
kubectl label nodes ip-10-0-0-50.us-west-1.compute.internal env-
kubectl label node ip-10-0-0-50.us-west-1.compute.internal environment-
kubectl label node ip-10-0-0-50.us-west-1.compute.internaal env-
kubectl label nodes ip-10-0-0-50.us-west-1.compute.internaal env-
kubectl label node ip-10-0-0-50.us-west-1.compute.internaal env-
kubectl label node ip-10-0-0-50.us-west-1.compute.internaal env=qa
vi Deployment.yml 
kubectl apply -f Deployment.yml 
vi Deployment.yml 
apt update 
vi Deployment.yml 
kubectl apply -f Deployment.yml 
vi Deployment.yml 
kubectl apply -f Deployment.yml 
vi Deployment.yml 
kubectl apply -f Deployment.yml 
kubectl get pods
kubectl get nodes
ev
kubectl label node ip-10-0-0-6.us-west-1.compute.internal env=prod
kubectl label node --help
kubectl get pods
kubectl delete -f Deployment.yml 
kubectl get pods
kubectl label nodes  environment-
kubectl label node ip-10-0-0-6.us-west-1.compute.internal env=dev-
kubectl label node ip-10-0-0-6.us-west-1.compute.internal env=qa
kubectl apply -f Deployment.yml 
kubectl get pods
vi Deployment.yml 
kubectl delete -f Deployment.yml 
kubectl apply -f Deployment.yml 
kubectl get pods
kubectl get nodes
kubectl apply -f Deployment.yml 
kubectl get pods
kubectl exec -it my-deployment-6fff878688-269dx /bin/bash
vi Deployment.yml 
kubectl get pods -A
kubectl get pods kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.14"
kubectl get pods -A
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.14"
kubectl get pods
history 
kubectl get pods
kubectl get pods -A
kubectl describe pod tigera-operator-cffd8458f-zzf8b
kubectl describe pod tigera-operator
kubectl delete -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.14"
kubectl get pods -A
kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
kubectl get nodes
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.14"
kubectl get pods -A
kubectl get pods
kubectl get pods -A
vi pv.yml
kubectl apply -f pv.yml
kubectl get pv
vi pvc.yml
vi pv.yml
kubectl apply -f pv.yml
kubectl get pv
kubectl apply -f pvc.yml
kubectl get pvc
ls
cp Deployment.yml pvc_deploy.yml
vi pvc_deploy.yml 
kubectl get pods -A
LS
ls
kubectl get pvc
kubectl get pv
kubectl get pvc
kubectl get pods -A
kubectl get pod
kubectl get nodes
kubectl get pod
vi pvc_deploy.yml 
kubectl delete -f pvc_deploy.yml 
kubectl get pod
kubectl delete secrets secret-details
ls
vi pod_secrets.yml 
vi secrets_temp.yml 
kubectl get secrets
kubectl delete -f pod_secrets.yml 
kubectl delete -f pod_secrets.yml --force
kubectl get secrets
kubectl get pod
kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.ya
kubectl get pod
kubectl describe pod tigera-operator-cffd8458f-lq9m9 
kubectl describe pod tigera-operator
kubectl get pods --all namespaces
kubectl get pod --all-namespaces
kubectl get pods --all-namespaces
kubectl get pods --all-namespaces | grep evicted
kubectl get pods --all-namespaces | grep -i evicted
kubectl get pods --all-namespaces | grep -i evicted | awk '{print $2, "--namespaces", $1}'
kubectl get pods --all-namespaces | grep -i evicted | awk '{print $2, "--namespaces", $1}' | xargs kubectl delete pod
kubectl get pods --all-namespaces | grep -i evicted | awk '{print $2, "--namespaces", $1}' | xargs kubectl delete pod tigera-operator-cffd8458f-zwzm9 --namespaces tigera-operator
kubectl get pod
kubectl get pods -A
kubectl get nodes
kubectl get pv
kubectl get pvc
kubectl get pods -owide
kubectl get nodes -owide
kubectl get pods -owide
kubectl get pods 
kubectl get pods -A
kubectl get pods 
kubectl get pods -A
kubectl get nodes
ls
vi pv.yml 
kubectl delete pv pv.yml 
vi pv.yml 
kubectl apply -f pv.yml 
kubectl get pv
ls
vi pvc.yml 
kubectl apply -f pvc.yml 
kubectl get pvc
kubectl get pv
kubectl get pvc
vi pvc_deploy.yml 
kubectl get pods
kubectl apply -f pvc_deploy.yml
vi pvc_deploy.yml 
kubectl apply -f pvc_deploy.yml
vi pvc_deploy.yml 
kubectl apply -f pvc_deploy.yml
vi pvc_deploy.yml 
kubectl apply -f pvc_deploy.yml
kubectl get pods
kubectl get pods -owide
kubectl get nodes
kubectl get pods -owide
kubectl delete -f pvc_deploy.yml
kubectl apply -f pvc_deploy.yml
kubectl get pods -owide
kubectl delete -f pvc_deploy.yml
kubectl get pods -owide
kubectl apply -f pvc_deploy.yml
kubectl get pods -owide
kubectl delete -f pvc_deploy.yml
kubectl get pods -owide
kubectl get nodes
kubectl apply -f pvc_deploy.yml
kubectl get pods -owide
kubectl get pvc
kubectl get pv
kubectl get pods -owide
vi pvc_deploy.yml 
kubectl delete -f pvc_deploy.yml
kubectl get pods -owide
vi pvc_deploy.yml 
kubectl apply -f pvc_deploy.yml
kubectl get pods -owide
kubectl get pods
kubectl get pod
kubectl get pods
kubectl delete -f pvc_deploy.yml
vi storageclass.yml
kubectl apply -f storageclass.yml 
kubectl get sc
vi pvc.yml 
kubectl apply -f pvc.yml 
vi pvc.yml 
kubectl apply -f pvc.yml 
vi pvc.yml 
kubectl apply -f pvc.yml 
kubectl get pv
kubectl get pvc
kubectl apply -f pvc_deploy.yml 
kubectl get pvc
kubectl get pv
kubectl get pods
kubectl delete pods my-deployment-7f7667487-c6dxg my-deployment-7f7667487-2bfzx my-deployment-7f7667487-wvpkv
kubectl get pods
kubectl get pv
kubectl get pvc
kubectl delete -f pvc_deploy.yml 
kubectl get pv
kubectl get pvc
kubectl delete -f pvc_deploy.yml 
kubectl get pods
kubectl delete -f pvc_deploy.yml 
kubectl get pvc
kubectl delete -f pvc.yml 
kubectl get pvc
kubectl get pv
kubectl get pods
kubectl get svc
kubectl delete svc loadbalancer
kubectl delete svc nodeport
kubectl get svc
vi statefulset.yml
kubectl get sc
vi statefulset.yml
kubectl apply -f statefulset.yml 
kubectl get pods
kubectl get pvc
kubectl get pv
kubectl get svc
for i in 0 1; do kubectl exec "web-$i" -- sh -c 'hostname'; done
kubectl run -i --tty --image busybox:1.28 dns-test --restart=Never --rm
kubectl run -i --tty --image busybox:1.28 dns-test --restart=Never --rm
nslookup web-0.nginx
kubectl get pods
kubectl delete pod web-2
kubectl get pods
kubectl scale sts web --replica=5
kubectl scale sts web --replicas=5
kubectl get pods
kubectl stsweb-p '("spec:{replica":3)}'
kubectl sts web -p '("spec:{replica":3)}'
kubectl sts web -p '("spec:{replicas":3)}'
kubectl patch sts web -p '("spec:{replicas":3)}'
kubectl patch sts web -p '("spec":{"replicas":3)}'
kubectl patch sts web -p '{"spec":{"replicas":3}}'
kubectl get pods
kubectl delete -f statefulset.yml 
kubectl get pods
vi livneness.yml
kubectl apply -f livneness.yml 
kubectl get pods
kubectl get pv
kubectl get pvc
kubectl delete -f pvc.yml 
kubectl delete pvc --all
kubectl get pvc
kubectl get pv
kubectl get pvc
kubectl get pods
kubectl delete pods liveness-exec
kubectl get pods
kubectl delete pods liveness-exec --force
kubectl get pods
wget https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.6.4/deploy/static/provider/aws/nlb-with-tls-termination/deploy.yaml
ls
vi deploy.yaml 
kubectl apply -f deploy.yaml 
kubectl get pods
kubectl get svc
kubectl get pv
kubectl get pvc
kubectl get svc -A
kubectl describe svc ingress-nginx-controller -n ingress-nginx
kubectl get svc -A
kubectl describe svc ingress-nginx-controller -n ingress-nginx
kubectl delete -f deploy.yaml --force
kubectl get svc -A
kubectl get ns
kubectl get rs
kubectl get pods
kubectl get pv
kubectl get pvc
kubectl apply -f deploy.yaml --force
kubectl get svc -A
kubectl apply -f deploy.yaml 
kubectl delete -f deploy.yaml --force
kubectl get svc -A
kubectl apply -f deploy.yaml
vi deploy.yaml 
kubectl delete -f deploy.yaml
wget https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.6.4/deploy/static/provider/aws/nlb-with-tls-termination/deploy.yaml
rm deploy.yaml.1 
kubectl get pods
kubectl get nodes
rm deploy.yaml
wget https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.6.4/deploy/static/provider/aws/nlb-with-tls-termination/deploy.yaml
vi deploy.yaml 
kubectl apply -f deploy.yaml 
kubectl get all -n ingress-nginx
kubectl get ns
kubectl delete ns ingress-nginx
kubectl delete ns ingress-nginx --force
kubectl get ns
kubectl delete ns ingress-nginx --force
kubectl get all -n ingress-nginx
kubectl get ns
kubectl describe ns ingress-nginx
kubectl get pods
kubectl apply -f deploy.yaml 
kubectl get ns
kubectl delete ns ingress-nginx --force
history 
kubectl describe svc ingress-nginx-controller -n ingress-nginx
kubectl describe svc ingress-nginx -n ingress-nginx
kubectl delete -f deploy.yaml 
kubectl get ns
kubectl get all -n ingress-nginx
kubectl get ns
kubectl delete ns ingress-nginx --force
kubectl get ns
kubectl get all -n ingress-nginx
kubectl delete -f deploy.yaml 
kubectl apply -f deploy.yaml 
git init
git push https://github.com/viru1554/hello-world-war-new.git
git push https://github.com/viru1554/hello-world-war.git
git push https://github.com/viru1554/hello-world-war-new.git
git push --help
git push --all https://github.com/viru1554/hello-world-war-new.git
apt update 
git branch 
git status 
git add .
git status 
git commit -m "k8's manifest files"
git status 
git push --all https://github.com/viru1554/hello-world-war-new.git
git pull https://github.com/viru1554/hello-world-war-new.git
git branch 
git branch k8's


git branch 
git branch kubernetes
git branch 
git checkout kubernetes 
git branch 
git status 
git add .
git status 
git commit -m "chceking"
git status 
tree
git pull https://github.com/viru1554/hello-world-war-new.git

git pull https://github.com/viru1554/hello-world-war-new.git
ls
kubectl get nodes
kubectl get ns
ls
vi deployment.yml 
kubectl apply -f deployment.yml 
kubectl delete -f deployment.yml 
kubectl apply -f deployment.yml 
kubectl get pods
kubectl get svc
kubectl get ns
kubectl get ing
kubectl get pods
kubectl get pods -A
cat clusterip.yml 
kubectl get pods
kubectl get ing
kubectl get ns
kubectl get svc
kubectl get pv
kubectl get pvc
kubectl get ns
kubectl delete ns ingress-nginx --force
kubectl get ns
kubectl get ns ingress-nginx 
kubectl delete ns ingress-nginx --force
kubectl get ns
kubectl delete ns ingress-nginx --force
kubectl get nodes
kubectl get ns
kubectl get pods
kubectl get pv
kubectl delete -f pv.yml 
kubectl get pv
kubectl get pvc
kubectl get pods
kubectl get ns
kubectl get pv
kubectl get ns
kubectl get pods
kubectl get ns
kubectl describe ns ingress-nginx
history 
kubectl get ns
kubectl describe svc ingress-nginx -n ingress-nginx
kubectl describe ns ingress-nginx -n ingress-nginx
kubectl get ns
vi old_deploy.yml 
kubectl apply -f old_deploy.yml 
kubectl get ns
kubectl delete -f old_deploy.yml 
kubectl get ns
kubectl delete ns ingress-nginx --force
kubectl get ns
kubectl delete ns ingress-nginx --force
kubectl delete ns ingress-nginx -n ingress-nginx
kubectl get ns
kubectl get svc
kubectl get svc -A
kubectl get ns
kubectl edit ns ingress-nginx
kubectl get ns
kubectl delete ns ingress-nginx --force
kubectl get all -n ingress-nginx
kubectl get ns
kubectl delete -f deploy.yaml 
kubectl get ns
kubectl describe ns ingress-nginx
kubectl get ns
kubectl api-resources --verbs=list --namespaced -o name   | xargs -n 1 kubectl get --show-kind --ignore-not-found -n ingress-nginx
kubectl get namespace ingress-nginx -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/stucked-namespace/finalize -f -
kubectl get namespace ingress-nginx -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/ingress-nginx/finalize -f -
kubectl get ns
kubectl get pods -A
kubectl get pods --all-namespaces
kubectl get pods --all-namespaces | grep Evicted
kubectl delete pod calico-apiserver calico-apiserver-75496dd59d-4r754 --namespace=calico-apiserver
kubectl delete pods --all --namespace=calico-apiserver --field-selector=status.phase=Failed
kubectl get pods --all-namespaces | grep Evicted
kubectl get ns
kubectl get pods
kubectl apply -f old_deploy.yml 
kubectl get all -n ingress-nginx
kubectl get pods -owide
kubectl get pod -owide
kubectl get pods -A
kubectl delete ns tigera-operator
kubectl delete ns tigera-operatorls
ls
kubectl get ns
kubectl apply -f old_deploy.yml 
kubectl get all -n ingress-nginx
kubectl get pods -A
kubectl get svc -A
kubectl describe svc ingress-nginx -n ingress-nginx-controller
kubectl describe svc ingress-nginx-controller -n ingress-nginx
kubectl delete -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
kubectl get nodes
kubectl get pods
kubectl get pods -A
kubectl delete pod tigera-operator-cffd8458f-zzz5x
kubectl delete pod tigera-operator
kubectl delete ns tigera-operator --all
kubectl delete --help
kubectl get namespace tigera-operator -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/tigera-operator/finalize -f -
kubectl api-resources --verbs=list --namespaced -o name   | xargs -n 1 kubectl get --show-kind --ignore-not-found -n tigera-operator
kubectl get namespace tigera-operator-cffd8458f-zvc4w -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/tigera-operator-cffd8458f-zvc4w/finalize -f -
kubectl get namespace tigera-operator  -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/tigera-operator/finalize -f -
kubectl delete ns tigera-operator --all
kubectl get pods -A
kubectl get pod -n calico-apiserver | grep Evicted | awk '{print $1}' | xargs kubectl delete pod -n calico-apiserver
kubectl get pods -A
kubectl get pod -n calico-apiserver | grep Error | awk '{print $1}' | xargs kubectl delete pod -n calico-apiserver
kubectl get pods -A
kubectl get pod -n calico-apiserver | grep ContainerStatusUnknown | awk '{print $1}' | xargs kubectl delete pod -n calico-apiserver
kubectl get pods -A
kubectl get pod -n calico-apiserver | grep CrashLoopBackOff | awk '{print $1}' | xargs kubectl delete pod -n calico-apiserver
kubectl get pod -n calico-system | grep CrashLoopBackOff | awk '{print $1}' | xargs kubectl delete pod -n calico-system
kubectl get svc -A
kubectl describe svc ingress-nginx-controller -n ingress-nginx
kubectl get pods -A
kubectl get pod -n calico-system | grep CrashLoopBackOff | awk '{print $1}' | xargs kubectl delete pod -n calico-system
kubectl get pods -A
kubectl get pod -n calico-system | grep CrashLoopBackOff | awk '{print $1}' | xargs kubectl delete pod -n calico-system
kubectl get pods -A
kubectl get svc -A
kubectl describe svc ingress-nginx-controller -n ingress-nginx
kubectl get svc -A
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
helm --version
helm version
helm create jenkins
ls
cd jenkins/
ls
kubectl get svc
kubectl get svc -a
kubectl get svc -A
kubectl logs ingress-nginx-controller
kubectl logs ingress-nginx
kubectl get pods -A
kubectl get ing
kubectl get svc -A
kubectl get ns
kubectl describe svc ingress-nginx-controller
kubectl describe svc ingress-nginx
kubectl describe svc ingress-nginx-controllr ingress-nginx
kubectl describe svc ingress-nginx-controller -n apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Values.name_deploy }}
  labels:
    app: {{ .Values.labels }}
spec:
  replicas: {{ .Values.replicas }}
  selector:
    matchLabels:
      app: {{ .Values.labels }}
  template:
    metadata:
      labels:
        app: {{ .Values.labels }}
    spec:
      containers:
        - image: {{ .Values.dockerrepname }}/{{ .Values.dockerimage }}:{{ .Values.tag }}
          name: {{ .Values.img_name }}
          env:
          - name: JENKINS_OPTS
            value: --prefix=/jenkins
---
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.serv_name }}
spec:
  type: ClusterIP
  ports:
    - name: http
      protocol: TCP
      port: {{ .Values.port }}
      targetPort: {{ .Values.tar_port }}
  selector:
    app: {{ .Values.labels }}
kubectl get svc -A
kubectl describe svc ingress-nginx-controller -n ingress-nginx
kubectl get svc -A
history 
helm version 
ls
cd jenkins/
ls
lscd ..
cd ..
cd jenkin
ls
rm -rf jenkni
ls
cd ..
rm -rf jenkin
ls
helm version
helm create -p jenkins
helm version
helm create jenkins
helm version
helm create jenkin
cd jenkin
ls
cd charts/
ls
cd ..
vi Chart.yaml 
cd templates/
ls
cd ..
vi values.yaml 
ls
rm -rf charts/
ls
cd templates/
ls
rm -rf *
ls
cd ..
ls
kubectl get pods -A
kubectl delete ns calico-system
kubectl get pod -n calico-system | grep CrashLoopBackOff | awk '{print $1}' | xargs kubectl delete pod -n calico-system
kubectl get pod -n calico-kube-controllers-6c95665469-l8gk | grep CrashLoopBackOff | awk '{print $1}' | xargs kubectl delete pod -n calico-kube-controllers-6c95665469-l8gkn
history 
kubectl get pods -A
kubectl get svc -A
kubectl describe svc ingress-nginx-controller -n ingress-nginx
ls
cd jenkins/
ls
cd ..
cd jenkin
ls
cd 
rm -rf jenkins
ls
cd jenkin/
ls
kubectl get svc -A
kubectl get ng
history 
kubectl delete -f old_deploy.yml 
kubectl get ns
apt update 
kubectl get ns
kubectl get pods -A
kubectl get ns
kubectl delete ns calico-system --force
kubectl get ns
kubectl get namespace ingress-nginx -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/ingress-nginx/finalize -f -
kubectl get ns
kubectl get namespace calico-system -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/calico-system/finalize -f -
kubectl get ns
kubectl get pods
kubectl get pods -A
kubectl get svc
kubectl get svc -A
kubectl apply -f old_deploy.yml 
kubectl get svc -A
kubectl get all -n ingress-nginx
kubectl get ns
kubectl describe svc ingress-nginx-controller -n ingress-nginx
kubectl get all -n ingress-nginx
kubectl delete -f old_deploy.yml 
kubectl get ns
kubectl get pods -A
kubectl get svc -A
kubectl get all -n ingress-nginx
kubectl get ns
kubectl get namespace ingress-nginx -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/ingress-nginx/finalize -f -
kubectl get ns
kubectl apply -f old_deploy.yml
kubectl get ns
kubectl get all -n ingress-nginx
kubectl get pods -A
kubectl describe svc ingress-nginx-controller -n ingress-nginx
ls
vi deployment.yml 
cp deployment.yml jenkins/templates
mv jenkin jenkins
cp deployment.yml jenkins/templates
cp old_deploy.yml jenkins/templates
cp deploy.yml jenkins/templates
mv deploy.yaml deploy.yml 
cp deploy.yml jenkins/templates
ls
cd jenkins/
ls
cd templates/
ls
kubectl get pods
kubectl get ing
kubectl get pods
cd ..
helm install myjen
helm install myjen .
helm install myjenkin .
kubectl get nodes
kubectl cluster-info
kubectl cluster-info dump
ls
cd templates/
ls
cat old_deploy.yml 
vi old_deploy.yml 
[A
vi old_deploy.yml 
cd ..
helm install myjenkins .
helm ls
helm version
kubectl get pods -A
kubectl get all -n ingress-nginx
kubectl delete -f old_deploy.yml 
kubectl get all -n ingress-nginx
kubectl get ns
history 
kubectl get namespace ingress-nginx -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/ingress-nginx/finalize -f -
kubectl get ns
kubectl get all -n ingress-nginx
ls
kubectl apply -f old_deploy.yml 
kubectl get ns
kubectl get all -n ingress-nginx
kubectl  describe svc ingress-nginx-controller -n ingress-nginx-controller
kubectl  describe svc ingress-nginx-controller -n ingress-nginx'
kubectl  describe svc ingress-nginx-controller -n ingress-nginx
kubectl get ns
cd jenkins/
ls
cd templates/
ls
cd ..
helm install myjenkins .
helm uninstall myjenkins .
helm uninstall myjenkins
helm ls
ls
cd jenkins/
ls
cd templates/
ls
kubectl get pods
kubectl get ing
ls
cat deploy.yml 
cat deployment.yml 
kubectl get pods -A
kubectl get svc -A
kubectl delete -f old_deploy.yml 
kubectl get pods
kubectl get svc -A
kubectl get pods -A
kubectl delete -f deployment.yml 
kubectl delete -f deploy.yml 
kubectl get ns
kubectl get namespace ingress-nginx -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/ingress-nginx/finalize -f -
kubectl get ns
kubectl get nodes
kubectl get ns
kubectl apply -f old_deploy.yml 
kubectl get ns
kubectl get all -n ingress-nginx
kubectl get svc -A
kubectl describe svc ingress-nginx-controller -n ingress-nginx
ls
cd jenkins/
cat Chart.yaml 
ls
helm install myjen .
cd templates/
vi old_deploy.yml 
vi deployment.yml 
helm install myjen .
cd ..
helm install myjen .
cd templates/
vi deployment.yml 
cd ..
helm install myjen .
ls 
cd templates/
ls
cd ..
helm install myjen .
cd jenkins/
ls
helm install myjen .
helm uninstall myjen .
rm -rf myjen .
helm delete myjen
rm -rf myjen 
ls
cat templates/ls
ls templates/
helm install myjen .
cd g:
cd G:
cd jenkins/
helm install jenkin .
ls
cd jenkins/
ls
ls templates/
helm install jenkins .
kubectl get nodes
kubectl get pos
kubectl get pods
kubectl get ing
kubectl get ns
kubectl get all -n ingress-nginx
c 
cd 
kubectl describe svc ingress-nginx-controller -n ingress-nginx
kubectl delete -f old_deploy.yml 
cd jenkins/
helm install jenkin .
cd jenkins/
helm install trial-jenkin .
cd jenkins/
helm install trial-jenkin .
kubectl get ns
kubectl get namespace ingress-nginx -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/ingress-nginx/finalize -f -
kubectl get ns
kubectl get svc
kubectl delete -f loadbalancer.yml 
kubectl get svc -A
kubectl get ns
kubectl get namespace ingress-nginx -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/ingress-nginx/finalize -f -
kubectl get ns
kubectl delete -f old_deploy.yml 
kubectl get ns
kubectl get namespace ingress-nginx -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/ingress-nginx/finalize -f -
kubectl get ns
history 
cd jenkins/
ls
helm install jenkins .
ls
vi deploy
vi deploy.yml 
vi deployment.yml 
ls
cat deployment.yml 
cd jenkins/
cd templates/
cat deployment.yml 
cd 
ls
cat old_deploy.yml 
vi old_deploy.yml 
cat old_deploy.yml 
ls
cat old_deploy.yml 
ls
kubectl get pods -A
kubectl get svc -A
kubectl get ns
kubectl delete ns ingress-nginx --force
kubectl get ns
kubectl get pods -A
kubectl get nodes
kubectl get pods
kubectl get pods -n ingress-nginx
kubectl get all -n ingress-nginx
kubectl get ns
kubectl get namespace ingress-nginx -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/ingress-nginx/finalize -f -
kubectl get ns
ls
kubectl apply -f deploy.yml 
kubectl get all -n ingress-nginx
kubectl get svc -A
kubectl describe svc ingress-nginx-controller -n ingress-nginx
kubectl get svc -A
kubectl delete -f deploy.yml 

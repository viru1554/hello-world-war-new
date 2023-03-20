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

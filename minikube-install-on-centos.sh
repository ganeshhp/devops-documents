## Kubectl installation ##
echo "download kubectl"

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "change mode and move"

chmod +x ./kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl

## Docker-CE installation ##

echo "install yum utils"
sudo yum install -y yum-utils

echo "update Docker-repo"
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
echo "install docker-ce"
sudo yum install docker-ce-18.06.3.ce-3.el7 docker-ce-cli-18.06.3.ce-3.el7 containerd.io docker-compose-plugin

echo "start docker engine"
sudo systemctl start docker
sudo systemctl enable docker

## Install dependencies ##

echo "swapoff"
swapoff -a

echo "install curl and conntrack"
sudo yum install curl conntrack -y

#echo "start and enable kubelet"
#sudo yum install -y kubelet
#sudo systemctl enable kubelet && sudo systemctl start kubelet

## Download and Install Minikube ##

echo "download minikube"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube


#echo "minikube version"
#sudo minikube version

echo "start minikube cluster"
#sudo minikube start --vm-driver=none --extra-config=kubelet.cgroup-driver=systemd
sudo minikube start --vm-driver=none

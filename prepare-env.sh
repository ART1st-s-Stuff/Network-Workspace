function install_kernel() {
    dpkg -i kernel/*.deb
    #tar xvf *.tar -C /
}

function install_docker_k8s() {
    # Install docker
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh ./get-docker.sh
    # Install k8s
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl gpg
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
    apt-get update
    apt-get install -y kubelet kubeadm kubectl
    apt-mark hold kubelet kubeadm kubectl
    systemctl enable --now kubelet
}

apt-get install git-lfs -y

install_kernel

install_docker_k8s

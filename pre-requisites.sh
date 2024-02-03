#!/bin/bash

# Mudar o hostname
echo "Digite o novo hostname para este host:"
read new_hostname
sudo hostnamectl set-hostname "$new_hostname"
echo -e "\nHostname alterado para $new_hostname.\n"

# Solicitar ao usuário que digite o e-mail para a chave SSH
echo "Digite o e-mail para a chave SSH 'github':"
read ssh_email

# Criar chave SSH
echo -e "\nCriando chave SSH chamada 'github'...\n"
ssh-keygen -t rsa -b 4096 -C "$ssh_email" -f ~/.ssh/github -N ""
echo -e "\nChave SSH 'github' criada.\n"


# Exibir a chave pública SSH
echo -e "Chave pública SSH 'github':\n"
cat ~/.ssh/github.pub
echo -e "\nCopie a chave pública acima para usar onde precisar.\n"

# Instalar o kind
echo -e "Instalando o Kind...\n"
if [ $(uname -m) = x86_64 ]; then
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.21.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
fi
echo -e "\nKind instalado.\n"

# Instalar o Docker
echo -e "Instalando o Docker...\n"
curl -fsSL https://get.docker.com | bash
echo -e "\nDocker instalado.\n"

# Instalar o kubectl
echo -e "Instalando o kubectl...\n"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256) kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
echo -e "\nkubectl instalado.\n"
kubectl version --client
kubectl version --client --output=yaml

# Configurar kubectl alias e autocompletar
echo -e "Configurando kubectl alias e autocompletar...\n"
echo 'source <(kubectl completion bash)' >>~/.bashrc
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -o default -F __start_kubectl k' >>~/.bashrc
source ~/.bashrc
echo -e "\nConfiguração do kubectl concluída.\n"

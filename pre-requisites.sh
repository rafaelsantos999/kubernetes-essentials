#!/bin/bash

# Solicitar o novo hostname do usuário
echo "Digite o novo hostname para este host:"
read new_hostname

# Mudar o hostname permanentemente
echo -e "\nMudando o hostname...\n"
sudo sh -c "echo $new_hostname > /etc/hostname"

# Encontrar o endereço IP local principal
ip_address=$(hostname -I | awk '{print $1}')
echo "Endereço IP local encontrado: $ip_address"

# Atualizar /etc/hosts com o novo hostname e o endereço IP local
echo -e "\nAtualizando /etc/hosts com o novo hostname e o endereço IP local...\n"
sudo sed -i "s/127\.0\.1\.1.*/127.0.1.1\t$new_hostname/g" /etc/hosts
echo -e "$ip_address\t$new_hostname" | sudo tee -a /etc/hosts > /dev/null

# Solicitar ao usuário que digite o e-mail para a chave SSH
echo "Digite o e-mail para a chave SSH 'github':"
read ssh_email

# Obter data e hora no formato brasileiro e HH:MM
data_hora=$(date +"%d-%m-%Y-%H:%M")

# Criar chave SSH com o nome baseado na data e hora atuais
echo -e "\nCriando chave SSH com o nome 'github-$data_hora'...\n"
ssh-keygen -t rsa -b 4096 -C "$ssh_email" -f ~/.ssh/github-"$data_hora" -N ""
echo -e "\nChave SSH 'github-$data_hora' criada.\n"

# Exibir a chave pública SSH
echo -e "Chave pública SSH 'github-$data_hora':\n"
cat ~/.ssh/github-"$data_hora".pub
echo -e "\nCopie a chave pública acima para usar onde precisar.\n"

# Contador regressivo de 10 segundos para que o usuário possa copiar a chave
echo -n "Você tem 30 segundos para copiar a chave: "
for i in $(seq 30 -1 1); do
    echo -ne "\r$i segundos restantes... "
    sleep 1
done
echo -e "\rContinuando...\n"

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

# No final do script, antes de reiniciar
echo "O sistema precisa ser reiniciado para aplicar todas as mudanças. Deseja reiniciar agora? (y/n)"
read reboot_choice
if [ "$reboot_choice" = "y" ]; then
    echo -e "\nReiniciando o sistema...\n"
    sudo reboot
else
    echo -e "\nCertifique-se de reiniciar o sistema mais tarde para aplicar todas as mudanças.\n"
fi

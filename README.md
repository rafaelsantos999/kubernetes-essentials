# Kubernetes Essentials

Este documento visa esclarecer os conceitos fundamentais associados ao mundo dos containers, com foco especial no Kubernetes, uma plataforma de código aberto para automação de implantação, escalonamento e gerenciamento de aplicações em containers.

## O que é um Container?

Um Container é uma unidade padrão de software que empacota o código e todas as suas dependências para que a aplicação seja executada de forma rápida e confiável em diferentes ambientes de computação. Os containers virtualizam o sistema operacional, permitindo que múltiplos workloads sejam executados isoladamente no mesmo hardware.

## O que é um Container Engine?

Um Container Engine é um software que provê um ambiente de runtime para containers, facilitando a criação e gerenciamento destes. Ele permite aos usuários construir e empacotar aplicações em containers, executá-los e gerenciá-los. Docker é um exemplo popular de Container Engine.

## O que é um Container Runtime?

O Container Runtime é a parte do software responsável por executar os containers. Ele cuida da execução de imagens de container, mantendo os containers em execução, e gerenciando o ciclo de vida destes. O Containerd e o CRI-O são exemplos de Container Runtimes.

## O que é o Docker?

Docker é uma plataforma de containers que permite desenvolver, enviar e executar aplicações dentro de containers. Simplificando o processo de execução de aplicações em diferentes ambientes através do uso de Dockerfiles e imagens de containers.

## O que é a OCI?

A Open Container Initiative (OCI) é uma organização que promove padrões abertos para container formats e runtimes. Seu objetivo é garantir que os containers sejam portáveis entre diferentes sistemas e plataformas.

## O que é Kubernetes?

Kubernetes, também conhecido como K8s, é uma plataforma de código aberto para automação de implantação, escalonamento e operações de aplicações em containers. Ele agrupa containers que compõem uma aplicação em unidades lógicas para fácil gerenciamento e descoberta de serviço.

## Kubernetes: Workers e Control Plane

### Workers
Os Workers, ou nós de trabalho, são as máquinas onde os containers são executados. Eles hospedam os Pods, que são as menores unidades implantáveis gerenciadas pelo Kubernetes.

### Control Plane
O Control Plane do Kubernetes gerencia os Workers e os Pods neles. Ele toma decisões globais sobre o cluster (como agendamento) e detecta e responde a eventos do cluster (como a falha de um Worker).

## Componentes do Control Plane do Kubernetes

1. **kube-apiserver**: O servidor API atua como a porta de entrada para o control plane do Kubernetes.
2. **etcd**: Um armazenamento consistente e de alta disponibilidade usado como repositório de backup do Kubernetes.
3. **kube-scheduler**: Responsável por agendar os pods nos nós.
4. **kube-controller-manager**: Executa os processos de controle do Kubernetes.
5. **cloud-controller-manager**: Integra o cluster com APIs de provedores de nuvem.

## Componentes dos Workers do Kubernetes

1. **kubelet**: Um agente que executa em cada nó no cluster. Garante que os containers estão rodando em um Pod.
2. **kube-proxy**: Mantém as regras de rede nos nós, permitindo a comunicação dentro ou fora do cluster.
3. **Container Runtime**: O software responsável por executar os containers.

## Portas TCP e UDP dos Componentes do Kubernetes

- **kube-apiserver**: Geralmente exposto na porta TCP 6443.
- **etcd**: Normalmente utiliza a porta TCP 2379 para comunicações do cliente e a porta TCP 2380 para comunicação do server-to-server.
- **kube-scheduler**: Não expõe uma porta TCP/UDP por padrão, se comunica via kube-apiserver.
- **kube-controller-manager**: Também se comunica via kube-apiserver, sem portas TCP/UDP expostas diretamente.
- **kubelet**: Comunica-se na porta TCP 10250.
- **kube-proxy**: Usa várias portas TCP/UDP, que são dinâmicas e configuráveis.

## Kubernetes: Pods, ReplicaSets, Deployments, e Services

- **Pods**: A menor unidade de implantação que você pode criar e gerenciar no Kubernetes. Cada Pod encapsula um ou mais containers.
- **ReplicaSets**: Garante que um número específico de réplicas de um Pod estejam rodando a qualquer momento.
- **

Deployments**: Fornece atualizações declarativas para Pods e ReplicaSets, facilitando a atualização e o rollback de aplicações.
- **Services**: Uma abstração que define um conjunto lógico de Pods e uma política para acessá-los, geralmente através de um IP fixo ou DNS name.

## O que é o Kind?

Kind (Kubernetes IN Docker) é uma ferramenta para rodar clusters Kubernetes localmente dentro de containers Docker. É útil para testes e desenvolvimento local com Kubernetes.

## Criando o Primeiro Cluster com Kind

1. Instale o Docker no seu sistema.
2. Baixe e instale o Kind.
3. Crie um arquivo de configuração para seu cluster, se necessário.
4. Execute o comando `kind create cluster` para criar um cluster padrão.
5. Utilize o `kubectl` para interagir com seu cluster.

## Instalando o kubectl

O `kubectl` é a ferramenta de linha de comando para interagir com clusters Kubernetes. Para instalá-lo:

1. Baixe a versão mais recente do `kubectl`.
2. Torne o binário executável.
3. Mova o binário para um diretório em seu PATH.

---

Referências da Documentação Oficial:

- [Docker](https://docs.docker.com/)
- [Open Container Initiative](https://opencontainers.org/)
- [Kubernetes](https://kubernetes.io/docs/home/)
- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/)

# Kubernetes

Kubernetes é uma plataforma de código aberto utilizada para automatizar a implantação, o escalonamento e a operação de aplicações em contêineres. Facilita a gestão de aplicações em larga escala, permitindo a automação de diversas tarefas.

## Arquitetura do Kubernetes

A arquitetura do Kubernetes é dividida em duas partes principais: o plano de controle e os nós (ou workers).

### Plano de Controle (Control Plane) 

O Control Plane é responsável por gerenciar o estado global do cluster Kubernetes, incluindo agendamento e comunicação entre os componentes do cluster.

- **API Server (Servidor de API):** Ponto central de comunicação do plano de controle, expõe a API do Kubernetes.
- **etcd:** Armazenamento de chave-valor distribuído que guarda as informações de configuração do cluster.
- **Scheduler (Agendador):** Responsável por decidir em qual nó os contêineres devem ser executados.
- **Controller Manager (Gerenciador de Controladores):** Executa processos de background que mantêm o estado desejado do cluster.
- **Cloud Controller Manager:** Integra o cluster com APIs de provedores de nuvem, permitindo interações com componentes de infraestrutura de nuvem.

### Nós (Workers)

Os workers são as máquinas que executam os contêineres e os pods, incluindo os componentes necessários para essa execução.

- **Kubelet:** Agente que garante que os contêineres estão rodando em um Pod.
- **Kube-Proxy:** Gerencia as regras de rede nos nós, permitindo a comunicação para dentro e fora dos contêineres.
- **Container Runtime:** Ambiente de execução responsável por executar os contêineres.

### Container Engine (Motor de Contêiner)

O Container Engine é um componente chave para a execução de contêineres, fornecendo o ambiente necessário para construir, executar e gerenciar os contêineres.

- **Compatível com diversos runtimes:** Kubernetes suporta runtimes de contêineres como Docker, containerd, CRI-O, entre outros, através da Interface de Runtime de Contêiner (CRI).

Cada componente do Kubernetes desempenha um papel específico, trabalhando juntos para criar uma plataforma robusta para a gestão automatizada de aplicações em contêineres.


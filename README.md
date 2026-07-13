# 🚀 MERN Stack DevOps Infrastructure

<p align="center">

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform\&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?logo=docker\&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?logo=kubernetes\&logoColor=white)
![Minikube](https://img.shields.io/badge/Minikube-Local%20Cluster-2C3E50?logo=kubernetes)
![Kustomize](https://img.shields.io/badge/Kustomize-Kubernetes%20Management-326CE5)

</p>

---

## 📌 Overview

This repository contains infrastructure and deployment configurations for a **MERN Stack application** built using modern DevOps and cloud-native practices.

The project demonstrates a complete local Kubernetes deployment workflow with Infrastructure as Code, container orchestration, and secure configuration management.

### Key objectives:

* 🏗️ Infrastructure as Code using **Terraform**
* 🧩 Modular infrastructure architecture
* 📦 Containerized application delivery using **Docker**
* ☸️ Kubernetes orchestration and workload management
* 💾 Stateful database deployment
* 🌐 Kubernetes networking and Ingress configuration
* 🔐 Secure secrets management using **Kustomize overlays**
* 🔄 Reproducible local development environment

The infrastructure follows production-oriented DevOps principles:

> **Declarative configuration · Automation · Modularity · Environment isolation**

---

# 🏗️ Architecture

The application is deployed using a classic **3-tier architecture**:

```text
                         User
                           |
                           |
                    ┌─────────────┐
                    │   Ingress   │
                    └──────┬──────┘
                           |
                           ▼
                    ┌─────────────┐
                    │  Frontend   │
                    │    Nginx    │
                    └──────┬──────┘
                           |
                           ▼
                    ┌─────────────┐
                    │  Backend    │
                    │ Node.js API │
                    └──────┬──────┘
                           |
                           ▼
                    ┌─────────────┐
                    │  MongoDB    │
                    │ StatefulSet │
                    └─────────────┘
```

---

# 🧰 Technology Stack

| Technology | Role                                |
| ---------- | ----------------------------------- |
| Terraform  | Infrastructure provisioning         |
| Docker     | Container runtime                   |
| Kubernetes | Container orchestration             |
| Minikube   | Local Kubernetes cluster            |
| Kustomize  | Kubernetes configuration management |
| Nginx      | Frontend web server                 |
| Node.js    | Backend API                         |
| MongoDB    | Persistent database                 |

---

# 📂 Repository Structure

```bash
.
├── k8s/
│   ├── base/
│   │   ├── backend.yaml
│   │   ├── frontend.yaml
│   │   ├── mongo.yaml
│   │   ├── ingress.yaml
│   │   └── kustomization.yaml
│   │
│   └── overlays/
│       └── local/
│           ├── .env
│           └── kustomization.yaml
│
└── terraform/
    ├── environments/
    │   └── local/
    │
    └── modules/
        ├── frontend/
        ├── backend/
        └── database/
```

---

# 🔐 Secrets Management

Sensitive information is **never stored inside Git**.

Secrets are injected locally during deployment using environment-specific configuration.

| Component  | Secret Source   |
| ---------- | --------------- |
| Terraform  | `secret.tfvars` |
| Kubernetes | `.env`          |

---

## Terraform Secrets

Create local variables:

```bash
cd terraform/environments/local

touch secret.tfvars
```

Example:

```hcl
db_password = "YourSuperSecretPassword123"
```

---

## Kubernetes Secrets

Create local environment configuration:

```bash
cd ../../../k8s/overlays/local

touch .env
```

Example:

```env
db-password=YourSuperSecretPassword123

mongo-url=mongodb://admin:YourSuperSecretPassword123@mongodb:27017
```

> ⚠️ These files are local-only and excluded from version control.

---

# ⚙️ Infrastructure Deployment

## Requirements

Install:

* Docker
* Terraform CLI
* kubectl
* Minikube

Verify installation:

```bash
docker --version
terraform --version
kubectl version --client
minikube version
```

---

# 🚀 Deployment Process

## 1. Provision Infrastructure with Terraform

Initialize Terraform:

```bash
cd terraform/environments/local

terraform init
```

Deploy infrastructure:

```bash
terraform apply \
-var-file="secret.tfvars"
```

Terraform provisions:

* Docker resources
* Networks
* Persistent volumes
* Required infrastructure dependencies

---

## 2. Start Kubernetes Cluster

Start Minikube:

```bash
minikube start --driver=docker
```

Enable Ingress controller:

```bash
minikube addons enable ingress
```

---

## 3. Deploy Kubernetes Resources

Deploy application stack:

```bash
kubectl apply -k k8s/overlays/local
```

Kustomize manages:

* Deployments
* StatefulSets
* Services
* Ingress
* Secrets

---

# 🔎 Validation

Check workloads:

```bash
kubectl get pods
```

Check services, ingress and secrets:

```bash
kubectl get svc,ingress,secrets
```

---

# 🌐 Local Application Access

Get Minikube IP:

```bash
minikube ip
```

Configure local DNS mapping.

### Linux / WSL

```bash
sudo nano /etc/hosts
```

### Windows

Open as Administrator:

```text
C:\Windows\System32\drivers\etc\hosts
```

Add:

```text
<MINIKUBE_IP> mern-app.local
```

Open application:

```text
http://mern-app.local
```

---

# 🔄 Deployment Workflow

```mermaid
flowchart LR

A[Source Code] --> B[Terraform]

B --> C[Docker Environment]

C --> D[Minikube Cluster]

D --> E[Kustomize]

E --> F[Kubernetes Resources]

F --> G[Frontend]

F --> H[Backend API]

F --> I[MongoDB StatefulSet]
```

---

# 🧹 Cleanup

## Remove Kubernetes resources

```bash
kubectl delete -k k8s/overlays/local

minikube stop
```

---

## Destroy Terraform infrastructure

```bash
cd terraform/environments/local

terraform destroy \
-var-file="secret.tfvars"
```

---

# ✅ DevOps Concepts Demonstrated

* [x] Infrastructure as Code (Terraform)
* [x] Modular Terraform architecture
* [x] Containerized application delivery
* [x] Kubernetes workload management
* [x] Stateful services
* [x] Declarative configuration
* [x] Kubernetes networking & Ingress
* [x] Secure secret management
* [x] Environment-specific overlays with Kustomize

---

# 🔜 Future Improvements

Planned improvements:

* [ ] GitHub Actions CI/CD pipeline
* [ ] Automated Terraform validation
* [ ] Container image build automation
* [ ] Deployment automation
* [ ] Monitoring and observability stack

---

# 📌 Project Status

| Component                | Status        |
| ------------------------ | ------------- |
| Terraform Infrastructure | ✅ Implemented |
| Docker Environment       | ✅ Implemented |
| Kubernetes Deployment    | ✅ Implemented |
| Kustomize Configuration  | ✅ Implemented |
| Secrets Management       | ✅ Implemented |
| CI/CD Pipeline           | 🚧 Planned    |

---

# 👨‍💻 About

DevOps portfolio project demonstrating modern infrastructure automation, Kubernetes deployment practices, and cloud-native engineering principles.

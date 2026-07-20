# 🚀 MERN Stack DevOps Infrastructure

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Containers-2496ED?logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?logo=kubernetes&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI/CD-2088FF?logo=githubactions&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

Infrastructure and deployment configuration for a **MERN Stack** application built with modern **DevOps**, **Infrastructure as Code**, and **Cloud-Native** practices.

The project demonstrates a complete local Kubernetes deployment workflow, including infrastructure provisioning, container orchestration, secrets management, and CI/CD automation.

---

# 📑 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Technology Stack](#-technology-stack)
- [Repository Structure](#-repository-structure)
- [CI/CD Pipeline](#-cicd-pipeline)
- [Secrets Management](#-secrets-management)
- [Deployment Guide](#-deployment-guide)
- [Validation](#-validation)
- [Local Access](#-local-access)
- [Deployment Workflow](#-deployment-workflow)
- [Cleanup](#-cleanup)
- [DevOps Concepts](#-devops-concepts-demonstrated)
- [Future Improvements](#-future-improvements)
- [Project Status](#-project-status)

---

# 📌 Overview

This repository demonstrates a production-oriented DevOps workflow for deploying a MERN Stack application locally on Kubernetes.

## Key Features

- 🏗 Infrastructure as Code using Terraform
- 📦 Docker containerization
- ☸ Kubernetes orchestration
- 💾 MongoDB StatefulSet deployment
- 🌐 Kubernetes Ingress networking
- 🔐 Secure secret management with Kustomize
- 🔄 Reproducible local development environment
- 🤖 GitHub Actions CI/CD pipeline
- 🧩 Modular infrastructure architecture

### DevOps Principles

- Declarative Infrastructure
- Automation
- Modularity
- Environment Isolation
- Reproducibility

---

# 🏗 Architecture

```text
                     User
                       │
                       ▼
               ┌─────────────────┐
               │ Kubernetes       │
               │ Ingress          │
               └────────┬─────────┘
                        │
                        ▼
               ┌─────────────────┐
               │ Frontend        │
               │ Nginx           │
               └────────┬─────────┘
                        │
                        ▼
               ┌─────────────────┐
               │ Backend API     │
               │ Node.js         │
               └────────┬─────────┘
                        │
                        ▼
               ┌─────────────────┐
               │ MongoDB         │
               │ StatefulSet     │
               └─────────────────┘
```

---

# 🧰 Technology Stack

| Technology | Purpose |
|------------|---------|
| Terraform | Infrastructure as Code |
| Docker | Containerization |
| Kubernetes | Container Orchestration |
| Minikube | Local Kubernetes Cluster |
| Kustomize | Kubernetes Configuration Management |
| GitHub Actions | CI/CD |
| Docker Hub | Container Registry |
| Node.js | Backend API |
| Nginx | Frontend Web Server |
| MongoDB | Database |

---

# 📂 Repository Structure

```text
.
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── backend/
│   ├── Dockerfile
│   └── package.json
│
├── frontend/
│   ├── Dockerfile
│   └── package.json
│
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
        ├── backend/
        ├── frontend/
        └── database/
```

---

# 🤖 CI/CD Pipeline

The project uses **GitHub Actions** to automate infrastructure validation and Docker image builds.

Pipeline triggers:

- Push to `main`
- Pull Request to `main`

## Pipeline Flow

```mermaid
flowchart LR

A[Git Push]
--> B[GitHub Actions]

B --> C[Terraform Validate]
B --> D[Kubernetes Validation]

C --> E[Build Docker Images]
D --> E

E --> F[(Docker Hub)]
```

Pipeline stages:

- Terraform Format
- Terraform Validate
- Kubernetes Manifest Validation
- Docker Build
- Docker Image Push

---

# 🔐 Secrets Management

Sensitive data is **never committed to Git**.

| Component | Secret Source |
|------------|---------------|
| Terraform | `secret.tfvars` |
| Kubernetes | `.env` |
| CI/CD | GitHub Secrets |

## Terraform Secrets

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

```bash
cd k8s/overlays/local

touch .env
```

Example:

```env
db-password=YourSuperSecretPassword123

mongo-url=mongodb://admin:YourSuperSecretPassword123@mongodb:27017
```

> Both files are excluded from version control using `.gitignore`.

---

# ⚙️ Deployment Guide

## Requirements

Install:

- Docker
- Terraform
- kubectl
- Minikube

Verify installation:

```bash
docker --version
terraform --version
kubectl version --client
minikube version
```

---

## 1. Provision Infrastructure

```bash
cd terraform/environments/local

terraform init

terraform apply -var-file="secret.tfvars"
```

Terraform provisions:

- Docker resources
- Networks
- Persistent volumes
- Infrastructure dependencies

---

## 2. Start Kubernetes

```bash
minikube start --driver=docker

minikube addons enable ingress
```

---

## 3. Deploy Application

```bash
kubectl apply -k k8s/overlays/local
```

Kustomize deploys:

- Deployments
- StatefulSets
- Services
- Ingress
- Secrets

---

# 🔎 Validation

Check Pods:

```bash
kubectl get pods
```

Check Services:

```bash
kubectl get svc
```

Check Ingress:

```bash
kubectl get ingress
```

Check Secrets:

```bash
kubectl get secrets
```

---

# 🌐 Local Access

Retrieve Minikube IP:

```bash
minikube ip
```

Update your hosts file.

### Linux / macOS

```bash
sudo nano /etc/hosts
```

### Windows

```
C:\Windows\System32\drivers\etc\hosts
```

Add:

```text
<MINIKUBE_IP> mern-app.local
```

Open:

```
http://mern-app.local
```

---

# 🔄 Deployment Workflow

```mermaid
flowchart LR

A[Docker Hub Images]
--> B[Minikube]

B --> C[Kustomize]

C --> D[Kubernetes]

D --> E[Frontend]
D --> F[Backend API]
D --> G[(MongoDB)]
```

---

# 🧹 Cleanup

Remove Kubernetes resources:

```bash
kubectl delete -k k8s/overlays/local

minikube stop
```

Destroy Terraform infrastructure:

```bash
cd terraform/environments/local

terraform destroy -var-file="secret.tfvars"
```

---

# ✅ DevOps Concepts Demonstrated

- ✅ Infrastructure as Code (Terraform)
- ✅ Modular Terraform Architecture
- ✅ Docker Containerization
- ✅ Kubernetes Workload Management
- ✅ Stateful Services
- ✅ Declarative Infrastructure
- ✅ Kubernetes Networking
- ✅ Ingress Controller
- ✅ Secrets Management
- ✅ Kustomize Overlays
- ✅ GitHub Actions CI/CD
- ✅ Docker Image Build & Push

---

# 🚀 Future Improvements

- [ ] GitOps deployment (ArgoCD / Flux)
- [ ] Prometheus & Grafana monitoring
- [ ] Helm Charts
- [ ] Multi-environment deployments
- [ ] Production-ready cloud deployment (AWS / Azure / GCP)

---

# 📊 Project Status

| Component | Status |
|------------|--------|
| Terraform Infrastructure | ✅ |
| Docker | ✅ |
| Kubernetes | ✅ |
| Kustomize | ✅ |
| Secrets Management | ✅ |
| CI/CD | ✅ |
| Docker Build & Push | ✅ |

---


## ⭐ If you found this project useful, consider giving it a star!

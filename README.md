<h1 align="center">🚀 MERN Stack Infrastructure Configuration</h1>

<p align="center">
  Infrastructure as Code (IaC) and container orchestration setup for deploying a 
  <strong>3-tier MERN Stack application</strong> in a local environment.
</p>

<p align="center">
  Terraform • Docker • Kubernetes • Minikube • GitHub Actions
</p>

---

## 📖 Overview

This repository contains infrastructure and deployment configurations for a
**MERN Stack application** using modern DevOps practices.

The main purpose of this project is to demonstrate:

- Infrastructure as Code (IaC)
- Modular Terraform architecture
- Container orchestration
- Secrets management
- CI/CD automation
- Local Kubernetes deployment workflow

The infrastructure is designed around a **3-tier architecture**:

```
Frontend → Backend → Database
```

---

# 🧰 Core Components

| Component | Description |
|-----------|-------------|
| **Terraform** | Automates provisioning of local infrastructure including Docker containers, volumes, networks, and reusable modules. |
| **Docker** | Provides containerized application environments. |
| **Kubernetes (Minikube)** | Manages container lifecycle, networking, and service discovery. |
| **GitHub Actions** | Provides CI/CD automation for Terraform validation and quality checks. |

---

# 📂 Repository Structure

```
.
├── .github/
│   └── workflows/              # CI/CD pipelines and automated checks
│
├── k8s/                        # Kubernetes manifests
│   ├── base/                   # Common Kubernetes resources
│   │   ├── deployments/
│   │   └── services/
│   │
│   └── overlays/               # Environment-specific configurations
│       ├── dev/
│       └── prod/
│
└── terraform/                  # Terraform Infrastructure as Code
    │
    ├── environments/           # Terraform root modules
    │   └── local/              # Local development environment
    │
    └── modules/                # Reusable Terraform modules
        │
        ├── backend/            # Node.js API infrastructure
        │
        ├── database/           # MongoDB infrastructure
        │
        └── frontend/           # Nginx frontend infrastructure
```

---

# ⚙️ Getting Started

Follow these steps to deploy the infrastructure locally.

---

## ✅ Prerequisites

Make sure the following tools are installed:

- Docker
- Terraform CLI
- Minikube
- kubectl

Verify installation:

```bash
docker --version
terraform --version
kubectl version --client
minikube version
```

---

# 🔐 Secrets Management

For security reasons, sensitive data is not stored inside the repository.

Database credentials should be provided through a local Terraform variables file.

Navigate to:

```bash
cd terraform/environments/local
```

Create the secrets file:

```bash
touch secret.tfvars
```

Add your database password:

```hcl
db_password = "YourSuperSecretPassword123"
```

> ⚠️ `secret.tfvars` is ignored by Git and should never be committed.

---

# 🚀 Terraform Deployment

## 1. Initialize Terraform

```bash
terraform init
```

This downloads required providers and initializes Terraform modules.

---

## 2. Review Infrastructure Changes

```bash
terraform plan -var-file="secret.tfvars"
```

This shows what resources Terraform will create or modify.

---

## 3. Deploy Infrastructure

```bash
terraform apply -var-file="secret.tfvars"
```

Terraform will create the required infrastructure resources.

---

# 🧹 Cleanup

To remove all created resources:

```bash
terraform destroy -var-file="secret.tfvars"
```

This will destroy the infrastructure created by Terraform.

---

# ☸️ Kubernetes Deployment

Kubernetes manifests are located inside:

```
k8s/
```

The Kubernetes deployment workflow will be added in the next project phase.

---

# 🔒 Security Practices

This project follows several security principles:

✅ No credentials stored in Git  
✅ Secrets managed through local variables  
✅ Infrastructure defined as code  
✅ Reusable Terraform modules  
✅ Automated configuration validation  

---

# 🔄 Continuous Integration

Every push triggers GitHub Actions workflows that validate:

- Terraform formatting
- Terraform configuration syntax
- Infrastructure consistency

---

<h2 align="center">📌 Project Status</h2>

<p align="center">
Infrastructure foundation completed.<br>
Kubernetes deployment automation is under development.
</p>

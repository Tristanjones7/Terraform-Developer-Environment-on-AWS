<div align="center">

# 🧱 **Terraform AWS Dev Environment with Docker on EC2**

<!-- Badges -->
<a href="https://www.terraform.io/"><img src="https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform&logoColor=white" alt="Terraform"></a>
<a href="https://aws.amazon.com/"><img src="https://img.shields.io/badge/AWS-Cloud-232F3E?logo=amazon-aws&logoColor=FF9900" alt="AWS"></a>
<a href="https://aws.amazon.com/ec2/"><img src="https://img.shields.io/badge/EC2-Compute-FF9900?logo=amazon-aws&logoColor=white" alt="EC2"></a>
<a href="https://docs.aws.amazon.com/vpc/"><img src="https://img.shields.io/badge/VPC-Networking-146EB4?logo=amazon-aws&logoColor=white" alt="VPC"></a>
<a href="https://ubuntu.com/download/server"><img src="https://img.shields.io/badge/Ubuntu-24.04%20LTS-E95420?logo=ubuntu&logoColor=white" alt="Ubuntu 24.04"></a>
<a href="https://www.docker.com/"><img src="https://img.shields.io/badge/Docker-Engine-2496ED?logo=docker&logoColor=white" alt="Docker"></a>
<img src="https://img.shields.io/badge/Region-us--west--2-blue" alt="Region us-west-2">
<img src="https://img.shields.io/badge/Status-Production%20Ready-success" alt="Status">

<br/><br/>

A fully automated **development environment** built with **Terraform**, **AWS**, and **Docker**.  
This project provisions an entire network stack — VPC, subnet, internet gateway, route table, and a secure EC2 instance — then bootstraps Docker using user-data.It also automatically generates an SSH config for easy remote access from macOS using the VS Code Remote-SSH extension.


</div>

---

## 🚀 **Project Overview**

**Goal:** Create a reproducible, Docker-ready Ubuntu 24.04 environment on AWS using Terraform.

**What it does:**
- Provisions a complete **VPC** with public subnet and Internet Gateway  
- Configures routing for external connectivity  
- Deploys an **Ubuntu 24.04 EC2 instance**  
- Uses **user-data** to install Docker CE, CLI, and containerd on first boot  
- Generates a macOS **SSH config** via template for one-command SSH  
- Lightweight, modular, and fast to redeploy

---

## 🏗️ **Architecture**

AWS Cloud
└── VPC (10.123.0.0/16)
├── Public Subnet (10.123.1.0/24)
│ ├── Internet Gateway
│ ├── Route Table (0.0.0.0/0 → IGW)
│ └── EC2 Instance (Ubuntu 24.04)
│ └── Docker Engine (installed via user-data)
└── Security Group
├── Ingress: all ports open for testing (0.0.0.0/0)
└── Egress: all traffic allowed

---

## ⚙️ **File Breakdown**

| File | Purpose |
|------|--------|
| **main.tf** | VPC, Subnet, IGW, Route Table, SG, EC2, local SSH config provisioner |
| **datasources.tf** | Latest **Ubuntu 24.04 LTS** AMI from Canonical |
| **providers.tf** | AWS provider (region `us-west-2`, profile `vscode`) |
| **userdata.tpl** | Installs Docker CE/CLI/containerd on first boot |
| **mac-ssh-config.tpl** | Writes `~/.ssh/config` for simplified SSH |

---

## 🧰 **Prerequisites**

- Terraform ≥ 1.6  
- AWS CLI configured:
  ```bash
  aws configure --profile vscode
SSH key at ~/.ssh/terrakey & ~/.ssh/terrakey.pub
VS Code Remote-SSH extension (optional but nice)

🪜 Deployment
terraform init
terraform plan
terraform apply -auto-approve
Terraform will output your instance’s public IP and (via the template) write a simple SSH config.

🔐 Connect & Verify
# SSH (macOS; created by mac-ssh-config.tpl)
ssh ubuntu@<public-ip>

# Verify Docker
docker --version
sudo systemctl status docker
docker run hello-world

Expected:
Docker version 28.2.2, build 28.2.2-0ubuntu1~24.04.1
Hello from Docker!


🧹 Cleanup
terraform destroy -auto-approve


🧠 Key Learnings
Real-world IaC with Terraform (network + compute)
User-data bootstrap for hands-off provisioning
Verified Docker runtime on Ubuntu 24.04 LTS
Smooth dev workflow via VS Code Remote-SSH


👤 Author

Tristan Jones — Cloud / DevOps Engineer
🔗 GitHub: @Tristanjones7

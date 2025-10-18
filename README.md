<h1 align="center">🧱 Terraform Developer Environment on AWS</h1>

<h2>📖 Overview</h2>
This project sets up a lightweight <b>developer environment on AWS</b> using <b>Terraform</b>.  
The goal is to keep the build <b>minimal and efficient</b>, using only the core resources needed for a functional, secure development setup.  
Once deployed, you’ll be able to connect to your EC2 instance directly from <b>VS Code</b> via a remote SSH session.

---

<h2>⚙️ What You’ll Build</h2>

This Terraform configuration provisions the following components:

- <b>VPC</b> – The foundational network layer for your AWS resources.  
- <b>Internet Gateway</b> – Enables internet access for your public subnet.  
- <b>Public Subnet</b> – Hosts the EC2 instance for your development environment.  
- <b>Route Table</b> – Connects the subnet to the Internet Gateway.  
- <b>Security Group</b> – Manages inbound/outbound rules for SSH and other access.  
- <b>EC2 Instance</b> – Serves as the <b>developer node</b>, bootstrapped with user data to configure your environment automatically.  

---

<h2>🧩 Tools & Technologies</h2>

- Terraform – Infrastructure as Code  
- AWS – Cloud Provider  
- VS Code – IDE used for remote access and development  
- User Data Scripts – Bootstraps and configures the EC2 instance automatically  

---

<h2>🧠 How It Works</h2>

1. Terraform processes the configuration files:
   - <code>main.tf</code>  
   - <code>providers.tf</code>  
   - <code>variables.tf</code>  
   - <code>user_data.sh</code>  

2. Once deployed, Terraform outputs the <b>public IP</b> of your EC2 instance.

3. A VS Code configuration file connects your terminal to the EC2 node via <b>SSH</b>, allowing direct file access and remote development.

---

<h2>✅ Prerequisites</h2>

- Terraform ≥ 1.6  
- AWS account with access keys (IAM user with least-privilege)  
- AWS CLI (optional but recommended)  
- VS Code + Remote SSH extension  
- SSH key pair available locally (e.g., <code>~/.ssh/id_rsa.pub</code>)

---

<h2>🔐 Authentication</h2>

```bash
export AWS_ACCESS_KEY_ID=AKIA...
export AWS_SECRET_ACCESS_KEY=...
export AWS_DEFAULT_REGION=eu-west-2   # change as needed
If using a profile:
provider "aws" {
  region  = var.region
  profile = var.aws_profile
}
<h2>⚙️ Configuration</h2>
variables.tf
variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "AWS region to deploy into"
}

variable "project_name" {
  type        = string
  default     = "dev-env"
  description = "Name prefix for resources"
}

variable "ssh_key_name" {
  type        = string
  description = "Existing AWS key pair name for EC2 SSH"
}

variable "ssh_public_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Local path to your public key if creating a key pair"
}
terraform.tfvars
region             = "eu-west-2"
project_name       = "dev-env"
ssh_key_name       = "tristan-dev-key"
ssh_public_key_path = "~/.ssh/id_rsa.pub"
<h2>🚀 Deploy</h2>
terraform init
terraform validate
terraform plan -out plan.tfplan
terraform apply plan.tfplan
Terraform will output the EC2 public IP (and any other outputs defined).
<h2>💻 Connect via VS Code (Remote SSH)</h2>
Copy the output dev_instance_public_ip.
In VS Code, install Remote - SSH extension.
Add to ~/.ssh/config:
Host aws-dev
  HostName <PUBLIC_IP_FROM_OUTPUT>
  User ec2-user
  IdentityFile ~/.ssh/id_rsa
In VS Code: Remote Explorer → SSH Targets → aws-dev → Connect
<h2>📤 Outputs</h2>
outputs.tf
output "dev_instance_public_ip" {
  value       = aws_instance.dev.public_ip
  description = "Public IP of the developer EC2 instance"
}
<h2>🧹 Clean Up</h2>
terraform destroy
<h2>💸 Cost & Security Notes</h2>
Uses public subnet + EC2 + Internet Gateway — minimal cost, but not free.
Restrict SSH access to your IP only in Security Group rules.
Store state in a remote backend (Terraform Cloud or S3 + KMS) for security.
Never commit secrets; use Terraform Cloud variables or environment variables instead.
<h2>🏁 Summary</h2>
This project serves as a hands-on foundation for cloud-based development with Terraform and AWS.
By keeping it minimal, modular, and secure, it’s easy to extend as your infrastructure and skillset grow.

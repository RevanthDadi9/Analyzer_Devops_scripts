# Analyzer Project

## Project Overview

The **Analyzer Project** is a multi-service application involving a **React frontend**, a **Node.js backend**, and a **Flask API**. The services are deployed across multiple **Virtual Machines (VMs)** in an Azure cloud environment. The architecture is designed to use **CI/CD pipelines**, **Terraform** for infrastructure management, and **Ansible** for managing dependencies and service setup.

## Architecture

The project consists of the following components:

1. **React Frontend**:
   - Deployed on a **React VM** with a **public IP**.
   - Exposes the frontend application for users to interact with.

2. **Node.js Backend**:
   - Deployed on a **Node VM**.
   - Only accessible through private IP within the VPC.

3. **Flask API**:
   - Deployed on a **Flask API VM**.
   - Also accessible only through a private IP, used to interact with the Node.js backend.

### Networking and Subnets

- **3 VMs** are created in different subnets of a **VPC** (Virtual Private Cloud).
  - **React VM** has a public IP, allowing it to be accessed from the internet.
  - **Node VM** and **Flask API VM** have **private IPs**, ensuring they can only communicate within the internal network.
  - These subnets are configured to ensure that the **React frontend** can communicate with both the **Node.js backend** and the **Flask API**, while the backend services remain isolated.

## Technologies Used

1. **Azure Virtual Machines**: The project uses 3 Linux-based VMs for React, Node.js, and Flask.
2. **Terraform**: Used for provisioning the infrastructure (VMs, subnets, etc.).
3. **Ansible**: Used for managing the dependencies and configuration on each VM.
4. **CI/CD Pipelines**: The project utilizes Azure DevOps Pipelines for continuous integration and deployment.
5. **SSH and SCP**: Used for deploying code and connecting between VMs.

## Setup Process

### 1. **VM Creation using Terraform**
   Terraform is used to automate the creation of the infrastructure. It provisions 3 VMs across different subnets in an Azure Virtual Network (VNet).
   - The **React VM** is assigned a public IP.
   - The **Node.js** and **Flask API VMs** have private IPs only.

### 2. **Configuring the VMs with Ansible**
   - Ansible is used to install and configure necessary dependencies on each VM.
   - On the **React VM**, Nginx and Node.js are set up.
   - On the **Node VM**, the Node.js backend is configured to handle requests from the React frontend.
   - On the **Flask API VM**, Python dependencies and Flask are set up.

### 3. **CI/CD Pipeline**
   The CI/CD pipeline automates the process of deploying updates to the services.

   - **React Frontend**: When a change is pushed to the repository, the React application is automatically built and deployed to the React VM using SSH.
   - **Node.js and Flask Backend**: Code for both the backend and API is uploaded and deployed to the private VMs using SCP and SSH, respectively.

#### Pipeline Steps:
1. **Code Checkout**: The latest code is pulled from the GitHub repository.
2. **File Upload via SSH**: Files for the Node.js and Flask APIs are uploaded to their respective VMs.
3. **Service Restart**: After uploading, services are restarted to reflect the latest changes.
4. **Flask API Health Check**: A health check ensures that the Flask API is running as expected.

### 4. **Terraform for Infrastructure Provisioning**
   Terraform code is used to provision the Azure resources. This includes the creation of:
   - A Virtual Network (VNet) with 3 subnets.
   - 3 VMs (one for React, one for Node.js, and one for Flask API).
   - Security Groups, Network Interfaces, and Public IP configuration for the React VM.

### 5. **Firewall and Security Configurations**
   - The **React VM** is publicly accessible through port 80 (HTTP).
   - The **Node.js** and **Flask API VMs** are only accessible through private IP addresses, communicating with the React VM via private network routes.

## Deployment Steps

1. **VM Creation**:
   Run the Terraform script to provision the infrastructure in Azure.
   ```bash
   terraform init
   terraform apply
Ansible Setup:

Run Ansible playbooks to set up each VM with the required dependencies.

bash
Copy
Edit
ansible-playbook -i inventory setup-vms.yml
Deploy Code via CI/CD Pipeline:

Push changes to the repository. The Azure DevOps Pipeline will automatically deploy the latest code to the VMs.

The pipeline will upload the code to the Flask API VM and Node.js VM, and restart the services.

Access the Services:

The React app is accessible via the public IP of the React VM.

The backend and Flask API can communicate via private IPs.

# WordPress on AWS with Terraform

Terraform project to deploy a fully monitored, Blue-Green WordPress application on AWS, with automated CI/CD and secure secret management.

---

## Prerequisites

Before you begin, make sure you have the following:

### 1. AWS S3 Bucket for Terraform State
Terraform uses an S3 bucket to store its remote state. You must create a bucket manually before running Terraform.
Update `backend.tf` with your actual bucket name.

### 2. IAM User for Terraform and GitHub Actions
You need an IAM user with programmatic access and permissions to manage the infrastructure.

**Required Permissions:**
- EC2
- RDS
- IAM (to attach instance profiles)
- S3 (for the Terraform backend)
- Secrets Manager
- CloudWatch

Once created, store the access keys in your GitHub repo's secrets as:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `DB_PASSWORD_BLUE`
- `DB_PASSWORD_GREEN`

---

## How to Use

### 1. Clone the repo
```bash
git clone https://github.com/YOURUSER/aws-wordpress-terraform-challenge
cd aws-wordpress-terraform-challenge
```

### 2. Create a secrets file
Create a `secrets.tfvars` file (ignored by Git) with:
```hcl
db_password_blue  = "your-db-password-blue"
db_password_green = "your-db-password-green"
```

### 3. Initialize Terraform
```bash
terraform init
```

### 4. Plan and Apply
```bash
terraform plan -var-file="secrets.tfvars"
terraform apply -var-file="secrets.tfvars"
```

---

## Switching Between Blue and Green Environments

This project uses a Blue-Green deployment strategy managed via a Terraform variable named `active_environment`. You can switch which environment is live behind the ALB by specifying the value when applying.

### How to switch environments

To switch to the **Green** environment:
```bash
terraform apply -var-file="secrets.tfvars" -var="active_environment=green"
```

To switch back to **Blue**:
```bash
terraform apply -var-file="secrets.tfvars" -var="active_environment=blue"
```

This will update the ALB target group to route traffic to the selected environment with no downtime.

---

## CI/CD

This project uses **GitHub Actions** to automate `terraform init`, `plan`, and `apply` on every push to the `main` branch.
Make sure to configure the required GitHub secrets.

---

## Monitoring and Observability

- A CloudWatch dashboard is automatically created, including:
  - EC2 CPU Usage (%)
  - RDS CPU Utilization (%)
  - RDS Free Storage (MB)
  - EC2 Network In (Bytes)
- Logs are sent to CloudWatch Logs from **both EC2 and RDS** instances
- A custom CloudWatch dashboard provides visual monitoring

---

## Terratest

A local Terratest suite (`tests/wordpress_test.go`) is included to validate that:
- Terraform applies successfully
- The ALB URL is reachable
- WordPress responds with HTTP 200 and a valid homepage

**Run locally with:**
```bash
go test -v ./tests/
```

---

## Modular Infrastructure

All components are modularized under the `modules/` folder:
- `vpc`
- `ec2`
- `rds`
- `alb`
- `cloudwatch`
- `secrets`

---

## Bonus Features

- Blue-Green deployment strategy
- Secure password injection via Secrets Manager
- IAM least privilege for CloudWatch Agent
- Modularized Terraform codebase
- CI/CD with GitHub Actions

---


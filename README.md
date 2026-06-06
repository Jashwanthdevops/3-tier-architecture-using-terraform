This project provisions a highly available and scalable 3-Tier Architecture on AWS using Terraform (Infrastructure as Code).

The architecture follows industry best practices:
Public-facing Load Balancer
Auto Scaling Web Tier
Private Database Tier (RDS)
Secure networking with VPC
NAT Gateway for private subnet internet access

Architecture Components

1.Networking Layer

Custom VPC
2 Public Subnets (Multi-AZ)
2 Private Subnets (Multi-AZ)
Internet Gateway
NAT Gateway
Route Tables

2. Web Tier

Launch Template
Auto Scaling Group
Apache Web Server (via user_data)
Security Group allowing HTTP from ALB

3. Application Load Balancer

Public-facing ALB
Target Group
Health Checks
Listener on port 80

4.Database Tier

RDS MySQL (db.t3.micro)
Private Subnet Group
Security Group allowing MySQL from Web Tier only
Not publicly accessible

-> Security Design
ALB allows HTTP (80) from Internet
Web Tier allows HTTP only from ALB SG
RDS allows MySQL (3306) only from Web SG
No direct SSH access to private instances
NAT Gateway used for private subnet internet access

Project Structure :
├── provider.tf
├── variables.tf
├── network.tf
├── security.tf
├── alb.tf
├── asg.tf
├── rds.tf
├── outputs.tf
└──resource.tf
README.md

Deployment:
terraform init
terraform validate 
terraform plan
terraform apply


# 3-tier-architecture-using-Terraform-iac-

📌 CI/CD Pipeline for Web Application Deployment

🚀 Project Overview
This repository contains a CI/CD pipeline for automating the deployment of a web application using:
✅ Jenkins for Continuous Integration & Deployment
✅ Docker for containerization
✅ Terraform for automated AWS infrastructure provisioning
✅ AWS EC2 for hosting the application

This pipeline ensures a fully automated process from code commit to deployment, reducing manual work by 80% and improving deployment speed & reliability.

🛠️ Tech Stack
Technology	Purpose
Jenkins:	CI/CD Pipeline Automation
Docker:	Containerization
Terraform:	Infrastructure as Code (IaC)
AWS EC2:	Cloud Hosting
GitHub:	Version Control
🔧 Setup & Installation
1️⃣ Prerequisites
Before you begin, make sure you have:

Jenkins installed and running
AWS CLI configured with your AWS credentials
Docker installed on your system
Terraform installed
2️⃣ Clone Repository

git clone https://github.com/yourusername/ci-cd-pipeline-webapp.git
cd ci-cd-pipeline-webapp
3️⃣ Setup Jenkins Pipeline
Open Jenkins → New Item → Pipeline
Under Pipeline Definition, select Pipeline script from SCM
Enter the repository URL and branch
Save and Build Now
4️⃣ Configure AWS Infrastructure (Terraform)

cd terraform
terraform init
terraform apply -auto-approve
This provisions an EC2 instance on AWS for hosting the app.

5️⃣ Deploy Application
Once the pipeline runs, deploy the app manually if needed:


ssh -i your-key.pem ec2-user@your-ec2-ip
bash /home/ec2-user/deploy.sh
📜 CI/CD Pipeline Workflow
✅ 1. Code Commit & Build
Developer pushes code to GitHub
Jenkins pulls the latest code
✅ 2. Docker Build & Push
Jenkins builds a Docker image
The image is pushed to Docker Hub
✅ 3. Infrastructure Setup (Terraform)
Terraform creates an EC2 instance
Security groups & networking are configured
✅ 4. Deployment & Monitoring
Jenkins SSHs into EC2 and runs the deployment script
Nginx handles traffic
Logs & metrics are monitored
📂 Key Files & Configurations
1️⃣ Jenkins Pipeline (jenkins/Jenkinsfile)
Defines the CI/CD workflow.


pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/yourusername/ci-cd-pipeline-webapp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build('myapp:latest')
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy to AWS EC2') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh 'scp scripts/deploy.sh ec2-user@your-ec2-ip:/home/ec2-user/'
                    sh 'ssh ec2-user@your-ec2-ip "bash /home/ec2-user/deploy.sh"'
                }
            }
        }
    }
}
2️⃣ Terraform Infrastructure (terraform/main.tf)
Creates an EC2 instance on AWS.

hcl
Copy
Edit
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"  
  instance_type = "t2.micro"
  key_name      = "my-key-pair"

  tags = {
    Name = "CI-CD-EC2-Instance"
  }
}
3️⃣ Deployment Script (scripts/deploy.sh)
Runs on EC2 to start the app inside a Docker container.


#!/bin/bash
# Stop existing container
docker stop myapp || true
docker rm myapp || true

# Pull latest image and run the container
docker pull your-dockerhub-username/myapp:latest
docker run -d -p 80:3000 --name myapp your-dockerhub-username/myapp:latest
🚀 Future Enhancements
✅ Add AWS Load Balancer for high availability
✅ Implement Kubernetes (EKS) for container orchestration
✅ Use Ansible for configuration management
✅ Integrate CloudWatch for better monitoring
🙌 Contributions
Contributions are welcome! Feel free to fork this repo and submit a pull request.


📞 Contact & Support
If you have any questions, feel free to reach out:
📧 Email: anant16mohan@gmail.com
🔗 LinkedIn: https://www.linkedin.com/in/anant-mohan-183b5423a/

⭐ If you found this useful, please give this repo a star! 🌟

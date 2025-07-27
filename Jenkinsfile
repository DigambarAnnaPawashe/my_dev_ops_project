pipeline {
  agent any
  stages {
    stage('Clone') {
      steps { git 'https://github.com/DigambarAnnaPawashe/my_dev_ops_project.git' }
    }
    stage('Build Docker') {
      steps {
        sh 'docker build -t inventory-manager-1:staging .'
      }
    }
    stage('Push to ECR') {
      steps {
        withCredentials([string(credentialsId: 'aws-ecr-creds', variable: 'ECR_LOGIN')]) {
          sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/c4g4u0w2'
          sh 'docker tag inventory-manager-1:latest public.ecr.aws/c4g4u0w2/inventory-manager-1:latest'
          sh 'docker push public.ecr.aws/c4g4u0w2/inventory-manager-1:latest'
        }
      }
    }
    stage('Deploy to EKS') {
      steps {
        sh 'git clone https://github.com/DigambarAnnaPawashe/my_dev_ops_project.git'
        sh ' cd my_dev_ops_project/k8s'
        sh 'kubectl apply -f k8s/staging-deployment.yaml'
      }
    }
  }
}

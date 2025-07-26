pipeline {
  agent any
  stages {
    stage('Clone') {
      steps { git 'https://github.com/yourorg/inventory-manager.git' }
    }
    stage('Build Docker') {
      steps {
        sh 'docker build -t inventory-manager:staging .'
      }
    }
    stage('Push to ECR') {
      steps {
        withCredentials([string(credentialsId: 'aws-ecr-creds', variable: 'ECR_LOGIN')]) {
          sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account_id>.dkr.ecr.us-east-1.amazonaws.com'
          sh 'docker tag inventory-manager:staging <ecr-repo>'
          sh 'docker push <ecr-repo>'
        }
      }
    }
    stage('Deploy to EKS') {
      steps {
        sh 'kubectl apply -f k8s/staging-deployment.yaml'
      }
    }
  }
}

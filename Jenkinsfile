pipeline {
    agent any
    environment {
        IMAGENAME = "nginx"
        AWS = "232481028428"
        AWSREGION = "us-east-1"

    } 
    stages {
        stage('Docker Build') { 
            steps {
                sh 'docker images'
                sh 'docker build -t ${IMAGENAME}:lts .'
                sh 'docker images' 
                sh 'docker run -d -p 80:80 ${IMAGENAME}:lts'
                sh 'docker tag ${IMAGENAME}:lts ${AWS}.dkr.ecr.${AWSREGION}.amazonaws.com/${IMAGENAME}:lts'
               
             
            }
        }
        stage('Terraform') { 
            steps {
                sh 'terraform version'
                sh 'terraform init'
                sh 'terraform plan'
                sh 'terraform apply -auto-approve'
                sh 'terraform output'        
            }
        }
        stage('Push') { 
            steps {
               
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${AWS}.dkr.ecr.us-east-1.amazonaws.com'  
                sh 'docker push ${AWS}.dkr.ecr.${AWSREGION}.amazonaws.com/${IMAGENAME}:lts'              
            }
        }
    }
}


pipeline {
    agent any

    
    environment

            {

               AWS_ACCESS_KEY_ID  = credentials('aws_access_key_id')
               AWS_SECRET_ACCESS_KEY= credentials('aws_secret_access_key')

                

            }

    stages {

      stage('build-image') {
          steps {
            withCredentials([usernamePassword(credentialsId: 'ecr', passwordVariable: 'PASS', usernameVariable: 'USERNAME')]) {
              sh"""
                          echo $PASS | docker login --username AWS --password-stdin 860098129225.dkr.ecr.us-east-1.amazonaws.com
                   """
      
                    }
            sh"""
            docker build -t python-project  ./python
            docker tag python-project 860098129225.dkr.ecr.us-east-1.amazonaws.com/bar:1.0
            docker push 860098129225.dkr.ecr.us-east-1.amazonaws.com/bar:1.0
            aws eks update-kubeconfig --region us-east-1 --name demo
            export KUBECONFIG=path


            """

              
          
                        }
      }
      stage('push-image-to-ecr') {
          steps {
            
            sh"""
            
            docker push 860098129225.dkr.ecr.us-east-1.amazonaws.com/bar:1.0
        


            """

              
          
                        }
      }
      stage('access-ecr') {
          steps {
            
            sh"""
           
            aws eks update-kubeconfig --region us-east-1 --name demo
            export KUBECONFIG=path//to/.kube/config


            """

              
          
                        }
      }

      stage('Deploy App') {
          steps {

              
                sh """
                kubectl apply -f ./k8s/project-configmap.yml
                kubectl apply -f ./k8s/project-secret.yml
                kubectl  apply -f ./k8s/python-dep.yml
                kubectl apply -f ./k8s/python-svc.yml
                kubectl apply -f ./k8s/stateful.yml
                kubectl apply -f ./k8s/mysql-svc.yml
                """
                
              }
          }
      


  }
}
pipeline {
    agent any
    stages {
        stage ('Ready') {
            steps {
                sh '''
                echo "Ready to build pipeline."
                echo "Build ID: ${BUILD_ID}"
                '''
            }
        }
        stage ('Lint') {
            steps {
                sh '''
                    echo "Lint Dockerfile"
                    dockerlint Dockerfile
                '''
            }
        }
        stage ('Docker Build & Push') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        def app = docker.build("devinyang1992/udacityclouddevopsnanodegree:latest", '.')
                        app.push()
                    }
                }
            }
        }

        stage ('Green deployment') {
            steps {
                script {
                        withAWS(credentials: 'aws-credentials', region: 'us-west-2'){
                            sh "aws eks update-kubeconfig --region us-west-2 --name udacitycluster"
                            sh 'kubectl apply -f deploy/green.yml'
                        }
                }
            }
        }

        stage ('Blue deployment') {
            steps {
               script {
                   withAWS(credentials: 'aws-credentials', region: 'us-west-2'){
                    sh 'kubectl apply -f deploy/blue.yml'
                    sh 'echo "Blue deployment successfully"'
                   }
               }
            }
        }

        stage ('Finish & Clean Up') {
            steps {
                sh '''
                echo 'Cleaning up...'
                docker system prune
                '''
            }
        }
    }
}
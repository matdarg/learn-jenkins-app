pipeline {
    agent any

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                ls -la
                npm --version
                node --version
                npm ci
                npm run build
                ls -la
                '''
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {

                echo 'Test stage'
                // check if index.html exists in build directory
                script {
                    def fileExists = sh(script: 'test -f build/index.html', returnStatus: true) == 0
                    if (!fileExists) {
                        error 'index.html does not exist in build directory'
                    } else {
                        echo 'index.html exists in build directory'
                    }
                }
                sh '''
                npm test
                '''
            }
        }
    }
    post {
        always {
            junit 'test-results/junit.xml'
        }
    }
}

pipeline {
    agent any

    stages {
        /*
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
        */
        stage("Run tests") {
            parallel {
                stage('Test') {
                    agent {
                        docker {
                            image 'node:18-alpine'
                            reuseNode true
                        }
                    }
                    steps {
                        // check if index.html exists in build directory
                        // script {
                        //     def fileExists = sh(script: 'test -f build/index.html', returnStatus: true) == 0
                        //     if (!fileExists) {
                        //         error 'index.html does not exist in build directory'
                        //     } else {
                        //         echo 'index.html exists in build directory'
                        //     }
                        // }
                        sh '''
                        npm test
                        '''
                    }
                    post {
                        always {
                            junit 'jest-results/junit.xml'
                        }
                    }
                }
                stage ('E2E') {
                    agent {
                        docker {
                            // use playwright image for e2e tests
                            image 'mcr.microsoft.com/playwright:v1.39.0-jammy'
                            reuseNode true

                        }
                    }
                    steps {
                        // run e2e tests
                        sh '''
                        # run server
                        npm install serve
                        node_modules/.bin/serve -s build -l 3000 &
                        # wait for server to start
                        sleep 10
                        # run e2e tests
                        npx playwright test --reporter=html
                        '''
                    }
                    post {
                        always {
                            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                        }
                    }
                }
            }
        }
    }
}

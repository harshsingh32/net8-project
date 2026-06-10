pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/YOUR_USERNAME/SampleApp.git'
            }
        }

        stage('Restore') {
            steps {
                sh 'dotnet restore src/SampleApp/SampleApp.csproj'
            }
        }

        stage('Build') {
            steps {
                sh 'dotnet build src/SampleApp/SampleApp.csproj -c Release'
            }
        }

        stage('Publish') {
            steps {
                sh '''
                dotnet publish \
                src/SampleApp/SampleApp.csproj \
                -c Release \
                -o publish
                '''
            }
        }

        stage('Package') {
            steps {
                sh '''
                cd publish
                zip -r app.zip .
                '''
            }
        }

        stage('Transfer') {
            steps {

                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: 'AppServer',
                            transfers: [
                                sshTransfer(
                                    sourceFiles: 'publish/app.zip',
                                    remoteDirectory: '/opt/sampleapp/releases'
                                )
                            ]
                        )
                    ]
                )
            }
        }

        stage('Deploy') {
            steps {

                sshagent(['app-server-key']) {

                    sh '''
                    ssh -o StrictHostKeyChecking=no \
                    ubuntu@APP_SERVER_IP \
                    "/opt/sampleapp/scripts/deploy.sh \
                    /opt/sampleapp/releases/app.zip \
                    ${BUILD_NUMBER} \
                    ${JOB_NAME}"
                    '''
                }
            }
        }
    }
}
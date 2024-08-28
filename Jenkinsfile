pipeline {
    agent {
        node {
            label 'eso_slave'
        }
    }
    stages {
        stage('Clean') {
            steps {
                sh 'git clean -xdff'
            }
        }
        stage('Submodule sync') {
            steps {
                sh 'git submodule sync'
                sh 'git submodule update --init --recursive'
                // Ensure that Bob has all of its dependencies
                sh './bob/bob.sh --selftest'
            }
        }
        stage('Lint') {
            steps {
                sh './bob/bob.sh lint'
            }
        }
        stage('Build image and chart') {
            steps {
                sh './bob/bob.sh image'
            }
        }
        stage('Push image and chart') {
            when {
                expression { params.RELEASE == "true" }
            }
            steps {
                sh './bob/bob.sh push'
            }
        }
        stage('Generate input for DIT staging'){
            when {
                expression { params.RELEASE == "true" }
            }
            steps{
                sh 'bob/bob.sh generate-output-parameters'
                archiveArtifacts 'artifact.properties'
            }
        }
    }

}

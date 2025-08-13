pipeline{
    agent {
        label 'AGENT-1'
    }
    options{
        timeout(time: 10, unit: 'SECONDS')
        disableConcurrentBuilds()
    }
    stages{
        stage('Build') {
            steps {
                echo 'Building...'
                // sh 'sleep 10'
                // Add your build commands here
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                //sh 'post failure'
                // Add your test commands here
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Add your deployment commands here
            }
        }
    }


 post {
        always{
            echo "This sections runs always"
            deleteDir()
        }
        success{
            echo "This section run when pipeline success"
        }
        failure{
            echo "This section run when pipeline failure"
        }
    }
}
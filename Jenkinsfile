pipeline {
  agent any

  parameters {
    choice(
      name: 'browser',
      choices: ['chrome', 'firefox'],
      description: 'Select browser to run automation'
    )
  }

  tools {
    maven 'Maven 3.9.1'
    jdk 'Java 21.0.6'
  }

  stages {
    stage('Verify Jenkinsfile is Running') {
      steps {
        echo '✅ This Jenkinsfile is being executed!'
      }
    }

    stage('Show browser param') {
      steps {
        echo "🧪 Browser param received: ${params.browser}"
      }
    }

    stage('Run Dummy Command') {
      steps {
        sh 'echo Hello from Jenkins!'
      }
    }
  }

  post {
    always {
      echo '📦 Post actions complete'
    }
  }
}

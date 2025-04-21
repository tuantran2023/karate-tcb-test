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
    stage('Checkout') {
      steps {
        echo "==> Cloning repo..."
        git url: 'https://github.com/tuantran2023/karate-tcb-test.git', branch: 'main'
      }
    }

    stage('Run Karate Tests') {
      steps {
        echo "==> run test..."
        sh "mvn clean test -Dbrowser=${params.browser}"
      }
    }
  }

  post {
    always {
      publishHTML([
        reportDir: 'target/site',
        reportFiles: 'surefire-report.html',
        reportName: 'Test Report'
      ])
    }
  }
}

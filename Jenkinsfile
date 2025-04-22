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
    stage('Checkout source code') {
      steps {
        git(url: 'https://github.com/tuantran2023/karate-test.git',
        branch: 'main',
        credentialsId: '51e5cdea-8602-43ff-aa70-2e4b294e0931')
      }
    }

    stage('Running automation test') {
      steps {
        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                   sh "mvn clean test -Dbrowser=Chrome"
                }
      }
    }

  }

  post{
    always{
      publishHTML([
      allowMissing: false,
      alwaysLinkToLastBuild: true,
      keepAll: true,
      reportDir: "target/site",
      reportFiles: "surefire-report.html",
      reportName: "TuanTest HTML Report",
      reportTitles: "TuanTest HTML Report"
      ])
      archiveArtifacts artifacts: 'target/karate-report/*.html'
      cleanWs()
    }
  }
}

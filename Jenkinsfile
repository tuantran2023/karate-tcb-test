pipeline {

  agent any

  tools {
    maven 'Maven 3.9.9'
    jdk 'Java 21.0.6'
  }

  parameters {
    choice(
        name: 'browser',
        choices: ['chrome', 'firefox'],
        description:  'Select browser to run automation')
  }

  stages {
    stage('Checkout source code') {
      steps {
        git(url: 'https://github.com/tuantran2023/karate-test.git',
        branch: 'main',
        credentialsId: '51e5cdea-8602-43ff-aa70-2e4b294e0931')
      }
    }

    stage('Build') { 
            steps {
                // 
            }
        }

    stage('Run Karate Tests') {
      steps {
        sh 'mvn clean test'
      }
    }

    stage('Publish Karate Report') {
      steps {
        publishHTML([
          allowMissing: false,
          alwaysLinkToLastBuild: true,
          keepAll: true,
          reportDir: 'target/karate-reports',
          reportFiles: 'karate-summary.html',
          reportName: 'Karate Test Report'
        ])
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
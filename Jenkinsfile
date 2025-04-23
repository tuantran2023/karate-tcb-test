pipeline {
  agent { label 'local' }

  environment {
    KARATE_ENV = 'ci'
    CHROMEDRIVER_VERSION = ''
    GECKODRIVER_VERSION = ''
  }

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
        git(
          url: 'https://github.com/tuantran2023/karate-tcb-test.git',
          branch: 'main',
          credentialsId: '51e5cdea-8602-43ff-aa70-2e4b294e0931'
        )
      }
    }

    stage('Install WebDrivers (Linux only)') {
      when {
        expression { isUnix() }
      }
      steps {
        script {
          sh '''
          set -e
          mkdir -p drivers

          # Install ChromeDriver
          if [ "$browser" = "chrome" ]; then
            echo "Installing ChromeDriver..."
            apt-get update && apt-get install -y curl unzip jq

            CHROMEDRIVER_VERSION=${CHROMEDRIVER_VERSION:-$(curl -s https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json | jq -r '.channels.Stable.version')}

            wget -q -O chromedriver.zip https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/${CHROMEDRIVER_VERSION}/linux64/chromedriver-linux64.zip
            unzip -o chromedriver.zip -d drivers
            chmod +x drivers/chromedriver-linux64/chromedriver
            mv drivers/chromedriver-linux64/chromedriver /usr/local/bin/
          fi

          # Install Geckodriver
          if [ "$browser" = "firefox" ]; then
            echo "Installing Geckodriver..."
            GECKODRIVER_VERSION=${GECKODRIVER_VERSION:-$(curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest | jq -r '.tag_name')}
            wget -q -O geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/${GECKODRIVER_VERSION}/geckodriver-${GECKODRIVER_VERSION}-linux64.tar.gz
            tar -xzf geckodriver.tar.gz -C /usr/local/bin
            chmod +x /usr/local/bin/geckodriver
          fi
          '''
        }
      }
    }

    stage('Run Karate Tests') {
      steps {
        script {
          catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
            if (isUnix()) {
              sh "mvn clean test -Dbrowser=${params.browser} -Dkarate.env=ci"
            } else {
              bat "mvn clean test -Dbrowser=${params.browser} -Dkarate.env=ci"
            }
          }
        }
      }
    }
  }

  post {
    always {
      publishHTML([
        allowMissing: false,
        alwaysLinkToLastBuild: true,
        keepAll: true,
        reportDir: 'target/karate-reports',
        reportFiles: 'karate-summary.html',
        reportName: 'Karate Test Report',
        reportTitles: 'Karate Test Report'
      ])
      archiveArtifacts artifacts: 'target/karate-reports/*.html', allowEmptyArchive: true
      cleanWs()
    }
  }
}

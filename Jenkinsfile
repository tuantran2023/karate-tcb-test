pipeline {
  agent any

  environment {
    KARATE_ENV = 'ci'
    HROMEDRIVER_VERSION = ''
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
        git(url: 'https://github.com/tuantran2023/karate-tcb-test.git',
        branch: 'main',
        credentialsId: '51e5cdea-8602-43ff-aa70-2e4b294e0931')
      }
    }

    stage('Install WebDrivers') {
      steps {
        script {
          sh '''
          set -e
          mkdir -p drivers

          # Install ChromeDriver
          if [ "$KARATE_BROWSER" = "chrome" ]; then
            echo "Downloading ChromeDriver..."
            apt-get update && apt-get install -y curl unzip jq

            CHROMEDRIVER_VERSION=${CHROMEDRIVER_VERSION:-$(curl -s https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json | jq -r '.channels.Stable.version')}

            wget -q -O chromedriver.zip https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/${CHROMEDRIVER_VERSION}/linux64/chromedriver-linux64.zip
            unzip chromedriver.zip -d drivers
            chmod +x drivers/chromedriver-linux64/chromedriver
            mv drivers/chromedriver-linux64/chromedriver /usr/local/bin/
          fi

          # Install Geckodriver
          if [ "$KARATE_BROWSER" = "firefox" ]; then
            echo "Downloading Geckodriver..."
            GECKODRIVER_VERSION=${GECKODRIVER_VERSION:-$(curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest | jq -r '.tag_name')}
            wget -q -O geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/${GECKODRIVER_VERSION}/geckodriver-${GECKODRIVER_VERSION}-linux64.tar.gz
            tar -xzf geckodriver.tar.gz -C /usr/local/bin
            chmod +x /usr/local/bin/geckodriver
          fi
          '''
        }
      }
    }

    stage('Running automation test') {
      steps {
        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                   sh "mvn clean test -Dbrowser=${params.browser} -Dkarate.env=ci"
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
      reportDir: "target/karate-reports",
      reportFiles: "karate-summary.html",
      reportName: "Karate Test Report",
      reportTitles: "Karate Test Report"
    ])
    archiveArtifacts artifacts: 'target/karate-reports/*.html'
    cleanWs()
  }
}


}

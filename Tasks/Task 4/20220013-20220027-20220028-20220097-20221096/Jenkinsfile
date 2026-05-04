pipeline {
    agent any

    tools {
        maven 'Maven-3.9.11'
        jdk   'JDK-26'
    }

    environment {
        APP_NAME = 'simple-calculator'
    }

    stages {

        // ── Stage 1: Clone / Pull Repository ────────────────────────────────
        stage('Clone Repository') {
            steps {
                echo "Cloning repository: ${APP_NAME}"
                git branch: 'main',
                        url: 'https://github.com/Nerosegnofic/CI-CD-and-Jenkins-Pipeline.git'
            }
        }

        // ── Stage 2: Build Project ───────────────────────────────────────────
        stage('Build') {
            steps {
                echo 'Building the project with Maven...'
                bat 'mvn clean package -DskipTests'
            }
            post {
                success {
                    echo 'Build completed successfully.'
                }
                failure {
                    echo 'Build FAILED. Check the console output above.'
                }
            }
        }

        // ── Stage 3: Run Unit Tests ──────────────────────────────────────────
        stage('Run Unit Tests') {
            steps {
                echo 'Running JUnit 5 unit tests...'
                bat 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                    echo 'Test results published.'
                }
                success {
                    echo 'All tests PASSED!'
                }
                failure {
                    echo 'One or more tests FAILED. Review the Test Results tab.'
                }
            }
        }

    }

    post {
        success {
            echo "Pipeline finished successfully for ${APP_NAME}."
        }
        failure {
            echo "Pipeline FAILED for ${APP_NAME}. Please investigate."
        }
        always {
            cleanWs()
        }
    }
}
pipeline {
    agent any

    environment {
        APP_NAME = 'usuarios-rest'
    }

    stages {
        stage('1. Descargar proyecto') {
            steps {
                checkout scm
            }
        }

        stage('2. Compilar con Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('3. Ejecutar pruebas') {
            steps {
                sh './mvnw test'
            }
        }

        stage('4. Crear imagen Docker') {
            steps {
                sh 'docker build -t usuarios-rest:latest .'
            }
        }

        stage('5. Desplegar aplicación') {
            steps {
                sh '''
                    docker compose down || true
                    docker compose up -d
                    docker compose ps
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline terminado correctamente.'
        }
        failure {
            echo 'El pipeline falló. Revisar el registro de Jenkins.'
        }
    }
}

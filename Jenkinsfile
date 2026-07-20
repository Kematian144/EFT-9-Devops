pipeline {
    agent any

    options {
        // Evita que Jenkins descargue el proyecto dos veces.
        skipDefaultCheckout(true)
    }

    environment {
        APP_NAME = 'usuarios-rest'
    }

    stages {
        stage('1. Descargar proyecto') {
            steps {
                // Descarga el proyecto desde GitHub.
                checkout scm
            }
        }

        stage('2. Compilar con Maven') {
            steps {
                // Limpia el proyecto y genera el archivo JAR.
                // Las pruebas se ejecutan en la siguiente etapa.
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('3. Ejecutar pruebas') {
            steps {
                // Ejecuta las pruebas usando Maven instalado en la EC2.
                sh 'mvn test'
            }
        }

        stage('4. Crear imagen Docker') {
            steps {
                // Crea la imagen Docker de la aplicación.
                sh 'docker build -t ${APP_NAME}:latest .'
            }
        }

        stage('5. Desplegar aplicación') {
            steps {
                sh '''
                    # Detiene la versión anterior si existe.
                    docker compose down --remove-orphans || true

                    # Inicia MySQL y la aplicación.
                    docker compose up -d

                    # Muestra el estado de los contenedores.
                    docker compose ps
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline terminado correctamente.'
            echo 'La aplicación fue compilada, probada y desplegada.'
        }

        failure {
            echo 'El pipeline falló. Revisar el registro de Jenkins.'
        }

        always {
            echo 'Proceso del pipeline finalizado.'
        }
    }
}

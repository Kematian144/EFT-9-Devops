# API REST de Usuarios - Municipalidad de La Florida.

Proyecto realizado para la Evaluación Final Transversal de Herramientas DevOps.
La aplicación permite listar, buscar, agregar, editar y eliminar usuarios mediante una API REST.

## Datos del estudiante

- Nombre: Leonardo Meza
- Sección: 001A
- Asignatura: Herramientas DevOps (CDY2202)

## Tecnologías utilizadas

- Java 17
- Spring Boot
- Maven
- MySQL 8
- Docker y Docker Compose
- Jenkins
- GitHub
- Postman

## Funciones de la API

| Método | Ruta | Función |
|---|---|---|
| GET | `/` | Comprobar que la API funciona |
| GET | `/user` | Listar todos los usuarios |
| GET | `/user/{id}` | Buscar un usuario por id |
| POST | `/user` | Agregar un usuario |
| PUT | `/user/{id}` | Editar un usuario |
| DELETE | `/user/{id}` | Eliminar un usuario |

## Estructura principal

```text
UsuariosREST/
├── database/              Script de MySQL
├── postman/               Colección de pruebas
├── scripts/               Instalación y verificación del servidor
├── src/                   Código Java
├── Dockerfile             Imagen de la aplicación
├── docker-compose.yml     API y base de datos MySQL
├── Jenkinsfile            Pipeline de cinco etapas
├── pom.xml                Configuración de Maven
└── README.md              Documentación del repositorio
```

## Base de datos

Este proyecto no utiliza AWS RDS. La base de datos MySQL se ejecuta en un contenedor junto con la aplicación.

Los datos principales de conexión son:

```properties
DB_HOST=mysql
DB_PORT=3306
DB_NAME=municipalidad_la_florida
DB_USER=municipalidad
DB_PASSWORD=municipalidad123
```

El script inicial está en:

```text
database/municipalidad_la_florida.sql
```

## Compilar con Maven

En Windows:

```bat
mvnw.cmd clean package
```

En Linux:

```bash
chmod +x mvnw
./mvnw clean package
```

El archivo generado queda en:

```text
target/usuarios-rest.jar
```

## Ejecutar todo con Docker Compose

Primero se debe compilar el proyecto y después levantar los contenedores:

```bash
./mvnw clean package
docker build -t usuarios-rest:latest .
docker compose up -d
```

Comprobar que ambos contenedores estén funcionando:

```bash
docker compose ps
```

La API queda disponible en:

```text
http://localhost:8081/user
```

Swagger queda disponible en:

```text
http://localhost:8081/swagger-ui.html
```

Para detener los contenedores:

```bash
docker compose down
```

Para borrar también los datos de MySQL y comenzar desde cero:

```bash
docker compose down -v
```

## Ejecutar sin Docker

Para esta opción se debe tener MySQL instalado en el PC.

Crear la base de datos:

```bash
mysql -u root -p < database/municipalidad_la_florida.sql
```

Configurar las variables y ejecutar el JAR:

```bash
export DB_HOST="localhost"
export DB_PORT="3306"
export DB_NAME="municipalidad_la_florida"
export DB_USER="municipalidad"
export DB_PASSWORD="municipalidad123"
java -jar target/usuarios-rest.jar
```

## Pruebas en Postman

Importar este archivo:

```text
postman/Usuarios_REST.postman_collection.json
```

La variable `baseUrl` debe quedar así:

```text
http://IP_DEL_SERVIDOR:8081
```

Ejemplo para POST y PUT:

```json
{
  "firstName": "Camila",
  "lastName": "Rojas",
  "email": "camila.rojas@gmail.com"
}
```

## Pipeline de Jenkins

El archivo `Jenkinsfile` contiene cinco etapas:

1. Descargar el proyecto desde GitHub.
2. Compilar con Maven.
3. Ejecutar las pruebas.
4. Crear la imagen Docker.
5. Desplegar la API y MySQL con Docker Compose.

No se necesita crear una credencial de RDS. Solo se debe dar permiso a Jenkins para utilizar Docker y abrir el puerto 8081 en el servidor.

## Estado de la compilación

El proyecto está preparado para generar un JAR ejecutable. Después de ejecutar Maven correctamente debe aparecer:

```text
target/usuarios-rest.jar
```

# Exchange Discovery Service (Eureka Server)

This is a Eureka Discovery Service for the Exchange Microservice architecture.

## Running with Docker

### Prerequisites
- Docker
- Docker Compose

### Building and Running

1. Build the application with Maven:
   ```
   ./mvnw clean package
   ```

2. Build and start the Docker container:
   ```
   docker-compose up -d
   ```

3. To stop the container:
   ```
   docker-compose down
   ```

## Accessing the Eureka Dashboard

Once the service is running, you can access the Eureka dashboard at:
```
http://localhost:8761
```

## Configuration

The service is configured to run on port 8761. When running in Docker, it uses the configuration from `application-docker.yml`.

### Actuator Endpoints

The service exposes the following Spring Boot Actuator endpoints:

- Health: `http://localhost:8761/actuator/health`
- Info: `http://localhost:8761/actuator/info`

These endpoints provide information about the service's health and status, and are used by Docker for health checks.

## Docker Details

- The Docker image is based on Eclipse Temurin JDK 17 Alpine
- The service exposes port 8761
- The container is connected to a custom bridge network called "exchange-network"
- Health checks are configured to monitor the service's health
- The container is configured to restart automatically unless explicitly stopped

## Running with Kubernetes

### Prerequisites
- Kubernetes cluster
- kubectl command-line tool
- kustomize (optional, but recommended)

### Building and Running

1. Build the application with Maven:
   ```
   ./mvnw clean package
   ```

2. Build the Docker image:
   ```
   docker build -t exchange-discovery-service:latest .
   ```

3. Deploy to Kubernetes using the provided script:
   ```
   ./kubernetes/deploy.sh
   ```

   Or deploy manually using kustomize:
   ```
   kubectl apply -k kubernetes/
   ```

   Or deploy each resource individually:
   ```
   kubectl apply -f kubernetes/configmap.yaml
   kubectl apply -f kubernetes/deployment.yaml
   kubectl apply -f kubernetes/service.yaml
   ```

4. To check the status of the deployment:
   ```
   kubectl get pods -l app=eureka-server
   kubectl get services -l app=eureka-server
   ```

5. To access the Eureka dashboard from outside the cluster, you can use port-forwarding:
   ```
   kubectl port-forward svc/eureka-server 8761:8761
   ```
   Then access the dashboard at http://localhost:8761

6. To delete the deployment, use the provided cleanup script:
   ```
   ./kubernetes/cleanup.sh
   ```

   Or delete manually:
   ```
   kubectl delete -k kubernetes/
   ```

### Kubernetes Configuration Details

- The deployment uses a ConfigMap to store the application configuration
- Readiness and liveness probes are configured to ensure the application is healthy
- Resource requests and limits are set to ensure the application has enough resources
- The service is exposed as a ClusterIP service, making it accessible within the cluster

#!/bin/bash
set -e

# Build the application
echo "Building the application..."
./mvnw clean package

# Build the Docker image
echo "Building the Docker image..."
docker build -t exchange-discovery-service:latest .

# Deploy to Kubernetes
echo "Deploying to Kubernetes..."
kubectl apply -k kubernetes/

echo "Waiting for deployment to be ready..."
kubectl rollout status deployment/eureka-server

echo "Deployment complete!"
echo "To access the Eureka dashboard, run:"
echo "kubectl port-forward svc/eureka-server 8761:8761"
echo "Then open http://localhost:8761 in your browser."
#!/bin/bash
set -e

echo "Removing Kubernetes resources..."
kubectl delete -k kubernetes/

echo "Cleanup complete!"
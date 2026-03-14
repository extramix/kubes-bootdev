# Variables
DEPLOYMENT_FILE=deployment.yml
APP_NAME=my-app

.PHONY: up down status proxy

# Start minikube and apply the deployment
up:
	@minikube status > /dev/null 2>&1 || minikube start
	@kubectl apply -f $(DEPLOYMENT_FILE)
	@echo "Deployment applied. Waiting for pods to be ready..."
	@kubectl rollout status deployment/$(APP_NAME)

# Stop the proxy and delete the deployment
down:
	@kubectl delete -f $(DEPLOYMENT_FILE)

# View the status of your pods and deployments
status:
	@kubectl get all

# Start the proxy server
# Note: This will block the terminal, run in a separate tab or use &
proxy:
	@echo "Starting proxy on http://localhost:8001"
	@kubectl proxy --port=8001
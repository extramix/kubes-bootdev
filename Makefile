# Variables
DEPLOYMENT_FILE=deployment.yml
APP_NAME=synergychat-web
PORT=8080

.PHONY: up down status proxy

# Start minikube and apply the deployment
up:
	@minikube status > /dev/null 2>&1 || minikube start
	@kubectl apply -f $(DEPLOYMENT_FILE)
	@echo "Deployment applied. Waiting for pods to be ready..."
	@kubectl rollout status deployment/$(APP_NAME)

# Open the dashboard
dashboard:
	@echo "Starting dashboard on port 63840..."
	@minikube dashboard --port=63840

# Port-forward to the deployment
forward:
	@echo "Forwarding $(APP_NAME) to http://localhost:$(PORT)..."
	@kubectl port-forward deployment/$(APP_NAME) $(PORT):$(PORT)

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
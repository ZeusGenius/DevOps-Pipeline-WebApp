#!/bin/bash
# Stop existing container (if any)
docker stop myapp || true
docker rm myapp || true

# Pull latest image and run the container
docker pull your-dockerhub-username/myapp:latest
docker run -d -p 80:3000 --name myapp your-dockerhub-username/myapp:latest

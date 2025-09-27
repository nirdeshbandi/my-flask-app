#!/bin/bash
# Test if Flask app runs in Docker

docker build -t nirdeshbandi/my-flask-app:latest .
docker run -d --name test-container -p 5000:5000 nirdeshbandi/my-flask-app:latest
sleep 5
curl http://localhost:5000
docker stop test-container && docker rm test-container


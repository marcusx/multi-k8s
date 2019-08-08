docker build -t marcusx/multi-client:latest -t marcusx/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marcusx/multi-server:latest -t marcusx/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marcusx/multi-worker:latest -t marcusx/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marcusx/multi-client:latest
docker push marcusx/multi-server:latest
docker push marcusx/multi-worker:latest

docker push marcusx/multi-client:$SHA
docker push marcusx/multi-server:$SHA
docker push marcusx/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=marcusx/multi-server:$SHA
kubectl set image deployments/client-deployment client=marcusx/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=marcusx/multi-worker:$SHA

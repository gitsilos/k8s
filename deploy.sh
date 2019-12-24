docker build -t k8s/multi-client:latest -t k8s/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t k8s/multi-server:latest -t k8s/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t k8s/multi-worker:latest -t k8s/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push k8s/multi-client:latest
docker push k8s/multi-server:latest
docker push k8s/multi-worker:latest

docker push k8s/multi-client:$SHA
docker push k8s/multi-server:$SHA
docker push k8s/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployments server=stephengrider/multi-server:latest
kubectl set image deployments/client-deployments client=stephengrider/multi-client:latest
kubectl set image deployments/worker-deployments worker=stephengrider/multi-worker:latest
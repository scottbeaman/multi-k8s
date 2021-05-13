docker build -t scottbeaman/multi-client:latest -t  scottbeaman/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t scottbeaman/multi-server:latest -t scottbeaman/multi-server:$SHA - f ./server/Dockerfile ./server
docker build -t scottbeaman/multi-worker:latest -t scottbeaman/multi-worker:$SHA - f ./worker/Dockerfile ./worker
docker push scottbeaman/multi-client:latest
docker push scottbeaman/multi-server:latest
docker push scottbeaman/multi-worker:latest

docker push scottbeaman/multi-client:$SHA
docker push scottbeaman/multi-server:$SHA
docker push scottbeaman/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=scottbeaman/multi-server:$SHA
kubectl set image deployments/client-deployment client=scottbeaman/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=scottbeaman/multi-worker:$SHA
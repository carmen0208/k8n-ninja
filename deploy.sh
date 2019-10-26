docker build -t carmen0208/multi-client:latest -t carmen0208/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t carmen0208/multi-server:latest -t carmen0208/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t carmen0208/multi-worker:latest -t carmen0208/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push carmen0208/multi-client:latest
docker push carmen0208/multi-server:latest
docker push carmen0208/multi-worker:latest

docker push carmen0208/multi-client:$SHA
docker push carmen0208/multi-server:$SHA
docker push carmen0208/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=carmen0208/multi-server:$SHA
kubectl set image deployments/client-deployment client=carmen0208/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=carmen0208/multi-worker:$SHA
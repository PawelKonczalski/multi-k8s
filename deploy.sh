docker build -t pawelkonczalski/multi-client:latest -t pawelkonczalski/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pawelkonczalski/multi-server:latest -t pawelkonczalski/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pawelkonczalski/multi-worker:latest -t pawelkonczalski/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pawelkonczalski/multi-client:latest
docker push pawelkonczalski/multi-server:latest
docker push pawelkonczalski/multi-worker:latest

docker push pawelkonczalski/multi-client:$SHA
docker push pawelkonczalski/multi-server:$SHA
docker push pawelkonczalski/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=pawelkonczalski/multi-server:$SHA
kubectl set image deployment/client-deployment client=pawelkonczalski/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=pawelkonczalski/multi-server:$SHA
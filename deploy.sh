docker build -t alperzafer/multi-client:latest -t alperzafer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alperzafer/multi-server:latest -t alperzafer/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alperzafer/multi-worker:latest -t alperzafer/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alperzafer/multi-client:latest
docker push alperzafer/multi-server:latest
docker push alperzafer/multi-worker:latest

docker push alperzafer/multi-client:$SHA
docker push alperzafer/multi-server:$SHA
docker push alperzafer/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alperzafer/multi-server:$SHA
kubectl set image deployments/client-deployment client=alperzafer/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alperzafer/multi-worker:$SHA
docker build -t sahanratnayake/multi-client:latest -t sahanratnayake/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sahanratnayake/multi-server:latest -t sahanratnayake/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sahanratnayake/multi-worker:latest -t sahanratnayake/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sahanratnayake/multi-client:latest
docker push sahanratnayake/multi-server:latest
docker push sahanratnayake/multi-worker:latest

docker push sahanratnayake/multi-client:$SHA
docker push sahanratnayake/multi-server:$SHA
docker push sahanratnayake/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployments client=sahanratnayake/multi-client:$SHA 
kubectl set image deployments/server-deployments server=sahanratnayake/multi-server:$SHA 
kubectl set image deployments/worker-deployments worker=sahanratnayake/multi-worker:$SHA 

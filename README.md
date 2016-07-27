# swarm_test
Quick go script to easily check docker swarm load balancing

## How to test swarm load balancing

*Make sure you are on a swarm master running these*

1. `docker network create --driver overlay backend`

2. `docker service create --mode global --name swarm_test --publish 80:80 --network backend jhorwit2/swarm-test:0.0.1`

3. curl any of your master nodes at port 80 and you should see the ips changing each request

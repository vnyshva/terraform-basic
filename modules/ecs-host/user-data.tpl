#!/bin/bash -ex

echo Begin: user-data

echo Begin: update and install packages
yum update -y
yum install -y aws-cli jq
sudo yum install -y amazon-efs-utils
sudo mkdir /efs
#sudo chmod 777 /efs -R
#sudo mount -t efs fs-ab338663:/ /efs
#sudo mount -t efs -o tls fs-ab338663:/ /efs
#sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport efslink.amazonaws.com:/ /efs



echo Begin: start ECS
cluster="nexus"
echo ECS_CLUSTER=$cluster >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS='["json-file","syslog","awslogs","gelf"]' >> /etc/ecs/ecs.config
start ecs
until $(curl --output /dev/null --silent --head --fail http://localhost:51678/v1/metadata); do
  printf '.'
  sleep 1
done
echo End: start ECS

echo End: user-data

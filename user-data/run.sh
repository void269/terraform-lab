#!/bin/bash -xe

terraform apply -var "server_port=80" -auto-approve

public_ip=$(terraform output -raw public_ip)

curl http://$public_ip
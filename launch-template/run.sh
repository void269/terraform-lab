#!/bin/bash -xe

terraform apply "plan.out"

public_ip=$(terraform output -raw public_ip)

sleep 20

curl http://$public_ip
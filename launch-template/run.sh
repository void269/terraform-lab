#!/bin/bash -xe

terraform apply "plan.out" -auto-approve

public_ip=$(terraform output -raw public_ip)

curl http://$public_ip
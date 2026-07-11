# Terraform Lab

This repository serves as a landing zone for my Terraform lab work. Each lab is organized into its own subfolder. Every lab includes a set of Bash scripts that simplify working with the Terraform module.

| File Name    | Description |
|--------------|-------------|
| `build.sh`   | Initializes the Terraform module, generates an execution plan, and saves it as `plan.out`. |
| `run.sh`     | Applies the execution plan stored in `plan.out` and provisions all resources defined in `main.tf`. |
| `destroy.sh` | Destroys all resources that were provisioned by the Terraform deployment. |
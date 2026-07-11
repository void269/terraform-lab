# terraform-lab

This is a landing zone for Terraform Lab work I am writing.
Each section has it's own subfolder.
The sections have Bash scripts to interact with the module.
| File Name | Description |
| 'build.sh' | This will initialize the Terraform Module then create the plan and output it to 'plan.out'.  If the 'plan.out' exists there is no need to run this script. |
| 'run.sh' | This will apply the plan which will stand up all resources outlined in the 'main.ft' file. |
| 'destroy.sh' | This will destroy all resources associated with the plan that was deployed. |
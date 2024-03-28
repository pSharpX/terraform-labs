# terraform-labs
A set of handy terraform sample projects

## Terraform CLI basic commands
````bash
terraform plan
terraform apply
terraform apply --auto-approve
terraform destroy
terraform destroy --auto-approve
````

## Terraform CLI - Import resources
````bash
terraform plan -generate-config-out=generated_resources.tf
````

## Tool for testing autoscaling features in EC2 instances
````bash
apt-get install -y stress
stress --help
stress --cpu 2 --timeout 300s
stress --cpu 2 --timeout 300s -v
````
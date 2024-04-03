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

## Format and validate the configuration
We recommend using consistent formatting in all of your configuration files. The terraform fmt command automatically updates configurations in the current directory for readability and consistency.
You can also make sure your configuration is syntactically valid and internally consistent by using the terraform validate command.
````bash
terraform fmt
terraform validate
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

## GCP
List compute images available in Google Cloud Platform
````bash
gcloud compute images list --sort-by=PROJECT
````
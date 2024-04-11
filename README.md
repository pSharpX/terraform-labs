# **terraform-labs**
A set of handy terraform sample projects

### *Terraform CLI basic commands*
````bash
terraform plan
terraform apply
terraform apply --auto-approve
terraform destroy
terraform destroy --auto-approve
````

### *Format and validate the configuration*
We recommend using consistent formatting in all of your configuration files. The terraform fmt command automatically updates configurations in the current directory for readability and consistency.
You can also make sure your configuration is syntactically valid and internally consistent by using the terraform validate command.
````bash
terraform fmt
terraform validate
````

### *Terraform CLI - Import resources*
````bash
terraform plan -generate-config-out=generated_resources.tf
````

### *Tool for testing autoscaling features in EC2 instances*
````bash
apt-get install -y stress
stress --help
stress --cpu 2 --timeout 300s
stress --cpu 2 --timeout 300s -v
````

## **AWS**
TODO

## **AZURE**
TODO

## **GCP**

### *Print GCloud cheat-sheet for help*
````bash
# display gcloud cheat sheet
gcloud cheat-sheet
````

### *GCloud command structure - Playing with services*
1. **GROUP** - which service group are you playing with ?
    - i.e config or compute or container or dataflow or functions or iam or ...
2. **SUBGROUP** - which subgroup of the service do you want to play with ?
    - i.e instances or images or instance-templates or machine-types or regions or zones
3. **ACTION** - what do you want to do ?
    - i.e create or delete or list or stop or start or describe

````bash
gcloud GROUP SUBGROUP ACTION ...
````

### *Initialize & Configure GCloud*
````bash
# Initialize the gcloud configuration
gcloud init
gcloud config list
# gcloud config list SECTION/PROPERTY
gcloud config list account
gcloud config list project
gcloud config list compute/region
# gcloud config set SECTION/PROPERTY
# gcloud config set compute/zone us-central1-a
# gcloud config set compute/region us-central1
gcloud config set compute/zone NAME
gcloud config set compute/region NAME
# gclouf config unset SECTION/PROPERTY
gcloud config unset project
gcloud config unset compute/region
gcloud config unset compute/zone

gcloud config list project
gcloud config list
````

### *Manage multiple configurations*
````bash
# Use one of the following options to manage multiple configurations in your environment
gcloud config configurations create/delete/activate/describe/list
gcloud config configurations activate my-default-configuration
gcloud config configurations describe my-second-configuration
gcloud config configurations list
gcloud config configurations create my-third-configuration
gcloud config configurations delete my-third-configuration
````

### *List compute images available in Google Cloud Platform*
````bash
gcloud compute images list --sort-by=PROJECT
````

### *Playing with Compute services*
#### *Compute Engine*
````bash
gcloud compute instances list
gcloud compute instances create
gcloud compute instances create my-first-instance-from-gcloud
gcloud compute instances describe my-first-instance-from-gcloud
gcloud compute instances delete my-first-instance-from-gcloud
gcloud compute zones list
gcloud compute regions list
gcloud compute machine-types list
 
gcloud compute machine-types list --filter zone:asia-southeast2-b
gcloud compute machine-types list --filter "zone:(asia-southeast2-b asia-southeast2-c)"
gcloud compute zones list --filter=region:us-west2
gcloud compute zones list --sort-by=region
gcloud compute zones list --sort-by=~region
gcloud compute zones list --uri
gcloud compute regions describe us-west4
 
gcloud compute instance-templates list
gcloud compute instance-templates create instance-template-from-command-line
gcloud compute instance-templates delete instance-template-from-command-line
gcloud compute instance-templates describe my-instance-template-with-custom-image
````
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
gcloud compute images list --filter="name:ubuntu-pro-fips-1804-bionic-v20240411"
gcloud compute images list --filter="name=ubuntu-pro-fips-1804-bionic-v20240411"
gcloud compute images list --filter="PROJECT:(windows-cloud,ubuntu-os-cloud)"
gcloud compute images list --filter="name ~ debian.*"
gcloud compute images list --filter="name ~ debian.*" --uri
gcloud compute images list --filter="name ~ ubuntu.*"
gcloud compute images list --filter="family ~ ubuntu-pro.*"
gcloud compute images list --filter="family ~ fedora-cloud.*"
gcloud compute images list --filter="name ~ ubuntu.*-v202404.*"
gcloud compute images list --filter="name ~ ubuntu.*-v202403.*"
gcloud compute images list --filter="name ~ ubuntu.*-amd64.*"
gcloud compute images list --filter="name ~ ubuntu.* AND NOT name ~ .*arm64.*"
gcloud compute images list --filter="creationTimestamp > -P1Y"
gcloud compute images list --filter="creationTimestamp > -P1Y" --uri
gcloud compute images list --filter="name ~ ubuntu.* AND creationTimestamp > -P1Y"
gcloud compute images list --filter="name ~ ubuntu.* AND creationTimestamp > -P1Y" --uri
gcloud compute images list --filter="name ~ ubuntu.*" --format="value(name,creationTimestamp)"
gcloud compute images list --filter="name ~ ubuntu.*" --format="value(name,creationTimestamp,uri(selfLink))"
gcloud compute images list --filter="name ~ ubuntu.*" --format="value(name, creationTimestamp, uri(selflink))"
gcloud compute images list --filter="name ~ ubuntu.*" --sort-by=creationTimestamp --format="value(name,creationTimestamp)"
gcloud compute images list --filter="name ~ ubuntu.* AND NOT name ~ .*arm64.*" --sort-by=~creationTimestamp --format="value(name, creationTimestamp)"
gcloud compute images list --filter="name ~ ubuntu.* AND NOT name ~ .*arm64.*" --sort-by=creationTimestamp --format="value(name, creationTimestamp)"
gcloud compute images list --filter="name ~ ubuntu.*" --sort-by=creationTimestamp --format="value(name, creationTimestamp)"
gcloud compute images list --filter="name ~ ubuntu.*" --sort-by=~creationTimestamp --format="value(name, creationTimestamp)"

gcloud compute images describe NAME|URI
gcloud compute images describe NAME|URI
gcloud compute images describe https://www.googleapis.com/compute/v1/projects/fedora-cloud/global/images/fedora-cloud-base-gcp-34-1-2-x86-64
````
### Describe image response example
```
archiveSizeBytes: '718809600'
creationTimestamp: '2021-05-06T09:33:30.114-07:00'
description: Fedora, Fedora Cloud Base 34, v34.20210423.0, x86_64 published on 2021-04-27
diskSizeGb: '10'
family: fedora-cloud-34
guestOsFeatures:
- type: UEFI_COMPATIBLE
- type: VIRTIO_SCSI_MULTIQUEUE
id: '2751620519915267254'
kind: compute#image
labelFingerprint: 42WmSpB8rSM=
licenseCodes:
- '1002001'
- '2706998670158047507'
licenses:
- https://www.googleapis.com/compute/v1/projects/vm-options/global/licenses/enable-vmx
- https://www.googleapis.com/compute/v1/projects/fedora-cloud/global/licenses/fedora-34-cloud-base
name: fedora-cloud-base-gcp-34-1-2-x86-64
rawDisk:
  containerType: TAR
  source: ''
selfLink: https://www.googleapis.com/compute/v1/projects/fedora-cloud/global/images/fedora-cloud-base-gcp-34-1-2-x86-64
sourceType: RAW
status: READY
storageLocations:
- us
- eu
- asia
```

### *List machine types available in Google Cloud Platform*
````bash
gcloud compute machine-types list --sort-by=PROJECT
gcloud compute machine-types list --filter zone:us-central1-a
gcloud compute machine-types list --filter="zone:( us-central1-b europe-west1-d )"
gcloud compute machine-types list --filter="name ~ n1-standard.*"
gcloud compute machine-types list --filter="name ~ n1-standard.* AND zone:us-central1-a"
gcloud compute machine-types list --filter="guestCpus = 4"
gcloud compute machine-types list --filter="guestCpus = 2 AND zone ~ us-central1.*"
gcloud compute machine-types list --filter="zone~us-west.*"
gcloud compute machine-types list --filter="memoryMb >= 8192"
gcloud compute machine-types list --filter="guestCpus >= 2 AND guestCpus <= 4 AND memoryMb >= 8192"
gcloud compute machine-types list --filter="description ~ .*High-memory.*"

# gcloud compute machine-types describe NAME
gcloud compute machine-types describe n1-standard-1
````

### *Results with all possible fields/properties*
```
creationTimestamp: '1969-12-31T16:00:00.000-08:00'
description: 1 vCPU, 3.75 GB RAM
guestCpus: 1
id: '3001'
imageSpaceGb: 10
isSharedCpu: false
kind: compute#machineType
maximumPersistentDisks: 128
maximumPersistentDisksSizeGb: '263168'
memoryMb: 3840
name: n1-standard-1
selfLink: https://www.googleapis.com/compute/v1/projects/aforo255-387602/zones/us-central1-a/machineTypes/n1-standard-1
zone: us-central1-a
```

### *Playing with Compute Engine service*
#### *Manage Instances*
````bash
gcloud compute instances list
gcloud compute instances create
gcloud compute instances create my-first-instance-from-gcloud
gcloud compute instances create my-first-instance-from-gcloud \
    --machine-type=e2-standard-2 \
    --source-instance-template= \
    --custom-cpu=4 \
    --custom-memory=4096 \
    --custom-vm-type=n2 \
    --image=debian \
    --zone=us-central1-a \
    --tags= \
    --preemptible \
    --restart-on-failure \
    --maintenance-policy=MIGRATE \
    --metadata-from-file= \
    --

gcloud compute instances describe my-first-instance-from-gcloud
gcloud compute instances delete my-first-instance-from-gcloud
gclout compute instances stop my-first-instance-from-gcloud
gclout compute instances start my-first-instance-from-gcloud
gclout compute instances move my-first-instance-from-gcloud --zone us-central1-b --zone us-central1-c

gcloud compute zones list
gcloud compute zones list --uri
gcloud compute regions list
gcloud compute regions list --uri
gcloud compute zones list --filter=region:us-west2
gcloud compute zones list --sort-by=region
gcloud compute zones list --sort-by=~region
gcloud compute zones list --uri
gcloud compute regions describe us-west4

gcloud compute disk-types list
gcloud compute disks list
gcloud compute snapshots list
````

#### *Manage Instance Templates*
````bash
gcloud compute instance-templates list
gcloud compute instance-templates create instance-template-from-command-line
gcloud compute instance-templates delete instance-template-from-command-line
gcloud compute instance-templates describe my-instance-template-with-custom-image
````

#### *Configure default REGION/ZONE in Compute Instances*

**Options**
1. Centralized configuration:
````bash
gcloud compute project-info add-metadata \
    --metadata[google-compute-default-region=REGION|google-compute-default-zone=ZONE]
````
2. Local gcloud configuration
````bash
gcloud config set compute/region REGION
gcloud config set compute/zone ZONE
````
3. Command specific
````bash
--zone or
--region in the command
````
> **PRIORITY** Option 3 (if exists) overrides Option 2 (if exists) overrides Option 1

#### *Managed Instances Groups*
````bash
gcloud compute instance-groups managed list
gcloud compute instance-groups managed describe my-managed-instance-group
gcloud compute instance-groups managed delete my-managed-instance-group
gcloud compute instance-groups managed delete my-managed-instance-group --region=us-central1
gcloud compute instance-groups managed create my-mig --zone us-central1-a --template my-instance-template-with-custom-image --size 1
gcloud compute instance-groups managed set-autoscaling my-mig --max-num-replicas=2 --zone us-central1-a --cool-down-period=60s --min-num-replicas=1 --mode=on
gcloud compute instance-groups managed stop-autoscaling my-mig --zone us-central1-a
## Resize the Group
gcloud compute instance-groups managed resize my-mig --size=1 --zone=us-central1-a
## Recreate one or more instances
gcloud compute instance-groups managed recreate-instances my-mig --instances=my-mig-85fb --zone us-central1-a
## Update specific instances
gcloud compute instance-groups managed update-instances my-mig --instances=my-instance--3,my-instance-4 --minimal-action=none(default)/refresh/replace/restart \
--most-disruptive-allowed-action=none(default)/refresh/replace/restart
## Update instance templates
gcloud compute instance-groups managed set-instance-template my-mig --template=v2-template
## Rolling Actions
### Scenario: You want to manage your new release - v1 to v2 - without downtime
gcloud compute instance-groups managed rolling-action
## -> Restart (stop & start)
## --max-surge=max n° of instances updated at a time
gcloud compute instance-groups managed rolling-action restart my-mig \
--max-surge=5 or 10% #(max n° of instances updated at a time)
## -> Replace (delete & recreate)
## --max-surge=max n° of instances updated at a time
## --max-unavailable=max n° of instances that can be down for the update
## --replacement-method=substitute(default) creates instances with new names. recreate reuse names
gcloud compute instance-groups managed rolling-action replace my-mig \
--max-surge=5 or 10% \
--max-unavailable=5 or 10% \
--replacement-method=recreate/substitute
## -> Updates instance to a new template 
## Basic version= updates all instances slowly step by step
gcloud compute instace-groups managed rolling-action start-update my-mig \
--version=template=v1-template
gcloud compute instance-groups managed rolling-action start-update my-mig \
--version=template=v1-template \
--canary-version=template=v2-template,target-size=10%
## Canary version
````
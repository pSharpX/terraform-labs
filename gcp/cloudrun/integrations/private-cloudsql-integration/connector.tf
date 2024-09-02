# https://cloud.google.com/vpc/docs/serverless-vpc-access#ip_address_ranges

resource "google_compute_subnetwork" "conector_subnet" {
    name = local.connector_subnet
    description = "Internal Subnetwork for Serverless VPC access connector"
    region = var.REGION
    ip_cidr_range = "10.0.3.0/28"
    network = data.google_compute_network.default.id
    stack_type = "IPV4_ONLY"
}

resource "google_vpc_access_connector" "default" {
    name = local.connector_name
    region = var.REGION
    machine_type = "f1-micro"
    min_instances = 2
    max_instances = 3
    
    subnet {
        name = google_compute_subnetwork.conector_subnet.name
        project_id = data.google_project.onebank.project_id
    }
}
# resource "google_compute_instance_template" "backend_template_3" {
#     name = "onebank-backend-template-3"
#     description = "This template is used to create backend server instances"

#     tags = [ "ssh", "http", "onebank" ]
#     labels = local.common_tags

#     instance_description = "Backend Server Instances"
#     machine_type = data.google_compute_machine_types.general_purpose_e2_standard.machine_types[0].name
#     region = data.google_compute_subnetwork.private_1.region

#     disk {
#         source_image = data.google_compute_image.ubuntu.self_link
#         auto_delete = true
#         boot = true
#         disk_size_gb = 50
#     }

#     network_interface {
#         network = data.google_compute_network.default.name
#         subnetwork = data.google_compute_subnetwork.private_1.name
#     }

#     metadata_startup_script = file(var.PROVISIONER_SCRIPT_PATH)

#     lifecycle {
#         create_before_destroy = true
#     }
# }


# resource "google_compute_health_check" "autohealing_3" {
#     name = "onebank-backend-autohealing-3"
#     description = "Health Check configuration for Backend Instances"
#     check_interval_sec = 5
#     timeout_sec = 5
#     healthy_threshold = 2
#     unhealthy_threshold = 5

#     http_health_check {
#         request_path = "/"
#         port = 80
#     }

#     log_config {
#         enable = false
#     }
# }

# resource "google_compute_instance_group_manager" "onebank_instance_group_3" {
#     name = "onebank-instance-group-manager-3"
#     base_instance_name = "onebank-backend-group-3"
#     target_size = var.INSTANCE_COUNT
#     zone = data.google_compute_zones.private_1.names[1]

#     named_port {
#         name = "http"
#         port = 80
#     }

#     version {
#         name = "primary"
#         instance_template = google_compute_instance_template.backend_template_3.self_link
#     }

#     all_instances_config {
#         labels = local.common_tags
#     }

#     auto_healing_policies {
#         health_check = google_compute_health_check.autohealing_3.id
#         initial_delay_sec = 120
#     }
# }

# resource "google_compute_autoscaler" "autoscaling_3" {
#     name = "onebank-backend-autoscaler-3"
#     target = google_compute_instance_group_manager.onebank_instance_group_3.id
#     zone = data.google_compute_zones.private_1.names[1]

#     autoscaling_policy {
#         max_replicas = var.MAX_REPLICAS
#         min_replicas = var.MIN_REPLICAS
#         cooldown_period = 60

#         cpu_utilization {
#             target = 0.7
#         }
#     }
# }

# resource "google_compute_backend_service" "backend_3" {
#     name = "onebank-backend-group-3"
#     description = "Backend Servers to which traffic will be routed from LB"
#     port_name = "http"
#     protocol = "HTTP"
#     compression_mode = "AUTOMATIC"
#     enable_cdn = true
#     load_balancing_scheme = "EXTERNAL"
#     session_affinity = "NONE"
#     timeout_sec = 30

#     backend {
#         description = "Backend Group for managed instance group 3"
#         group = google_compute_instance_group_manager.onebank_instance_group_3.self_link
#         balancing_mode = "UTILIZATION"
#         capacity_scaler = 1.0
#     }

#     # health_checks = [
#     #     google_compute_http_health_check.http.id
#     # ]

#     log_config {
#         enable = true
#     }
# }
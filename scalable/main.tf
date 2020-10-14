/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

provider "google" {
  project = var.project_id
  region  = var.region
  version = "~> 3.39.0"
}

resource "google_compute_forwarding_rule" "default" {  
  name         = var.fr_name
  region       = var.region
  network      = module.network.network_name
  subnetwork   = module.network.subnets_self_links[0]
  project      = module.project_iam_bindings.projects[0]
  backend_service       = google_compute_region_backend_service.default.id
  load_balancing_scheme = "INTERNAL"
  ports = var.ports
  ip_address   = google_compute_address.internal_with_subnet_and_address.address
}

resource "google_compute_health_check" "http_hc" {
  name                = "hc-http-80"
  check_interval_sec  = 4
  timeout_sec         = 4
  healthy_threshold   = 2
  unhealthy_threshold = 4
  
  http_health_check {
    port = 80
  }

  description = "This HC returns OK depending on the method"
}

resource "google_compute_region_backend_service" "default" {

  backend {
    group          = module.managed_instance_group.instance_group
    balancing_mode = "CONNECTION"
  }

  region      = var.region
  name        = var.ilb_name
  protocol    = "TCP"
  timeout_sec = 10

  health_checks = [google_compute_health_check.http_hc.id]
}

# module "gce-ilb" {
#   source            = "GoogleCloudPlatform/lb-internal/google"
#   version           = "~> 2.0"
#   name              = "cdle-sf-api-ilb"
#   project           = module.project_iam_bindings.projects[0]
#   //firewall_networks = [module.network.network_self_link]
#   soure_tags        = 
#   target_tags       = var.target_tags
#   region            = var.region
#   port              = 80
#   health_check      = google_compute_health_check.http_hc

#   backends = [
#   {
#     group       = module.managed_instance_group.instance_group
#     description = "Backend module"
#   },
#   }
# }

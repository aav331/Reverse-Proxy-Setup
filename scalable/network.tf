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
resource "google_compute_address" "external_ip_address" {
  name = var.ext_ip_name
  address_type = "EXTERNAL"
  project = module.project_iam_bindings.projects[0]
}

module "network" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 2.5.0"
  project_id   = module.project_iam_bindings.projects[0]
  network_name = var.network_name
  routing_mode = "GLOBAL"
  subnets = [
    {
      subnet_name   = var.subnet_name
      subnet_ip     = "10.1.2.0/24"
      subnet_region = var.region
    }
  ]
}

resource "google_compute_address" "internal_with_subnet_and_address" {
  name         = var.internal_ip_name
  subnetwork   = module.network.subnets_self_links[0]
  address_type = "INTERNAL"
  address      = var.internal_ip
  region       = var.region
}

module "cloud_nat" {
  source        = "terraform-google-modules/cloud-nat/google"
  version       = "~> 1.3.0"
  project_id    = module.project_iam_bindings.projects[0]
  region        = var.region
  create_router = true
  router        = var.router_name
  network       = module.network.network_name
  //nat_ip_allocate_option ="MANUAL_ONLY"
  nat_ips       = [google_compute_address.external_ip_address.self_link]
}

resource "google_vpc_access_connector" "connector" {
  name          = var.vpc_connector
  region        = var.region
  ip_cidr_range = "10.8.0.0/28"
  network       = module.network.network_name
}


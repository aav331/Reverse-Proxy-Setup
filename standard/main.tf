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

# This startup script creates a Nginx Server as a Reverse Proxy used for testing

provider "google" {
  project = var.project_id
  region  = var.region
  version = "~> 3.39.0"
}

data "local_file" "instance_startup_script" {
  filename = "${path.module}/templates/startupnginx.sh"
}

resource "google_service_account" "instance_group" {
  account_id = var.service_account_id
  project    = module.project_iam_bindings.projects[0]
}

resource "google_service_account_iam_member" "service_account_user" {
  service_account_id = google_service_account.instance_group.name
  role               = "roles/iam.serviceAccountUser"
  member             = var.iam_member
}

module "instance_template" {
  source               = "terraform-google-modules/vm/google//modules/instance_template"
  version              = "~> 4.0.0"
  project_id           = module.project_iam_bindings.projects[0]
  subnetwork           = module.network.subnets_self_links[0]
  source_image_family  = "debian-9"
  source_image_project = "debian-cloud"
  machine_type         = var.type_machine
  startup_script       = data.local_file.instance_startup_script.content
  service_account = {
    email  = google_service_account.instance_group.email
    scopes = ["cloud-platform"]
  }
  tags = var.target_tags
}

module "compute_instance" {
  source            = "terraform-google-modules/vm/google//modules/compute_instance"
  region            = var.region
  subnetwork        = module.network.subnets_self_links[0]
  num_instances     = "1"
  hostname          = var.mig_hostname
  instance_template = module.instance_template.self_link
  static_ips	      = [google_compute_address.internal_with_subnet_and_address.address]
}
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

resource "google_compute_firewall" "default-lb-fw" {
  project = module.project_iam_bindings.projects[0]
  name    = "fw-allow-lb-access"
  network = module.network.network_name

  allow {
    protocol = "all"
  }

  source_ranges = ["10.1.2.0/24", "10.3.4.0/24"]
  direction = "INGRESS"

}

resource "google_compute_firewall" "default-lb-ssh" {
  project = module.project_iam_bindings.projects[0]
  name    = "fw-allow-ssh"
  network = module.network.network_name

  allow {
    protocol = "tcp"
    ports = ["22", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-ssh"]
  direction = "INGRESS"

}

resource "google_compute_firewall" "default-lb-hc" {
  project = module.project_iam_bindings.projects[0]
  name    = "fw-allow-health-check"
  network = module.network.network_name

  allow {
    protocol = "all"
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["allow-health-check"]
  direction = "INGRESS"

}
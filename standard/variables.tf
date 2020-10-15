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

variable "project_id" {
  description = "GCP Project ID"
}

variable "region" {
  description = "GCP Region"
  default     = "us-east1"
}

variable "bucket_name" {
  description = "Bucket name where the state file will be stored"
}

variable "iam_member" {
  description = "The Iam account that terraform will use"
}

variable "mig_hostname" {
  description = "The name of the Managed Instance Hostname group"
}

variable "target_tags" {
  description = "Network Tags to add to Managed Instance Group VMs"
}

variable "service_account_id" {
  description = "The service account id for creating the instance templates"
}

variable "ext_ip_name" {
  description = "The name of the external ip address"
}

variable "network_name" {
  description = "The name of the API network"
}

variable "subnet_name" {
  description = "The name of the API subnetwork"
}

variable "internal_ip" {
  description = "The internal IP address of the subnetwork"
}

variable "internal_ip_name"{
  description = "The name of the internal IP address"
}

variable "router_name" {
  description = "The name of the Router that will be used to access the internet"
}

variable "vpc_connector" {
  description = "The name of the VPC connector"
}

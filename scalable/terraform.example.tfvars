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

project_id = "" # Insert Project ID here
region = "" # Insert Region here
target_tags = [] # Insert target tags here
bucket_name = "" # Insert bucket name where state will be stored here
iam_member = "" # Insert service account key in the following format (serviceAccount:key-name) here
mig_hostname = "" # Insert Managed Instance Hostname here
type_machine = "" # Insert the Machine Type of the Compute Instance here
ext_ip_name = "" # Insert External IP address Name here
network_name = "" # Insert Network name here
subnet_name = "" # Insert Sub-Network name here
internal_ip = "" # Insert Internal IPv4 address here
internal_ip_name = "" # Insert Internal IP address name here
router_name = "" # Insert Cloud NAT Router name here
vpc_connector = "" # Insert Serverless VPC Connector name here
service_account_id = "" # Insert Service Account ID to be used by the MIG here
ports = [] # Insert the target ports here
fr_name = "" # Insert the name of the Frontend of your ILB here
ilb_name = "" # Insert name of your Internal Load Balancer here

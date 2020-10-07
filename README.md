## Prerequisite

* [00-Setup](https://github.com/terraform-google-modules/cloud-foundation-training/tree/master/00-Setup/README.md)

You should have [Google Cloud SDK](https://cloud.google.com/sdk/docs/downloads-interactive) installed and configured before continuing, otherwise refer to [00-Setup](https://github.com/terraform-google-modules/cloud-foundation-training/tree/master/00-Setup/README.md)

## Internal TCP Load Balancer

This resource helps you create an Internal Load Balancer using Cloud Foundation Toolkit and Terraform resources.

At the end of this, you'll have an internal TCP Load Balancer with a single internal IP backed by the Managed Instance Group VM instances you've created. A Serverless VPC Connector that will allow your Application deployed on App Engine to communicate with the network and make the API calls. 

### What You'll Learn

* [terraform-google-lb-internal](https://github.com/terraform-google-modules/terraform-google-lb-internal)
* [Internal TCP Load Balancer](https://cloud.google.com/load-balancing/docs/internal)

## Task 1. Create IAM Role Bindings 
Use the Cloud Foundation Toolkit [IAM](https://github.com/terraform-google-modules/terraform-google-iam) module in iam.tf to setup role bindings for a user or group. You can pick any user here for the demonstration: another account that belongs to you or someone you know.

## Task 2. Create Networking and Create Cloud NAT instance
Use the Cloud Foundation Toolkit [Network](https://github.com/terraform-google-modules/terraform-google-network) module in network.tf to setup VPC network and [Cloud NAT](https://github.com/terraform-google-modules/terraform-google-cloud-nat) module to create a Cloud NAT instance and a Cloud Router and the terraform resource [Serverless VPC Connector](https://www.terraform.io/docs/providers/google/r/vpc_access_connector.html).

## Task 3. Create Firewalls
Use the terraform resource [Firewall](https://www.terraform.io/docs/providers/google/r/compute_firewall.html) to create the firewall rules to allow traffic movement within your network

## Task 4. Create Instance Template 
Use the Cloud Foundation Toolkit [Instance Template](https://github.com/terraform-google-modules/terraform-google-vm/tree/master/modules/instance_template) module in mig.tf to create an Instance Template

## Task 5. Create Managed Instance Group
Use the Cloud Foundation Toolkit [Managed Instance Group](https://github.com/terraform-google-modules/terraform-google-vm/tree/master/modules/mig) module in mig.tf to create a Managed Instance Group

## Task 6. Create TCP Load Balancer
Use the terraform resource [Forwarding Rule](https://www.terraform.io/docs/providers/google/r/compute_forwarding_rule.html) module and [Backend Service](https://www.terraform.io/docs/providers/google/r/compute_region_backend_service.html) in main.tf to create a Internal TCP Load Balancer with Managed Instance Group as the backend

**VPC Network**, **Cloud NAT**, **Internal IP**, **External IP**, **Serverless VPC Connector**, **Instance Template** and **Managed Instance Group** provided in `network.tf` and `mig.tf`

## Task 7. Configurations

### backend.tf

Fill in backend.tf the bucket name created from [00-Setup](https://github.com/terraform-google-modules/cloud-foundation-training/tree/master/00-Setup/README.md)

### terraform.tfvars

Make a copy of the example `.tfvar` file and populate details.
```bash
cp terraform.example.tfvars terraform.tfvars
```

**Note**: You can have input variables as

* **default** in variables.tf
* using [terraform.tfvars](https://www.terraform.io/docs/configuration/variables.html#variable-definitions-tfvars-files)
* command line argument `-var='key=value'`

## Task 8. Terraform

### Terraform Init & Plan
Initialize Terraform
```bash
terraform init
```

Review Terraform execution plan
```bash
terraform plan -out=plan.out
```

### Terraform Apply

Execute previous generated execution plan

```bash
terraform apply plan.out
```

## Task 9. Verify

On [Google Cloud Console](https://console.cloud.google.com/), navigate to **Network services -> Load balancing**

Review the new **Load Balancer**

From the output of `terraform apply`, you will see the Configuration details for load balancer


## Task 10. Clean Up

Destroy resources created by Terraform

```bash
terraform destroy
```

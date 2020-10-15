## Prerequisite

* [00-Setup](https://github.com/terraform-google-modules/cloud-foundation-training/tree/master/00-Setup/README.md)

You should have [Google Cloud SDK](https://cloud.google.com/sdk/docs/downloads-interactive) installed and configured before continuing, otherwise refer to [00-Setup](https://github.com/terraform-google-modules/cloud-foundation-training/tree/master/00-Setup/README.md)

## Compute Engine VM

This resource helps you create an Internal VM machine that is setup as a Nginx Reverse Proxy for making API calls from Application deployed on App Engine using a Serverless VPC Connector and Cloud NAT.

At the end of this, you'll have an Internal Compute VM with a single internal IP. A Serverless VPC Connector that will allow your Application deployed on App Engine to communicate with the network. A Cloud NAT Router that will enable the Compute VM's to make the API calls. 

### What You'll Build

* [Compute VM](https://github.com/terraform-google-modules/terraform-google-vm)

## Task 1. Create IAM Role Bindings 
Use the Cloud Foundation Toolkit [IAM](https://github.com/terraform-google-modules/terraform-google-iam) module in iam.tf to setup role bindings for a user or group. You can pick any user here for the demonstration: another account that belongs to you or someone you know.

## Task 2. Create Networking, Cloud NAT instance and the Serverless VPC Connector
Use the Cloud Foundation Toolkit [Network](https://github.com/terraform-google-modules/terraform-google-network) module in network.tf to setup VPC network and [Cloud NAT](https://github.com/terraform-google-modules/terraform-google-cloud-nat) module to create a Cloud NAT Instance and a Cloud Router and the terraform resource [Serverless VPC Connector](https://www.terraform.io/docs/providers/google/r/vpc_access_connector.html) to create the VPC Connector that will allow communication between your Application hosted on App Engine and your network.

## Task 3. Create Firewalls
Use the terraform resource [Firewall](https://www.terraform.io/docs/providers/google/r/compute_firewall.html) module in firewalls.tf to create the firewall rules to allow traffic movement within your network.

## Task 4. Create Instance Template 
Use the Cloud Foundation Toolkit [Instance Template](https://github.com/terraform-google-modules/terraform-google-vm/tree/master/modules/instance_template) module in main.tf to create an Instance Template. It contains the startup script that will setup the Compute Engine as an Nginx Reverse Proxy.

## Task 5. Create Compute VM
Use the Cloud Foundation Toolkit [Compute VM](https://github.com/terraform-google-modules/terraform-google-vm) module in main.tf to create a single Compute Engine Instance.

**VPC Network**, **Cloud NAT**, **Internal IP**, **External IP**, **Serverless VPC Connector**, **Instance Template** and **Compute Engine VM** provided in `network.tf` and `main.tf`

## Task 6. Configurations

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

## Task 7. Terraform

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

## Task 8. Verify

On [Google Cloud Console](https://console.cloud.google.com/), navigate to **Compute Engine -> VM Instances**

Review the new **Compute Engine Instance**

From the output of `terraform apply`, you will see the Configuration details for the VM Instance


## Task 9. Clean Up

Destroy resources created by Terraform

```bash
terraform destroy
```

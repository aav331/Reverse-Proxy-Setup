## Prerequisite

* [00-Setup](https://github.com/terraform-google-modules/cloud-foundation-training/tree/master/00-Setup/README.md)

You should have [Google Cloud SDK](https://cloud.google.com/sdk/docs/downloads-interactive) installed and configured before continuing, otherwise refer to [00-Setup](https://github.com/terraform-google-modules/cloud-foundation-training/tree/master/00-Setup/README.md)

## Internal TCP Load Balancer

The folder named standard helps you create an Internal VM machine that is setup as a Reverse Proxy for making API calls from the Application deployed on App Engine using a Serverless VPC Connector and Cloud NAT.
The folder named scalable helps you to create an Internal Load Balancer for making API calls from the Application deployed on App Engine using a Serverless VPC Connector and Cloud NAT at scale using Cloud Foundation Toolkit and Terraform resources.

At the end of this, you'll have an Internal TCP Load Balancer with a single internal IP backed by the Managed Instance Group VM instances you've created. A Serverless VPC Connector that will allow your Application deployed on App Engine to communicate with the network and make API calls. 

### What You'll Build

* [Compute VM](https://github.com/terraform-google-modules/terraform-google-vm)
* [terraform-google-lb-internal](https://github.com/terraform-google-modules/terraform-google-lb-internal)
* [Internal TCP Load Balancer](https://cloud.google.com/load-balancing/docs/internal)
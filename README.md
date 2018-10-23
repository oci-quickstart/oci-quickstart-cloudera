# oci-cloudera-edh
These are Terraform modules for deploying Cloudera Enterprise Data Hub (EDH) on Oracle Cloud Infrastructure (OCI):

* [Sandbox](Sandbox) deploys a single instance running the Cloudera Docker container.  This is a good fit for individuals who want to explore Cloudera on OCI at a very low cost.
* [Development](Development) is the next step up and deploys five instances.
* [Production](Production) is the most powerful preconfigured option.  It provides high density, high performance and high availability.  It is an appropriate entry point for scaling up a production big data practice.
* [N-Node](N-Node) deploys a cluster of arbitrary size.
* [AD-Spanning](AD-Spanning) is a variation of the N-Node deployment that spans all ADs in a region.  This provides the most highly available solution for running Cloudera EDH on OCI.

## Prerequisites
First off you'll need to do some pre deploy setup.  That's all detailed [here](https://github.com/cloud-partners/oci-prerequisites).

## Clone the Module
Now, you'll want a local copy of this repo.  You can make that with the commands:

    git clone https://github.com/cloud-partners/oci-cloudera-edh.git
    cd oci-couchbase/terraform
    ls

## Deploy
You can deploy with the following Terraform commands:

    terraform init
    terraform plan
    terraform apply

## Destroy the Deployment
When you no longer need the deployment, you can run this command to destroy it:

    terraform destroy

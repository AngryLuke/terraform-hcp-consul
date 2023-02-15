# terraform-hcp-consul
This is a simple repo where you can find the basics to deploy a HCP Consul cluster using Terraform.
AWS is the cloud where everything is going to be deployed.

## Tech Preconditions
* Lastest Terraform binary, available on your env PATH [here](https://developer.hashicorp.com/terraform/downloads)
* HCP Account already created [here](https://developer.hashicorp.com/hcp/docs/hcp/create-account)
* HVN on AWS already created [here](https://developer.hashicorp.com/hcp/docs/hcp/network/hvn-aws/hvn-aws)
* HCP Service principal already created (choose Contributor role) [here](https://developer.hashicorp.com/hcp/docs/hcp/security/service-principals)

## How to run the project
Before launch the terraform project please check you already did the following steps:
1. export on the environment HCP client id and secrect
```
export HCP_CLIENT_ID=<your client id>
export HCP_CLIENT_SECRET=<the key generated>
```
2. fecth from HCP portal the hvn-id (name of hvn created)

Following you can find all the mandatory variables needed to deploy the HCP Consul cluster
* min_consul_version (use this variable to change the min Consul version)
* hcp_tier (available values are: development, standard, plus)
    * read [here](https://cloud.hashicorp.com/products/consul/pricing) for all valid options
* hcp_tier_size (available values are: x_small, small, medium, large)
    * x_small is the only valid option for development tier
* enable_public_endpoint (true or false)
* hcp_consul_cluster (the name of the HCP Consul cluster)
* hvn_id (name of hvn already created)

Put all this values into a file <name>.tfvars and execute the provisioning process:
```
terraform apply -var-file="<name>.tfvars"
```

At the end of the provisioning process you'll be able to read from the output:
* public endpoint (if you had set to true enable_public_endpoint)
* private endpoint

### Read the consul token
To read the consul access token (outout will not show value because is flagged as sensitive) you can simply grep the state file, and use it to log in to the portal:
```
grep "consul_root_token" terraform.tfstate
```


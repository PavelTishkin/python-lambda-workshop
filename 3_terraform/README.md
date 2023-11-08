# Weater API Lambda Terraform

## Description

In this lab we will learn how to automate deployment of your Python Lambdas through Terraform.

Terraform is a declarative configuration language that allows us to describe resources we would like to deploy to AWS, Azure, GCP, K8s and many more providers

Each resource that Terraform supports is described as a module, here's an example of AWS modules supported by Terraform
https://registry.terraform.io/namespaces/terraform-aws-modules

## Project code structure

### [weather_api](weather_api)

The folder that contains source code for the Lambda function. Usually this should contain all the code the Lambda needs to function, unless we reference a Lambda layer

### [requests_layer](requests_layer)

Contains source code for the libraries used by the Lambda. This code will be deployed as a separate Lambda layer and can be referenced by other Lambda functions in our account

### [main.tf](main.tf)

This is the main Terraform configuration file containing information for AWS accounts and backend to use during the deployment

The backend is used to save the state that reflects the changes that Terraform applied to our environment. If this is not specified, Terraform will store state in a local file, which won't work if multiple people worked on the same Terraform project 

### [lambda.tf](lambda.tf)

A file containing Terraform code for deploying Lambda and libraries layer. Technically we could put all the Terraform code in main.tf, but this makes it easier to work with

For reference, you can find documentation for the Lambda module here: https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest

There are 100+ inputs that can be provided to the module but we will be using only a small portion of those

### [vars.tf](vars.tf)

The variables required by any of the modules can be described here. This file only contains descriptions of the items and does not contain any values.

The actual values will be contained in *.tfvars* file and there can be more than one file, e.g. one for dev environment and another for prod

<span style="color:red">**Please be careful about storing credentials or secrets in your variable files.**</span> If those are committed to source code repo, other people with access to your source code could gain access to your services, databases, etc.

We are storing API key in the variable file for demonstration purposes but there are better ways of doing that through Secrets Manager, Vault, etc.

### [prod.tfvars](prod.tfvars)

Contains actual variables data that will be used during the deployment by providing `-var-file` parameter

## Deployment

### Environment setup

Terraform will need to know which AWS profile to use when connecting to AWS API. Assuming you have installed your AWS CLI and configured access to your account described in the [setup part](../README.md)

```console
export AWS_PROFILE=<profile_name>
```
### Initialise Terraform providers

Before we do anything else with out deployment we will need to download and cache modules used by Terraform. This step needs to be done once at the start or if any new modules are added to our project configuration

```console
terraform init
```

The modules are downloaded and stored in .terraform directory locally

### Inspect changes

Optionally, we can see what changes Terraform is going to make to the environment when resouces are deployed.

This will make use of the state file we specified in the backend. If there is no statefile yet, the Terraform will assume the resources do not exist yet. Otherwise it will show what changes to resources will be made by our configuration

We'll need to specify `-var-file` parameter, passing in variables that will be used during the deploy phase

This command does not make any actual changes to the environment

```console
terraform plan -var-file prod.tfvars
```

### Apply changes

Similar to plan command, but now the changes will be deployed to the target environment

```console
terraform apply -ver-file prod.tfvars
```

You can run the above command any time you make any changes to your code, it will pick it up and update just the resources that are changed

### Test changes

The deployment will create a function that is similar to the function we created manually in the previous lab. You can explore and run the function through the AWS Console to make sure the deployment completed correctly

### Teardown

After you have ensured that the deployment works, you can clean up the changes you deployed with the following command

    terraform destroy -var-file prod.tfvars

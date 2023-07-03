# Weater API Lambda Terraform

## Description

Terraform package containing source code and supporting libraries for deploying Weather API Lambda

## Source code

### [weather_api](weather_api)

Contains source code for the Lambda function

### [requests_layer](requests_layer)

Contains source code for libraries used by the Lambda

### [lambda.tf](lambda.tf)

Terraform code for deploying Lambda and libraries layer

### [main.tf](main.tf)

Terraform configuration containing information for AWS accounts and backend

### [vars.tf](vars.tf)

Describes variables that will be used by Terraform

### [prod.tfvars](prod.tfvars)

Contains actual variables data that will be used during the deployment by providing `-var-file` parameter

## Deployment

### Environment setup

Terraform will need to know which AWS profile to use when connecting to AWS API. Assuming `~/.aws/credentials` contains valid access keys

```console
export AWS_PROFILE=default
```
### Initialise Terraform providers

Download and cache modules used by Terraform. This step needs to be done once at the start or if any new modules are references in the source code

```console
terraform init
```

### Inspect changes

Optionally, display see what changes Terraform is going to make to the environment when resouces are deployed.
Can take `-var-file` as a parameter, specifying variables that will be used during deploy phase.
Will not make changes to the environment

```console
terraform plan -var-file prod.tfvars
```

### Apply changes

Similar to plan command, but the changes will be deployed to the target environment

```console
terraform apply -ver-file prod.tfvars
```

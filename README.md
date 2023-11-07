# Python in AWS Workshop

## Overview

This workshop covers a few different ways to interact with Python Labmda in AWS.

We will look at configuring access to an AWS account, exploring Lambda through AWS console, configuring programmatic access, automating deployments and connecting to other AWS services

## Prerequisites

In order to be able to go through the tasks set out in the workshop, participants need to have the following setup in advance, to minimise time spent downloading and configuriung tools in the workshop

* Linux-based system for running console commands. If using a Windows laptop, it should be possible to run a Linux image in a VMWare or Virtual Box
* Your own AWS account. We will be using free tier as much as possible, but you should be mindful that creating resources outside of the scope of the workshop may result in additional cost, especially if you forget to delete them
* Python - while the workshop is focused on running Python in AWS and not required for the workshop, you might want to experiment around on the localhost
* Code editor - use your favouive code editor for working with Python
* AWS CLI - we will be needing this for any interactions with AWS from command line and also for Terraform
* Terraform - will help us automate deployment of Lambda to AWS
* Git - to download useful libraries and code repos (including this one)
* OpenWeather account - for later labs to help us learn interacting with external API services

## Setup

### AWS account

You can either sign up for a new AWS account (https://aws.amazon.com/free/) or use your existing account if you have one already. Please note that you may be required to enter your credit card details for billing and may get charged based on the services you decide to deploy

One of the first steps you should do in your new account is to create an IAM user for logging in. You can certainly use the root credentials that were used to create the account, but it is not a recommended practice since it 
allows logged in users (or any apps that you give credentials to) full control of your AWS account, including billing information

Instead, you should create a new administrator IAM user and use it going forward. Follow the instructions here https://docs.aws.amazon.com/streams/latest/dev/setting-up.html and don't forget to log out your root user and log back in as the new user you created when you're done

### AWS CLI

For our next step we will follow the guide to install and configure AWS CLI https://docs.aws.amazon.com/streams/latest/dev/setup-awscli.html

If the CLI has installed correctly, you should be able to run the version check

    aws --version

Once the CLI has been installed, you'll need to configure credentials for accessing your account

    aws configure --profile <profile_name>

You will need a set of access keys for the command above. Those can be created by following https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey

Once everything is setup correctly, you can test with the following command

    aws sts get-caller-identity --profile <profile_name>

### Terraform

Terraform can be installed by following official guide here
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

### Git

Git can be installed as a regular package

    sudo apt install git

After installing, clone this repo for further references and being able to run the code

### OpenWeather

We will be using API calls to retrieve current weather conditions, so it would help to subscribe to https://openweathermap.org/ account and generate an API key
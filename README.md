# Deploying a secure Two-tier web Infrastructure (Includes the use nodejs app to retrieve the database password from secrets manager using IAM role)

This is an example Terraform configuration the allows the deployment of a two-tier web architecture on AWS.

## What are the resources used in this architecture?

A VPC

Availability Zones

Internet gateway

Two public subnets in two availability zones

Two private subnets in two availability zones

Route tables

Security group for our web-tier instance in the public subnet

Security group for our database in the private subnet

Security group for VPC Interface endpoint for secrets manager

ssh key for our web-tier instance

ec2 instance profile with ec2 role containing policy for actions on secrets manager

secrets manager secret

secrets manager secret version

VPC Interface endpoint

random password

kms key and policy

RDS - MySQL instance

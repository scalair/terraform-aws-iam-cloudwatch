# Terraform AWS IAM CloudWatch

Module to create an AWS IAM user with policy to interact with CloudWatch.
This module uses [iam-user](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-user) to create the iam user. This module requires [Keybase](https://keybase.io/) to encrypt/decrypt user password, so you need a Keybase account before using it (you can find more details on the [iam-user module page](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-user#notes-for-keybase-users)).
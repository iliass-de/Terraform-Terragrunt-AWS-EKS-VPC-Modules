terraform {
  # Deploy stage
  source = "git::https://github.com/iliassh1/terragnut.git//modules/eks"
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    bucket         = "csa-bucket-project"
    key            = "terraform/eks.state"
    region         = "us-east-1"
  }
}

#EKS inputs
inputs = {
 cluster_name                     = "eks-demo"
 instance_type                    = "t2.small"
 launch_configuration_prefix_name = "terraform_config"
 autoscaling_group_name           = "terraform_auto_scaling"
 security_group_nodes_name        = "terraform_nodes"
 security_group_workers_name      = "terraform_workers"
}








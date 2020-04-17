data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.eks_cluster.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  eks-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.eks_cluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.eks_cluster.certificate_authority[0].data}' '${var.cluster_name}'
USERDATA

}

resource "aws_launch_configuration" "eks_aws_cluster" {
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.eks_node.name
  image_id = data.aws_ami.eks-worker.id
  instance_type = var.instance_type
  key_name             = aws_key_pair.eksKeypair.key_name
  name_prefix = var.launch_configuration_prefix_name
  security_groups = [aws_security_group.eks_node.id]
  user_data_base64 = base64encode(local.eks-node-userdata)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "eks_aws_cluster" {
  desired_capacity = 2
  launch_configuration = aws_launch_configuration.eks_aws_cluster.id
  max_size = 2
  min_size = 1
  name = var.autoscaling_group_name
  vpc_zone_identifier = module.vpc.public_subnets

  tag {
    key = "Name"
    value = "aws-eks-cluster"
    propagate_at_launch = true
  }

  tag {
    key = "kubernetes.io/cluster/${var.cluster_name}"
    value = "owned"
    propagate_at_launch = true
  }
}


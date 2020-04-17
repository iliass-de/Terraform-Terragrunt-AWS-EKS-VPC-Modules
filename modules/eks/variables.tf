variable "cluster_name" {
  description = "cluster_name"
  type        = string
}

variable "instance_type" {
  description = "instance type"
  type        = string
  
}

variable "launch_configuration_prefix_name" {
  description = "launch_configuration_prefix_name"
  type        = string
}

variable "autoscaling_group_name" {
  description = "autoscaling group name"
  type        = string
}

variable "security_group_nodes_name" {
  description = "security_group_nodes_name"
  type        = string
}

variable "security_group_workers_name" {
  description = "security_group_workers_name"
  type        = string
}



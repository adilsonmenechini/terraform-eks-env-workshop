module "eks" {

  source          = "terraform-aws-modules/eks/aws"
  version         = "12.1.0"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnets         = var.private_subnets
  vpc_id          = var.vpc_id

  enable_irsa     = true

  map_users = var.map_users

  workers_additional_policies = [
    "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  ]

  worker_groups = [
    {
      spot_price           = var.spot_price
      instance_type        = var.instance_type
      asg_max_size         = var.max_cluster_size
      asg_desired_capacity = var.desired_capacity
      asg_min_size         = var.min_cluster_size
    },
  ]

  tags = {
    environment = var.environment
  }
}
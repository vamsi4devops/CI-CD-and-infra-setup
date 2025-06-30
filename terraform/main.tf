module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = var.cluster_name
  cluster_version = "1.28"
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  eks_managed_node_groups = {
    devops-node-group = {
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      instance_types = ["t3.medium"]
    }
  }

  enable_irsa                      = true
  cluster_endpoint_public_access   = true
  cluster_endpoint_private_access  = true

  manage_aws_auth = true

  aws_auth_users = [
  {
    userarn  = "arn:aws:iam::388252588517:user/admin"
    username = "admin"
    groups   = ["system:masters"]
  }
]

  tags = {
    Environment = "dev"
    Project     = "devops-backend"
  }
}

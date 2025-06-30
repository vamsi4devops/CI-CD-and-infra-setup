module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"  # latest as of now

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.29"

  vpc_id     = aws_vpc.eks_vpc.id
  subnet_ids = aws_subnet.public_subnet[*].id

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 3
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }

  manage_aws_auth_configmap = true

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::388252588517:user/admin"
      username = "admin"
      groups   = ["system:masters"]
    }
  ]
}

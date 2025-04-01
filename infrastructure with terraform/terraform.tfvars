vpc_cidr = "10.0.0.0/16"
vpc_name = "task-vpc"
igw_name ="task-igw"
rt_name  = "publicrt-table"
pub_rt_igw_access_cidr = "0.0.0.0/0"
pri_rt = "privatert-table"
lb_name = "my-applb"
sg_name = "applb-sg"
subnets = [
  { name = "app-subnet-1", cidr = "10.0.1.0/24", type = "application", az = "eu-north-1a" },
  { name = "app-subnet-2", cidr = "10.0.2.0/24", type = "application", az = "eu-north-1b" },
  { name = "app-subnet-3", cidr = "10.0.3.0/24", type = "application", az = "eu-north-1c" },
  { name = "db-subnet-1", cidr = "10.0.4.0/24", type = "database", az = "eu-north-1a" },
  { name = "db-subnet-2", cidr = "10.0.5.0/24", type = "database", az = "eu-north-1b" },
  { name = "db-subnet-3", cidr = "10.0.6.0/24", type = "database", az = "eu-north-1c" },
  { name = "lb-subnet-1", cidr = "10.0.7.0/24", type = "loadbalancer", az = "eu-north-1a" },
  { name = "lb-subnet-2", cidr = "10.0.8.0/24", type = "loadbalancer", az = "eu-north-1b" },
  { name = "lb-subnet-3", cidr = "10.0.9.0/24", type = "loadbalancer", az = "eu-north-1c" }
]

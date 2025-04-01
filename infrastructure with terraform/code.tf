resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = var.pub_rt_igw_access_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.rt_name
  }
}

resource "aws_subnet" "subnets" {
  for_each = { for idx, subnet in var.subnets : subnet.name => subnet }

  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.type == "loadbalancer" ? true : false

  tags = {
    Name = each.value.name
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  for_each = { for subnet in var.subnets : subnet.name => subnet if subnet.type == "loadbalancer" }
  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = var.pri_rt
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  for_each = { for subnet in var.subnets : subnet.name => subnet if subnet.type == "application" || subnet.type == "database" }

  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_lb" "main" {
  name               = "my-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [for s in aws_subnet.subnets : s.id if s.map_public_ip_on_launch]

  tags = {
    Name = var.lb_name
  }
}

resource "aws_security_group" "lb_sg" {
  vpc_id = aws_vpc.my-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}

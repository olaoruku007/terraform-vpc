# terraform { 
#   cloud { 
    
#     organization = "zthcloud" 

#     workspaces { 
#       name = "terraform-new" 
#     } 
#   } 
# }


resource "aws_vpc" "terraform-pro" {
  cidr_block = var.vpc_cidr
  #cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

}

resource "aws_security_group" "allow_HTTP" {
  name        = "allow_HTTP and SSH"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.terraform-pro.id

  tags = {
    Name = "${var.Environment}-terraform-pro-SG"
  }


  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.terraform-pro.cidr_block]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.terraform-pro.cidr_block]
  }





  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.terraform-pro.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
}  


resource "aws_subnet" "terraform-pro1" {
  vpc_id                  = aws_vpc.terraform-pro.id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone       = var.az[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.Environment}-terraform-pro-public1"
  }
}

resource "aws_subnet" "terraform-pro2" {
  vpc_id     = aws_vpc.terraform-pro.id
  cidr_block = var.public_subnet_cidrs[1]
  #cidr_block              = "10.1.8.0/21"
  availability_zone       = var.az[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.Environment}-terraform-pro-public2"
  }
}

resource "aws_subnet" "terraform-pro3" {
  vpc_id                  = aws_vpc.terraform-pro.id
  cidr_block              = "10.1.16.0/21"
  availability_zone       = var.az1[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.Environment}-terraform-pro-private1"
  }
}

resource "aws_subnet" "terraform-pro4" {
  vpc_id                  = aws_vpc.terraform-pro.id
  cidr_block              = "10.1.24.0/21"
  availability_zone       = var.az1[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.Environment}-terraform-pro-private2"
  }
}


resource "aws_subnet" "terraform-pro5" {
  vpc_id                  = aws_vpc.terraform-pro.id
  cidr_block              = "10.1.32.0/21"
  availability_zone       = var.az[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.Environment}-terraform-pro-public3"
  }
}




resource "aws_internet_gateway" "terraform-pro-igw" {
  vpc_id = aws_vpc.terraform-pro.id

  tags = {
    Name = "${var.Environment}-terraform-pro-igw"
  }
}


resource "aws_route_table" "terraform-pro-RT" {
  vpc_id = aws_vpc.terraform-pro.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-pro-igw.id
  }

  tags = {
    Name = "${var.Environment}-terraform-pro-RT"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.terraform-pro1.id
  route_table_id = aws_route_table.terraform-pro-RT.id

}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.terraform-pro4.id
  route_table_id = aws_route_table.terraform-pro-RT.id
}

resource "aws_route_table_association" "public3" {
  subnet_id      = aws_subnet.terraform-pro5.id
  route_table_id = aws_route_table.terraform-pro-RT.id
}



# Look up subnets by name
# data "aws_subnet" "subnet_id" {
#   for_each = toset([
#     "terraform-pro", # first subnet name
#     "terraform-pro1"  # second subnet name
#   ])

#   filter {
#     name   = "tag:Name"
#     values = [each.key]
#   }
# }

# # Launch EC2 instances in each subnet
# resource "aws_instance" "multi_subnet" {
#   for_each      = data.aws_subnet.subnet_id
#   ami           = "ami-0474a0658ad946d8e" # Replace with a valid AMI
#   instance_type = "t2.large"
#   subnet_id     = each.value.id

#   tags = {
#     Name = "ec2-${each.key}"
#   }
# }








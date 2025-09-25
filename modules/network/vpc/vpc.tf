# 1. VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr                                     
  tags = {
    Name = "main-vpc"
                   
  }
}
# 2. Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "public-subnet"
  }
#depends_on = [
 #   aws_vpc.main
 # ]
}

# 3. Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# 4. Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# 5. Route Table Association
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


# Use the first subnet for simplicity
resource "aws_instance" "example" {
  ami           = "ami-01b6d88af12965bb6"  
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id 

  tags = {
    Name = "ExampleInstance"
  }
}

output "name"{
value = aws_instance.example.public_ip
}


# EBS volume creation
resource "aws_ebs_volume" "eb" {
  availability_zone = "ap-south-1a"
  size              = 10
  tags = {
    Name = "New-volume"
  }
}

#attaching the ebs volume in ap-south-1a

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.eb.id
  instance_id = aws_instance.example.id
}
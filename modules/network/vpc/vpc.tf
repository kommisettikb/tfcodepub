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
  cidr_block              = var.sub_cidr
  availability_zone       = var.zone

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




output "name"{
value = aws_instance.example.public_ip
}



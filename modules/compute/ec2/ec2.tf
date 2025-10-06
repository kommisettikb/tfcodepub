# Use the first subnet for simplicity
resource "aws_instance" "i3" {
  ami           = "ami-0f9708d1cd2cfee41"  
  instance_type = "t3.micro"
  subnet_id     = "subnet-031939f2ea993e91f"

  tags = {
    Name = "i360"
  }
}
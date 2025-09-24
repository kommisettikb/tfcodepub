resource "aws_instance" "example" {
  ami           = "ami-01b6d88af12965bb6"  
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id 

  tags = {
    Name = "tfinstance"
  }
}

output "name"{
value = aws_instance.example.public_ip
}
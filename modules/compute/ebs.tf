# EBS volume creation
resource "aws_ebs_volume" "eb" {
  availability_zone = "ap-south-1a"
  size              = 10
  tags = {
    Name = "i360_volume"
  }
}

#attaching the ebs volume in ap-south-1a

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.eb.id
  instance_id = aaws_instance.i3.id
}
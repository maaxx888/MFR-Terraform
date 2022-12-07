#add encrypted volume
resource "aws_ebs_volume" "volume-1" {
  
  availability_zone = "eu-west-1a"
  size              = 2
  encrypted         = true

  tags = {
    Name = "volume-1"
  }
}

#attach volume to ec2
resource "aws_volume_attachment" "attach-1" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.volume-1.id
  instance_id = aws_instance.web-server.id
}
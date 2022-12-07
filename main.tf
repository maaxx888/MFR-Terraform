#Create ec2 with apache and php
resource "aws_instance" "web-server" {
  ami               = "ami-096800910c1b781ba"
  instance_type     = "t2.micro"
  availability_zone = "eu-west-1a"
  key_name          = "Main-key"

  tags = {
    name = "ubuntu"
    name = "apache"
    Name = "web-server"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install apache2 -y
    sudo apt install php8.1 -y
    sudo systemctl start apache2
    sudo systemctl enable apache2
    EOF
}

resource "aws_instance" "ec2" {
  ami               = "ami-096800910c1b781ba"
  instance_type     = "t2.micro"
  availability_zone = "eu-west-1a"
  key_name          = "Main-key"
  count = 2

  tags = {
    Name = "instance-${count.index}"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install apache2 -y
    sudo apt install php8.1 -y
    sudo systemctl start apache2
    sudo systemctl enable apache2
    EOF
}

#-----------------------------------------------------------------------------------------------------

# Create a bucket and upload files
resource "aws_s3_bucket" "bucket-1" {

  bucket = "r0831987.terraform"
  tags = {
    Name = "bucket-1"
  }
}

#acl
resource "aws_s3_bucket_acl" "acl-1" {
  bucket = aws_s3_bucket.bucket-1.id
  acl    = "public-read"
}

#enable versioning for bucket-1
resource "aws_s3_bucket_versioning" "versioning-1" {
  bucket = aws_s3_bucket.bucket-1.id
  versioning_configuration {
    status = "Enabled"
  }
}

# upload multiple files
resource "aws_s3_object" "file-1" {
  bucket   = aws_s3_bucket_versioning.versioning-1.bucket
  for_each = fileset("myfiles","*")
  key      = each.value
  acl      = "public-read"
  source   = "myfiles/${each.value}"
  etag     = filemd5("myfiles/${each.value}")
}

#-----------------------------------------------------------------------------------------------------




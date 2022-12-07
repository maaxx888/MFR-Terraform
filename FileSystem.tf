#file system
resource "aws_efs_file_system" "file-system-1" {
  creation_token = "FS-1-matser"

  tags = {
    Name = "MyProduct"
  }
}
resource "aws_efs_mount_target" "efs-target-1" {
 file_system_id = aws_efs_file_system.file-system-1.id
 subnet_id      = aws_subnet.public-subnet-1.id
}
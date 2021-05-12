provider "aws" {

    region = "ap-south-1"
    profile =  "default"
}
resource "aws_instance" "os1" {

    ami= "ami-010aff33ed5991201"
    instance_type = "t2.micro"
    tags = {
        Name = "Instance using Terraform"
    }
}

output "o1" {
    value = aws_instance.os1
}

resource "aws_ebs_volume" "myebs" {
  availability_zone = aws_instance.os1.availability_zone
  size              = 10

  tags = {
    Name = "myebsfromterraform"
  }
}

output "o2" {
    value = aws_ebs_volume.myebs
}


resource "aws_volume_attachment" "ebs_instance" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.myebs.id
  instance_id = aws_instance.os1.id
}

output "o3" {
    value = aws_volume_attachment.ebs_instance
}   

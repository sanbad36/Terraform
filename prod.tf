provider "aws" {
  region                  = "ap-south-1"
  profile                 = "default"
}


resource "aws_instance" "webos1" {
  ami           = "ami-010aff33ed5991201"
  instance_type = "t2.micro"
  security_groups =  [ "Forterraform" ]
  key_name = "terraform-key"

  tags = {
    Name = "Web Server by TF"
  }

}
resource "null_resource"  "nullremote1" {

connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/OMEN/Downloads/terraform-key.pem")
    host     = aws_instance.webos1.public_ip
  }

provisioner "remote-exec" {
    inline = [
      "sudo yum  install httpd  -y",
      "sudo  yum  install php  -y",
      "sudo systemctl start httpd",
      "sudo systemctl start httpd"
    ]
  }

}


resource "aws_ebs_volume" "example" {
  availability_zone = aws_instance.webos1.availability_zone
  size              = 1

  tags = {
    Name = "Web Server HD by TF"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdc"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.webos1.id
  force_detach = true
}



resource "null_resource"  "nullremote2" {
connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/OMEN/Downloads/terraform-key.pem")
    host     = aws_instance.webos1.public_ip
  }

provisioner "remote-exec" {
    inline = [
      "sudo mkfs.ext4 /dev/xvdc",
      "sudo  mount /dev/xvdc  /var/www/html",
    ]
  }

}

resource "null_resource"  "nullremote4" {

connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/OMEN/Downloads/terraform-key.pem")
    host     = aws_instance.webos1.public_ip
  }

provisioner "remote-exec" {
    inline = [
      "sudo yum install git -y",
      "sudo git clone https://raw.githubusercontent.com/sanbad36/Terraform/main/index.php    /var/www/html/web"
    ]
  }

}

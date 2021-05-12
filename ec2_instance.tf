provider "aws" {

    region = "ap-south-1",
    access_key = "my-access-key"   
    secret_key = "my-secret-key"   
}
# You have to provide the access key and secret key 
resourse "aws_instance" "os1" {

    ami= "ami-010aff33ed5991201"
    instance_type = "t2.micro"
    tags = {
        Name = "Instance using Terraform"
    }
}

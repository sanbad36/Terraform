variable "x" {
  type= string
  default = "linux world"
  }
output "myvalue" {
  value = "${var.x}"
  }

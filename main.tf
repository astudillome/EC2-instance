provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "sample" {
    ami = "ami-006dcf34c09e50022"
    instance_type = "t2.micro"
}

resource "null_resource" "instance_ttl" {
  triggers = {
    instance_id = aws_instance.sample.id
  }

  provisioner "local-exec" {
    command = "sleep 90 && terraform destroy -target=aws_instance.sample -auto-approve"
  }
}

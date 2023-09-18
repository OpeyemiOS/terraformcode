resource "aws_lightsail_instance" "gitlab_test" {
  name              = "custom_gitlab"
  availability_zone = "us-east-1b"
  blueprint_id      = "amazon_linux_2"
  bundle_id         = "nano_1_0"
  #key_pair_name     = "some_key_name"
  tags = {
    env = "dev"
  }
}

resource "aws_lightsail_instance" "example" {
  name              = "example-server"
  availability_zone = "us-east-1a"  # Change this to your desired availability zone
  blueprint_id      = "amazon_linux_2"
  bundle_id         = "nano_2_0"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>This Server is created using Terraform </h1>" >> /var/www/html/index.html
              EOF
}

output "instance_ip" {
  value = aws_lightsail_instance.example.public_ip_address
}
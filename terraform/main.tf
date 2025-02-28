provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with latest AMI
  instance_type = "t2.micro"
  key_name      = "my-key-pair"
  security_groups = ["web-sg"]

  tags = {
    Name = "CI-CD-EC2-Instance"
  }
}

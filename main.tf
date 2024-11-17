provider "aws" {
  region = "eu-central-1"  # Choose your region
}

resource "aws_instance" "web2" {
  ami           = "ami-0084a47cc718c111a"  # Example AMI for Ubuntu; update based on region
  instance_type = "t2.micro"
  key_name      = "NEW"

  security_groups = [aws_security_group.web_sg2.name]

  tags = {
    Name = "web-server2"
  }
}

resource "aws_security_group" "web_sg2" {
  name        = "web-sg2"
  description = "Allow inbound traffic to EC2 instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic to backend (port 3001)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "ec2_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.web2.public_ip
}

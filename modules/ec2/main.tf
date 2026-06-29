# modules/ec2/main.tf

# Security Group — Kaun access kar sakta hai
resource "aws_security_group" "ec2" {
  name        = "${var.project_name}-ec2-sg"
  description = "EC2 Security Group"
  vpc_id      = var.vpc_id

  # HTTP access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # App port
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound — sab allow
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-ec2-sg"
    Environment = var.environment
  }
}

# EC2 Instance
resource "aws_instance" "app" {
  ami                    = "ami-0f58b397bc5c1f2e8" # Ubuntu 22.04 ap-south-1
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  iam_instance_profile   = var.iam_instance_profile

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y python3 python3-pip docker.io
    systemctl start docker
    systemctl enable docker
  EOF

  tags = {
    Name        = "${var.project_name}-ec2"
    Environment = var.environment
  }
}

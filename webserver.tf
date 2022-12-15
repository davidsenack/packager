provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "puppy-server" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y golang
    export GOPATH=$HOME/go
    go get github.com/davidsenack/packager
    $GOPATH/bin/packager
  EOF
}

output "puppy-server-ip" {
  value = "${aws_instance.puppy-server.public_ip}"
}

resource "aws_security_group" "puppy-server" {
  name        = "puppy-server-sg"
  description = "Security group for the puppy server"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

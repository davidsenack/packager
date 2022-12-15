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
    go get github.com/your-username/packager
    $GOPATH/bin/webserver
  EOF
}

output "puppy-server-ip" {
  value = "${aws_instance.puppy-server.public_ip}"
}

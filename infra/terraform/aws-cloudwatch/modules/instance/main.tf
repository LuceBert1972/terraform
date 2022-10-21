data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

resource "aws_key_pair" "ssh" {
  public_key = var.ssh_key
  key_name   = "ssh"
}

resource "aws_security_group" "instance" {
  name        = "${var.namespace}-${var.project_name}-app"
  description = "Allow traffic to application"
  vpc_id      = var.vpc.id

  ingress {
    protocol        = "tcp"
    from_port       = 8080
    to_port         = 8080
    self            = false
  }
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    self        = false
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_ebs_volume" "data-vol" {
 availability_zone = "${var.region}a"
 size = 20
 tags = {
        Name = "data-volume"
 }
}

resource "aws_volume_attachment" "good-morning-vol" {
 device_name = "/dev/sdc"
 volume_id = "${aws_ebs_volume.data-vol.id}"
 instance_id = "${aws_instance.cloudwatchtestname.id}"
}

resource "aws_instance" "cloudwatchtestname" {
  ami = "ami-0f0f1c02e5e4d9d9f"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  subnet_id = var.subnet.public_a.id
  key_name = "Laptop"
  iam_instance_profile = "CloudWatchAgentServerRole"
}

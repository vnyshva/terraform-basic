#Security groups configurations allowing incoming traffic

#security group to allow ssl connections

resource "aws_security_group" "ssl" {
  vpc_id = "${var.VPC_ID}"
  name = "${var.STACK}-ALB-SG"
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.STACK}-ALB-SG"
    Description = "${var.STACK} HTTPS  traffic firewall rules"
  }
}

resource "aws_security_group" "docker" {
  vpc_id = "${var.VPC_ID}"
  name = "${var.STACK}-CONTAINER-SG"
  ingress {
    from_port = "0"
    to_port = "65535"
    protocol = "tcp"
    security_groups = ["${aws_security_group.ssl.id}"]
  }
  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    security_groups = ["${aws_security_group.admin.id}"]
  }

  ingress {
    from_port = "0"
    to_port = "65535"
    protocol = "tcp"
    self = true
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    Name = "${var.STACK}-CONTAINER-SG"
    Description = "${var.STACK} instance rules"
  }
}
resource "aws_security_group" "admin" {
  vpc_id = "${var.VPC_ID}"
  name = "${var.STACK}-ADMIN-SG"


  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/22"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    Name = "${var.STACK}-ADMIN-SG"
    Description = "${var.STACK} adminserver access  firewall rules"
  }
}
resource "aws_security_group" "nfs" {
  vpc_id = "${var.VPC_ID}"
  name = "${var.STACK}-nfs-SG"


  ingress {
    from_port = "2049"
    to_port = "2049"
    protocol = "tcp"
    security_groups = ["sg-0e12eb38b22a22993"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    Name = "${var.STACK}-nfs-SG"
    Description = "${var.STACK} sg for nfs"
  }
}


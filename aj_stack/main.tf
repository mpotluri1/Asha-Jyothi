#EC2 Instance
terraform {
  backend "s3" {
    bucket = "arun-cloudfront-logs"
    key = "testing-terraform"
    region = "us-east-1"
  }
}
data "terraform_remote_state" "aj_vpc" {
  backend = "s3"
  config {
    bucket = "${var.remote_state_bucket}"
    key = "${var.remote_state_key}"
    region = "${var.remote_buc_reg}"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "aj_stack" {
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.az}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group}"]
  user_data = "${data.template_file.aj_boot.rendered}"
  subnet_id = "${data.terraform_remote_state.aj_vpc.public_subnets[0]}"
  iam_instance_profile = "${var.iamprofile}"
  root_block_device {
    volume_type = "standard"
    volume_size = "100"
    delete_on_termination = "true"
  }
  tags {
    Owner = "${var.owner}"
    Name = "${var.name}"
  }
  }

resource "aws_ebs_volume" "aj_ebs" {
  availability_zone = "us-west-2a"
  size = 100
  tags {
    Owner = "${var.owner}"
    Name = "${var.name}"
  }
}


data "template_file" "aj_boot" {
  template = "${file("user_data/aj_bootstrap.sh.tpl")}"
}


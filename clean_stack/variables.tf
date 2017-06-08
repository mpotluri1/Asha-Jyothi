variable ami_id {
  default = "ami-22ce4934"
}

variable key_name {
  default = "manvi_trainee"
}

variable security_group {
  default = "sg-806bcbfc"
}

variable instance_type {
  default = "t2.medium"
}

variable az {
  default = "us-east-1a"
}

variable owner {
  default = "manvitha.potluri"
}

variable name {
  default = "AJ-Dev"
}

variable remote_state_bucket {
  default = "arun-cloudfront-logs"
}

variable remote_state_key {
  default = "tfstate/aj-infra"
}

variable remote_buc_reg {
  default = "us-east-1"
}

variable expiration_date {
  default = "2017-06-30"
}

variable "iamprofile" {
  default = "s3accesstoec2"
}

variable "state_file" {
  default = "testing-terraform"
}
variable "database-endpoint" {
  default = ""
}


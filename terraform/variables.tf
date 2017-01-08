variable "name" {
  description = "Asha-Jyothi Development and Testing"
  default = "AJ-VPC"
}

variable "cidr" {
  description = "CIDR for the AJ-VPC"
  default = "192.168.0.0/24"
}

variable "public_subnets" {
  type = "list"
  description = "A list of public subnets inside the VPC."
  default     = ["192.168.0.0/27", "192.168.0.32/27", "192.168.0.64/27"]
}

variable "private_subnets" {
  type = "list"
  description = "A list of private subnets inside the VPC."
  default     = ["192.168.0.96/27", "192.168.0.128/27", "192.168.0.160/27"]
}

variable "azs" {
  type = "list"
  description = "A list of Availability zones in the region"
  default     = ["us-east-1a","us-east-1b","us-east-1c"]
}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "enable_nat_gateway" {
  description = "should be true if you want to provision NAT Gateways for each of your private networks"
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  default     = true
}

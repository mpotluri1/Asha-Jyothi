data "terraform_remote_state" "aj_infra" {
  backend = "s3"
  config {
    bucket = "arun-cloudfront-logs"
    key = "tfstate/aj-terrafrom-infra.tfstate"
    region = "us-east-1"
  }
}
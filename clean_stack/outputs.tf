output "DNS" {
  value = "${aws_instance.aj_stack.public_dns}"
}

output "IP" {
  value = "${aws_instance.aj_stack.public_ip}"
}

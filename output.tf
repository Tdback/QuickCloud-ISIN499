output "instance_ip" {
  value = aws_instance.quickcloud_instance[*].public_ip
}

# vim: ft=terraform : ts=2

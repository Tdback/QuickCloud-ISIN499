output "instance_ip" {
  value = aws_instance.jump_box.public_ip
}

# vim: ft=terraform : ts=2

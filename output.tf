output "instance_ip" {
  value       = aws_instance.jump_box.public_ip
  description = "IP address of public-facing jumpbox."
}

output "alb_domain_name" {
  value       = aws_lb.quickcloud_alb.dns_name
  description = "Domain name of the load balancer."
}

# vim: ft=terraform : ts=2

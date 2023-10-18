output "instance_ip" {
  value       = aws_instance.jump_box.public_ip
  description = "IP address of public-facing jumpbox."
}

output "alb_domain_name" {
  value       = aws_lb.quickcloud_alb.dns_name
  description = "Domain name of the load balancer."
}

output "rds_endpoint" {
  value       = aws_db_instance.quickcloud_db.endpoint
  description = "Endpoint of RDS database."
}

# vim: ft=terraform :ts=2

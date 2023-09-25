output "instance_public_ip" {
  description = "Return public IP address of server."
  value       = aws_instance.app_server.public_ip
}

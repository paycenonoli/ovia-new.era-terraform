# Get outputs
output "public_ip" {
  description = "The public IP of the instance"
  value       = aws_instance.ovia-app.public_ip
  sensitive   = false
}
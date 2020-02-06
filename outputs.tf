output "Server_IP" {
  value = module.ec2.server_ip
}

output "Verify_assesment" {
  value = "Please open Server IP in your browser"
}
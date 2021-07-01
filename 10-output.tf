output "alb-dns" {
  value = aws_lb.alb.dns_name
}

output "app1-private-ips" {
  value = aws_instance.app1-instances[*].private_ip
}

output "app2-private-ips" {
  value = aws_instance.app2-instances[*].private_ip
}
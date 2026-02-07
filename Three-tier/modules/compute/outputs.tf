output "alb_dns_name" {
  description = "The public DNS name of the web load balancer"
  value       = aws_lb.web_alb.dns_name
}

output "app_sg_id" {
  description = "The ID of the security group for the application servers"
  value       = aws_security_group.app_sg.id
}

output "asg_name" {
  description = "The name of the auto scaling group"
  value       = aws_autoscaling_group.app_asg.name
}
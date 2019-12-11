output "arn" {
  description = "The ARN of the issued certificate"
  value       = aws_acm_certificate.main.arn
}


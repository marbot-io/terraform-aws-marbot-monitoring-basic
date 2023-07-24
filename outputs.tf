output "topic_name" {
  description = "Name of the SNS topic where errors, warnings, and notifications are published to."
  value       = join("", aws_sns_topic.marbot[*].name)
}

output "topic_arn" {
  description = "ARN of the SNS topic where errors, warnings, and notifications are published to."
  value       = join("", aws_sns_topic.marbot[*].arn)
}

output "topic_name" {
  value = aws_sns_topic.marbot.name
}

output "topic_arn" {
  value = aws_sns_topic.marbot.arn
}

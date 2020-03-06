terraform {
  required_providers {
    aws = ">= 2.48.0"
  }
}

data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

##########################################################################
#                                                                        #
#                                 TOPIC                                  #
#                                                                        #
##########################################################################

resource "aws_sns_topic" "marbot" {
}

resource "aws_sns_topic_policy" "marbot" {
  arn    = aws_sns_topic.marbot.arn
  policy = data.aws_iam_policy_document.topic_policy.json
}

data "aws_iam_policy_document" "topic_policy" {
  statement {
    sid       = "Sid1"
    effect    = "Allow"
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.marbot.arn]

    principals {
      type        = "Service"
      identifiers = [
        "events.amazonaws.com",
        "budgets.amazonaws.com",
        "rds.amazonaws.com",
        "s3.amazonaws.com",
        "backup.amazonaws.com"
      ]
    }
  }

  statement {
    sid       = "Sid2"
    effect    = "Allow"
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.marbot.arn]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }

  statement {
    sid      = "Sid3"
    effect   = "Allow"
    actions  = ["sns:Publish"]
    resources = [aws_sns_topic.marbot.arn]

    principals {
      type        = "Service"
      identifiers = ["ses.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:Referer"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}

resource "aws_sns_topic_subscription" "marbot" {
  depends_on = [aws_sns_topic_policy.marbot]

  topic_arn              = aws_sns_topic.marbot.arn
  protocol               = "https"
  endpoint               = "https://api.marbot.io/${var.stage}/endpoint/${var.endpoint_id}"
  endpoint_auto_confirms = true
  delivery_policy        = <<JSON
{
  "healthyRetryPolicy": {
    "minDelayTarget": 1,
    "maxDelayTarget": 60,
    "numRetries": 100,
    "numNoDelayRetries": 0,
    "backoffFunction": "exponential"
  },
  "throttlePolicy": {
    "maxReceivesPerSecond": 1
  }
}
JSON
}



resource "aws_cloudwatch_event_rule" "monitoring_jump_start" {
  depends_on = [aws_sns_topic_subscription.marbot]

  description         = "Monitoring Jump Start connection (created by marbot)"
  schedule_expression = "rate(30 days)"
}

resource "aws_cloudwatch_event_target" "monitoring_jump_start" {
  rule      = aws_cloudwatch_event_rule.monitoring_jump_start.name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
  input     = <<JSON
{
  "Type": "monitoring-jump-start-tf-connection",
  "Module": "basic",
  "Version": "0.1.0",
  "Partition": "${data.aws_partition.current.partition}",
  "AccountId": "${data.aws_caller_identity.current.account_id}",
  "Region": "${data.aws_region.current.name}"
}
JSON
}

##########################################################################
#                                                                        #
#                                 ALARMS                                 #
#                                                                        #
##########################################################################

resource "random_id" "id8" {
    byte_length = 8
}



resource "aws_cloudwatch_metric_alarm" "trusted_advisor_cost_optimization" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = (data.aws_region.current.name == "us-east-1" && var.trusted_advisor) ? 1 : 0

  alarm_name          = "marbot-cost-optimization-${random_id.id8.hex}"
  alarm_description   = "Trusted Advisor Cost Optimization checks are red (created by marbot)."
  namespace           = "AWS/TrustedAdvisor"
  metric_name         = "RedChecks"
  statistic           = "Maximum"
  period              = 21600
  evaluation_periods  = 1
  comparison_operator = "GreaterThanThreshold"
  threshold           = 0
  alarm_actions       = [aws_sns_topic.marbot.arn]
  ok_actions          = [aws_sns_topic.marbot.arn]
  dimensions          = {
    Category = "Cost Optimization"
  }
}



resource "aws_cloudwatch_metric_alarm" "trusted_advisor_fault_tolerance" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = (data.aws_region.current.name == "us-east-1" && var.trusted_advisor) ? 1 : 0

  alarm_name          = "marbot-fault-tolerance-${random_id.id8.hex}"
  alarm_description   = "Trusted Advisor Fault Tolerance checks are red (created by marbot)."
  namespace           = "AWS/TrustedAdvisor"
  metric_name         = "RedChecks"
  statistic           = "Maximum"
  period              = 21600
  evaluation_periods  = 1
  comparison_operator = "GreaterThanThreshold"
  threshold           = 0
  alarm_actions       = [aws_sns_topic.marbot.arn]
  ok_actions          = [aws_sns_topic.marbot.arn]
  dimensions          = {
    Category = "Fault Tolerance"
  }
}



resource "aws_cloudwatch_metric_alarm" "trusted_advisor_performance" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = (data.aws_region.current.name == "us-east-1" && var.trusted_advisor) ? 1 : 0

  alarm_name          = "marbot-performance-${random_id.id8.hex}"
  alarm_description   = "Trusted Advisor Performance checks are red (created by marbot)."
  namespace           = "AWS/TrustedAdvisor"
  metric_name         = "RedChecks"
  statistic           = "Maximum"
  period              = 21600
  evaluation_periods  = 1
  comparison_operator = "GreaterThanThreshold"
  threshold           = 0
  alarm_actions       = [aws_sns_topic.marbot.arn]
  ok_actions          = [aws_sns_topic.marbot.arn]
  dimensions          = {
    Category = "Performance"
  }
}



resource "aws_cloudwatch_metric_alarm" "trusted_advisor_security" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = (data.aws_region.current.name == "us-east-1" && var.trusted_advisor) ? 1 : 0

  alarm_name          = "marbot-security-${random_id.id8.hex}"
  alarm_description   = "Trusted Advisor Security checks are red (created by marbot)."
  namespace           = "AWS/TrustedAdvisor"
  metric_name         = "RedChecks"
  statistic           = "Maximum"
  period              = 21600
  evaluation_periods  = 1
  comparison_operator = "GreaterThanThreshold"
  threshold           = 0
  alarm_actions       = [aws_sns_topic.marbot.arn]
  ok_actions          = [aws_sns_topic.marbot.arn]
  dimensions          = {
    Category = "Security"
  }
}



resource "aws_cloudwatch_metric_alarm" "trusted_advisor_service_limits" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = (data.aws_region.current.name == "us-east-1" && var.trusted_advisor) ? 1 : 0

  alarm_name          = "marbot-service-limits-${random_id.id8.hex}"
  alarm_description   = "Trusted Advisor Service Limits checks are red (created by marbot)."
  namespace           = "AWS/TrustedAdvisor"
  metric_name         = "RedChecks"
  statistic           = "Maximum"
  period              = 21600
  evaluation_periods  = 1
  comparison_operator = "GreaterThanThreshold"
  threshold           = 0
  alarm_actions       = [aws_sns_topic.marbot.arn]
  ok_actions          = [aws_sns_topic.marbot.arn]
  dimensions          = {
    Category = "Service Limits"
  }
}

##########################################################################
#                                                                        #
#                              SUBSCRIPTIONS                             #
#                                                                        #
##########################################################################

# TODO Terraform bug: Error fetching subscriptions for topic ***: AuthorizationError: User: *** is not authorized to perform: SNS:ListSubscriptionsByTopic on resource: *** status code: 403, request id: ***
#resource "aws_sns_topic_subscription" "ami_update_notification_ecs_optimized" {
#  depends_on = [aws_sns_topic_subscription.marbot]
#  count      = (data.aws_region.current.name == "us-east-1" && var.ami_update_notification_ecs_optimized) ? 1 : 0
#
#  topic_arn               = "arn:aws:sns:us-east-1:177427601217:ecs-optimized-amazon-ami-update"
#  protocol                = "https"
#  endpoint                = "https://api.marbot.io/${var.stage}/endpoint/${var.endpoint_id}"
#  endpoint_auto_confirms  = true
#  delivery_policy = <<JSON
#{
#  "healthyRetryPolicy": {
#    "minDelayTarget": 1,
#    "maxDelayTarget": 60,
#    "numRetries": 100,
#    "numNoDelayRetries": 0,
#    "backoffFunction": "exponential"
#  },
#  "throttlePolicy": {
#    "maxReceivesPerSecond": 1
#  }
#}
#JSON
#}



# TODO Terraform bug: Error fetching subscriptions for topic ***: AuthorizationError: User: *** is not authorized to perform: SNS:ListSubscriptionsByTopic on resource: *** status code: 403, request id: ***
#resource "aws_sns_topic_subscription" "ami_update_notification_amazon_linux" {
#  depends_on = [aws_sns_topic_subscription.marbot]
#  count      = (data.aws_region.current.name == "us-east-1" && var.ami_update_notification_amazon_linux) ? 1 : 0
#
#  topic_arn               = "arn:aws:sns:us-east-1:137112412989:amazon-linux-ami-updates"
#  protocol                = "https"
#  endpoint                = "https://api.marbot.io/${var.stage}/endpoint/${var.endpoint_id}"
#  endpoint_auto_confirms  = true
#  delivery_policy = <<JSON
#{
#  "healthyRetryPolicy": {
#    "minDelayTarget": 1,
#    "maxDelayTarget": 60,
#    "numRetries": 100,
#    "numNoDelayRetries": 0,
#    "backoffFunction": "exponential"
#  },
#  "throttlePolicy": {
#    "maxReceivesPerSecond": 1
#  }
#}
#JSON
#}



# TODO Terraform bug: Error fetching subscriptions for topic ***: AuthorizationError: User: *** is not authorized to perform: SNS:ListSubscriptionsByTopic on resource: *** status code: 403, request id: ***
#resource "aws_sns_topic_subscription" "ami_update_notification_amazon_linux2" {
#  depends_on = [aws_sns_topic_subscription.marbot]
#  count      = (data.aws_region.current.name == "us-east-1" && var.ami_update_notification_amazon_linux2) ? 1 : 0
#
#  topic_arn               = "arn:aws:sns:us-east-1:137112412989:amazon-linux-2-ami-updates"
#  protocol                = "https"
#  endpoint                = "https://api.marbot.io/${var.stage}/endpoint/${var.endpoint_id}"
#  endpoint_auto_confirms  = true
#  delivery_policy = <<JSON
#{
#  "healthyRetryPolicy": {
#    "minDelayTarget": 1,
#    "maxDelayTarget": 60,
#    "numRetries": 100,
#    "numNoDelayRetries": 0,
#    "backoffFunction": "exponential"
#  },
#  "throttlePolicy": {
#    "maxReceivesPerSecond": 1
#  }
#}
#JSON
#}

##########################################################################
#                                                                        #
#                                 BUDGET                                 #
#                                                                        #
##########################################################################

resource "aws_budgets_budget" "cost" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = (data.aws_region.current.name == "us-east-1" && var.budget_threshold >= 0) ? 1 : 0

  budget_type       = "COST"
  limit_amount      = var.budget_threshold
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2019-01-01_12:00"
  cost_filters      = {
    LinkedAccount   = data.aws_caller_identity.current.account_id
  }

  cost_types {
    include_credit             = false
    include_discount           = true
    include_other_subscription = false
    include_recurring          = false
    include_refund             = false
    include_subscription       = true
    include_support            = false
    include_tax                = false
    include_upfront            = false
    use_amortized              = false
    use_blended                = false
  }

  notification {
    comparison_operator       = "GREATER_THAN"
    threshold                 = 100
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_sns_topic_arns = [aws_sns_topic.marbot.arn]
  }

  notification {
    comparison_operator       = "GREATER_THAN"
    threshold                 = 100
    threshold_type            = "PERCENTAGE"
    notification_type         = "FORECASTED"
    subscriber_sns_topic_arns = [aws_sns_topic.marbot.arn]
  }
}

##########################################################################
#                                                                        #
#                                 EVENTS                                 #
#                                                                        #
##########################################################################

resource "aws_cloudwatch_event_rule" "root_user_login" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.root_user_login ? 1 : 0

  description   = "A root user login was detected, better use IAM users instead (created by marbot)."
  event_pattern = <<JSON
{
  "detail-type": [
    "AWS Console Sign In via CloudTrail"
  ],
  "detail": {
    "userIdentity": {
      "arn": [
        "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "root_user_login" {
  count = var.root_user_login ? 1 : 0

  rule      = aws_cloudwatch_event_rule.root_user_login[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "cloud_watch_alarm_fired" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.cloud_watch_alarm_fired ? 1 : 0

  description   = "A CloudWatch Alarm fired (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.cloudwatch"
  ],
  "detail-type": [
    "CloudWatch Alarm State Change"
  ],
  "detail": {
    "state": {
      "value": [
        "ALARM"
      ]
    }
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "cloud_watch_alarm_fired" {
  count = var.cloud_watch_alarm_fired ? 1 : 0

  rule      = aws_cloudwatch_event_rule.cloud_watch_alarm_fired[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "cloud_watch_alarm_orphaned" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.cloud_watch_alarm_orphaned ? 1 : 0

  description   = "A CloudWatch Alarm orphaned (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.cloudwatch"
  ],
  "detail-type": [
    "CloudWatch Alarm State Change"
  ],
  "detail": {
    "state": {
      "value": [
        "INSUFFICIENT_DATA"
      ]
    }
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "cloud_watch_alarm_orphaned" {
  count = var.cloud_watch_alarm_orphaned ? 1 : 0

  rule      = aws_cloudwatch_event_rule.cloud_watch_alarm_orphaned[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "cloud_watch_alarm_auto_close" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.cloud_watch_alarm_auto_close ? 1 : 0

  description   = "A CloudWatch Alarm could be auto-closed (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.cloudwatch"
  ],
  "detail-type": [
    "CloudWatch Alarm State Change"
  ],
  "detail": {
    "state": {
      "value": [
        "OK"
      ]
    }
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "cloud_watch_alarm_auto_close" {
  count = var.cloud_watch_alarm_auto_close ? 1 : 0

  rule      = aws_cloudwatch_event_rule.cloud_watch_alarm_auto_close[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "batch_failed" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.batch_failed ? 1 : 0

  description   = "A Batch job failed (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.batch"
  ],
  "detail-type": [
    "Batch Job State Change"
  ],
  "detail": {
    "status": [
      "FAILED"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "batch_failed" {
  count = var.batch_failed ? 1 : 0

  rule      = aws_cloudwatch_event_rule.batch_failed[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "code_pipeline_failed" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.code_pipeline_failed ? 1 : 0

  description   = "A CodePipeline execution failed (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.codepipeline"
  ],
  "detail-type": [
    "CodePipeline Pipeline Execution State Change"
  ],
  "detail": {
    "state": [
      "FAILED"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "code_pipeline_failed" {
  count = var.code_pipeline_failed ? 1 : 0

  rule      = aws_cloudwatch_event_rule.code_pipeline_failed[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "code_pipeline_notifications" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.code_pipeline_notifications ? 1 : 0

  description   = "CodePipeline notifications (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.codepipeline"
  ],
  "detail-type": [
    "CodePipeline Pipeline Execution State Change"
  ],
  "detail": {
    "state": [
      "SUCCEEDED"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "code_pipeline_notifications" {
  count = var.code_pipeline_notifications ? 1 : 0

  rule      = aws_cloudwatch_event_rule.code_pipeline_notifications[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "code_build_failed" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.code_build_failed ? 1 : 0

  description   = "A CodeBuild build failed (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.codebuild"
  ],
  "detail-type": [
    "CodeBuild Build State Change"
  ],
  "detail": {
    "build-status": [
      "FAILED"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "code_build_failed" {
  count = var.code_build_failed ? 1 : 0

  rule      = aws_cloudwatch_event_rule.code_build_failed[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "code_deploy_failed" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.code_deploy_failed ? 1 : 0

  description   = "A CodeDeploy deployment or instance failed (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.codedeploy"
  ],
  "detail-type": [
    "CodeDeploy Deployment State-change Notification",
    "CodeDeploy Instance State-change Notification"
  ],
  "detail": {
    "state": [
      "FAILURE"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "code_deploy_failed" {
  count = var.code_deploy_failed ? 1 : 0

  rule      = aws_cloudwatch_event_rule.code_deploy_failed[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "health_issue" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.health_issue ? 1 : 0

  description   = "AWS is experiencing events that may impact you (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.health"
  ],
  "detail-type": [
    "AWS Health Event"
  ],
  "detail": {
    "eventTypeCategory": [
      "issue",
      "scheduledChange"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "health_issue" {
  count = var.health_issue ? 1 : 0

  rule      = aws_cloudwatch_event_rule.health_issue[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "auto_scaling_failed" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.auto_scaling_failed ? 1 : 0

  description   = "EC2 Instances controlled by an Auto Scaling Group failed to launch or terminate (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.autoscaling"
  ],
  "detail-type": [
    "EC2 Instance Launch Unsuccessful",
    "EC2 Instance Terminate Unsuccessful"
  ]
}
JSON
}

resource "aws_cloudwatch_event_target" "auto_scaling_failed" {
  count = var.auto_scaling_failed ? 1 : 0

  rule      = aws_cloudwatch_event_rule.auto_scaling_failed[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "guard_duty_finding" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.guard_duty_finding ? 1 : 0

  description   = "Findings from AWS GuardDuty (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.guardduty"
  ],
  "detail-type": [
    "GuardDuty Finding"
  ]
}
JSON
}

resource "aws_cloudwatch_event_target" "guard_duty_finding" {
  count = var.guard_duty_finding ? 1 : 0

  rule      = aws_cloudwatch_event_rule.guard_duty_finding[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "emr_failed" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.emr_failed ? 1 : 0

  description   = "EMR step or auto scaling policy failed (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.emr"
  ],
  "detail-type": [
    "EMR Auto Scaling Policy State Change",
    "EMR Step Status Change"
  ],
  "detail": {
    "state": [
      "FAILED"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "emr_failed" {
  count = var.emr_failed ? 1 : 0

  rule      = aws_cloudwatch_event_rule.emr_failed[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "ebs_failed" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.ebs_failed ? 1 : 0

  description   = "EBS snapshot failed (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.ec2"
  ],
  "detail-type": [
    "EBS Snapshot Notification",
    "EBS Multi-Volume Snapshots Completion Status"
  ],
  "detail": {
    "result": [
      "failed"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "ebs_failed" {
  count = var.ebs_failed ? 1 : 0

  rule      = aws_cloudwatch_event_rule.ebs_failed[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "ssm_failed" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.ssm_failed ? 1 : 0

  description   = "SSM maintenance window execution failed (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.ssm"
  ],
  "detail-type": [
    "Maintenance Window Execution State-change Notification"
  ],
  "detail": {
    "status": [
      "FAILED",
      "TIMED_OUT"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "ssm_failed" {
  count = var.ssm_failed ? 1 : 0

  rule      = aws_cloudwatch_event_rule.ssm_failed[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_db_event_subscription" "rds_instance_issue" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.rds_issue ? 1 : 0

  sns_topic   = aws_sns_topic.marbot.arn
  source_type = "db-instance"
}



resource "aws_db_event_subscription" "rds_cluster_issue" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.rds_issue ? 1 : 0

  sns_topic   = aws_sns_topic.marbot.arn
  source_type = "db-cluster"
}



resource "aws_cloudwatch_event_rule" "glue_job_failed" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.glue_job_failed ? 1 : 0

  description   = "Glue job failed (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.glue"
  ],
  "detail-type": [
    "Glue Job State Change"
  ],
  "detail": {
    "state": [
      "FAILED",
      "TIMEOUT"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "glue_job_failed" {
  count = var.glue_job_failed ? 1 : 0

  rule      = aws_cloudwatch_event_rule.glue_job_failed[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "ec2_spot_instance_interruption" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.ec2_spot_instance_interruption ? 1 : 0

  description   = "EC2 Spot Instance interrupted (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.ec2"
  ],
  "detail-type": [
    "EC2 Spot Instance Interruption Warning"
  ]
}
JSON
}

resource "aws_cloudwatch_event_target" "ec2_spot_instance_interruption" {
  count = var.ec2_spot_instance_interruption ? 1 : 0

  rule      = aws_cloudwatch_event_rule.ec2_spot_instance_interruption[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "ecs_service_failed" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.ecs_service_failed ? 1 : 0

  description   = "ECS Service failed (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.ec2"
  ],
  "detail-type": [
    "ECS Service Action"
  ],
  "detail": {
    "eventType": [
      "ERROR",
      "WARN"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "ecs_service_failed" {
  count = var.ecs_service_failed ? 1 : 0

  rule      = aws_cloudwatch_event_rule.ecs_service_failed[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "macie_alert" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.macie_alert ? 1 : 0

  description = "Alerts from AWS Macie (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.macie"
  ],
  "detail-type": [
    "Macie Alert"
  ]
}
JSON
}

resource "aws_cloudwatch_event_target" "macie_alert" {
  count = var.macie_alert ? 1 : 0

  rule      = aws_cloudwatch_event_rule.macie_alert[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "security_hub_finding" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.security_hub_finding ? 1 : 0

  description   = "Findings from AWS SecurityHub (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.securityhub"
  ],
  "detail-type": [
    "Security Hub Findings - Imported"
  ]
}
JSON
}

resource "aws_cloudwatch_event_target" "security_hub_finding" {
  count = var.security_hub_finding ? 1 : 0

  rule      = aws_cloudwatch_event_rule.security_hub_finding[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "ops_works_deployment_failed" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.ops_works_deployment_failed ? 1 : 0

  description   = "An OpsWorks deployment failed (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.opsworks"
  ],
  "detail-type": [
    "OpsWorks Deployment State Change"
  ],
  "detail": {
    "status": [
      "failed"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "ops_works_deployment_failed" {
  count = var.ops_works_deployment_failed ? 1 : 0

  rule      = aws_cloudwatch_event_rule.ops_works_deployment_failed[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "ops_works_command_failed" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.ops_works_command_failed ? 1 : 0

  description   = "An OpsWorks command failed (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.opsworks"
  ],
  "detail-type": [
    "OpsWorks Command State Change"
  ],
  "detail": {
    "status": [
      "failed",
      "expired",
      "skipped"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "ops_works_command_failed" {
  count = var.ops_works_command_failed ? 1 : 0

  rule      = aws_cloudwatch_event_rule.ops_works_command_failed[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "ops_works_instance_failed" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.ops_works_instance_failed ? 1 : 0

  description   = "An OpsWorks instance failed (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.opsworks"
  ],
  "detail-type": [
    "OpsWorks Instance State Change"
  ],
  "detail": {
    "status": [
      "connection_lost",
      "setup_failed",
      "start_failed",
      "stop_failed"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "ops_works_instance_failed" {
  count = var.ops_works_instance_failed ? 1 : 0

  rule      = aws_cloudwatch_event_rule.ops_works_instance_failed[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "ops_works_alert" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.ops_works_alert ? 1 : 0

  description   = "Alerts from AWS OpsWorks (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.opsworks"
  ],
  "detail-type": [
    "OpsWorks Alert"
  ]
}
JSON
}

resource "aws_cloudwatch_event_target" "ops_works_alert" {
  count = var.ops_works_alert ? 1 : 0

  rule      = aws_cloudwatch_event_rule.ops_works_alert[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "ecr_image_scan_finding" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.ecr_image_scan_finding ? 1 : 0

  description   = "Findings from AWS ECR Image Scans (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.ecr"
  ],
  "detail-type": [
    "ECR Image Scan"
  ],
  "detail": {
    "finding-severity-counts": {
      "CRITICAL": [{"exists": false}, {"numeric": [">", 0]}],
      "HIGH": [{"exists": false}, {"numeric": [">", 0]}],
      "MEDIUM": [{"exists": false}, {"numeric": [">", 0]}],
      "UNDEFINED": [{"exists": false}, {"numeric": [">", 0]}]
    }
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "ecr_image_scan_finding" {
  count = var.ecr_image_scan_finding ? 1 : 0

  rule      = aws_cloudwatch_event_rule.ecr_image_scan_finding[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "dlm_policy_alert" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.dlm_policy_alert ? 1 : 0

  description   = "Alerts from Amazon Data Lifecycle Manager (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.dlm"
  ],
  "detail-type": [
    "DLM Policy State Change"
  ],
  "detail": {
    "state": [
      "ERROR"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "dlm_policy_alert" {
  count = var.dlm_policy_alert ? 1 : 0

  rule      = aws_cloudwatch_event_rule.dlm_policy_alert[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}



resource "aws_cloudwatch_event_rule" "iot_analytics_dataset_alert" {
  depends_on = [aws_sns_topic_subscription.marbot]
  count      = var.iot_analytics_dataset_alert ? 1 : 0

  description   = "Alerts from IoT Analytics dataset (created by marbot)."
  event_pattern = <<JSON
{
  "source": [ 
    "aws.iotanalytics"
  ],
  "detail-type": [
    "IoT Analytics Dataset Lifecycle Notification"
  ],
  "detail": {
    "state": [
      "CONTENT_DELIVERY_FAILED"
    ]
  }
}
JSON
}

resource "aws_cloudwatch_event_target" "iot_analytics_dataset_alert" {
  count = var.iot_analytics_dataset_alert ? 1 : 0

  rule      = aws_cloudwatch_event_rule.iot_analytics_dataset_alert[0].name
  target_id = "marbot"
  arn       = aws_sns_topic.marbot.arn
}

##########################################################################
#                                                                        #
#                                  TEST                                  #
#                                                                        #
##########################################################################

# not possible with Terraform

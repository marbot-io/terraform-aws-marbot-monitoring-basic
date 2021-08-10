variable "endpoint_id" {
  type        = string
  description = "Your marbot endpoint ID (to get this value: select a channel where marbot belongs to and send a message like this: \"@marbot show me my endpoint id\")."
}

variable "enabled" {
  type        = bool
  description = "Turn the module on or off"
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "budget_threshold" {
  type        = number
  description = "Receive an alert, if your monthly AWS costs (in USD) are higher than this value (works in us-east-1 only; set to -1 to disable)."
  default     = -1
}

variable "savings_plans_coverage_threshold" {
  type        = number
  description = "Receive an alert, if your monthly Savings Plans coverage (in percents) is lower than this value (works in us-east-1 only; set to -1 to disable)."
  default     = -1
}

variable "savings_plans_utilization_threshold" {
  type        = number
  description = "Receive an alert, if your monthly Savings Plans utilization (in percents) is lower than this value (works in us-east-1 only; set to -1 to disable)."
  default     = -1
}

variable "trusted_advisor" {
  type        = bool
  description = "Receive an alert, if any Trusted Advisor check turns red (works in us-east-1 only; requires AWS Business Support or higher)."
  default     = true
}

variable "root_user_login" {
  type        = bool
  description = "Receive an alert, if a root user login is performed."
  default     = true
}

variable "cloud_watch_alarm_fired" {
  type        = bool
  description = "Receive an alert, if any CloudWatch Alarm fires (state ALARM; instead of defining actions for each alarm)."
  default     = true
}

variable "cloud_watch_alarm_orphaned" {
  type        = bool
  description = "Receive an alert, if any CloudWatch Alarm does not receive any data (state INSUFFICIENT_DATA; instead of defining actions for each alarm)."
  default     = false
}

variable "cloud_watch_alarm_auto_close" {
  type        = bool
  description = "Auto-Close an alert, if any CloudWatch Alarm fires (state OK; instead of defining actions for each alarm)."
  default     = false
}

variable "batch_failed" {
  type        = bool
  description = "Receive an alert, if any Batch job fails."
  default     = true
}

variable "code_pipeline_failed" {
  type        = bool
  description = "Receive an alert, if any CodePipeline execution fails."
  default     = true
}

variable "code_build_failed" {
  type        = bool
  description = "Receive an alert, if any CodeBuild build fails."
  default     = true
}

variable "code_deploy_failed" {
  type        = bool
  description = "Receive an alert, if any CodeDeploy deployment fails."
  default     = true
}

variable "health_issue" {
  type        = bool
  description = "Receive an alert, if AWS is experiencing events that may impact you."
  default     = true
}

variable "auto_scaling_failed" {
  type        = bool
  description = "Receive an alert, if any EC2 instance fails to start or terminate in an Auto Scaling Group."
  default     = true
}

variable "guard_duty_finding" {
  type        = bool
  description = "Receive an alert, if a GuardDuty finding is created."
  default     = true
}

variable "emr_failed" {
  type        = bool
  description = "Receive an alert, if any EMR step or auto scaling policy fails."
  default     = true
}

variable "ebs_failed" {
  type        = bool
  description = "Receive an alert, if any EBS snapshot fails."
  default     = true
}

variable "ssm_failed" {
  type        = bool
  description = "Receive an alert, if any SSM maintenance window execution fails."
  default     = true
}

variable "rds_issue" {
  type        = bool
  description = "Receive an alert, if any RDS issue is detected."
  default     = true
}

variable "glue_job_failed" {
  type        = bool
  description = "Receive an alert, if any Glue job fails."
  default     = true
}

variable "ec2_spot_instance_interruption" {
  type        = bool
  description = "Receive an alert, if any EC2 Spot instance is interrupted."
  default     = true
}

variable "ecs_service_failed" {
  type        = bool
  description = "Receive an alert, if any ECS service fails."
  default     = true
}

variable "macie_alert" {
  type        = bool
  description = "Receive an alert, if Macie fires an alert."
  default     = true
}

variable "security_hub_finding" {
  type        = bool
  description = "Receive an alert, if a SecurityHub finding is created."
  default     = true
}

variable "security_hub_insight" {
  type        = bool
  description = "Receive an alert, if a SecurityHub insight is created."
  default     = true
}

variable "ops_works_deployment_failed" {
  type        = bool
  description = "Receive an alert, if an OpsWorks deployment fails."
  default     = true
}

variable "ops_works_command_failed" {
  type        = bool
  description = "Receive an alert, if an OpsWorks command fails."
  default     = true
}

variable "ops_works_instance_failed" {
  type        = bool
  description = "Receive an alert, if an OpsWorks instance fails."
  default     = true
}

variable "ops_works_alert" {
  type        = bool
  description = "Receive an alert, if OpsWorks fires an alert."
  default     = true
}

variable "ecr_image_scan_finding" {
  type        = bool
  description = "Receive an alert, if a ECR Image Scan finding of severity MEDIUM, HIGH, or CRITICAL is created."
  default     = true
}

variable "dlm_policy_alert" {
  type        = bool
  description = "Receive an alert, if a DLM policy fires an alert."
  default     = true
}

variable "iot_analytics_dataset_alert" {
  type        = bool
  description = "Receive an alert, if an IoT Analytics dataset fires an alert."
  default     = true
}

variable "es_software_update_failed" {
  type        = bool
  description = "Receive an alert, if an ES software update fails."
  default     = true
}

variable "backup_failed" {
  type        = bool
  description = "Receive an alert, if AWS Backup fails."
  default     = true
}

variable "athena_failed" {
  type        = bool
  description = "Receive an alert, if Athena fails."
  default     = true
}

variable "app_flow_failed" {
  type        = bool
  description = "Receive an alert, if AppFlow fails."
  default     = true
}

variable "ec2_fleet_failed" {
  type        = bool
  description = "Receive an alert, if EC2 (Spot) Fleet fails"
  default     = true
}

variable "code_pipeline_notifications" {
  type        = bool
  description = "Receive a notification, if a CodePipeline pipeline succeedes."
  default     = true
}

variable "code_commit_pull_request_notifications" {
  type        = bool
  description = "Receive a notification, if a CodeCommit pull request changes."
  default     = true
}

variable "ami_update_notification_ecs_optimized" {
  type        = bool
  description = "Receive a notification, if a new ECS optimized AMI is released (works in us-east-1 only)."
  default     = false
}

variable "ami_update_notification_amazon_linux" {
  type        = bool
  description = "Receive a notification, if a new Amazon Linux AMI is released (works in us-east-1 only)."
  default     = false
}

variable "ami_update_notification_amazon_linux2" {
  type        = bool
  description = "Receive a notification, if a new Amazon Linux 2 AMI is released (works in us-east-1 only)."
  default     = true
}

variable "acm_certificate_approaching_expiration" {
  type        = bool
  description = "Receive a notification, if an ACM certificate approaches expiration."
  default     = true
}

variable "es_software_update_notifications" {
  type        = bool
  description = "Receive notifications about ES software updates."
  default     = true
}

variable "application_auto_scaling_notifications" {
  type        = bool
  description = "Receive notifications about Application Auto Scaling Scaling Activities."
  default     = true
}

variable "backup_notifications" {
  type        = bool
  description = "Receive notifications about AWS Backup activities."
  default     = true
}

variable "stage" {
  type        = string
  description = "marbot stage (never change this!)."
  default     = "v1"
}

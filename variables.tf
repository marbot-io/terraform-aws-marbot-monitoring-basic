variable "endpoint_id" {
  type        = string
  description = "Your marbot endpoint ID (to get this value: select a Slack channel where marbot belongs to and send a message like this: \"@marbot show me my endpoint id\")."
}

variable "stage" {
  type        = string
  description = "marbot stage (never change this!)."
  default     = "v1"
}

variable "test" {
  type        = bool
  description = "Send a single test alert."
  default     = true
}

variable "budget_threshold" {
  type        = number
  description = "Receive an alert, if your monthly AWS costs (in USD) are higher than this value (set to -1 to disable; works in us-east-1 only)."
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
  default     = false
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

variable "code_pipeline_notifications" {
  type        = bool
  description = "Receive a notification, if a CodePipeline pipeline succeedes."
  default     = true
}

variable "ami_update_notification_ecs_optimized" {
  type        = bool
  description = "Receive an alert, if a new ECS optimized AMI is released (works in us-east-1 only)."
  default     = false
}

variable "ami_update_notification_amazon_linux" {
  type        = bool
  description = "Receive an alert, if a new Amazon Linux AMI is released (works in us-east-1 only)."
  default     = false
}

variable "ami_update_notification_amazon_linux2" {
  type        = bool
  description = "Receive an alert, if a new Amazon Linux 2 AMI is released (works in us-east-1 only)."
  default     = true
}

variable "endpoint_id" {
  type        = string
  description = "Your marbot endpoint ID (to get this value: select a channel where marbot belongs to and send a message like this: \"@marbot show me my endpoint id\")."
}

variable "enabled" {
  type        = bool
  description = "Turn the module on or off"
  default     = true
}

variable "module_version_monitoring_enabled" {
  type        = bool
  description = "Report the module version back to marbot to notify if updates are available."
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "permissions_boundary_policy_arn" {
  description = "IAM policy ARN used as a permission boundary for all created IAM roles."
  type        = string
  default     = ""
}

variable "budget" {
  type        = string
  description = "Monthly cost budget (static|auto_adjust|off)."
  default     = "static"
}

variable "budget_threshold" {
  type        = number
  description = "Receive an alert, if your monthly AWS costs (in USD) are higher than this value (works in us-east-1 only; set to -1 to disable static budget)."
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
  description = "Receive an alert, if a root user login is performed (works in us-east-1 only)."
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

variable "ssm_failed" { # should be called ssm_maintenance_window_Failed, but was not changed for backward compatibility
  type        = bool
  description = "Receive an alert, if any SSM Maintenance Window execution fails."
  default     = true
}

variable "ssm_automation_failed" {
  type        = bool
  description = "Receive an alert, if any SSM Automation execution fails."
  default     = true
}

variable "ssm_configuration_compliance_failed" {
  type        = bool
  description = "Receive an alert, if any SSM Configuration Compliance check fails."
  default     = true
}

variable "ssm_command_failed" {
  type        = bool
  description = "Receive an alert, if any SSM Command execution fails."
  default     = true
}

variable "ssm_state_manager_failed" {
  type        = bool
  description = "Receive an alert, if any SSM State Manager association fails."
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
  description = "Receive a notification, if any EC2 Spot instance is interrupted."
  default     = true
}

variable "ecs_task_failed" {
  type        = bool
  description = "Receive an alert, if any ECS task fails."
  default     = true
}

variable "ecs_service_failed" {
  type        = bool
  description = "Receive an alert, if any ECS service fails."
  default     = true
}

variable "ecs_deployment_failed" {
  type        = bool
  description = "Receive an alert, if any ECS deployment fails."
  default     = true
}

variable "ecs_spot_interruption" {
  type        = bool
  description = "Receive an alert, if an ECS Fargate Spot task gets interrupted or fails to launch."
  default     = true
}

variable "macie_finding" {
  type        = bool
  description = "Receive an alert, if Macie generates a new finding."
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
  description = "Receive an alert, if an Elasticsearch/OpenSearch software update fails."
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

variable "xray_insight_update" {
  type        = bool
  description = "Receive an alert, if X-Ray Insight detects a fault."
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

variable "acm_certificate_approaching_expiration" {
  type        = bool
  description = "Receive a notification, if an ACM certificate approaches expiration."
  default     = true
}

variable "es_software_update_notifications" {
  type        = bool
  description = "Receive notifications about Elasticsearch/OpenSearch software updates."
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

variable "ecs_deployment_notifications" {
  type        = bool
  description = "Receive notifications when AWS deployments succeed."
  default     = true
}

variable "elastic_beanstalk_failed" {
  type        = bool
  description = "Receive an alert, if Elastic Beanstalk fails."
  default     = true
}

variable "inspector2_finding" {
  type        = bool
  description = "Receive an alert, if an Inspector2 finding is created."
  default     = true
}

variable "internetmonitoring_health" {
  type        = bool
  description = "Receive an alert, if a CloudWatch Internet Monitor health event is created."
  default     = true
}

variable "stage" {
  type        = string
  description = "marbot stage (never change this!)."
  default     = "v1"
}

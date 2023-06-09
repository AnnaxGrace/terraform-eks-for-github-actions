resource "aws_cloudwatch_log_group" "cloudwatch_logs_POC" {
  name              = var.cloudwatch_log_group_name
  retention_in_days = var.cloudwatch_log_retention_days

  tags = merge(
    {
        "Name" = format("%s", var.cloudwatch_log_group_name)
    },
    var.app_tags,
    local.module_tags
  )
}


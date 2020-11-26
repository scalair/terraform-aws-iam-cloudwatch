module "iam_user" {
  source  = "github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-user"
  version = "~> 2.0"

  name          = var.iam_user_name
  pgp_key       = var.iam_user_pgp_key
  force_destroy = var.iam_user_force_destroy

  tags = var.tags
}

resource "aws_iam_policy" "policy" {
  name   = var.aws_iam_policy_name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowReadingMetricsFromCloudWatch",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:DescribeAlarmsForMetric",
                "cloudwatch:ListMetrics",
                "cloudwatch:GetMetricStatistics",
                "cloudwatch:GetMetricData"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowReadingTagsInstancesRegionsFromEC2",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeTags",
                "ec2:DescribeInstances",
                "ec2:DescribeRegions"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowReadingResourcesForTags",
            "Effect" : "Allow",
            "Action" : "tag:GetResources",
            "Resource" : "*"
        }
    ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "cloudwatch" {
  user       = module.iam_user.this_iam_user_name
  policy_arn = aws_iam_policy.policy.arn
}

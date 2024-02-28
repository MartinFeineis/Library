resource "aws_iam_policy" "lambda_send_policy" {
  name   = "LambdaSendPolicy"
  policy = file(join("/", ["${path.module}", "lambdaPolicy.json"]))
  tags = {
    Project = "ApiGateWay"
    Task    = path.module
  }
}

resource "aws_iam_role" "lambda_send_role" {
  name                = "LambdaSendRole"
  assume_role_policy  = file(join("/", ["${path.module}", "lambdaRole.json"]))
  managed_policy_arns = [aws_iam_policy.lambda_send_policy.arn, "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole", "arn:aws:iam::aws:policy/AmazonElasticFileSystemClientFullAccess"]
  tags = {
    Project = "ApiGateWay"
    Task    = path.module
  }
}

resource "aws_ssm_parameter" "msg_counter" {
  name  = "msg_counter"
  type  = "String"
  value = "500"
}

data "archive_file" "lambda_send_zip" {
  type        = "zip"
  source_dir  = join("/", ["${path.module}", "send_code"])
  output_path = join("/", ["${path.module}", "send_code.zip"])
}

resource "aws_s3_object" "send_package" {
  key    = join("/", ["${path.module}", "send_code.zip"])
  bucket = var.codebucket
  source = join("/", ["${path.module}", "send_code.zip"])
  #etag   = filemd5(join("/", ["${path.module}", "send_code.zip"]))
}

resource "aws_lambda_function" "lambda_send_function" {
  depends_on       = [aws_s3_object.send_package, aws_efs_mount_target.alpha]
  s3_key           = join("/", ["${path.module}", "send_code.zip"])
  s3_bucket        = var.codebucket
  function_name    = "send_message"
  role             = aws_iam_role.lambda_send_role.arn
  description      = "Sending and storing messages"
  handler          = "main.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.lambda_send_zip.output_base64sha256
  file_system_config {
    # EFS file system access point ARN
    arn = aws_efs_access_point.access_point_for_lambda.arn

    # Local mount path inside the lambda function. Must start with '/mnt/'.
    local_mount_path = "/mnt/efs"
  }

  vpc_config {
    # Every subnet should be able to reach an EFS mount target in the same Availability Zone. Cross-AZ mounts are not permitted.
    subnet_ids         = [aws_subnet.send_efs_sn_1.id]
    security_group_ids = [aws_security_group.sg_lambda_efs.id]
  }
  tags = {
    Project = "ApiGateWay"
    Task    = path.module
  }
}

resource "aws_vpc" "send_efs_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Project = "ApiGateWay"
    Name    = "VPC for Efs for Lambda"
    Task    = path.module
  }
}

resource "aws_vpc_endpoint" "vpce_ddb" {
  vpc_id       = aws_vpc.send_efs_vpc.id
  service_name = "com.amazonaws.us-east-1.dynamodb"
}

resource "aws_vpc_endpoint" "vpce_sqs" {
  vpc_id            = aws_vpc.send_efs_vpc.id
  service_name      = "com.amazonaws.us-east-1.sqs"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.sg_lambda_efs.id,
  ]

  subnet_ids          = [aws_subnet.send_efs_sn_1.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint_route_table_association" "private-dynamodb" {
  vpc_endpoint_id = aws_vpc_endpoint.vpce_ddb.id
  route_table_id  = aws_vpc.send_efs_vpc.main_route_table_id
}

resource "aws_subnet" "send_efs_sn_1" {
  vpc_id     = aws_vpc.send_efs_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Project = "ApiGateWay"
    Task    = path.module
    Name    = "First Subnet for Efs for Lambda"
  }
}

resource "aws_security_group" "sg_lambda_efs" {
  name        = "efs_lambda"
  description = "SG for Lambda with EFS"
  vpc_id      = aws_vpc.send_efs_vpc.id

  ingress {
    description = "efs for Lambda"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    self        = true
  }
  ingress {
    description = "sqs for Lambda"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Project = "ApiGateWay"
    Task    = path.module
    Name    = "allow_tls"
  }
}

# EFS file system
resource "aws_efs_file_system" "send_efs_lambda" {
  tags = {
    Project = "ApiGateWay"
    Task    = path.module
    Name    = "efs_for_lambda"
  }
}

# Mount target connects the file system to the subnet
resource "aws_efs_mount_target" "alpha" {
  file_system_id  = aws_efs_file_system.send_efs_lambda.id
  subnet_id       = aws_subnet.send_efs_sn_1.id
  security_groups = [aws_security_group.sg_lambda_efs.id]
}

# EFS access point used by lambda file system
resource "aws_efs_access_point" "access_point_for_lambda" {
  file_system_id = aws_efs_file_system.send_efs_lambda.id

  root_directory {
    path = "/lambda"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "777"
    }
  }

  posix_user {
    gid = 1000
    uid = 1000
  }
}

output "send_lambda_arn" {
  value = aws_lambda_function.lambda_send_function.arn
}
output "send_invoke" {
  value = aws_lambda_function.lambda_send_function.invoke_arn
}
output "send_function_name" {
  value = aws_lambda_function.lambda_send_function.function_name
}
output "vpce_sqs_outs" {
  value = aws_vpc_endpoint.vpce_sqs.*
}

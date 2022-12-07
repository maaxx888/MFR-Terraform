#Iam role
resource "aws_iam_role" "lambda-1" {  #lambda_role
  name = "lambda-1"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

#log policy
resource "aws_iam_policy" "lambda-policy-1" { #iam_policy_for_lambda
  name = "lambda-policy-1"
  path = "/"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Action": [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
          ],
          "Resource": "arn:aws:logs:*:*:*",
          "Effect": "Allow"
      }
  ]
}
EOF
}

#policy attachment for role
resource "aws_iam_role_policy_attachment" "Policy-attachment-1" { #attach_iam_policiy_to_iam_role
  role = aws_iam_role.lambda-1.name
  policy_arn = aws_iam_policy.lambda-policy-1.arn
}

#generate archive from content
data "archive_file" "python-zip" {
  type = "zip"
  source_dir = "${path.module}/python/"
  output_path = "${path.module}/Python/hello.zip"
}

#Lambda function
resource "aws_lambda_function" "lambda-fc-1" {
  filename = "${path.module}/Python/hello.zip"
  function_name = "Lambda-1"
  role = aws_iam_role.lambda-1.arn
  handler = "hello.lambda1"
  runtime = "python3.8"
  depends_on = [aws_iam_role_policy_attachment.Policy-attachment-1]
}
module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "python-test-lambda"
  description   = "A test lambda function"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"

  source_path = "lambda_test"

  tags = {
    owner = "pavlo"
  }
}
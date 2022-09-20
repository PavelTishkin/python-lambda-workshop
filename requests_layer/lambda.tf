module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  create_layer = true

  layer_name = "SharedLayer_requests"
  description   = "Contains code for requests module"
  handler       = "index.lambda_handler"
  compatible_runtimes = ["python3.9"]

  source_path = "requests_layer"
}
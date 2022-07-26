# locals {
#     lambda_zip_location  =   "outputs/getImages.zip"
# }

data "archive_file" "allLambdaFunctions" {
  type        = "zip"
  source_dir  = "lambda_functions/"
  output_path = "outputs/allLambdaFunctions.zip"
}

resource "aws_lambda_function" "getImages" {
  # If the file is not in the current working directory you will need to include a 
  # path.module in the filename.
  filename      = "outputs/allLambdaFunctions.zip"
  function_name = "getImages"
  role          = aws_iam_role.lambda_role.arn
  handler       = "getImages.lambda_handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("outputs/getImages.zip"))}"
  # source_code_hash = filebase64sha256("./outputs/getImages.zip")

  runtime = "python3.7"

  environment {
    variables = {
      bucket_url = "http://djfsbhbsvbsdhvbsd"
    }
  }
}

resource "aws_lambda_function" "getPreassignedURL" {
  # If the file is not in the current working directory you will need to include a 
  # path.module in the filename.
  filename      = "outputs/allLambdaFunctions.zip"
  function_name = "getPreassignedURLs"
  role          = aws_iam_role.lambda_role.arn
  handler       = "getPreassignedURLs.lambda_handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("outputs/getImages.zip"))}"
  # source_code_hash = filebase64sha256("./outputs/getImages.zip")

  runtime = "nodejs12.x"

  environment {
    variables = {
      # bucket_url = "${aws_s3_bucket.images.website_endpoint}"
      bucket_url = "http://abcafjnj"
    }
  }
}

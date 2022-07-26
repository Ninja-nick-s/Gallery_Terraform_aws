resource "aws_api_gateway_rest_api" "serverless_gallery" {
  name  =   "serverless_gallery_gw"
}

resource "aws_api_gateway_resource" "getImages" {
  parent_id     =   aws_api_gateway_rest_api.serverless_gallery.root_resource_id
  path_part     =   "getImages"
  rest_api_id   =   aws_api_gateway_rest_api.serverless_gallery.id
}

resource "aws_api_gateway_resource" "getPreassignedURL" {
  parent_id     =   aws_api_gateway_rest_api.serverless_gallery.root_resource_id
  path_part     =   "getPreassignedURL"
  rest_api_id   =   aws_api_gateway_rest_api.serverless_gallery.id
}

resource "aws_api_gateway_method" "getImages" {
  rest_api_id   =   aws_api_gateway_rest_api.serverless_gallery.id
  resource_id   =   aws_api_gateway_resource.getImages.id
  http_method   =   "GET"
  authorization =   "NONE"
}

resource "aws_api_gateway_method" "getPreassignedURL" {
  rest_api_id   =   aws_api_gateway_rest_api.serverless_gallery.id
  resource_id   =   aws_api_gateway_resource.getPreassignedURL.id
  http_method   =   "GET"
  authorization =   "NONE"
}

resource "aws_api_gateway_integration" "getImages" {
  rest_api_id   =   aws_api_gateway_rest_api.serverless_gallery.id
  resource_id   =   aws_api_gateway_resource.getImages.id
  http_method   =   aws_api_gateway_method.getImages.http_method

  integration_http_method = "GET"
  type          =   "AWS_PROXY"
  uri           =   aws_lambda_function.getImages.invoke_arn
}

resource "aws_api_gateway_integration" "getPreassignedURL" {
  rest_api_id   =   aws_api_gateway_rest_api.serverless_gallery.id
  resource_id   =   aws_api_gateway_resource.getPreassignedURL.id
  http_method   =   aws_api_gateway_method.getPreassignedURL.http_method

  integration_http_method = "GET"
  type          =   "AWS_PROXY"
  uri           =   aws_lambda_function.getPreassignedURL.invoke_arn
}

resource "aws_api_gateway_deployment" "serverless_gallery" {
  depends_on   =   [aws_api_gateway_integration.getImages, aws_api_gateway_integration.getPreassignedURL]
  rest_api_id  =    aws_api_gateway_rest_api.serverless_gallery.id
  stage_name   =    "stage-api"
}

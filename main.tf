module "s3" {
    source  =   "./s3"
}

module "lambda-function" {
    source  =   "./lambdaAPIGateway"
}

# module "APIGateway" {

# }

module "cognito" {
    source  = "./cognito"
}
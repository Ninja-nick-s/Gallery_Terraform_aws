
resource "aws_cognito_user_pool" "pool" {
  name = "gallerypool"
  username_attributes = ["email"]
  auto_verified_attributes = ["email"]
    schema {
        name                     = "name"
        attribute_data_type      = "String"
        required                 = true 
        string_attribute_constraints {   # if it is a string
            min_length = 0                 
            max_length = 2048           
        } 
    }
    schema {
        name                     = "email"
        attribute_data_type      = "String"
        required                 = true 
        string_attribute_constraints {   # if it is a string
            min_length = 0                 
            max_length = 2048             
        }
    }

    verification_message_template {
        default_email_option = "CONFIRM_WITH_LINK"
    }

}

resource "aws_cognito_user_pool_client" "client" {
    user_pool_id = aws_cognito_user_pool.pool.id
    allowed_oauth_flows                  = []
    allowed_oauth_flows_user_pool_client = false
    allowed_oauth_scopes                 = []
    callback_urls                        = []
    prevent_user_existence_errors        = "ENABLED"
    explicit_auth_flows                  = ["ALLOW_USER_SRP_AUTH","ALLOW_REFRESH_TOKEN_AUTH"]
    generate_secret                      = false
    logout_urls                          = []
    name                                 = "gallery_client"
    read_attributes                      = ["email", "name"]
    supported_identity_providers         = []
    write_attributes                     = ["email", "name"]
    refresh_token_validity               = 30
}

resource "aws_cognito_user_pool_domain" "cognito-domain" {
  domain       = "mygallery"
  user_pool_id = aws_cognito_user_pool.pool.id
}


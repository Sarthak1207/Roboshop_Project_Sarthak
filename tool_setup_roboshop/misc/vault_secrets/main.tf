terraform {
    backend "s3" {
        bucket = "roboshop-terraform"
        key = "vault_secrets/terraform.tfstate"
        region = "us-east-1"
    }
}
provider "vault" {
    address = "http://vault-internal.sarthak1207.shop:8200"
    token = var.vault_token
    skip_tls_verify = true
    auth_login {
    #path = "auth/userpass/login/${var.login_username}"

    #parameters = {
    #    password = var.login_password
    #}
  }
}


variable "vault_token" {}


resource "vault_mount" "roboshop-dev" {
  path        = "roboshop-dev"
  type        = "kv"
  options     = { version = "2" }
  description = "RoboShop Dev Secrets"
}

data "vault_generic_secret" "roboshop-dev" {
    path = "$(vault_mount.roboshop-dev.path)/frontend" 
    data_json = <<EOT
{
    "catalogue_url": "https://catalogue-dev..sarthak1207.shop:8200",
    "cart_url": "https://cart-dev..sarthak1207.shop:8200",
    "payment_url": "https://payment-dev..sarthak1207.shop:8200",
    "user_url": "https://user-dev..sarthak1207.shop:8200",
    "shipping_url": "https://shipping-dev..sarthak1207.shop:8200"
}
EOT
}


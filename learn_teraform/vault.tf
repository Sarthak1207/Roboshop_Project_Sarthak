variable login_username {}
variable login_password {}

provider "vault" {
    address = "http://172.31.81.190:8200"
    token = var.token_value
    skip_tls_verify = true
    auth_login {
    path = "auth/userpass/login/${var.login_username}"

    parameters = {
        password = var.login_password
    }
  }
}

variable "token_value" {}

data "vault_generic_secret" "example_creds" {
  path = "example/creds"
}
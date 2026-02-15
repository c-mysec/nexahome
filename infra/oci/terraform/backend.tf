terraform {
  cloud {
    organization = "nexahome"
    workspaces {
      name = "nexahomeinfra"
    }
  }
}
# Notes:
# - Run `terraform login` on your machine or provide the API token via
#   `TF_TOKEN_app_terraform_io` environment variable in CI to allow `terraform init`.
# - This file is intentionally minimal; fill the organization and workspace
#   values before running `terraform init`.

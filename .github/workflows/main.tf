terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.48.0"
    }
  }
}

provider "tfe" {
  token = var.tfe_api_token
  organization = var.tfe_organization
}

variable "tfe_api_token" {
  description = "Terraform Cloud API token"
  type = string
}

variable "tfe_organization" {
  description = "Terraform Cloud organization name"
  type = string
}

resource "tfe_workspace" "tnd-dev-common-aks-workspace" {
  name          = "tnd-dev-common-aks-workspace"
  organization  = var.tfe_organization
  auto_apply    = true
}

data "tfe_workspace" "existing_workspace" {
  name         = "tnd-dev-common-aks-workspace"
  organization = var.tfe_organization
}

output "workspace_id" {
  value = data.tfe_workspace.existing_workspace.id
}

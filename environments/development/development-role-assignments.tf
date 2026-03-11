data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "jenkins_acr_push_dev" {
  scope                = module.acr.acr_id
  role_definition_name = "AcrPush"
  principal_id         = data.terraform_remote_state.shared.outputs.jenkins_principal_id
}

resource "azurerm_role_assignment" "jenkins_vmss_dev" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}"
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = data.terraform_remote_state.shared.outputs.jenkins_principal_id
}
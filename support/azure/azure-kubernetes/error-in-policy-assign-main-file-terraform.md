---
title: Error in policy-assignments main file at Terraform.
description: This article provide information about how to run as non-root user in containers by using the securityContext field.
ms.date: 03/27/2024
ms.reviewer: chiragpa, andbar, haitch, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
# Error in policy-assignments main file at Terraform


## Symptoms

You are getting the error because, in the policy-assignments, main file at terraform 

it is expecting the policy-definition-id, and where the module policyset_definitions is only known after apply.

resource "azurerm_policy_assignment" "kubernetes" {
  name                 = "kubernetes"
  scope                = var.cust_scope
  policy_definition_id = var.kubernetes_policyset_id
  description          = "Assignment of the Kubernetes to subscription."
  display_name         = "Kubernetes-custom-Intiative-test01"
}
 
where it is referring to the policy initiative definition that should refer to the : azurerm_policy_set_definition. And the azurerm_policy_set_definition might be delayed in creating or it could not find the module, before the policy assignment creation.
refer the following documentation for the reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_assignment

Try adding the depends_on on the policy assignment with the policy set definition to make sure that, the assignment file will be created only after the policy set definition is created.

Reference documentation which may help you: Utilizing Terraform Resource Dependencies with Azure Examples | Jeff Brown Tech




The error occurs when the policy assignment references the policy initiative definition, anticipating the policy-definition-id. However, the `azurerm_policy_set_definition` module might be delayed or not found before the policy assignment creation.

The error occurs when the policy assignment references the policy initiative definition, expecting the policy-definition-id. However, the `azurerm_policy_set_definition` module might be delayed or not found before the policy assignmentcreation.

Solution

In your Terraform configuration, include a `depends_on parameter` within the policy assignment resource. This ensures the policy assignment is generated only subsequent to the creation of the policy set definition. For further assistance and examples regarding Terraform resource dependencies with Azure, consult the provided documentation.


[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

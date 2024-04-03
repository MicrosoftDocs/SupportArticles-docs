---
title: Error in policy assignments main.tf file in Terraform.
description: This article provides a solution to an error that you encounter during policy assignments.
ms.date: 03/27/2024
ms.reviewer: chiragpa, andbar, haitch, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
# "Policy definition not found" during policy assignments in Terraform

This article provides a solution to the "Policy definition not found" error that you encounter during policy assignments when you use the Terraform tool.

## Symptoms

When you try to run policy assignments that are configured in the Main.tf file of the Terraform tool, you receive the following "Policy definition not found" error message:

```
resource "azurerm_policy_assignment" "kubernetes" {
  name                 = "kubernetes"
  scope                = var.cust_scope
  policy_definition_id = var.kubernetes_policyset_id
  description          = "Assignment of the Kubernetes to subscription."
  display_name         = "Kubernetes-custom-Initiative-test01"
}
```

## Cause

The error occurs if the policy assignment references the policy initiative definition that's provided for the `policy_definition_id` argument. However, the `azurerm_policy_set_definition` module might be delayed or not found before the policy assignment is created.

## Solution

In your Terraform configuration, include a 'depends_on' parameter within the policy assignment resource, as shown the following example. This value makes sure that the policy assignment is generated only after the creation of the policy set definition. 

```
resource "azurerm_policy_assignment" "kubernetes" {
  name                 = "kubernetes"
  scope                = var.cust_scope
  policy_definition_id = var.kubernetes_policyset_id
  description          = "Assignment of the Kubernetes to subscription."
  display_name         = "Kubernetes-custom-Initiative-test01"
  depends_on = [azurerm_policy_definition.policies]
}
```

For more information, see [the depends_on Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on).

[!INCLUDE [third-party-disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

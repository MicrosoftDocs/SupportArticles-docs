---
title: Error in policy-assignments main.tf file at Terraform.
description: This article provides a solution to an error encountered during policy assignment.
ms.date: 03/27/2024
ms.reviewer: chiragpa, andbar, haitch, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
# "Policy definition not found" during policy-assignments at Terraform

This article provides a solution to the "Policy definition not found" error encountered during policy assignment at Terraform.

## Symptoms

You receive the "policy definition not found " error in the policy-assignments that configured in main.tf file at terraform:

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

The error occurs when the policy assignment references the policy initiative definition  within `policy_definition_id`. However, the `azurerm_policy_set_definition` module might be delayed or not found before the policy assignment creation.

## Solution

In your Terraform configuration, include a 'depends_on' parameter within the policy assignment resource as the following sample. This ensures the policy assignment is generated only subsequent to the creation of the policy set definition. 

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

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

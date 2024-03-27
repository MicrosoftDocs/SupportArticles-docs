---
title: Error in policy-assignments main file at Terraform.
description: This article provide information about how to run as non-root user in containers by using the securityContext field.
ms.date: 03/27/2024
ms.reviewer: chiragpa, andbar, haitch, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
# Error in policy-assignments main file at Terraform


The error occurs when the policy assignment references the policy initiative definition, anticipating the policy-definition-id. However, the `azurerm_policy_set_definition` module might be delayed or not found before the policy assignment creation.

The error occurs when the policy assignment references the policy initiative definition, expecting the policy-definition-id. However, the `azurerm_policy_set_definition` module might be delayed or not found before the policy assignmentcreation.

Solution

In your Terraform configuration, include a `depends_on parameter` within the policy assignment resource. This ensures the policy assignment is generated only subsequent to the creation of the policy set definition. For further assistance and examples regarding Terraform resource dependencies with Azure, consult the provided documentation.


[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

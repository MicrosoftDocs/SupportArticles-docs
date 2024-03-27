---
title: The uninstall operation will delete the base layer for the component
description: Resolves an error that occurs when you try to delete an SLA item for an SLA with multiple solutions in Microsoft Dynamics Customer Service.
ms.reviewer: sdas, ankugupta, v-psuraty
ms.author: mpanduranga
ms.date: 03/14/2024
---
# "The uninstall operation will delete the base layer for the component with ID" error when deleting an SLA item

This article provides a resolution for the "The uninstall operation will delete the base layer for the component with ID \<componentID>" error that occurs when you try to delete a service-level agreement (SLA) item for an SLA that has multiple solutions in Microsoft Dynamics Customer Service.

## Symptoms

When you try to delete an SLA item for an SLA that has both unmanaged and managed solutions, the operation isn't successful because there are other managed layers over the base layer. Additionally, you receive the following error message:

> The uninstall operation will delete the base layer for the component \<component> with id \<componentID>

## Cause

The issue occurs when there are multiple solutions for a single SLA. For example, if SLA 1 is created using solution 1 but upgraded using solution 2 or 3. The issue also occurs when you have both multiple managed and unmanaged solutions for an SLA.

## Resolution

It's recommended to use a single managed solution for SLAs when you upgrade them. Additionally, you shouldn't upgrade an SLA using both unmanaged and managed solutions.

## See also

[Manage solutions with SLAs](/dynamics365/customer-service/administer/manage-solution).

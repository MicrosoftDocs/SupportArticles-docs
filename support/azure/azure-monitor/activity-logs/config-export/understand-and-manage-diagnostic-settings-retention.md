---
title: Understand and Manage Diagnostic Settings Retention
description: Provides guidance for understanding and managing diagnostic settings retention.
ms.date: 07/28/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Understand and manage diagnostic settings retention

When you manage Azure resources, you might experience issues that are related to the transition from diagnostic settings storage retention to Azure Storage lifecycle management. This article provides guidance to handle these issues effectively.

## Common issues and solutions

- **Issue**: Users might notice that templates aren't displayed when they try to verify resources that are affected by the transition from legacy solutions to diagnostic settings.
- **Root cause**: The automatic switch from activity log solutions to diagnostic settings might cause confusion if users don't fully understand diagnostic settings retention.

### Instructions to resolve diagnostic settings issues

1. Determine how resources are affected:
   1. Navigate to the Azure portal > **All Services**.
   1. Select **Resource Manager**.
   1. Select **Deploy**, and then select **Templates** in the left pane.
   1. Check whether any resources are affected by the transition.

2. To determine whether legacy solutions are in use, run the following PowerShell command:

     ```powershell
     $WorkspaceName = Get-AzOperationalInsightsWorkspace
     foreach ($Name in $WorkspaceName) {
         Get-AzOperationalInsightsDataSource -Kind AzureActivityLog -ResourceGroupName $Name.ResourceGroupName -WorkspaceName $Name.Name
     }
     ```

   If no output is returned, legacy solutions aren't in use, and no further action is required.

3. Understand that the transition to diagnostic settings is automatic. If your environment is already using diagnostic settings, no additional steps are necessary.

## References

- [Azure Monitor activity logs](/azure/azure-monitor/platform/activity-log?tabs=powershell#legacy-collection-methods)
- [Azure Storage lifecycle management](/azure/storage/blobs/storage-lifecycle-management-concepts)

[!INCLUDE [azure-help-support](../../../../includes/azure-help-support.md)]

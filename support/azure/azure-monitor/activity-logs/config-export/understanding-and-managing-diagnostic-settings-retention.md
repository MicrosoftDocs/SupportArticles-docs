---
title: Understanding and Managing Diagnostic Settings Retention
description: Provides guidance for understanding and managing diagnostic settings retention.
ms.date: 07/17/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Understanding and managing diagnostic settings retention

When you manage Azure resources, you might experience issues that are related to the transition from diagnostic settings storage retention to Azure Storage lifecycle management. This article provides guidance to handle these issues effectively.

## Common issues and solutions

- **Issue**: Users might notice that templates are not displayed when they try to verify resources that are affected by the transition from legacy solutions to diagnostic settings.
- **Root cause**: The automatic switch from activity log solutions to diagnostic settings might cause confusion if they're not well understood.

### Instructions to resolve diagnostic settings issues

1. **Verify resource effect**:
   - Navigate to the Azure portal > **All Services**.
   - Select **Resource Manager**.
   - Select **Deploy**, and then select **Templates** in the left pane.
   - Check whether any resources are affected by the transition.

2. **Check for legacy solutions**:
   - To determine whether legacy solutions are in use, run the following PowerShell command:
     
     ```powershell
     $WorkspaceName = Get-AzOperationalInsightsWorkspace
     foreach ($Name in $WorkspaceName) {
         Get-AzOperationalInsightsDataSource -Kind AzureActivityLog -ResourceGroupName $Name.ResourceGroupName -WorkspaceName $Name.Name
     }
     ```

   - If no output is returned, legacy solutions are not in use, and no further action is required.

3. **Automatic Transition**:
   - Understand that the transition to diagnostic settings is automatic. If your environment is already using diagnostic settings, no additional steps are necessary.

## References

- [Azure Monitor Activity Logs](https://learn.microsoft.com/azure/azure-monitor/platform/activity-log?tabs=powershell#legacy-collection-methods)
- [Azure Storage Lifecycle Management](https://learn.microsoft.com/azure/storage/blobs/storage-lifecycle-management-concepts)

If the issue persists after you follow these steps, open a support case for further assistance.

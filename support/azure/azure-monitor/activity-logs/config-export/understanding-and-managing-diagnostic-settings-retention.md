---
title: Understanding and Managing Diagnostic Settings Retention
description: Provides guidance on understanding and managing diagnostic settings retention.
ms.date: 07/17/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Understanding and Managing Diagnostic Settings Retention

When managing Azure resources, you might encounter issues related to the transition from diagnostic settings storage retention to Azure Storage lifecycle management. This article provides guidance on how to address these issues effectively.

## Common Issues and Solutions

- **Issue Description**: Users may notice that templates are not displayed when attempting to verify resources affected by the transition from legacy solutions to diagnostic settings.
- **Root Cause**: The automatic switch from activity log solutions to diagnostic settings may cause confusion if not properly understood.

### Step-by-Step Instructions to Resolve Diagnostic Settings Issues

1. **Verify Resource Impact**:
   - Navigate to the Azure portal.
   - Go to **All Services** and select **Resource Manager**.
   - Click on **Deploy** and then **Templates** in the left pane.
   - Confirm if any resources are impacted by the transition.

2. **Check for Legacy Solutions**:
   - Use the following PowerShell command to determine if legacy solutions are in use:
  
    ```powershell
     $WorkspaceName = Get-AzOperationalInsightsWorkspace
     foreach ($Name in $WorkspaceName) {
         Get-AzOperationalInsightsDataSource -Kind AzureActivityLog -ResourceGroupName $Name.ResourceGroupName -WorkspaceName $Name.Name
     }
     ```

   - If no output is returned, legacy solutions are not in use, and no further action is required.

3. **Automatic Transition**:
   - Understand that the transition to diagnostic settings is automatic. If your environment is already using diagnostic settings, no additional steps are necessary.

## Reference

- [Azure Monitor Activity Logs](https://learn.microsoft.com/azure/azure-monitor/platform/activity-log?tabs=powershell#legacy-collection-methods)
- [Azure Storage Lifecycle Management](https://learn.microsoft.com/azure/storage/blobs/storage-lifecycle-management-concepts)

If the issue persists after following the solution steps, please open a support case for further assistance.

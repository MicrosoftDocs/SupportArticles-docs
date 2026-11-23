---
title: Azure VM move fails because resource group has active deployments
description: Troubleshoot Azure VM move failures caused by active deployments in source or destination resource groups. Follow these steps to retry the move successfully.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/04/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine move fails because resource group has active deployments

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to troubleshoot Azure virtual machine (VM) move operations that fail because the source or destination resource group has active deployments. It provides steps to identify active deployments, wait for their completion, cancel or clean up stuck deployments, and retry the move operation.

## Symptoms

A move operation fails and returns an error message that resembles the following example.

```
DeploymentActive: Moving resources failed because resource group 'my-rg' has active deployments.
```

The move can't proceed even though the resource group appears to be available in the portal.

## Cause

Azure Resource Manager (ARM) blocks move operations if the resource group has active or recently active deployments. This condition includes the following types of deployments:

- Template deployments (ARM templates, Bicep)
- Infrastructure-as-code deployments (Terraform, Pulumi)
- Azure DevOps pipelines
- Azure CLI or Azure PowerShell deployment scripts still running
- Failed deployments that don't fully clean up their state

The lock persists until the deployment operation fully finishes or is canceled at the platform level.

## Resolution

### Step 1: Check for active deployments

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to check for active deployments in the source or destination resource group.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Resource groups** and select the resource group.
1. Select **Deployments** in the left menu.
1. Look for any deployment with a status other than **Succeeded** or **Failed**.

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

# [Azure PowerShell](#tab/powershell)

Run this command.

```azurepowershell
Get-AzResourceGroupDeployment -ResourceGroupName "<rg-name>" -ErrorAction SilentlyContinue |
  Where-Object { $_.ProvisioningState -ne "Succeeded" -and $_.ProvisioningState -ne "Failed" } |
  Select-Object DeploymentName, ProvisioningState, Timestamp
```

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
az deployment group list --resource-group "<rg-name>" \
  --query "[?properties.provisioningState!='Succeeded' && properties.provisioningState!='Failed'].{Name:name, State:properties.provisioningState, Time:properties.timestamp}" \
  --output table
```

---

### Step 2: Wait for deployments to finish

If active deployments are found, wait for them to finish. This process can take seconds to several minutes depending on the deployment complexity.

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to monitor the progress.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to **Resource groups**, and then select the resource group.
1. In the menu, in **Settings**, select **Deployments**.
1. Monitor the **Status** column. Wait for all active deployments to show **Succeeded** or **Failed** before you retry the move.

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
# Poll until the deployment finishes
Get-AzResourceGroupDeployment -ResourceGroupName "<rg-name>" |
  Where-Object { $_.ProvisioningState -eq "Running" } |
  ForEach-Object { $_ | Wait-AzResourceGroupDeployment }
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az deployment group wait --resource-group "<rg-name>" --name "<name>" --created
```

---

### Step 3: Cancel stuck deployments if necessary

If a deployment stops responding or is no longer needed, use the Azure portal, Azure PowerShell, or Azure CLI to cancel it.

# [Azure portal](#tab/portal)

Follow these steps:

1. Go to **Resource groups** > your resource group > **Deployments**.
1. Select the stuck deployment.
1. Select **Cancel**.

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

# [Azure PowerShell](#tab/powershell)

Run the following  command.

```azurepowershell
Stop-AzResourceGroupDeployment -ResourceGroupName "<rg-name>" -DeploymentName "<name>"
```

# [Azure CLI](#tab/cli)

Run the following  command.

```azurecli
az deployment group cancel --resource-group "<rg-name>" --name "<name>"
```

---

> [!NOTE]
> Canceling a deployment can leave resources in an incomplete state. Verify the resource group state before you retry the move.

### Step 4: Clean up failed deployments

After cancellation, use the Azure portal, Azure PowerShell, or Azure CLI to clear the failed deployment state.

# [Azure portal](#tab/portal)

Follow these steps:

1. Go to **Resource groups** > your resource group > **Deployments**.
1. Select the failed deployment.
1. Select **Delete**.

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

# [Azure PowerShell](#tab/powershell)

Run the following  command.

```azurepowershell
Remove-AzResourceGroupDeployment -ResourceGroupName "<rg-name>" -DeploymentName "<name>"
```

# [Azure CLI](#tab/cli)

Run the following  command.

```azurecli
az deployment group delete --resource-group "<rg-name>" --name "<name>"
```

---

### Step 5: Retry the move

After all deployments finish or clean up, use the Azure portal, Azure PowerShell, or Azure CLI to retry the move operation.

# [Azure portal](#tab/portal)

To move resources in the Azure portal, see [Move resources - Azure portal](/azure/azure-resource-manager/management/move-resource-group-and-subscription#use-the-azure-portal).

For more information, see [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Move-AzResource -DestinationResourceGroupName "<destination-rg>" -ResourceId @("/subscriptions/<sub-id>/resourceGroups/<source-rg>/providers/<resource-type>/<resource-name>")
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource move --destination-group "<destination-rg>" \
  --ids "/subscriptions/<sub-id>/resourceGroups/<source-rg>/providers/<resource-type>/<resource-name>"
```

---

### Prevention

Ensure that you take the following preventative measures:

- **Coordinate timing** - Schedule moves outside deployment windows.
- **Automated deployments** - Pause Continuous Integration (CI) and Continuous Deployment (CD) pipelines before you initiate moves.
- **Verify state first** - Always check the deployment status before you process a move.

## References

- [Move fails because active resource group locks block the operation](move-resources-resource-group-lock-duration.md)
- [Understand provisioning states for ARM deployments](/azure/azure-resource-manager/templates/deployment-history)
- [Troubleshoot common Azure deployment errors](/azure/azure-resource-manager/templates/common-deployment-errors)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]

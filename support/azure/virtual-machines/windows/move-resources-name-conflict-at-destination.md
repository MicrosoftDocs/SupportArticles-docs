---
title: Azure resource move fails because resource name already exists at destination
description: Resolve Azure resource move failures caused by existing names at the destination scope, and retry your move successfully by following these steps.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/10/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure resource move fails because resource name already exists at destination

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs :heavy_check_mark: All resource types with globally unique names

## Summary

This article helps you troubleshoot and resolve Azure resource move failures that occur if the resource name already exists in the destination scope.

## Symptoms

A move operation fails and returns an error message that resembles one of the following examples.

```
BadRequest: Cannot move Static Web App: Static Web Apps with names 'site-2410672-7cc1a60d-group' already exist at the destination in Subscription '<sub-id>'.
```

```
ResourceConflict: Cannot move resource because resource with the same name '<name>' already exists in the destination resource group or subscription.
```

When this error occurs, the resource isn't in use. However, the name is reserved or unavailable.

## Cause

Some Azure resources require globally unique names, like Azure Static Web Apps, Azure App Services, and Azure Storage Accounts. The move fails if a resource with the same name exists anywhere in the following locations:

- The destination subscription (for globally unique resources)
- The destination resource group (for resource group-scoped resources)
- The destination region (for region-specific name requirements)

> [!NOTE]
> The move fails even if the existing resource appears to be orphaned or inactive.

Common scenarios include the following:

- Resource deletion but name reservation persistence
- A different subscription containing a resource with the same name
- Previous failed moves that leave naming artifacts
- Related resources (such as App Service plans and Static Web App tiers) that already exist

## Resolution

### Step 1: Identify conflicting resources

Use Azure PowerShell or Azure CLI to search for existing resources with the same name.

# [Azure portal](#tab/portal)

Searching for existing resources by name across a subscription programmatically isn't available in the [Azure portal](https://portal.azure.com). To scan for name conflicts, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$resourceName = "<resource-name>"

# Search destination subscription for matching names
$existingGlobal = Get-AzResource -ResourceName $resourceName -ErrorAction SilentlyContinue

if ($existingGlobal) {
  Write-Host "Found existing resource:"
  $existingGlobal | Select-Object Name, ResourceType, ResourceGroupName, Location
} else {
  Write-Host "No existing resource with name '$resourceName' found"
}
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource list --name "<resource-name>" \
  --query "[].{Name:name, Type:type, RG:resourceGroup, Location:location}" --output table
```

---

### Step 2: Check whether conflicting resource can be deleted

If you no longer need the conflicting resource, use Azure PowerShell or Azure CLI to verify it's safe to delete.

# [Azure portal](#tab/portal)

The Azure portal doesn't provide a single view for you to inspect a conflicting resource's type, resource group, and properties to verify it can be safely deleted. To check the resource details, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$conflict = Get-AzResource -ResourceName $resourceName -ResourceType "<resource-type>"
$conflict | Select-Object Name, ResourceType, ResourceGroupName
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource show --name "<resource-name>" --resource-type "<resource-type>" \
  --resource-group "<rg-name>" --query "{Name:name, Type:type, RG:resourceGroup}"
```

---

### Step 3: Delete the conflicting resource

If it's safe to take the action, use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to delete the resource.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Resource groups** and then select the resource group that contains the conflicting resource.
1. Select the resource from the resource list.
1. Select **Delete**, and then verify the deletion.

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$conflict = Get-AzResource -ResourceName $resourceName -ResourceType "<resource-type>"
Remove-AzResource -ResourceId $conflict.ResourceId -Force
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource delete --name "<resource-name>" --resource-type "<resource-type>" \
  --resource-group "<rg-name>"
```

---

### Step 4: For Static Web Apps, delete related tiers

Static Web Apps create multiple named entities. Use Azure PowerShell or Azure CLI to delete all tiers.

# [Azure portal](#tab/portal)

You can't programmatically enumerate and delete Static Web App tiers and associated named entities in the Azure portal. To list and remove these resources, use Azure PowerShell or Azure CLI.

 # [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$baseName = "<base-name>"
Get-AzStaticWebApp -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match $baseName } |
  ForEach-Object {
    Remove-AzStaticWebApp -Name $_.Name -ResourceGroupName $_.ResourceGroupName -Force
  }
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az staticwebapp list --query "[?contains(name, '<base-name>')].{Name:name, RG:resourceGroup}" --output table
az staticwebapp delete --name "<app-name>" --resource-group "<rg-name>" --yes
```

---

### Step 5: Wait for name to become available

After deletion, wait for the name to be fully released. For globally unique names, this wait can take 15 or more minutes. 

Use Azure PowerShell or Azure CLI to check for name availability.

# [Azure portal](#tab/portal)

The Azure portal doesn't support polling for resource name availability after deletion. Globally unique names can take 15 or more minutes to be released. To check name availability programmatically, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
for ($i = 0; $i -lt 30; $i++) {
  $remaining = Get-AzResource -ResourceName $resourceName -ErrorAction SilentlyContinue
  if (-not $remaining) { Write-Host "Name is now available"; break }
  Write-Host "[$i] Name still reserved. Waiting..."
  Start-Sleep -Seconds 30
}
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
# Check if name is still in use
az resource list --name "<resource-name>" --query "[].name" --output tsv
```

> [!NOTE]
> Azure CLI doesn't have a built-in polling loop. Run the command manually every 30 seconds until no results are returned.

---

### Step 6: Retry the move

After you delete the conflicting resource and the name becomes available, use the Azure portal, Azure PowerShell, or Azure CLI to retry the move.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to **Resource groups**, and then select the source resource group.
1. Select the resources that you want to move, and then select **Move** > **Move to another resource group** (or **Move to another subscription**).
1. Select the destination resource group and subscription, and then select **OK**.

For more information, see [Use the Azure portal to move resources](/azure/azure-resource-manager/management/move-resource-group-and-subscription#use-the-azure-portal).

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Move-AzResource -DestinationResourceGroupName "<destination-rg>" `
  -DestinationSubscriptionId "<destination-sub-id>" `
  -ResourceId "/subscriptions/<source-sub-id>/resourceGroups/<source-rg>/providers/<resource-type>/<resource-name>"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource move --destination-group "<destination-rg>" \
  --ids "/subscriptions/<source-sub-id>/resourceGroups/<source-rg>/providers/<resource-type>/<resource-name>"
```

---

### Step 7: Alternative: Rename the source resource

If you want to keep the conflicting resource at the destination, use Azure PowerShell or Azure CLI to rename the source before you initiate the move.

# [Azure portal](#tab/portal)

Not all resource types support rename in the portal. For resources that don't support rename, re-create the resource with a new name at the destination instead.

For more information, see [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
# Some resources support rename via ARM — check the resource type documentation
# For resources that don't support rename, recreate with a new name
$sourceResource = Get-AzResource -ResourceId "/subscriptions/<source-sub-id>/resourceGroups/<source-rg>/providers/<resource-type>/<resource-name>"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
# Most resources don't support rename via CLI — recreate with a new name at destination
az resource show --ids "<resource-id>" --query "{Name:name, Type:type}"
```

---

Then, retry the move by using the new name.

### Step 8: Check for soft-deleted resources

For some resource types, a soft-delete operation might reserve the name. Use Azure PowerShell or Azure CLI to check for and manage soft-deleted resources.

# [Azure portal](#tab/portal)

The Azure portal doesn't provide a way to check for soft-deleted resources (such as storage accounts and key vaults) that might reserve a name. To query soft-deleted resources, use Azure PowerShell or Azure CLI.

#### [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
Get-AzStorageAccount -IncludeDeleted -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -eq "<resource-name>" -and $_.IsDeleted -eq $true }

# Check for soft-deleted storage accounts and purge
Get-AzStorageAccount -IncludeDeleted -ErrorAction SilentlyContinue |
  Where-Object { $_.StorageAccountName -eq "<resource-name>" -and $_.Deleted }
```

#### [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az storage account list --include-deleted \
  --query "[?name=='<resource-name>' && deleted].{Name:name, Deleted:deleted}" --output table
```

> [!NOTE]
> Purging soft-deleted storage accounts by using Azure CLI requires a REST API call. Use Azure PowerShell or the Azure portal for this operation.

---

### Prevention

Ensure that you take the following preventative measures:

- **Check the destination before the move** - Query for existing resources that share the same name.
- **Review naming conventions** - Ensure that names are unique across your environment.
- **Clean up failed moves** - Delete artifacts from failed move attempts.
- **Use unique suffixes** - To avoid conflicts, append an environment or region prefix.
- **Coordinate across teams** - To prevent accidental duplication, maintain a naming registry.

## References

- [Naming conventions and rules for Azure resources](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)
- [Naming rules and restrictions for Azure resources](/azure/azure-resource-manager/management/resource-name-rules)
- [Rename Azure resources](/azure/azure-resource-manager/management/move-resources-overview#rename-resources)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]

---
title: Azure VM move fails because scheduled updates or maintenance configuration settings block the move
description: Fix Azure virtual machine move failures caused by unsupported scheduled updates or maintenance configurations. Follow these steps to validate and retry.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/16/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine move fails because scheduled updates or maintenance configurations block the move

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to troubleshoot Azure virtual machine (VM) move failures that scheduled updates or maintenance configuration settings cause. The selected move path doesn't support these settings. The article provides steps to identify the blocking settings, adjust or remove them, and retry the move successfully.

## Symptoms

Move validation fails for a VM that uses guest patch orchestration or maintenance configuration settings.

The following are common error messages you might encounter.

```output
OperationNotAllowed
```

```output
The virtual machine uses scheduled patching or maintenance settings that aren't supported for move.
```

## Cause

Certain update and maintenance configuration states are unsupported or require a different migration pattern.

## Resolution

### Step 1: Identify update and maintenance settings

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to identify the update and maintenance settings for the VM.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>"

# Check patch mode
$vm.OSProfile.WindowsConfiguration.PatchSettings | Format-List

# Check maintenance configuration assignments
Get-AzMaintenanceAssignment -ResourceGroupName "<rg-name>" -ResourceName "<vm-name>" -ResourceType "virtualMachines" -ProviderName "Microsoft.Compute"
```

#### [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
az vm show --resource-group "<rg-name>" --name "<vm-name>" \
  --query "osProfile.windowsConfiguration.patchSettings"

az maintenance assignment list \
  --resource-group "<rg-name>" \
  --resource-name "<vm-name>" \
  --resource-type "virtualMachines" \
  --provider-name "Microsoft.Compute"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Virtual machines** and then select the VM.
1. In the menu, select **Updates** to view the current patch orchestration mode and any maintenance configuration assignments.
1. To see all maintenance configurations, search for **Maintenance Configurations** in the portal. Select a configuration and then select **Machines** to see which VMs are assigned to it.

For more information, see [Check the configuration and status](/azure/virtual-machines/maintenance-configurations-portal#check-the-configuration-and-status).

---

### Step 2: Remove or adjust unsupported configuration

If maintenance configurations are attached to the VM, use Azure PowerShell or Azure CLI to remove the assignment before the move.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$assignment = Get-AzMaintenanceAssignment -ResourceGroupName "<rg-name>" -ResourceName "<vm-name>" -ResourceType "virtualMachines" -ProviderName "Microsoft.Compute"

Remove-AzMaintenanceAssignment -InputObject $assignment
```

# [Azure CLI](#tab/cli)

If the patch mode blocks the move, run the following command to temporarily change it to `Manual`.

```azurecli
az vm update --resource-group "<rg-name>" --name "<vm-name>" \
  --set osProfile.windowsConfiguration.patchSettings.patchMode=Manual
```

# [Azure portal](#tab/portal)

Removing maintenance configuration assignments and changing the patch mode to Manual programmatically isn't available in the Azure portal. To detach maintenance configurations, use Azure PowerShell or Azure CLI.

---

### Step 3: Retry validation

After you clean up the configuration, run the move validation again.

### Step 4: Reapply the desired settings at destination

After the move finishes, use Azure PowerShell, Azure CLI, or the Azure portal to re-create the maintenance configuration assignment and restore the original patch mode.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
# Restore patch mode
$vm = Get-AzVM -ResourceGroupName "<destination-rg>" -Name "<vm-name>"
Update-AzVM -ResourceGroupName "<destination-rg>" -VM $vm -PatchMode "AutomaticByPlatform"

# Re-create maintenance assignment
$config = Get-AzMaintenanceConfiguration -ResourceGroupName "<config-rg>" -Name "<config-name>"

New-AzMaintenanceAssignment `
  -ResourceGroupName "<destination-rg>" `
  -Location "<location>" `
  -ResourceName "<vm-name>" `
  -ResourceType "virtualMachines" `
  -ProviderName "Microsoft.Compute" `
  -ConfigurationAssignmentName "<assignment-name>" `
  -MaintenanceConfigurationId $config.Id
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
# Restore patch mode
az vm update --resource-group "<destination-rg>" --name "<vm-name>" \
  --set osProfile.windowsConfiguration.patchSettings.patchMode=AutomaticByPlatform

# Re-create maintenance assignment
az maintenance assignment create \
  --resource-group "<destination-rg>" \
  --resource-name "<vm-name>" \
  --resource-type "virtualMachines" \
  --provider-name "Microsoft.Compute" \
  --configuration-assignment-name "<assignment-name>" \
  --maintenance-configuration-id "<config-resource-id>" \
  --location "<location>"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, search for **Maintenance Configurations**.
1. Select the maintenance configuration that the VM previously used (or create a new one by selecting **Create**).
1. Select **Machines** > **Add machine**, and then select the VM in the destination resource group.
1. To restore the patch mode, go to **Virtual machines** > select the VM > **Updates**, and change the orchestration mode back to the desired setting.

For more information, see [Assign the configuration](/azure/virtual-machines/maintenance-configurations-portal#assign-the-configuration).

## References

- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Managing VM updates with Maintenance Configurations](/azure/virtual-machines/maintenance-configurations#guest)
- [Move operation is taking longer than expected](move-resources-operation-duration-expected.md)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]

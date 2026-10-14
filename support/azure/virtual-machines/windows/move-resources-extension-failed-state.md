---
title: Azure resource move fails because a VM extension is in a failed state
description: Fix Azure resource move failures caused by VM extensions in Failed or Transitioning states. Use these steps to retry the move successfully.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/08/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure resource move fails because a virtual machine extension is in a failed state

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article helps you troubleshoot Azure resource move failures caused by a virtual machine (VM) extension that is in a `Failed` or `Transitioning` provisioning state.

## Symptoms

When you try to move a VM to a different resource group or subscription, the move validation fails and returns an error message that resembles the following example.

```output
The resource '<vm-name>' has a failed extension '<extension-name>'. 
Resolve the extension provisioning failure before attempting to move this resource.
```

Or the move appears to succeed, but the VM is inaccessible after the move because an extension that was in a `Transitioning` state during the move left the VM in an inconsistent configuration.

## Cause

Azure Resource Manager (ARM) validates the provisioning state of all VM extensions before it allows a move to proceed. Any extension that isn't in the `Succeeded` provisioning state blocks the move. This condition includes:

- Extensions that are stuck in a `Failed` state after a failed installation or update
- Extensions that are stuck in a `Transitioning` or `Creating` state during an ongoing operation
- Extensions that lost communication with the VM agent (`VMAgentStatusCommunicationError`)

## Resolution

### Step 1: Identify extensions in a failed state

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to list all extensions and their provisioning states.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Virtual machines**, and then select your VM.
1. In the left menu, under **Settings**, select **Extensions + applications**.
1. Review the **Status** column for each extension. Look for any extension that shows **Failed**, **Transitioning**, or **Provisioning failed**.

For more information, see [View available extensions](/azure/virtual-machines/extensions/overview#view-available-extensions).

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzVMExtension -ResourceGroupName "<rg-name>" -VMName "<vm-name>" |
  Select-Object Name, Publisher, ExtensionType, ProvisioningState |
  Format-Table -AutoSize
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm extension list \
  --resource-group "<rg-name>" \
  --vm-name "<vm-name>" \
  --query "[].{Name:name, Publisher:publisher, Type:typePropertiesType, State:provisioningState}" \
  --output table
```

---

Before you move the resources, resolve any extension that shows a state other than `Succeeded`.

### Step 2: Resolve the extension failure

Use the Azure portal, Azure PowerShell, or Azure CLI to apply the method that matches the extension state.

#### Method A: Force-update the extension from the portal

This method works for most extensions that are in a `Failed` state. Follow these steps:

1. In the Azure portal, go to the VM and select **Extensions + applications**.
1. Select the failed extension.
1. Select **Uninstall**, and wait for the uninstall process to finish.
1. Select **Add**, and reinstall the extension from the extension gallery.
1. Wait for the provisioning state to reach `Succeeded` before you try the move.

#### Method B: Force-update the extension

# [Azure portal](#tab/portal)

Force-updating a VM extension by removing and reinstalling it by using a command-line tool isn't available in the Azure portal. To force-update extensions programmatically, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
# Get the current extension settings
$ext = Get-AzVMExtension -ResourceGroupName "<rg-name>" -VMName "<vm-name>" -Name "<extension-name>"

# Remove the extension
Remove-AzVMExtension -ResourceGroupName "<rg-name>" -VMName "<vm-name>" -Name "<extension-name>" -Force

# Reinstall the extension
Set-AzVMExtension `
  -ResourceGroupName "<rg-name>" `
  -VMName "<vm-name>" `
  -Name "<extension-name>" `
  -Publisher $ext.Publisher `
  -ExtensionType $ext.ExtensionType `
  -TypeHandlerVersion $ext.TypeHandlerVersion `
  -Settings $ext.PublicSettings `
  -ProtectedSettings $ext.ProtectedSettings
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
# Remove the extension
az vm extension delete --resource-group "<rg-name>" --vm-name "<vm-name>" --name "<extension-name>"

# Reinstall the extension
az vm extension set --resource-group "<rg-name>" --vm-name "<vm-name>" \
  --name "<extension-name>" --publisher "<publisher>" \
  --version "<version>"
```

---

#### Method C: If you can't recover the extension, remove it before the move

If the extension isn't required for the move to succeed, use the Azure portal, Azure PowerShell, or Azure CLI to remove it. Then, complete the move and reinstall the extension at the destination.

# [Azure portal](#tab/portal)

Follow these steps:

1. Go to **Virtual machines** > your VM > **Extensions + applications**.
1. Select the extension, and then select **Uninstall**.

For more information, see [Azure VM extensions and features](/azure/virtual-machines/extensions/overview).

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Remove-AzVMExtension `
  -ResourceGroupName "<rg-name>" `
  -VMName "<vm-name>" `
  -Name "<extension-name>" `
  -Force
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm extension delete --resource-group "<rg-name>" --vm-name "<vm-name>" --name "<extension-name>"
```

---

> [!NOTE]
> Some extensions are required for platform features, such as Azure Monitor, Azure Backup, and Microsoft Defender for Cloud. If you remove these extensions, the related features stop reporting until you reinstall the extension at the destination.

#### Method D: Extensions stuck in Transitioning

If an extension is stuck in a `Transitioning` state, a background platform operation might still be running. Do the following:

1. Wait 15 minutes, and then recheck the provisioning state.
1. If the state doesn't change, use the Azure portal, Azure PowerShell, or Azure CLI to stop, deallocate, and restart the VM.

# [Azure portal](#tab/portal)

Follow these steps:

1. Go to **Virtual machines** > your VM.
1. Select **Stop** and wait for the VM to deallocate.
1. Select **Start**.

For more information, see [Azure VM extensions and features](/azure/virtual-machines/extensions/overview).

# [Azure PowerShell](#tab/powershell)

Run the following command.

   ```azurepowershell
   Stop-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>" -Force
   Start-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>"
   ```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm deallocate --resource-group "<rg-name>" --name "<vm-name>"
az vm start --resource-group "<rg-name>" --name "<vm-name>"
```

   ---

1. After a restart, recheck the extension state. The platform cleans up stuck operations during VM restart in most cases.

### Step 3: Verify that all extensions are in Succeeded state

After you resolve each failed extension, use the Azure portal, Azure PowerShell, or Azure CLI to verify that all extensions are healthy before you retry the move.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to **Virtual machines**, and then select your VM.
1. In the menu, in **Settings**, select **Extensions + applications**.
1. Verify that the **Status** column for every extension shows **Provisioning succeeded**. If any extension shows a different state, resolve it before you retry the move.

For more information, see [View available extensions](/azure/virtual-machines/extensions/overview#view-available-extensions).

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$exts = Get-AzVMExtension -ResourceGroupName "<rg-name>" -VMName "<vm-name>"
$failed = $exts | Where-Object { $_.ProvisioningState -ne "Succeeded" }

if ($failed) {
    Write-Warning "The following extensions are not in Succeeded state:"
    $failed | Select-Object Name, ProvisioningState | Format-Table
} else {
    Write-Host "All extensions are in Succeeded state. Safe to move." -ForegroundColor Green
}
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm extension list --resource-group "<rg-name>" --vm-name "<vm-name>" \
  --query "[?provisioningState!='Succeeded'].{Name:name, State:provisioningState}" --output table
```

If the output is empty, all extensions are in `Succeeded` state.

---

### Step 4: Retry the move

When all extensions are in the `Succeeded` state, retry the move operation. For a full pre-move verification, see [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md).

### Extension-specific notes

The following table summarizes common extension-specific failure causes and notes for handling them.

| Extension | Common failure cause | Notes |
|---|---|---|
| `MicrosoftMonitoringAgent` / `AzureMonitorWindowsAgent` | Workspace key rotation or connectivity loss | Remove before move. The Log Analytics workspace connection is reestablished after reinstallation at the destination. |
| `BGInfo` | Display driver unavailability during move | Benign. Remove if it blocks the move. Reinstallation is optional. |
| `IaaSDiagnostics` | Storage account key change | Update the extension settings by using the current storage key before you retry. |
| `CustomScriptExtension` | Script failure, extension left in Failed state | Remove after you verify the script output. Don't reinstall unless the script is needed again. |
| `DependencyAgentWindows` | Agent version mismatch | Update to the latest version. Don't remove because removal breaks VM Insights. |

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Troubleshoot Azure VM extension issues](/azure/virtual-machines/extensions/troubleshoot)
- [Azure virtual machine extensions and features](/azure/virtual-machines/extensions/overview)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]

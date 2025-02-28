---
title: Reset Remote Desktop Services or its administrator password in a Windows VM
description: Learn how to reset an account password or Remote Desktop Services on a Windows VM by using the Azure portal or Azure PowerShell.
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.custom: sap:Cannot connect to my VM, devx-track-azurepowershell
ms.service: azure-virtual-machines
ms.collection: windows
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting
ms.date: 10/18/2024
ms.author: genli
ms.reviewer: herensin
---
# Reset Remote Desktop Services or its administrator password in a Windows VM

**Applies to:** :heavy_check_mark: Windows VMs

[!INCLUDE [Feedback](../../../includes/feedback.md)]

> [!NOTE]
> The steps in this article don't apply to Windows domain controllers.

If you can't connect to a Windows virtual machine (VM), you can reset Remote Desktop Services and credentials by using the VMAccess extension. Here are the available methods to do this:

- [Reset by using the Azure portal](#reset-by-using-the-azure-portal)
- [Reset by using the Azure PowerShell](#reset-by-using-the-azure-powershell)

If you're using PowerShell, make sure that you have the [latest PowerShell module installed and configured](/powershell/azure/) and are signed in to your Azure subscription. You can also [perform these steps for VMs created with the classic deployment model](/previous-versions/azure/virtual-machines/windows/classic/reset-rdp).

## Reset by using the Azure portal

First, sign in to the [Azure portal](https://portal.azure.com) and then select **Virtual machines** on the left menu.

### **Reset the local administrator account password**

1. Select your Windows VM and then select **Reset password** under **Help**. The **Reset password** window is displayed.

2. Select **Reset password**, enter a username and a password, and then select **Update**.
    > [!TIP]
    > If you enter a different name than the current local administrator account on your VM, the VMAccess extension will add a local administrator account with that name, and assign your specified password to that account. If the local administrator account on your VM exists, the VMAccess extension will reset the password. If the account is disabled, the VMAccess extension will enable it.
3. Try connecting to your VM again.

### **Reset the Remote Desktop Services configuration**

This process will enable Remote Desktop service in the VM, and create a firewall rule for the default RDP port 3389.

1. Select your Windows VM and then select **Reset password** under **Help**. The **Reset password** window is displayed.

2. Select **Reset configuration only** and then select **Update**.

3. Try connecting to your VM again.

## Reset by using the Azure PowerShell

First, make sure that you have  the [latest PowerShell module installed and configured](/powershell/azure/) and are signed in to your Azure subscription by using the [Connect-AzAccount](/powershell/module/az.accounts/connect-azaccount) cmdlet.

### **Reset the local administrator account password**

- Reset the administrator password or user name with the [Set-AzVMAccessExtension](/powershell/module/az.compute/set-azvmaccessextension) PowerShell cmdlet. The `typeHandlerVersion` setting must be 2.0 or greater, because version 1 is deprecated.

    ```powershell
    $SubID = "<SUBSCRIPTION ID>" 
    $RgName = "<RESOURCE GROUP NAME>" 
    $VmName = "<VM NAME>" 
 
    Connect-AzAccount 
    Select-AzSubscription -SubscriptionId $SubID 
    Set-AzVMAccessExtension -ResourceGroupName $RgName -VMName $VmName -Credential (get-credential) -typeHandlerVersion "2.0" -Name VMAccessAgent 
    ```
### **Reset the Remote Desktop Services configuration**

1. Reset remote access to your VM with the [Set-AzVMAccessExtension](/powershell/module/az.compute/set-azvmaccessextension) PowerShell cmdlet. The following example resets the access extension named `VMAccessAgent` on a VM in the resource group:

    ```powershell
    $SubID = "<SUBSCRIPTION ID>" 
    $RgName = "<RESOURCE GROUP NAME>" 
    $VmName = "<VM NAME>" 
 
    Connect-AzAccount 
    Select-AzSubscription -SubscriptionId $SubID
    Set-AzVMAccessExtension -ResourceGroupName $RgName -VMName $VmName -Name VMAccessAgent -typeHandlerVersion "2.0" -ForceRerun $true
    ```

    > [!TIP]
    > At any point, a VM can have only a single VM access agent. To set the VM access agent properties, use the `-ForceRerun` option. When you use `-ForceRerun`, ensure you use the same name for the VM access agent that you might have used in any previous commands.

1. If you still can't connect remotely to your virtual machine, see [Troubleshoot Remote Desktop connections to a Windows-based Azure virtual machine](troubleshoot-rdp-connection.md). If you lose the connection to the Windows domain controller, you will need to restore it from a domain controller backup.

## Next steps

- If the Azure VM access extension fails to install you can [troubleshoot VM extension issues](/azure/virtual-machines/extensions/troubleshoot?toc=/azure/virtual-machines/windows/toc.json).

- If you're unable to reset the password using the VM access extension then you can [reset the local Windows password offline](reset-local-password-without-agent.md?toc=%2fazure%2fvirtual-machines%2fwindows%2ftoc.json). This method is more advanced and requires you to connect the virtual hard disk of the problematic VM to another VM. Follow the steps documented in this article first, and attempt the offline password reset method only if those steps don't work.

- [Learn about Azure VM extensions and features](/azure/virtual-machines/extensions/features-windows).

- [Connect to an Azure virtual machine with RDP or SSH](/previous-versions/azure/dn535788(v=azure.100)).

- [Troubleshoot Remote Desktop connections to a Windows-based Azure virtual machine](troubleshoot-rdp-connection.md?toc=%2fazure%2fvirtual-machines%2fwindows%2ftoc.json).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

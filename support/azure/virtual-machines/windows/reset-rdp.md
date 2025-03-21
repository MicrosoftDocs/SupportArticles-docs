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

## Troubleshoot and support

### Error messages

| Error  | Description |
| ---- | ---- |
| {"innererror": {"internalErrorCode": "CannotModifyExtensionsWhenVMNotRunning"}, "code": "OperationNotAllowed","message": "Cannot modify extensions in the VM when the VM is not running."} | The error indicates that the operation to modify extensions in the VM is not allowed because the VM is not running. Ensure that the VM is in a running state before attempting to modify extensions. |
| VM has reported a failure when processing extension 'enablevmAccess' (publisher 'Microsoft.Compute' and type 'VMAccessAgent'). Error message: 'VMAccess Extension does not support Domain Controller.'. More information on troubleshooting is available at https://aka.ms/vmextensionwindowstroubleshoot . | The error indicates that the VM extension 'enablevmAccess' failed because it does not support Domain Controller. Ensure that the VM is not configured as a Domain Controller when using this extension. For more information, see [Reset Remote Desktop Services or its administrator password in a Windows VM](https://learn.microsoft.com/troubleshoot/azure/virtual-machines/windows/reset-rdp). |
| VM 'vmname' has not reported status for VM agent or extensions. Verify that the OS is up and healthy, the VM has a running VM agent, and that it can establish outbound connections to Azure storage. Please refer to https://aka.ms/vmextensionwindowstroubleshoot  for additional VM agent troubleshooting information. | See [Troubleshooting checklist](https://learn.microsoft.com/troubleshoot/azure/virtual-machines/windows/windows-azure-guest-agent?source=recommendations#troubleshooting-checklist). |
| VM has reported a failure when processing extension 'enablevmAccess' (publisher 'Microsoft.Compute' and type 'VMAccessAgent'). Error message: 'Cannot update Remote Desktop Connection settings for Administrator account. Error: System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation. ---> System.Runtime.InteropServices.COMException: The password does not meet the password policy requirements. Check the minimum password length, password complexity, and password history requirements. --- End of inner exception stack trace --- at System.DirectoryServices.DirectoryEntry.Invoke(String methodName, Object[] args) at Microsoft.WindowsAzure.GuestAgent.Plugins.WindowsUser.SetPassword(SecureString password, Boolean expirePassword) at Microsoft.WindowsAzure.GuestAgent.Plugins.RemoteAccessAccountManager.AddOrUpdateRemoteUserAccount(String userName, SecureString password, Boolean expirePassword) at Microsoft.WindowsAzure.GuestAgent.Plugins.JsonExtensions.VMAccess.VMAccessExtension.OnEnable()'. More information on troubleshooting is available at https://aka.ms/vmextensionwindowstroubleshoot. | The error indicates that the VM extension 'enablevmAccess' failed to update Remote Desktop Connection settings for the Administrator account due to a password policy violation. Ensure that the password meets Windows password policy requirements, including minimum length, complexity, and history. For more information, see [Troubleshoot VM extensions](https://learn.microsoft.com/azure/virtual-machines/extensions/features-windows#troubleshoot-vm-extensions). |
| VM has reported a failure when processing extension 'enablevmAccess' (publisher 'Microsoft.Compute' and type 'VMAccessAgent'). Error message: 'The Admin User Account password cannot be null or empty if provided the username.'. More information on troubleshooting is available at https://aka.ms/vmextensionwindowstroubleshoot . | The error indicates that the VM extension 'enablevmAccess' failed because the Admin User Account password was not provided. Ensure that a non-null and non-empty password is specified for the Admin User Account to resolve this issue. |
|   Provisioning of VM extension enablevmaccess has timed out. Extension provisioning has taken too long to complete. The extension did not report a message. | The error message indicates that the provisioning of the VM extension ‘enablevmaccess’ has timed out due to taking too long to complete. Additionally, the extension did not provide any status message during the process. To resolve this issue, consider checking the VM’s performance and network conditions, and retry the provisioning operation. For more information, see [Troubleshooting Azure Windows VM extension failures](https://learn.microsoft.com/azure/virtual-machines/extensions/troubleshoot). |
| VM has reported a failure when processing extension 'enablevmAccess' (publisher 'Microsoft.Compute' and type 'VMAccessAgent'). Error message: 'Cannot update Remote Desktop Connection settings for Administrator account. Error: System.Exception: User account scsadmin already exists but cannot be updated because it is not in the Administrators group. at Microsoft.WindowsAzure.GuestAgent.Plugins.RemoteAccessAccountManager.AddOrUpdateRemoteUserAccount(String userName, SecureString password, Boolean expirePassword) at Microsoft.WindowsAzure.GuestAgent.Plugins.JsonExtensions.VMAccess.VMAccessExtension.OnEnable()'. More information on troubleshooting is available at https://aka.ms/vmextensionwindowstroubleshoot . | The error indicates that the VM extension 'enablevmAccess' failed because the user account 'scsadmin' already exists but is not in the Administrators group. Ensure that the user account is added to the Administrators group to resolve this issue.|
| VM has reported a failure when processing extension 'enablevmaccess' (publisher 'Microsoft.Compute' and type 'VMAccessAgent'). Error message: 'Cannot update Remote Desktop Connection settings for Administrator account. Error: System.Runtime.InteropServices.COMException (0x800708C5): The password does not meet the password policy requirements. Check the minimum password length, password complexity, and password history requirements. at System.DirectoryServices.DirectoryEntry.CommitChanges() at Microsoft.WindowsAzure.GuestAgent.Plugins.WindowsUser.SetPassword(SecureString password, Boolean expirePassword) at Microsoft.WindowsAzure.GuestAgent.Plugins.WindowsUserManager.CreateUserInGroup(String userName, SecureString password, Boolean expirePassword, String[] groups) at Microsoft.WindowsAzure.GuestAgent.Plugins.RemoteAccessAccountManager.AddOrUpdateRemoteUserAccount(String userName, SecureString password, Boolean expirePassword) at Microsoft.WindowsAzure.GuestAgent.Plugins.JsonExtensions.VMAccess.VMAccessExtension.OnEnable()'. More information on troubleshooting is available at https://aka.ms/vmextensionwindowstroubleshoot . | The error message indicates that the VM failed to process the ‘enablevmaccess’ extension due to an issue with updating Remote Desktop Connection settings for the Administrator account. The specific error is related to the password not meeting the policy requirements, such as minimum length, complexity, and history. To resolve this issue, ensure that the password complies with the required policy standards. For more information, see [Troubleshoot VM extensions](https://learn.microsoft.com/azure/virtual-machines/extensions/features-windows#troubleshoot-vm-extensions). |
| {"innererror": {"internalErrorCode": "MultipleExtensionsPerHandlerNotAllowed"}, "code": "BadRequest","message": "Multiple VMExtensions per handler not supported for OS type 'Windows'. VMExtension 'enablevmaccess' with handler 'Microsoft.Compute.VMAccessAgent' already added or specified in input."} | The error message indicates that multiple VM extensions per handler are not supported for the OS type ‘Windows’. The ‘enablevmaccess’ extension with the handler ‘Microsoft.Compute.VMAccessAgent’ has already been added or specified in the input. To resolve this issue, ensure that only one extension per handler is configured for the VM. <br><br> Manually remove extension and retry operation <br> ```Remove-AzVMExtension -ResourceGroupName "ResourceGroup11" -Name "ExtensionName" -VMName "VirtualMachineName"``` |

## Next steps

- If the Azure VM access extension fails to install you can [troubleshoot VM extension issues](/azure/virtual-machines/extensions/troubleshoot?toc=/azure/virtual-machines/windows/toc.json).

- If you're unable to reset the password using the VM access extension then you can [reset the local Windows password offline](reset-local-password-without-agent.md?toc=%2fazure%2fvirtual-machines%2fwindows%2ftoc.json). This method is more advanced and requires you to connect the virtual hard disk of the problematic VM to another VM. Follow the steps documented in this article first, and attempt the offline password reset method only if those steps don't work.

- [Learn about Azure VM extensions and features](/azure/virtual-machines/extensions/features-windows).

- [Connect to an Azure virtual machine with RDP or SSH](/previous-versions/azure/dn535788(v=azure.100)).

- [Troubleshoot Remote Desktop connections to a Windows-based Azure virtual machine](troubleshoot-rdp-connection.md?toc=%2fazure%2fvirtual-machines%2fwindows%2ftoc.json).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

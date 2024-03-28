---
title: (Failed to get contents of the log) error in VM Boot Diagnostics in Azure portal
description: Discusses an issue in which that you see a (Failed to get contents of the log) error in VM Boot Diagnostics in Azure portal.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-common-errors-issues
---
# Error in VM Boot Diagnostics in Azure portal: Failed to get contents of the log

This article provides a solution to an issue in which "Failed to get contents of the log" error occurs when you view a virtual machine screen shot in the Boot Diagnostics blade in the Azure portal.

_Original product version:_ &nbsp; Virtual Machine running Windows, Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4094480

## Symptoms

When you try to view a virtual machine screen shot in the Boot Diagnostics blade in the Azure portal, an error occurs, and you see the following entry logged in the notification area:

> Failed to get contents of the log '\<log url>' of virtual machine '/subscriptions/\<SUBID>/resourceGroups/\<RGNAME>/providers/Microsoft.Compute/virtualMachines/\<VMNAME>'. Error message: 'description: Failed to complete the RPC call for 'getExtendedInfoBlob' message: Failed to complete the RPC call for 'getExtendedInfoBlob' stack: ###_RPC_Exception_### From RPC: Microsoft_Azure_Compute -> Microsoft_Azure_Storage (getExtendedInfoBlob) (Callstack capturing is not enabled. Use ?trace=diagnostics to enable it.) '

## Cause

This problem might occur for any of the following reasons:

- Virtual Machines that run on Windows Server 2008 R2 or earlier versions don't produce a VM Health Report. Therefore, it's expected that no SerialConsole.log file is produced in the Boot Diagnostics storage account, and you see the error message that is mentioned in the "Symptoms" section. To verify the operating system version, open a Command Prompt window, type **winver**, and then press Enter. (See Workaround 1)

- Virtual machines that have an old VM Guest Agent version (earlier than 2.7.1198.806) installed are not expected to produce a VM Health Report. Therefore, it's expected that no SerialConsole.log file is produced in the Boot Diagnostics storage account, and you see the error message that is mentioned in the "Symptoms" section. To verify the version of VM Guest Agent, open the `C:\WindowsAzure\logs\WaAppAgent.log` folder, and then search on the following:

    WindowsAzureGuestAgent starting. Version 2.7.1198.802
    (See Workaround 2)

- The automatic generation of the VM Health Report by the VM Guest Agent may fail. If this occurs, no SerialConsole.log file is created. This triggers th e error message that is mentioned in the "Symptoms" section. For example, this report isn't produced if there are unresolved SIDs reported as members in the virtual machine Local Administrators group. To search for such issues, examine the `C:\WindowsAzure\logs\TransparentInstaller.log` file.
(See Workaround 3)

## Workaround

To work around this problem, try the following methods.

### Workaround 1

Upgrade your operating system to a more recent version.

### Workaround 2

Update the VM Guest Agent by installing version [2.7.1198.822](https://go.microsoft.com/fwlink/?LinkID=394789&clcid=0x409).

### Workaround 3  

Check whether the associated user was deleted from the domain.

You also can remove the unresolved SIDs (for example, S-1-5-21-XYZ-XYZ) from the Local Administrators group.

Also, check whether you have a domain policy that's locking down the Local Administrators group, or whether the built-in Administrator account was removed (indicated by "0x80005004" in the Transparent Installer log).

### Workaround 4

If you suspect that an issue affects the serial port on the host, you can try to redeploy the VM to move it to a different host.

> [!WARNING]
> This action triggers a restart of the VM.

## Status

We are working on a resolution to this problem. Our goal is to improve the discovery of cases in which the SerialConsole.log file isn't produced, and to prevent this error from becoming too intrusive.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

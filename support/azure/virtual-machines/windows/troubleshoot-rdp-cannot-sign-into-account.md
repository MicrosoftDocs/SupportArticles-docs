---
title: We can't sign into your account error occurs when you make an RDP connection to Azure Virtual Machines
description: Learn how to troubleshoot can't sign into your account errors in Microsoft Azure.
services: virtual-machines
documentationCenter: ''
author: genlin
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 10/18/2021
ms.author: genli
ms.custom: sap:Cannot connect to my VM
---
# Can't sign into your account when you try to connect to an Azure Windows VM

**Applies to:** :heavy_check_mark: Windows VMs

This article discusses how to troubleshoot the error "We can't sign into your account" when you try to connect to an Azure Windows VM using Remote Desktop Protocol (RDP).

## Symptoms

When you try to connect the Windows VM using RDP, you receive the following error message:

 > We can't sign into your account<br>
 > This problem can often be fixed by signing out of your account and then signing back in. If you don't sign out now, any files you create or changes you make will be lost.

In the Applications Event log, you see Event ID 1511 is logged for each RDP connection attempt.

 > ID:       1511<br>
 > Level:    Error<br>
 > Source:   Microsoft-Windows-User Profiles Service<br>
 > Machine:  RDPDemo.contoso.net<br>
 > Message:  Windows cannot find the local profile and is logging you on with a temporary profile. Changes you make to this profile will be lost when you log off.

## Cause

The issue can occur if the local profile of the user is corrupt, and Windows is unable to create a new local profile for the RDP session.

## Solution

Before proceeding with any of the solutions in this document, back up your VM OS disk by taking a [snapshot](/azure/virtual-machines/windows/snapshot-copy-managed-disk). If you need to revert any changes made while troubleshooting, you can use the snapshot to recreate the disk.

### Online repair by using Azure Serial Console

1. Connect to the VM using the Azure Serial Console, then [start a PowerShell session]( serial-console-windows.md#use-serial-console). If the Azure Serial Console doesn't work, connect to the VM using remote PowerShell. For more information, see [How to use remote tools to troubleshoot Azure VM issues](remote-tools-troubleshoot-azure-vm-issues.md).

1. After you connect to the VM, run the following command to list the user profiles entries. Locate any profiles that have the ".bak" extension on the end of the name.

    ```powershell
    reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" /s | more
    ```

1. Identify the profile entry for the affected user by looking at the value for the key "ProfileImagePath".

1. Remove the user profile backup entry for the affected user (ends with ".bak"), do not remove entries for the built-in system accounts **S-1-5-18**, **S-1-5-19**, and **S-1-5-20**:

    ```powershell
    reg delete "HKLM\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\ProfileList\<GUID>.bak"
    ```

1. Try to connect to the VM and see if the problem is resolved.
1. If the problem still occurs, you can try removing the user profile entry for the affected user.

### Offline repair

If you're unable to access the VM using the Azure Serial Console or other remote tools, then the repair must be done in offline mode.

1. Follow the steps 1-3 of the [VM Repair process](repair-windows-vm-using-azure-virtual-machine-repair-commands.md) to create a Repair VM. A copied OS disk of the failed VM will be attached to the Repair VM automatically. Usually the disk is attached as drive F.
1. Connect to the Repair VM.
1. On the Repair VM, start Registry Editor (regedit.exe). Select the **HKEY_LOCAL_MACHINE** key, select **File** > **Load Hive** from the menu. Locate and load the *SOFTWARE* hive file in the *F:\Windows\System32\config* folder, and then type *RepairSOFTWARE* as the name for the hive.
1. Navigate to *RepairSOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList*.
1. Identify the profile entry for the affected user by looking at the value for the key "ProfileImagePath".
1. Remove the user profile backup entry for the affected user (ends with ".bak"), do not remove entries for the built-in system accounts **S-1-5-18**, **S-1-5-19**, and **S-1-5-20**.
1. Use step 5 of the [VM Repair process](repair-windows-vm-using-azure-virtual-machine-repair-commands.md) to mount the repaired OS disk to the failed VM.
1. Start the failed VM and try to connect to the VM using RDP. If the problem continues to occur, you can try removing the user profile entry for the affected user.

## Next steps

If your Azure issue isn't addressed in this article, visit the Azure forums on [MSDN and Stack Overflow](https://azure.microsoft.com/support/forums/). You can post your issue in these forums, or post to [@AzureSupport on Twitter](https://twitter.com/AzureSupport). You also can submit an Azure support request.

To submit a support request, go to the [Azure support page](https://azure.microsoft.com/support/options/) and select **Get support**.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

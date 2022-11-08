---
title: How to start Azure Windows VM with Last Known Good Configuration
description: Describes how to start a VM that fails to boot by using the Last Known Good Configuration feature.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
---
# How to start Azure Windows VM with Last Known Good Configuration

If you've recently installed new software or changed some Windows settings, and your Azure Windows virtual machine (VM) stops booting correctly, you might have to start the VM by using the Last Known Good Configuration for troubleshooting. This article describes how to do this.

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4016731

## Step 1: Attach the OS disk of the VM to another (troubleshooter) VM as a data disk

1. Delete the VM. Make sure that you select the **Keep the disks** option when you do this.
2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM. Open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.

## Step 2: Modify the registry hive on the OS disk

1. On the OS disk you attached, navigate to `\windows\system32\config`. Copy all the files as a backup in case a rollback is required.
2. On the troubleshooting VM, open Registry Editor (regedit.exe).
3. Click the **HKEY_USERS** key, and then select **File > Load Hive** on the menu.
4. Navigate to `\windows\system32\config\SYSTEM` type a name for the hive, such as **ProblemSystem**. After you do this, you will see the registry hive under **HKEY_USERS**.

    :::image type="content" source="media/start-vm-last-known-good/registry-editor.png" alt-text="Screenshot shows registry key ProblemSystem under HKEY_USERS." border="false":::

5. Expand to `HKEY_USERS/ProblemSystem/Select`, and then modify the following values based on the OS version:

    For Windows Server 2012 R2 and older versions:

    | Value name| Change the value to |
    |---|---|
    | HKEY_USERS\ProblemSystem\Select\Current|  2 |
    | HKEY_USERS\ProblemSystem\Select\Default| 2 |
    | HKEY_USERS\ProblemSystem\Select\Failed| 1 |
    |HKEY_USERS\ProblemSystem\Select\LastKnownGood|3|

    For Windows 10, Windows Server 2016, and newer versions:

    | Value name| Change the value to |
    |---|---|
    | HKEY_USERS\ProblemSystem\Select\Current| 2 |
    | HKEY_USERS\ProblemSystem\Select\Default| 2 |
    | HKEY_USERS\ProblemSystem\Select\Failed| 1 |
    |HKEY_USERS\ProblemSystem\Select\LastKnownGood|2|

    > [!NOTE]
    > If the VM was restarted on a Last Known Good Configuration before, the value on Current, Default, Failed and LastKnownGood will be increased in 1.  So, to boot by using Last Known Good Configuration, add 1 to all those values. For example, you should set `HKEY_USERS\ProblemSystem\Select\Current` to **3** if the VM was restarted on a **Last Known Good Configuration** before.
6. Select `HKEY_USERS\ProblemSystem`, and then select **Unload Hive** on the **File** menu.
7. Detach the repaired OS disk from the troubleshooting VM. Then, [create a new VM from the OS disk](/azure/virtual-machines/windows/create-vm-specialized-portal). You may have to wait about 10 minutes for Azure to release the disk.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

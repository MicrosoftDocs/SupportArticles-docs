---
title: Hyper-V virtual machine doesn't start with error 0x80070005
description: Discusses that a Hyper-V virtual machine may not start, and you receive a General access denied error (0x80070005). Provides a resolution.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:virtual-machine-will-not-boot, csstroubleshoot
---
# Hyper-V virtual machine may not start, and you receive an error 0x80070005: General access denied error

This article helps fix the error 0x80070005 that occurs when a Hyper-V virtual machine fails to start.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2249906

## Symptoms

A Hyper-V virtual machine may fail to start, and you receive an error message that resembles the following:

> An error occurred while attempting to start the selected virtual machine(s).
>
> 'VMName' failed to start.
>
> Microsoft Emulated IDE Controller (Instance ID
{83F8638B-8DCA-4152-9EDA-2CA8B33039B4}): Failed to Power on with Error 'General
access denied error'
>
> IDE/ATAPI Account does not have sufficient privilege to open attachment
'E:\VMs\VMName\Disk0.vhd. Error: 'General access denied error'
>
> Account does not have sufficient privilege to open attachment
'E:\VMs\VMName\Disk0.vhd. Error: 'General access denied error'

If you click **See details** in the message window, the following information is displayed:

> 'VMName' failed to start. (Virtual machine ID
5FC5C385-BD98-451F-B3F3-1E50E06EE663)
>
> 'VMName' Microsoft Emulated IDE Controller (Instance ID
{83F8638B-8DCA-4152-9EDA-2CA8B33039B4}): Failed to Power on with Error 'General
access denied error' (0x80070005). (Virtual machine ID
5FC5C385-BD98-451F-B3F3-1E50E06EE663)
>
> 'VMName': IDE/ATAPI Account does not have sufficient privilege to open attachment
'E:\VMs\VMName\Disk0.vhd. Error: 'General access denied error' (0x80070005). (Virtual
Machine ID 5FC5C385-BD98-451F-B3F3-1E50E06EE663)
>
> 'VMName': Account does not have sufficient privilege to open attachment
'E:\VMs\VMName\Disk0.vhd. Error: 'General access denied error' (0x80070005). (Virtual
Machine ID 5FC5C385-BD98-451F-B3F3-1E50E06EE663)

> [!NOTE]
>
> - This error message references either the Microsoft Emulated IDE Controller or the Synthetic SCSI Controller.
> - This error message references either a virtual hard disk (.vhd) file or a snapshot file (.avhd).
> - The Virtual Machine ID is unique to every virtual machine.

## Cause

This issue occurs if the permissions on the virtual hard disk (.vhd) file or the snapshot file (.avhd) are incorrect.

Every Hyper-V virtual machine has a unique Virtual Machine ID (SID). If the Virtual Machine SID is missing from the security permissions on the .vhd or .avhd file, the virtual machine does not start, and you receive the error 0x80070005 (General access denied error) that is mentioned in the [Symptoms](#symptoms) section.

## Resolution

To resolve this issue, add the Virtual Machine SID to the virtual hard disk (.vhd) file or to the snapshot file (.avhd).

To add the Virtual Machine SID to a .vhd or .avhd file, follow these steps:

1. Note the Virtual Machine ID that is listed in the error 0x80070005 (General access denied error).

    For example, consider the following error message:

    > 'VMName': IDE/ATAPI Account does not have sufficient privilege to open attachment
    'E:\VMs\VMName\Disk0.vhd. Error: 'General access denied error' (0x80070005). (Virtual
    Machine ID 5FC5C385-BD98-451F-B3F3-1E50E06EE663)

    In this example, the Virtual Machine ID is 5FC5C385-BD98-451F-B3F3-1E50E06EE663.

2. Open an elevated command prompt.
3. To give the Virtual Machine ID (SID) access to the .vhd or .avhd file, type the following command, and then press Enter:

    ```console
    icacls <Path of .vhd or .avhd file> /grant "NT VIRTUAL MACHINE\ <Virtual Machine ID from step 1> ":(F)
    ```

    For example, to use the Virtual Machine ID that you noted in step 1, type the following command, and then press Enter:

    ```console
    icacls "E:\VMs\VMName\Disk0.vhd" /grant "NT VIRTUAL MACHINE\5FC5C385-BD98-451F-B3F3-1E50E06EE663":(F)
    ```  

4. Start the virtual machine.

## More information

If permissions on the Hyper-V virtual machine configuration file (.xml file) are incorrect, the virtual machine fails to start and returns the following error message:

> 'Unnamed VM' failed to initialize.
>
> An attempt to read or update the virtual machine configuration failed because access was denied.

If you click **See details** in the message window, the following error message is displayed:

> 'Unnamed VM' failed to initialize. (Virtual machine 7E77503A-A26B-4BB5-9846-396F49A30141)
>
> 'Unnamed VM' failed to read or update the virtual machine configuration because access was denied: General access denied error (0×80070005). Check the security settings on the folder in which the virtual machine is stored. (Virtual machine 7E77503A-A26B-4BB5-9846-396F49A30141)

To resolve this issue, perform the steps in the "Resolution" section to add the Virtual Machine SID to the .xml file. For example, run the following command:

```console
icacls "E:\VMs\VMName\7E77503A-A26B-4BB5-9846-396F49A30141.xml" /grant "NT VIRTUAL MACHINE\7E77503A-A26B-4BB5-9846-396F49A30141":(F)
```  

## References

For more information about Hyper-V, see [Hyper-V](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753637(v=ws.10)).

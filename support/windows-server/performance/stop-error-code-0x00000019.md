---
title: Error 0x19 when NTFS file system creates name in 8.3 format
description: Fixes a problem in which you may receive a Stop error 00000019 (Error 0x19) when NTFS generates a 8.3-formatted name for a file that has a long file name.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, bharathm, stevenxu
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
---
# Error message on a Windows Server 2003-based computer: Stop error code 0x00000019

This article provides workarounds for an issue where you receive a Stop error 00000019 when NTFS generates a 8.3-formatted name for a file that has a long file name.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 948289

## Symptoms

You may receive a Stop error message that resembles the following on a Windows Server 2003-based computer:

> STOP: 0x00000019 (**parameter1**, **parameter2**, **parameter3**, **parameter4**)  
BAD_POOL_HEADER

> [!NOTE]
>
> - The parameters in this Stop error message vary, depending on the configuration of the computer and on the type of the issue.
> - Not all 0x00000019 Stop errors are caused by this problem.

## Cause

This problem occurs because the pool memory is unexpectedly corrupted. This problem occurs when the NTFS file system creates a name in the 8.3 name format for a file that has a long file name.

## Workaround

To work around this problem, disable 8.3 name creation. To do this, use one of the following methods.

### Method 1

1. Run the following command at a command prompt:

    ```console
    fsutil behavior set disable8dot3 1
    ```

2. Restart the computer.

### Method 2

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the registry subkey:`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem`.
3. Right-click **NtfsDisable8dot3NameCreation**, and then click **Modify**.
4. In the **Value data** box, type *1*, and then click **OK**.

    > [!NOTE]
    > The default value is 0.
5. Exit Registry Editor.
6. To make this registry change effective, restart the computer.

## Status

Microsoft has confirmed that this is a problem.

## More information

It is not recommended that this registry key is placed on servers unless the customer has submitted the Memory dump file to Microsoft for analysis and the root cause has been determined.

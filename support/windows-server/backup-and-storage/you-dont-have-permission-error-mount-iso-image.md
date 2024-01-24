---
title: You don't have permission error
description: Helps to fix the error "You don't have permission" when you try to mount an ISO image.
ms.date: 12/09/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, dewitth, ctimon
ms.custom: sap:partition-and-volume-management, csstroubleshoot
ms.subservice: backup-and-storage
---
# "You don't have permission" error message when you try to mount an ISO image

This article helps to fix the error "You don't have permission" when you try to mount an ISO image.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 2993573

## Symptoms

When you try to mount an ISO image in Windows Server 2012 R2, Windows Server 2012, Windows 8.1, or Windows 8, you receive the following error message:

> Couldn't Mount File
>
> You don't have permission to mount the file.

The message window is shown in the following screenshot.

:::image type="content" source="media/you-dont-have-permission-error-mount-iso-image/could-not-mount-file.png" alt-text="You don't have permission to mount the file error that occurs when you mount an I S O image." border="false":::

This problem occurs when you perform either of the following operations:  

- You double-click an .iso file or you use disk image tools to mount an ISO image from either a local or network source.
- You try to mount an ISO image through the shortcut menu in Windows Explorer.  

> [!NOTE]
> Although you receive the error message, the ISO image is mounted successfully in most cases.

### Other reported symptoms

- When you click an .iso file in Windows Explorer to try to mount the ISO image, the operation fails and you receive the following error message:

    >Sorry there was a problem mounting the file

- You receive the following Windows PowerShell error message:

    >Error:17098 - The component store has been corrupted

- When you run the `mountdiskimage` `-imagepath c:\images\windows8.1_enterprise.iso` command in PowerShell, the operation fails and you receive the following error message:  

    >mount-diskimage: "The version does not support this version of the file format".  
    Hresult 0xc03a0005

## Cause

This problem may occur for one or more of the following reasons:  

- A USB media reader device is attached to the computer.
- Removable media is mounted in the computer.
- The .iso file that you are trying to mount is a sparse file.  

To determine whether a file is a sparse file, use one of the following methods.

### Method 1: Check the file properties

1. In the `C:\images` folder, right-click the Windows8.1_Enterprise.iso file.
2. Click **Properties**.
3. Click **Details**.
4. Check the **Attributes** line for the letter "P" to indicate a sparse file.

### Method 2: Use PowerShell

1. Run the following Windows PowerShell command:  

    ```powershell
    (get-item c:\test\mydisk.iso).attributes
    ```  

2. Check for the word "SparseFile" in the command output to indicate a sparse file.

## Resolution

To resolve this problem, use one of the following methods.

### Resolution 1

Copy the ISO file to a new file by saving it to a different folder or giving it a different name.

This process should remove the sparse attribute and enable the file to be mounted.

### Resolution 2

If you have a flash media reader or any removable media, try to eject the removable media. Then, reassign the drive letters in such a manner that you leave a lower drive letter available to mount the ISO image. The file might not behave correctly if it has an assigned drive that follows other drives.

For example, consider the following layout.

|Drive|Assignment|
|---|---|
|C|Hard disk|
|D|DVD|
|E|USB device|
|F|ISO (auto assigned)|

In this layout, the ISO image is auto assigned to drive F when it is mounted. It causes the error that is mentioned in the "Symptoms" section. However, the drive continues to function.

After you eject the ISO drive F, reassign the USB drive to drive F. Now when you mount the ISO image, it will be auto assigned to drive E without generating any errors. The new layout will be as follows.

|Drive|Assignment|
|---|---|
|C|Hard disk|
|D|DVD|
|E|ISO (auto assigned)|
|F|USB device|


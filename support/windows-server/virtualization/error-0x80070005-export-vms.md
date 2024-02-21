---
title: Error 0x80070005 when you export VM over Network
description: Provides a solution to an issue where the error 0x80070005 occurs when you export a virtual machine to a network share.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:backup-and-restore-of-virtual-machines, csstroubleshoot
---
# Error 0x80070005 when you export Hyper-V VMs over the Network

This article provides a solution to an issue where
the error 0x80070005 occurs when you export a virtual machine to a network share.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2008849

## Symptoms

You use Hyper-V on a computer that is running Windows Server 2008 or Windows Server 2008 R2.

- In Hyper-V Manager, you try to export a virtual machine to a network share.
- You have the full control permissions on the network share.

In this scenario, the export may fail with an error that resembles the following:

> **An error occurred while attempting to export the virtual machine.**  
Failed to copy file during export.  
Failed to copy file from '\<source path of VHD file>' to '\<network share>': General access denied error (0x80070005)

## Cause

When you export a virtual machine in Hyper-V manager, it is the System account of the Hyper-V host that executes the export.
This problem occurs because the Hyper-V host does not have permission on the network share.

## Resolution

Ensure the permissions allow the Computer account of the Hyper-V host performing the Export to update the shared folder.

> [!NOTE]
> While following steps are specific to 2008, the idea is the same for updating the share and NTFS permissions if the share is hosted on another version of Windows.

### Update the NTFS level permissions

1. On the destination server, right-click on the shared folder and select **Properties**.
2. Select the **Security** tab.
3. Click **Edit** button and click the **Add** button in the permissions dialog box.
4. Click **Oject Types** and select **Computers** if not already done and click **OK**.  
5. In the dialog **Enter the object names to select** provide the name of Hyper-V host machine and click **Check Names**.  
6. With the Hyper-V host machine name select, click **Allow** by Full control and click **OK**.  

### Update the share level permissions

1. On the destination server, Right-click on the shared folder and select Properties.
2. Select the **Sharing** tab.
3. Click **Advanced Sharing...**.
4. On the **Advanced Sharing** dialog, click **Permissions** and then **Add**.
5. Click **Oject Types** and select **Computers** if not already done and click **OK**.
6. In the dialog **Enter the object names to select** provide the name of Hyper-V host machine and click **Check Names**.  
7. With the Hyper-V host machine name select, click **Allow** by Full control and click **OK**.

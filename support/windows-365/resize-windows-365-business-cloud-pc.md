---
title: Resize a Windows 365 Business Cloud PC
description: Discusses how to resize a Cloud PC's RAM, CPU, or storage based on your available licenses.
manager: dcscontentpm
ms.date: 02/12/2026
ms.topic: troubleshooting
ms.reviewer: kaushika; v-appelgatet
ms.custom:
- sap:resizing
- pcy:WinComm User Experience
appliesto:
- <a href=https://learn.microsoft.com/lifecycle/products/windows-365target=_blank>Supported versions of Windows 365</a>
---
# Resize a Windows 365 Business Cloud PC

The Resize remote action preserves user and disk data. You can use this remote action to modify a Cloud PC in the following ways:

- Upgrade the RAM, CPU, and storage size of a Cloud PC.
- Downgrade the RAM and CPU of a Cloud PC.
- Resize a single Cloud PC.

> [!IMPORTANT]  
>
> - You can't use the Resize remote action to downsize disk space.
> - You can't use the Resize remote action on Cloud PCs that use Graphical Processing Units (GPU Cloud PCs). Although GPU Cloud PCs might show up in the resize flow, trying to resize a GPU Cloud PC results in an error.

> [!NOTE]  
> These operations don't require you to reprovision the Cloud PC.

Consider resizing a Cloud PC when a user needs changes in the following components:

- More RAM and vCPU cores to run CPU-intensive applications.
- More disk space for storing files.
- Less RAM and fewer vCPU cores to run their current workload applications.

## Resizing and licenses

The following Business Cloud PC licenses support the Resizing remote action:

- Direct licenses.
- Paid, preview, and trial licenses.
- Single device operations.

During the resizing process, the Windows 365 service automatically unassigns the original license and assigns the new license on behalf of the administrator. To avoid accidentally creating additional Cloud PCs, don't try to manually assign licenses.

## Prerequisites

- To resize a Cloud PC that uses a direct-assigned license, you have to belong to the Windows 365 Administrator role. Alternatively, you can use a custom role that includes the permissions of this built-in role.

- Before you use the Resize remote action, make sure that your license inventory includes available licenses for the resized Cloud PC configuration. To request more licenses, contact your procurement admin. You can also purchase licenses from one of the available channels, such  EA, CSP, MCA, and Web Direct.

- The resizing action disconnects the user from their session. This process might cause the loss of any unsaved work. To avoid such disruptions, before you begin any resizing action, coordinate with the end users. Contact them and instruct them to save their work and sign out, and that their Cloud PCs might be offline for 15 to 20 minutes. After they've signed out, begin the resizing action.

## How to resize a Windows 365 Business Cloud PC

1. Sign in to the [User Details Panel - Microsoft 365 admin center](https://admin.microsoft.com/Adminportal/Home#/users), and then select the user whose Cloud PC that you want to resize.

   :::image type="content" source="./media/resize-windows-365-business-cloud-pc/windows-365-active-user-list.png" alt-text="User details panel of the Microsoft 365 admin center, showing one user in the list.":::

1. In the user's Properties, select **Devices** > **Resize**.

   :::image type="content" source="./media/resize-windows-365-business-cloud-pc/user-properties-dialog-box.png" alt-text="Devices pane of a user's properties. Resize is highlighted.":::

1. Select one of the available options. The list of options is based on your inventory's available licenses.

   :::image type="content" source="./media/resize-windows-365-business-cloud-pc/resize-user-options-dialog-box.png" alt-text="List of the size options for a device, based on the available licenses.":::

1. Select **Resize**.

   Resizing can take from 15 to 20 minutes. You can monitor the status in the Windows 365 provisioning blade.

1. Review the results of the Resize action.

   If some listed devices are marked as "Resize not supported," those devices aren't resized. During a bulk resize operation, if some devices can't be resized, the operation continues for the other devices. To identify issues, review any status messages and details  After you resolve the issue, you can try to resize the affected devices again.


---
title: Configure Shadow Copies of Shared Folders feature
description: Describes how to configure a shadow copy of a clustered share in Windows Server 2003.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
ms.subservice: high-availability
---
# Configure the Shadow Copies of Shared Folders feature on a Windows Server 2003-based server cluster file share

This article describes how to configure a Shadow Copies of Shared Folders target on a server cluster in Microsoft Windows Server 2003.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 838421

## Summary

Windows Server 2003 includes the Shadow Copies of Shared Folders feature to permit you to revert to an earlier version of a specific file or a group of files in a folder.

## Configure a shadow copy

To configure a shadow copy, you must first create a file share resource in your server cluster by using the Cluster Administrator tool. Additionally, Microsoft recommends that you add another hard disk to the same group that contains the file share resource. This additional disk will function as the destination drive for shadow copy backups. For additional information about how to create a file share on a Microsoft Windows 2000-based server cluster, click the following article number to view the article in [How to create file shares on a cluster](https://support.microsoft.com/help/224967).

> [!NOTE]
> Although you can use the same drive that contains your file share resource as the destination drive for your shadow copies, for performance reasons, Microsoft recommends that you use a separate physical hard disk drive.

> [!IMPORTANT]
> You must assign a drive letter to the hard disk that you use for shadow copy backups. If possible, avoid creating a shadow copy on a mount point. Setting shadow storage on a mount point in a cluster is supported on a server cluster in Windows Server 2003.

When you configure shadow copies on the server cluster, a dependency is automatically configured between the host drive and the destination drive. You do not have to manually create this dependency. To configure shadow copies, follow these steps:

1. Click **Start**, right-click **My Computer**, and then click **Manage**.
2. Right-click **Shared Folders**, point to **All Tasks**, and then click **Configure Shadow Copies**.
3. In the **Select a volume** list, click the drive that contains the file share resource that you want to create a shadow copy for. For example, click drive R.
4. Click **Settings**, and then click the destination drive for the shadow copy in the **Located on this volume** list.

    > [!NOTE]
    > To appear in the **Located on this volume** list, the destination drive must contain a share.
5. If you do not want to configure a limit to the size of the shadow copy, click **No limit**.
6. Click **OK**, and then click **Enable**.
7. Click **Yes** to enable shadow copies.

    > [!NOTE]
    > There may be a delay while the initial shadow copy is created.
8. Click **OK**.

When you enable shadow copies, the following behavior occurs:

- The host drive becomes dependent on the destination drive.
- A Volume Shadow Copy Service Task resource type is created in the resource group that contains the drives that you created the shadow copy on. This resource is used to synchronize shadow copy schedules.

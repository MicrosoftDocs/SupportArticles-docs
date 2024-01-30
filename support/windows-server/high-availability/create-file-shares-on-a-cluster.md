---
title: How to create file shares on a cluster
description: Describes how to create file shares on a cluster.
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
# How to create file shares on a cluster

This article describes how to create file shares on a cluster.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 224967

## Summary

To create highly available file shares on a cluster, you should create them using either Cluster Administrator (CluAdmin.exe) or the cluster API set. When the share is placed in a group with other related resources (IP Address, Network Name, and a storage device), the share is available from whichever node in the cluster owns the group of resources. This article lists basic steps for creating a basic File Share resource.

## Steps to create a file share on a server cluster

To create a file share on a server cluster, follow these steps:

> [!NOTE]
> The information in this article is also valid for the Windows 2000 Cluster service.

1. Open Windows Explorer and create a folder on a shared disk that you want to share out for users.

2. Assign the appropriate NTFS file level permissions on the folder. Make sure that the account used to start the Cluster Service has at least READ rights to the folder.

    > [!NOTE]
    > Do not share the folder in Windows Explorer as you normally would for a file share. If you do not grant the Cluster account the appropriate permissions or share the folder through Windows Explorer, it may cause the cluster file share to fail. This also includes any administrative shares that already exist, you do not want to create shares for the root of the drive (Q$) for example.

3. Start Cluster Administrator (CluAdmin.exe).

4. Select a group that has an existing IP Address and Network Name resources. If you do not have these resources created, you will need to complete this before continuing.

5. Right-click and select **New**, then **Resource**.

6. Fill in an administrative name and description for the resource. From the **Resource Type** pull down, select **File Share**, click **Next**.

    > [!NOTE]
    > This is the name that will be displayed in Cluster Administrator and is only used for administrative purposes. This is not the share name that users will connect to, give the resource a name that will be easy to identify and manage.

7. Select the nodes that you want to be possible owners of the resource. Click **Next** to leave all nodes as possible owners.

    > [!NOTE]
    > Possible Owners defines whether a resource is ever able to failover to a specific node. Use extreme caution in defining Possible Owners because defining a possible owner for a single resource will affect the failover for the entire group.

8. Select a Network Name and Physical Disk resource that the file share will be dependent on.

    > [!NOTE]
    > Dependencies serve two functions.

    1. They define the bindings for a resource. You want the file share to be dependent on the Network Name resource that clients are going to use when connecting to the file share. The IP Address resource that the Network Name resource is dependent upon is the IP Address that will be used when connecting to this share. You never want a file share resource to be dependent on the "Cluster Name" resource.

    2. They define the start order for a resource. You want to make sure that the network name that the share is going to be created under and the physical disk where the folder resides that is going to be shared are online and available before attempting to bring the File Share online.

    When creating a dependency 'Tree', it is best to keep it as simple as possible. A file share resource should always be dependent on a Network Name that the clients will use to connect to this share and Physical disk resource where the folder is located. The Physical Disk resource should never be dependent on anything. The Network Name resource should be dependent on an IP Address resource that the virtual server will be associated with. The IP Address resource should not be dependent on anything.

9. On the **File Share Parameters** screen, fill in the following information and click **Finish**:

    1. The "Share Name" is the name of the share that will be created for the UNC when clients connect. This needs to be a valid NetBIOS name, and is recommended to be a valid URL name as well.

    2. The "Path" is the full path on the local node to the shared disk where the folder is located. For example: T:\\Users.

    3. The "Comment" is the information about the share that will appear when a client browses the share.

10. By default, when resources are created, they are in an offline state. The following steps are a best practice. Follow them to isolate the effect of the resource failure on other production resources. This will help until the resource is ready to be brought into production for users.

    1. Right-click the resource, and then click **Properties**.
    2. Click the **Advanced** tab, click to select the **Do not restart** button, and then click **OK**.
    3. Bring the resource online. Make sure that it functions correctly.
    4. After you confirm that the resource functions correctly, and you are ready to bring it into production, take the resource offline. Then, click to select the **Restart** button.
    5. Bring the resource online.

> [!NOTE]
>
> - The **User Limit** dialog can be used to limit the number of simultaneous users.
> - Click the **Permissions** button to set share level permissions. Only domain level groups should be used in defining share level permissions because local groups and user accounts do not reside on the other node, and the permissions will not take effect when the file share is failed over. The only exception to this is if all nodes in the cluster are domain controllers. It is recommended to use NTFS permissions instead of share level permissions on a server cluster.
> - The **Advanced** dialog can be used to create a Dynamic file share or a DFS Root. The **Advanced** button was a feature that was added in Windows NT 4.0 Service Pack 4. If you are running Windows NT 4.0, but you do not see the **Advanced** button, reapply Windows NT 4.0 Service Pack 4 or higher.

When browsing the file share, file shares for other virtual servers on the same cluster may be visible. If you are going to create a large number of file share resources, it may be easier to script the creation using Cluster.exe.

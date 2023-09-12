---
title: Changing the IP address of network adapters in cluster server
description: Discusses how to change the IP address of network adapters in a cluster server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: robbe, kaushika
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
ms.technology: windows-server-high-availability
---
# Changing the IP address of network adapters in cluster server

This article describes how to change the IP addresses of the network adapters in the nodes of a cluster.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 230356

## More information

During this procedure, it's important that the cluster server maintains a connection to the network. This is necessary so that it can communicate with a domain controller to validate the cluster server Service account.

This article assumes that there are two nodes named A and B.

> [!NOTE]
> For more information about clustered Microsoft SQL Server installations, click the following article number to view the article in the Microsoft Knowledge Base:
>
>[244980](https://support.microsoft.com/help/244980) How to change the network IP addresses of SQL Server failover cluster instances  

1. Change the IP address of the network adapter on node A. This may require the computer to be rebooted. If you're prompted to restart the computer, do so.
2. Start Cluster Administrator and open a connection to the cluster. To administer the cluster, you need to open a connection to "." (without quotation marks) in Cluster Administrator when you're prompted to do so. You must perform this process on one of the nodes in the cluster. If you do this remotely, it may be possible to open a connection to the name of the node itself. During this process, Cluster Administrator may respond with the following error message:
    > A connection to the cluster at  
    **cluster name** could not be opened. This may be caused by the Cluster Service on node **cluster name** not being started. Would you like Cluster Administrator to attempt to start the Cluster Service on node  **cluster name**?

    This occurs because Cluster Administrator attempts to connect to the last cluster it administered.
3. Double-click the IP Address resource to open its properties.
4. On the Parameters tab in the IP Address resource properties, make sure that the **Network to Use** box contains the new network as the network to use.
5. Fail all groups over to the functional node A.
6. Change the IP addresses for the network adapters in node B.
7. Reboot the computer.
8. When both nodes agree on the subnets, the old networks disappear and the new networks are created.
9. You can rename the networks at this time.

You use "." to administer the cluster because the IP Address resource doesn't come online when the Cluster service recognizes a new network and no longer uses the old network.

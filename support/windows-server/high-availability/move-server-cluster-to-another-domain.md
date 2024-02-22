---
title: Move Windows Server cluster to another domain
description: Describes how to move a Windows Server cluster from one domain to another.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:initial-cluster-creation-or-adding-node, csstroubleshoot
---
# Move a Windows Server cluster from one domain to another

Windows clustering provides high availability of server resources. This article describes how to move a Windows Server Cluster from one domain to another.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 269196

> [!NOTE]
> We do not recommend performing this type of move in a production environment.

## More information

Because of an increased dependence on Active Directory Domain Services, Microsoft does not support moving an already installed and configured Windows Server 2008, Windows Server 2008 R2 and Windows Server 2012 failover cluster from one domain to another. The following steps are not for Windows Server 2008, Windows Server 2008 R2 and Windows Server 2012 you must create a new cluster. Additionally, you must recluster highly available applications.

Although you can move a Microsoft Windows 2000-based server cluster or a Windows Server 2003-based server cluster from one domain to another, we recommend that you rebuild the cluster in the new domain so that all installed services and applications are configured correctly in the new domain. You can use the steps in this article to enable the cluster service to start and operate in a new domain. However, these steps will not make sure that all resources will be available in the new domain.

> [!Note]  
>
> - Microsoft does not provide support to administrators who try to move resources from one domain to another if the underlying operation is unsupported. For example, Microsoft does not provide support to administrators who try to move a Microsoft Exchange server from one domain to another.  
> - You cannot move Windows NT 4.0-based clusters from one domain to another if any of the nodes in the cluster are domain controllers.

> [!WARNING]
> We recommend that you perform a full backup of all data on all shared hard disks on each node in the cluster before you try to move the cluster.

The steps in this article enable the Cluster service to start in the new domain. However, you may be unable to bring the resources online in the new domain, and the resources that can be brought online may not work correctly.

To move the cluster:

1. Create a user account for the Cluster service in the new domain. You must make sure that no Group Policy objects (GPOs) or security template requirements remove any of these rights. The user account must have the following rights:
   - Lock pages in memory.
   - Log on as a service.
   - Act as part of the operating system. (Windows 2000 and Windows Server 2003)
   - Back up files and directories.
   - Increase quotas.
   - Increase scheduling priority.
   - Load and unload device drivers.
   - Restore files and directories.
   - Adjust memory quotas for a process (Windows Server 2003).

    In addition, the Cluster service account must have administrative permissions on all nodes in the cluster.

2. Set the Startup value for the Cluster service to Manual on all nodes in the cluster:

    1. Click Start, point to Settings, click Control Panel, and then double-click Services.
    2. Click **Cluster Service**, and then click Startup.
    3. Change the Startup Type from Automatic to Manual.
    4. Click OK.
3. Stop the Cluster service on all cluster nodes:

    1. Click Start, point to Settings, click Control Panel, and then double-click Services.
    2. Click **Cluster Service**, and then click Stop.
4. Turn off all nodes except one.
5. Move the node into the new domain by using procedures that are appropriate to your operating system. Complete the process, and then restart the node.
6. On the node, change the service account that is used by the Cluster service to log on to the domain to the user account that you created.
7. Start the Cluster service on that node.
8. Use Cluster Administrator to verify that there are no issues. Try to bring all resources online. Test the functionality of all resources from client computers, and then check the Event Viewer System log for error messages.

    > [!NOTE]
    > At this point, you can still cancel the move by moving this node back into the old domain and starting the nodes that are not moved.

9. If the first node move is successful, continue to migrate the other nodes in the cluster to the new domain starting with step 5 for each node.

> [!WARNING]
> If you move a computer that has a Virtual Microsoft SQL Server 7.0 instance to another domain, and you do not first uncluster SQL Server 7.0, the SQL cluster resources may fail. Because of the failure of the SQL Server 7.0, you may have to work with Microsoft CSS to manually uncluster SQL Server 7.0. After you have unclustered SQL Server 7.0, you must use the SQL Cluster Failover Wizard to reestablish your clustered SQL Server computers. You may also have to completely remove SQL Server 7.0, and then reinstall it.

> [!NOTE]
> If your DNS server is in a secure zone, DNS registrations may be affected. In a secure DNS zone, the credentials of the account performing the registration are captured and stored with the records. This protects them from being maliciously replaced with incorrect values. For a cluster virtual server, the original cluster service account would be used for this purpose. You may see DNS registration failures in the System Event logs, typically error 9005 (refused). If this occurs, delete the records on the DNS server, and bring the Network Name offline, then online again so that the new credentials can be recorded with the registration.

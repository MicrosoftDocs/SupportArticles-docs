---
title: Use Windows Server cluster nodes as DCs
description: Describes how to use Windows Server cluster nodes as domain controllers.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Clustering and High Availability\Setup and configuration of clustered services and applications, csstroubleshoot
---
# How to use Windows Server cluster nodes as domain controllers

This article describes how to use Windows Server cluster nodes as domain controllers.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 281662

## Summary

> [!NOTE]
> The information in this article addresses a situation that you do not generally encounter in most Information Technology architectures.

Links to all of the articles that are referenced within this article are located in the "References" section.

There are instances when you can deploy cluster nodes in an environment where there are no pre-existing Active Directory. This scenario requires that you configure at least one of the cluster nodes as a domain controller. It is recommended that 2+ nodes be configured as domain controllers, so that there be at least one backup domain controller. Keeping the configuration of the nodes consistent across the cluster is a general best practice, and you may wish to enable all nodes as domain controllers. Because Active Directory depends on the Domain Name System (DNS), each domain controller must be a DNS server if there is not another DNS server available that supports dynamic updates or SRV records. (Microsoft recommends that you use Active Directory-integrated zones). For more information, see article 255913.

## More information

Depending on the workload deployed on the Failover Cluster, there are different support policies and recommendations:  

- Microsoft Exchange Server - Is not supported in a clustered configuration where the cluster nodes are domain controllers. For more information, click the following article number to view the article in the Microsoft Knowledge Base: [898634](https://support.microsoft.com/help/281662) Active Directory domain controllers are not supported as Exchange Server cluster nodes.
- Microsoft SQL Server - Is not supported in a clustered configuration where the cluster nodes are domain controllers. For more information, click the following to view more information: [Installing SQL Server on a Domain Controller](/previous-versions/sql/sql-server-2008/ms143506(v=sql.100))  
- Windows Server Hyper-V - It is not recommended to run other workloads (including the domain controller role) in the hypervisor parent partition.  

If you have a cluster deployment in which there is no link with a domain, you must configure the cluster nodes as domain controllers prior to setting up the cluster. If the connectivity between cluster nodes and domain controllers is such that the link is either slow or unreliable, consider having a domain controller co-located at the same site or location as the cluster.  

Consider the following important points when you are deploying Windows Server 2003, Windows Server 2008, Windows Server 2008 R2, or Windows Server 2012 Failover Clustering nodes as domain controllers:  

- It is not recommended to combine the Active Directory Domain Services role and the Failover Cluster feature on Windows Server 2003, Windows Server 2008, or Windows Server 2008 R2
- It is not supported for a Windows Server 2003, Windows Server 2008, or Windows Server 2008 R2 node in a Failover Cluster to be a Read-Only Domain Controller (RODC)
- It is not supported for a Windows Server 2003, Windows Server 2008, or Windows Server 2008 R2 Failover Cluster running Microsoft Exchange Server or Microsoft SQL Server to be a domain controller
- It is not supported to combine the Active Directory Domain Services role and the Failover Cluster feature on Windows Server 2012
- It is recommended that at least two nodes be configured as domain controllers and potentially all nodes for consistency if cluster nodes are configured as domain controllers.
- There is overhead that is associated with the running of a domain controller. A domain controller that is idle can use anywhere between 130 to 140 megabytes (MB) of RAM, which includes the running of Failover Clustering. There is also replication traffic if these domain controllers have to replicate with other domain controllers within the domain and across domains. Most corporate deployments of clusters include nodes with gigabytes (GB) of memory so this is not generally an issue.
- If the Windows Server 2003 cluster nodes are the only domain controllers, they each have to be DNS servers as well, and they should point to themselves for primary DNS resolution, and to each other for secondary DNS resolution. You must address the problem of the ability to not register the private interface in DNS, especially if it is connected by way of a crossover cable (two-node only). For additional information about how to configure the heartbeat interface, click the following article number to view the article in the Microsoft Knowledge Base: [258750](https://support.microsoft.com/help/258750) Recommended private "heartbeat" configuration on a cluster server  

    However, before you can accomplish step 12 in article 258750, you must first modify other configuration settings, which are outlined in the following article in the Microsoft Knowledge Base:
 [275554](https://support.microsoft.com/help/275554) The host's "A" record is registered in DNS after you choose not to register the connection's address  

- If the cluster nodes are the only domain controllers, they must each be global catalog servers, or you must implement domainlets.
- The first domain controller in the forest takes on all flexible single master operation (FISMO) roles, refer to article 197132. You can redistribute these roles to each node. However, if a node fails, the flexible single master operation roles that the node has taken on are no longer available. You can use Ntdsutil to forcibly take away the roles and assign them to the node that is still running (refer to article 223787). Review article 223346 for information about placement of flexible single master operation roles throughout the domain.
- Clustering other programs, such as SQL or Exchange, in a scenario where the nodes are also domain controllers, may not result in optimal performance due to resource constraints
- You cannot cluster domain controllers for fault tolerance. You can promote computers to be domain controllers, and then you can install the Cluster service on those computers, but there is no method to store Active Directory on any one of the cluster's managed drives. There is no "failover" of Active Directory. Having multiple domain controllers are by the very nature deliver high availability of directory services.
- Nodes in a Windows Server 2003, Windows Server 2008, and Windows Server 2008 R2 Failover Cluster must have access to a Read-Write Domain Controller
- It is supported to deploy a Windows Server 2012 Failover Cluster in an environment that only has access to a Read-Only Domain Controller (RODC)
- It is recommended to leave at least one domain controller on bare metal when deploying domain controllers inside of virtual machines with Windows Server 2008 and Windows Server 2008 R2

## References

For more information, click the following article numbers to view the articles in the Microsoft Knowledge Base:  
[255913](https://support.microsoft.com/help/255913) Integrating Windows 2000 DNS into an existing BIND or Windows NT 4.0-based DNS namespace  

[258750](https://support.microsoft.com/help/258750) Recommended private "heartbeat" configuration on cluster server  

[275554](https://support.microsoft.com/help/275554) The host's "A" record is registered in DNS after you choose not to register the connection's address  

[223787](https://support.microsoft.com/help/223787) Flexible single master operation transfer and seizure process  

[197132](../identity/fsmo-roles.md) Windows 2000 Active Directory FSMO roles  

[223346](https://support.microsoft.com/help/223346) FSMO placement and optimization on Windows 2000 domain controllers  

[234790](https://support.microsoft.com/help/234790) How to find servers that hold flexible single master operations roles  

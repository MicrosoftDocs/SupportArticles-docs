---
title: Network Name resource fails to come online
description: Provides a solution to an issue where Network Name resource fails to come online in a Windows Server 2008 R2-based failover cluster.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: rspitz, kaushika
ms.custom: sap:Clustering and High Availability\Cannot bring a resource online, csstroubleshoot
---
# Network Name resource fails to come online in a Windows Server 2008 R2 Service Pack 1 failover cluster

This article provides a solution to an issue where Network Name resource fails to come online in a Windows Server 2008 R2-based failover cluster.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2797272

## Symptoms

In a Windows Server 2008 R2 Service Pack 1-based cluster, when you attempt to bring Network Name resources for the Services and Applications online, the Network Name go into the failed state. However, the Cluster Network Name is online. Checking the event logs, you may see some events logged.

Additionally, when you generate the cluster log on the failure node, you may see the following entries:

> INFO [RES] Network Name \<VCO>: GetCoreNetnameObject_VSToken returning status 0  
INFO [RES] Network Name \<VCO>: Obtained the security token for cluster name account.  
INFO [RES] Network Name \<VCO>: Logon failed so priming local KDC cache to \\\\\<Member DC Name> for domain \<DC Name>, status = 0 .  
INFO [RES] Network Name \<VCO>: Logon failed so priming local KDC cache to \\\\\<Member DC Name> for domain \<DC Name>, status = 0 .  
ERR [RES] Network Name \<VCO>: Unable to Logon. winError 1326  
WARN [RES] Network Name \<VCO>: Unable to enumerate server tranports, error 5.  
.  
.  
INFO [RES] Network Name \<VCO>: adapter Local Area Connection 2 (1)  
ERR [RES] Network Name \<VCO>: The specified network name is currently hosted by some other system in the network, So no attempt will be made to reset the computer object's password associated with \<VCO>.

## Cause

The password for the VCO (Virtual Computer Object) is out of sync with Active Directory. The CNO (Cluster Name Object) attempts to reset it, however, before it can do so, it checks if there is another computer with the same name on the network, so as to not reset that computer's Active Directory object password erroneously. It fails because this check will return true if the C:\Windows\System32\drivers\etc\hosts file contains an entry for the Cluster node's NetBIOS name.

## Resolution

Edit the C:\Windows\System32\drivers\etc\hosts file and remove the entry for the Cluster node.

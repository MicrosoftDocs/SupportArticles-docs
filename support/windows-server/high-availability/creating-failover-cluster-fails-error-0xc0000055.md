---
title: Error 0xc000005e when creating failover cluster
description: Fixes the error 0xc000005e that occurs when you create a failover cluster with Windows Server 2012.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: eldenc, kaushika
ms.custom: sap:initial-cluster-creation-or-adding-node, csstroubleshoot
---
# Creating a Failover Cluster Fails with Error 0xc000005e

This article provides a solution to fix the error 0xc000005e that occurs when you create a failover cluster with Windows Server 2012.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2830510

## Symptoms

When attempting to run the Create Cluster Wizard to create a Failover Cluster with Windows Server 2012, the operation may fail. Additionally, you may receive the following error:

An error occurred while creating the cluster.
An error occurred creating cluster 'MyCluster'.
Unknown error (0xc000005e)

Note: An error 0xc000005e means STATUS_NO_LOGON_SERVER

Upon investigating the CreateCluster.mht that is located under C:\Windows\Cluster\Reports directory, you may notice the operation failure happens during the following:

Verifying computer object 'MyCluster' in the domain.
Unable to successfully cleanup.

## Cause

This problem can occur if TCP or UDP Port 464 is blocked.

## Resolution

To resolve this problem, ensure that port 464 for both TCP and UDP is open on all firewall network devices between the nodes in the cluster and the domain controller.

The error STATUS_NO_LOGON_SERVER is caused because the nodes in the cluster were unable to communicate with a domain controller to set the password when attempting to configure the computer objects in Active Directory. Port 464 is enabled by default in Windows Firewall on Windows Server 2012. 

## More information

For more information on the Active Directory service port requirements, see the following article:
 [Active Directory and Active Directory Domain Services Port Requirements](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd772723(v=ws.10))

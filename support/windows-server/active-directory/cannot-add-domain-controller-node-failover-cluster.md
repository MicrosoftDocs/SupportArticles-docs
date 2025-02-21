---
title: You cannot add a domain controller as a node in a failover cluster environment
description: Provides some information about how to add a domain controller as a node in a failover cluster environment
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:active directory\dcpromo and the installation or removal of domain controllers
- pcy:WinComm Directory Services
---
# You cannot add a domain controller as a node in a failover cluster environment

This article provides some information about how to add a domain controller as a node in a failover cluster environment.  

_Original KB number:_ &nbsp; 2795523

## Symptoms

When you build a Windows Server 2012 failover cluster environment, you cannot add a server that has the Active Directory Domain Services (AD DS) role as a node.

## Cause

We do not support combining the AD DS role and the failover cluster feature in Windows Server 2012.

## Status

This behavior is by design.

## More information

Although we do not recommend this, you can enable domain controllers as a cluster node in Windows Server versions earlier than Windows Server 2012. However, starting with Windows Server 2012, we no longer support this configuration. 

For more information about how to use domain controllers as nodes in failover clusters, click the following article number to view the article in the Microsoft Knowledge Base: 

[281662](https://support.microsoft.com/help/281662) How to use Windows Server cluster nodes as domain controllers

For more information about Microsoft support policy for Windows Server 2012 failover clusters, click the following article number to view the article in the Microsoft Knowledge Base:

[2775067](https://support.microsoft.com/help/2775067) The Microsoft support policy for Windows Server 2012 failover clusters

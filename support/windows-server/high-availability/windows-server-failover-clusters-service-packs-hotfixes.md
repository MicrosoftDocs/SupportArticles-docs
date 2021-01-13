---
title: Update Windows Server failover clusters
description: Describes how to update failover clusters in Windows.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Replacing hardware and updating the operating system
ms.technology: HighAvailability
---
# How to update Windows Server failover clusters

This article describes how to update failover clusters in Windows.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 174799

## Summary

This article describes how to install service packs or hotfixes on a Windows Server failover cluster. Applying a service pack or hotfix to a server cluster is the same as applying a service pack or hotfix to Windows Servers (although Windows Server 2012 requires a different process). However, there are special conditions that you should consider to make sure that clients have a high level of access while you perform the installation.

## More information

Always install the same service packs or hotfixes on each cluster node of a Windows Server failover cluster.

### Windows Server 2012 or newer

Installing service packs and hotfixes on Windows Server 2012 or newer requires a different process. For more information, see [Draining Nodes for Planned Maintenance with Windows Server](https://techcommunity.microsoft.com/t5/failover-clustering/draining-nodes-for-planned-maintenance-with-windows-server-2012/ba-p/371713).

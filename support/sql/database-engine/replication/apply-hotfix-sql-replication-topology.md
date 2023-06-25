---
title: Apply hotfix in a replication topology
description: This article describes how to apply a hotfix for Microsoft SQL Server in a replication topology.
ms.date: 03/16/2020
ms.custom: sap:Replication, change tracking, change data capture
ms.reviewer: vijayts
---
# Apply a hotfix for SQL Server in a replication topology

This article describes how to apply a hotfix for Microsoft SQL Server in a replication topology.

_Original product version:_ &nbsp; SQL Server 2005 and the later versions  
_Original KB number:_ &nbsp; 941232

## Servers for applying a hotfix

You apply a hotfix to one or more of the following servers in a replication topology:

- The Distributor
- The Publisher
- The Subscriber
- The Web server

> [!NOTE]
> The purpose of the hotfix determines the servers to which you apply the hotfix.

After you apply the hotfix, you may have to follow additional steps to completely resolve the problem for which you apply the hotfix. The Microsoft Knowledge Base article that describes the hotfix describes these additional steps.

## Requirements

In a replication topology, you can apply any hotfix for SQL Server to the Distributor or to the Publisher. However, if you have more than one version of SQL Server installed, you must also meet the following requirements:

- After you apply the hotfix, the version of SQL Server on the Distributor must be later than or the same as the version of SQL Server on the Publisher.

    > [!NOTE]
    > The Distributor is the same server as the Publisher.

- After you apply the hotfix, the version of SQL Server on the Publisher must be earlier than or the same as the version of SQL Server on the Distributor.

The SQL Server version requirement for the Subscriber after you apply a hotfix depends on the type of publication. If you have a read-only Subscriber to a transactional publication, you can apply any hotfix to the Subscriber. If you have a Subscriber to a merge publication, the version of SQL Server on the Subscriber must be earlier than or the same as the version of SQL Server on the Publisher after you apply the hotfix.

When you use Web synchronization to replicate to one of the following destinations, you must apply a hotfix on a Web server that hosts the replication components:

- A SQL Server Subscriber
- A SQL Server CE database
- A SQL Server Mobile Edition database
- A SQL Server Compact Edition database

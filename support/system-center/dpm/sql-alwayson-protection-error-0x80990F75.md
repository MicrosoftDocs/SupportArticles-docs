---
title: SQL Server Always On protection fails with error 0x80990F75
description: Fixes an issue where you receive error 0x80990F75 when attempting to protect a SQL Server Always On Availability Group in Data Protection Manager.
ms.date: 04/08/2024
ms.reviewer: Mjacquet, dpmtechreview
---
# SQL Server 2012 Always On protection in DPM fails with Internal error 0x80990F75

This article helps you fix an issue where you receive error 0x80990F75 when attempting to protect a SQL Server Always On Availability Group in Data Protection Manager (DPM).

_Original product version:_ &nbsp; System Center 2012 Data Protection Manager  
_Original KB number:_ &nbsp; 2769094

## Symptoms

When attempting to protect a SQL Server Always On Availability Group using System Center 2012 Data Protection Manager, the job fails with the following error:

> The DPM job failed for SQL Server 2012 database \<*DBname*> on \<*serverName*> because the SQL Server instance **refused a connection to the protection agent. (ID 30172 Details: Internal error code: 0x80990F75)**

In SQL Server, Always On is configured as follows:

- Availability Mode: **Synchronous Commit**
- Failover Mode: **Automatic**
- Connections in Primary Role: **Allow all connections**
- Readable Secondary: **No**
- Backup Preferences:
  - Prefer Secondary
  - Priority: 50 (for each node)
  - Exclude Replica: False (for each node)

In general, **Prefer Secondary** backups should occur on a secondary replica except when the primary replica is the only replica online. If there are multiple secondary replicas available, the node with the highest backup priority will be selected for backup. In the case that only primary replica is available then backup should occur on the primary replica.

## Cause

This occurs due to incorrect SQL Server Always On settings for DPM backups where **Make Readable Secondary** is set to **No**.

## Resolution

Set **Make Readable Secondary** to **Yes** on all the nodes.

## More information

If setting **Make Readable Secondary** to **Yes** on all the nodes doesn't resolve the issue, verify on the SQL Server that the DPMRA service is running under the **Local System** account and that the **NT Authority\System** has the sysadmin selected for the server role in SQL Server Management Studio.

1. On the SQL Server side, the DPMRA service should run under the **Local System** account. You can verify this via services in computer management.
2. In SQL Server 2012 Management Studio, connect to the SQL Server 2012 instance. Then select and expand **Security** > **Logins**, right-click **NT AUTHORITY\SYSTEM**, select **Properties** > **Server roles**, check the **sysadmin** checkbox, and then click **OK**.

After this, in certain cases it may also be necessary to reinstall the DPM agent on the SQL Server or manually run the `SetDPMServer` command on the SQL Server specifying the DPM server.

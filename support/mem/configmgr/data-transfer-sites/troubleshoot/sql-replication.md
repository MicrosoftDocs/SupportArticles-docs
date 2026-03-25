---
title: Start Troubleshooting Database Replication
description: Use this diagram to start troubleshooting DRS between Configuration Manager sites
ms.date: 08/09/2019
ms.subservice: core-infra
ms.topic: reference
ms.collection: tier3
---

# Troubleshoot Database Replication Service links

In a multi-site hierarchy, Configuration Manager uses Database Replication Service (DRS) to transfer data between sites. For more information, see [Database replication](/intune/configmgr/core/plan-design/hierarchy/database-replication).

Use the following diagram to start troubleshooting DRS replication when a link fails:

![Diagram to troubleshoot SQL Server replication](media/sql-replication/sql-replication.svg)

## Queries

This diagram uses the following queries:

### Check if the replication group link is in degraded or failed state

```sql
SELECT * FROM RCM_ReplicationLinkStatus
WHERE Status IN (8, 9)
```

### Check if replication group link is recently calculated

```sql
DECLARE @cutoffTime DATETIME
SELECT @cutoffTime = DATEADD(minute, -30, GETUTCDATE())
SELECT * FROM RCM_ReplicationLinkStatus
WHERE UpdateTime >@cutoffTime
```

### Check SQL Server maintenance mode

```sql
SELECT * FROM ServerData
WHERE SiteStatus = 120
```

## Next steps

- [DRS reinitialization (reinit)](sql-replication-reinit.md)
- [DRS performance](sql-performance.md)
- [DRS configuration](sql-configuration.md)

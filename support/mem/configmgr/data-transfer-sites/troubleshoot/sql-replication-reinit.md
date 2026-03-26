---
title: DRS replication reinit
description: Use this diagram to start troubleshooting DRS reinitialization between Configuration Manager sites
ms.manager: dcscontentpm
audience: itpro
ms.date: 03/25/2026
ms.subservice: core-infra
ms.topic: reference
ms.collection: tier3
ms.custom: sap:Configuration Manager Database\Database Replication Links
---

# Database Replication Service reinitialization

In a multi-site hierarchy, Configuration Manager uses Database Replication Service (DRS) to transfer data between sites. For more information, see [Database replication](/intune/configmgr/core/plan-design/hierarchy/database-replication).

Use the following diagram to start troubleshooting DRS reinitialization (reinit):

:::image type="content" source="media/sql-replication-reinit/sql-replication-reinit.svg" alt-text="Diagram of a decision tree to troubleshoot DRS reinitialization.":::

## Queries

This diagram uses the following queries:

### Check if site is in maintenance mode

```sql
SELECT * FROM ServerData
WHERE Status = 120
```

### Check that reinit isn't completed for which replication group

```sql
SELECT * FROM RCM_DrsInitializationTracking
WHERE InitializationStatus NOT IN (6,7)
```

### Check global data

```sql
SELECT * FROM RCM_DrsInitializationTracking dt
INNER JOIN ReplicationData rg
ON dt.ReplicationGroup = rg.ReplicationGroup
WHERE dt.InitializationStatus NOT IN (6,7)
AND rg.ReplicationPattern=N'GLOBAL'
```

### Check site data

```sql
SELECT * FROM RCM_DrsInitializationTracking dt
INNER JOIN ReplicationData rg
ON dt.ReplicationGroup = rg.ReplicationGroup
WHERE dt.InitializationStatus NOT IN (6,7)
AND rg.ReplicationPattern=N'Site'
```

## Next steps

- [Global data reinit](global-data-reinit.md)
- [Site data reinit](site-data-reinit.md)
- [SQL Server configuration](sql-configuration.md)

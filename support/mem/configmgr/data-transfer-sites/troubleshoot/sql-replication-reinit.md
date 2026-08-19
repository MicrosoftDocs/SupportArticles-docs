---
title: Troubleshoot DRS reinitialization
description: Helps resolve DRS reinitialization issues that affect Configuration Manager database replication
ms.manager: dcscontentpm
audience: itpro
ms.date: 07/30/2026
ms.subservice: core-infra
ms.topic: troubleshooting
ai-usage: ai-assisted
ms.reviewer: umaikhan
ms.collection: tier3
ms.custom: sap:Configuration Manager Database\Database Replication Links
ms.service: configuration-manager
---

<!-- markdownlint-disable-next-line MD025 -->
# Troubleshoot Database Replication Service reinitialization

## Summary

Configuration Manager uses Database Replication Service (DRS) to transfer data between sites in a multi-site hierarchy. When reinitialization (reinit) occurs, DRS resynchronizes data between site databases. If reinit doesn't complete successfully, site communication can be affected. Use this article to diagnose and resolve DRS reinitialization issues. The troubleshooting diagram guides you through key checks, and the SQL queries help you identify which replication groups aren't completing reinit.

For more information, see [Database replication](/intune/configmgr/core/plan-design/hierarchy/database-replication).

## The troubleshooting process

Use the following diagram to start troubleshooting DRS reinitialization (reinit):

:::image type="content" source="media/sql-replication-reinit/sql-replication-reinit.svg" alt-text="Diagram that shows the process of troubleshooting DRS reinitialization.":::

## Queries

This diagram shows the following queries:

### Check if site is in maintenance mode

```sql
SELECT * FROM ServerData
WHERE Status = 120
```

### Check which replication group has incomplete reinit

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

- [DRS reinitialization internals](drs-reinitialization-internals.md)
- [Global data reinit](global-data-reinit.md)
- [Site data reinit](site-data-reinit.md)
- [SQL Server configuration](sql-configuration.md)

---
title: SQL Server instance configuration
description: Use this diagram to start troubleshooting SQL Server instance configuration for Configuration Manager
ms.manager: dcscontentpm
audience: itpro
ms.date: 03/25/2026
ms.subservice: core-infra
ms.topic: reference
ms.collection: tier3
ms.custom: sap:Configuration Manager Database\SQL Settings and Configuration
---

# SQL Server instance configuration

In a multi-site hierarchy, Configuration Manager uses Database Replication Service (DRS) to transfer data between sites. For more information, see [Database replication](/intune/configmgr/core/plan-design/hierarchy/database-replication).

Use the following diagram to start troubleshooting DRS configuration related to SQL Server Service Broker:

![Diagram to troubleshoot SQL Server configuration](media/sql-configuration/sql-configuration.svg)

## Queries

This diagram has the following queries and actions:

### Check if SQL Server can deliver SSB messages

```sql
SELECT transmission_status, *
FROM sys.transmission_queue
ORDER BY enqueue_time DESC
```

## Remediation actions

### Remediate the issues reported from transmission_status

Common issues:

- Firewall configuration
- Network configuration
- SSB certificate misconfigured

### Run SQL Server profiler to trace SSB events

Run SQL Server profiler on the CAS and primary site database to trace events related to the SQL Server Service Broker:

- **Audit Broker Login**
- **Audit Broker Conversation**
- Events in **Broker** category

---
title: Troubleshoot the SQL Server instance configuration
description: Helps resolve SQL Server Service Broker configuration issues that affect Configuration Manager database replication.
ms.manager: dcscontentpm
audience: itpro
ms.date: 07/30/2026
ms.subservice: core-infra
ms.topic: troubleshooting
ms.collection: tier3
ms.custom: sap:Configuration Manager Database\SQL Settings and Configuration
ms.service: configuration-manager
ai-usage: ai-assisted
ms.reviewer: umaikhan
---

<!-- markdownlint-disable-next-line MD025 -->
# Troubleshoot the SQL Server instance configuration

Use this article to troubleshoot SQL Server instance configuration issues that affect Database Replication Service (DRS) in a Configuration Manager hierarchy. The troubleshooting diagram and queries in this article focus on SQL Server Service Broker (SSB), which Configuration Manager uses to transfer data between sites. For more information, see [Database replication](/intune/configmgr/core/plan-design/hierarchy/database-replication).

## The troubleshooting process

Use the following diagram to start troubleshooting DRS configuration related to SQL Server Service Broker:

:::image type="content" source="media/sql-configuration/sql-configuration.svg" alt-text="Diagram that shows the process of troubleshooting the SQL Server configuration.":::

## Queries

This diagram shows the following queries and actions:

### Check if SQL Server can deliver SSB messages

```sql
SELECT transmission_status, *
FROM sys.transmission_queue
ORDER BY enqueue_time DESC
```

## Remediation actions

### Resolve the issues that transmission_status reports

Common issues:

- Firewall configuration
- Network configuration
- SSB certificate misconfigured

For endpoint, peer-certificate, permission, route, and transmission diagnostics, see [Troubleshoot DRS Service Broker certificate and endpoint errors](drs-ssb-certificate-errors.md).

### Run SQL Server Profiler to trace SSB events

Run SQL Server Profiler on the CAS and primary site database to trace events related to the SQL Server Service Broker:

- **Audit Broker Login**
- **Audit Broker Conversation**
- Events in **Broker** category

---
title: Troubleshooting intermittent connection timeouts between availability group replicas
description: This article helps you diagnose intermittent connection timeouts that are reported between availability group replicas. 
ms.date: 02/28/2023
ms.custom: sap:Availability Groups
ms.prod: sql
author: padmajayaraman
ms.author: v-jayaramanp
ms.reviewer: ramakoni, cmathews
---

# Troubleshooting intermittent connection timeouts between availability group replicas

This article helps you diagnose intermittent connection timeouts that are reported between availability group replicas.

## Symptoms and effect of intermittent availability group replica connection timeouts

### Querying secondary returns different results than the primary replica

Read only workloads which query secondary replicas may query stale data. If there are intermittent replica connection timeouts, changes to data on the primary replica database aren't yet reflected in the secondary database when querying the same data. For more information, see the section **Data latency on secondary replica**.

### Secondary replica may not be failover ready if configured for automatic failover

If your availability group is configured for automatic failover and the synchronous commit failover partner is intermittently disconnected from the primary, automatic failover may be unsuccessful.

### Various diagnostic features report availability group not synchronized

The Always On dashboard in SQL Server Management Studio may report an unhealthy availability group with replicas in a **Not Synchronizing** state.

Intermittently you may observe the Always On dashboard report replicas in the **Not synchronizing** state.

:::image type="content" source="media/troubleshooting-intermittent-connection-timeouts-availability-groups/always-on-dashboard-report-replicas-not-synchronizing-state.png" alt-text="Screenshot that shows the Always On dashboard report replicas in the Not Synchronizing state." lightbox="media/troubleshooting-intermittent-connection-timeouts-availability-groups/always-on-dashboard-report-replicas-not-synchronizing-state.png":::

When you review the SQL Server error logs of those replicas, you might observe messages like the following, which indicates that there was a connection timeout between the replicas in the availability group.

**Error log from the primary replica**

```output
2023-02-15 07:10:55.500 spid43s Always On availability groups connection with secondary database terminated for primary database 'agdb' on the availability replica 'SQL19AGN2' with Replica ID: {85682e51-07e1-4b9a-9d66-d7ca5e9164ad}. This is an informational message only. No user action is required.
```

**Error log from the secondary replica**

```output
2023-02-15 07:11:03.100 spid31s A connection timeout has occurred on a previously established connection to availability replica 'SQL19AGN1' with id [17116239-4815-4B9B-8097-26F68DED0653]. Either a networking or a firewall issue exists or the availability replica has transitioned to the resolving role.

2023-02-15 07:11:03.100 spid31s Always On Availability Groups connection with primary database terminated for secondary database 'agdb' on the availability replica 'SQL19AGN1' with Replica ID: {17116239-4815-4b9b-8097-26f68ded0653}. This is an informational message only. No user action is required.
```


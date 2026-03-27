---
title: Site data reinit
description: Use this diagram to start troubleshooting DRS reinit for site data in a Configuration Manager hierarchy
ms.manager: dcscontentpm
audience: itpro
ms.date: 03/25/2026
ms.subservice: core-infra
ms.topic: reference
ms.collection: tier3
ms.custom: sap:Configuration Manager Database\Database Replication Links
---

# Troubleshoot site data reinit

In a multi-site hierarchy, Configuration Manager uses Database Replication Service (DRS) to transfer data between sites. For more information, see [Database replication](/intune/configmgr/core/plan-design/hierarchy/database-replication).

Use the following diagram to start troubleshooting DRS reinitialization (reinit) for site data in a Configuration Manager hierarchy:

:::image type="content" source="media/site-data-reinit/site-data-reinit.svg" alt-text="Diagram of a decision tree to troubleshoot site data reinitialization.":::

## Queries

This diagram uses the following queries:

### Check if reinit isn't finished for site replication

```sql
SELECT * FROM RCM_DrsInitializationTracking dt
INNER JOIN ReplicationData rg
ON dt.ReplicationGroup = rg.ReplicationGroup
WHERE dt.InitializationStatus NOT IN (6,7)
AND rg.ReplicationPattern=N`Site'
```

### Get the TrackingGuid & Status from the CAS

```sql
SELECT RequestTrackingGUID, InitializationStatus
FROM RCM_DrsInitializationTracking dt
INNER JOIN ReplicationData rg
ON dt.ReplicationGroup = rg.ReplicationGroup
WHERE dt.InitializationStatus NOT IN (6,7)
AND rg.ReplicationPattern=N'Site'
```

### Get the TrackingGuid & Status from the primary site

```sql
SELECT RequestTrackingGUID, InitializationStatus
FROM RCM_DrsInitializationTracking dt
WHERE RequestTrackingGUID=@trackingGuid
```

### Check primary site isn't in maintenance mode

```sql
SELECT * FROM ServerData
WHERE SiteStatus = 125
AND SiteCode=dbo.fnGetSiteCode()
AND ServerRole=N'Peer'
```

### Check request status for the tracking ID

```sql
SELECT Status FROM RCM_InitPackageRequest
WHERE RequestTrackingGUID=@trackGuid
```

## Next steps

- [Reinit missing message](reinit-missing-message.md)
- [Global data reinit](global-data-reinit.md)

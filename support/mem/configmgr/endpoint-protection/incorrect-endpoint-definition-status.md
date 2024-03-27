---
title: Incorrect Endpoint Definition status
description: Describes an issue in which the v_GS_AntimalwareHealthStatus view reports incorrect Endpoint Definition status in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Endpoint Protection\Antimalware Policies
---
# v_GS_AntimalwareHealthStatus view reports incorrect Endpoint Definition status in Configuration Manager 2012

This article helps you work around an issue in which the `v_GS_AntimalwareHealthStatus` view reports an incorrect Endpoint Definition status in Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Configuration Manager, System Center 2012 Endpoint Protection, System Center 2012 R2 Endpoint Protection, Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 3183902

## Symptom

The Endpoint Protection view `v_GS_AntimalwareHealthStatus` reports an incorrect Endpoint Definition status based on the `AntivirusSignatureUpdateDateTime` value in versions of Configuration Manager that are older than Configuration Manager current branch version 1511.

## Cause

This is a known bug that's fixed in Configuration Manager current branch version 1511 (and later versions). This bug prevents some of the information typically found in state messages for Endpoint Protection from being displayed in this view.

## Workaround

To work around this issue, run the following query as an alternative way to gather the information:

```sql
declare @USERSIDS as varchar(64)='Disabled'
select distinct b.Name, (a.SignatureUpTo1DayOld) AS SignatureUpTo1DayOld
, (a.SignatureUpTo3DaysOld) AS SignatureUpTo3DaysOld
, (a.SignatureUpTo7DaysOld) AS SignatureUpTo7DaysOld
, (a.SignatureOlderThan7Days) AS SignatureOlderThan7Days
, (a.NoSignature) AS NoSignature
, a.EpInstalled
from fn_rbac_EndpointProtectionStatus(@UserSIDs) AS a
inner join fn_rbac_FullCollectionMembership_valid(@UserSIDs) AS b on b.ResourceID = a.ResourceID
where b.CollectionID='SMS00001'
and a.EpInstalled = 1
and b.ResourceType <> 2
```

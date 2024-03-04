---
title: Duplicate rows in the DistributionContentVersion table
description: Describes an issue in which duplicate rows for packages on a distribution point are generated in the DistributionContentVersion table after you reassign the DP to another primary site.
ms.date: 12/05/2023
ms.custom: sap:Distribution point migration
ms.reviewer: kaushika
---
# Duplicate rows in the DistributionContentVersion table after you reassign a DP in Configuration Manager

This article provides a solution and workaround for the issue that duplicate rows are created in the `DistributionContentVersion` table after you reassign the distribution point (DP) to another primary site in Configuration Manager.

_Original product version:_ &nbsp; Configuration Manager (current branch - version 1810), Configuration Manager (current branch - version 1806), Configuration Manager (current branch - version 1802)  
_Original KB number:_ &nbsp; 4498264

## Symptoms

In a Configuration Manager current branch version 1802 or later version hierarchy, you use the [Reassign Distribution Point](/mem/configmgr/core/servers/deploy/configure/install-and-configure-distribution-points#bkmk_reassign) feature to reassign a DP to another primary site. Content validation is enabled on the DP.

In this scenario, after a new content validation cycle ends, duplicate rows for each package on the DP are generated in the `DistributionContentVersion` table, one for the old site and one for the new site.

This is an example of what occurs when you reassign a DP from site PS2 to site PS1.

Figure 1: Output of the `DistributionContentVersion` table before you reassign the DP

:::image type="content" source="media/duplicate-rows-in-distributioncontentversion/table-before-dp-move.png" alt-text="Screenshot of the output of the DistributionContentVersion table before DP move.":::

Figure 2: Output of the `DistributionContentVersion` table after you reassign the DP and a new content validation cycle ends

:::image type="content" source="media/duplicate-rows-in-distributioncontentversion/table-after-dp-move.png" alt-text="Screenshot of the output of the DistributionContentVersion table after DP move.":::

After you reassign the DP, merging data into the `ContentDistribution` table fails. For example, when the `spRebuildContentDistribution` procedure runs or the Configuration Data group is reinitialized, you receive this error message:

> Msg 8672, Level 16, State 1, Procedure spRebuildContentDistribution, Line 197 [Batch Start Line 29]  
> The MERGE statement attempted to UPDATE or DELETE the same row more than once. This happens when a target row matches more than one source row. A MERGE statement cannot UPDATE/DELETE the same row of the target table multiple times. Refine the ON clause to ensure a target row matches at most one source row, or use the GROUP BY clause to group the source rows.

Failure scenarios include adding a new site, recovering a site, and re-initializing configuration data.

## Cause

When content validation is enabled, the `DistributionContentVersion` table is populated with data that's reported by content validation. When you reassign a DP from one site to another, the `spMoveDistributionPoint` procedure updates `DPNALPath` in the `DistributionContentVersion` table. However, it doesn't update `SiteCode`.

Therefore, after the DP is reassigned to the new site and a new content validation cycle runs, there are two rows for each package in the `DistributionContentVersion` table: One for the old site and one for the new site.

To determine whether you experience this issue, run this SQL query:

```sql
SELECT * FROM DistributionContentVersion DCV
LEFT JOIN DistributionPoints DP ON DP.NALPath = DCV.DPNALPath
WHERE DCV.SiteCode <> DP.SMSSiteCode
```

If the result isn't NULL, the issue occurs.

## Resolution

To fix the issue, update to [Configuration Manager version 1902](/mem/configmgr/core/plan-design/changes/whats-new-in-version-1902).

## Workaround

To work around this issue without updating, run the following SQL statements on the central administration site or a primary site after you reassign the DP:

```sql
--Detect and fix the DistributionContentVersion duplicates after reassigning a DP to a new site
--Run this on any one site in the hierarchy (CAS or Primary) and the fix should propagate in the rest sites through DRS

IF OBJECT_ID('tempdb..#temp') IS NOT NULL
DROP TABLE #TEMP

SELECT DCV.PkgID, DCV.DPNALPath,DP.SMSSiteCode,DCV.SiteCode
INTO #TEMP
FROM DistributionContentVersion DCV
LEFT JOIN DistributionPoints DP ON DP.NALPath = DCV.DPNALPath
WHERE DCV.SiteCode <> DP.SMSSiteCode

IF EXISTS (SELECT 1 from #TEMP)
BEGIN
    PRINT 'Affected by DistributedContentVersion Duplicate PkgID, NalPath issue. Cleaning the old site records...'
    PRINT ''
    DECLARE @PkgID NVARCHAR(255)
    DECLARE @NALPath NVARCHAR(255)
    DECLARE @ActualSiteCode NVARCHAR(3)
    DECLARE @OldSiteCode NVARCHAR(3)

    DECLARE DelOldSiteInfoForDistContentVersion CURSOR FOR
        SELECT A.PkgID,A.DPNALPath,A.SMSSiteCode,A.SiteCode FROM #TEMP AS A
    OPEN DelOldSiteInfoForDistContentVersion;
    FETCH NEXT FROM DelOldSiteInfoForDistContentVersion INTO @PkgID,@NALPath,@ActualSiteCode,@OldSiteCode;
    WHILE @@FETCH_STATUS = 0
       BEGIN
          PRINT 'Deleting the record for Package '+ @PkgID +' and NalPath '+ @NalPath + ' for the Old SiteCode '+   @OldSiteCode
           -- Delete records of DP which are for the old site
          DELETE FROM DistributionContentVersion WHERE PkgID=@PkgID AND DPNALPath=@NALPath AND SiteCode = @OldSiteCode
       FETCH NEXT FROM DelOldSiteInfoForDistContentVersion INTO @PkgID,@NALPath,@ActualSiteCode,@OldSiteCode;
       END;
    CLOSE DelOldSiteInfoForDistContentVersion;
    DEALLOCATE DelOldSiteInfoForDistContentVersion;
END
ELSE
    PRINT 'DistributionContentVersion table is Fine. Exiting...'
```

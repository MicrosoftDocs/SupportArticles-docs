---
title: Active users and groups are unexpectedly deleted by the Delete Aged Discovery Data task
description: Fixes an issue in which some active users and groups are unexpectedly deleted by the Delete Aged Discovery Data task in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Active users and groups are unexpectedly deleted by the Delete Aged Discovery Data task in Configuration Manager

This article helps you fix an issue in which some active users and groups are unexpectedly deleted by the **Delete Aged Discovery Data** task in Configuration Manager.

_Original product version:_ &nbsp; Configuration Manager (current branch), Configuration Manager (current branch - version 1906), Configuration Manager (current branch - version 1902)  
_Original KB number:_ &nbsp; 4537087

## Symptoms

In a Configuration Manager current branch, version 1910, 1906, or 1902 environment, you use Active Directory User Discovery and Active Directory Group Discovery to discover users and groups. You also set up the **Delete Aged Discovery Data** task to delete aged discovery data.

In this scenario, some active users and groups are unexpectedly deleted by the **Delete Aged Discovery Data** task.

## Cause

The **Delete Aged Discovery Data** task uses the `sp_GetAgedDiscoveryItems` stored procedure to identify aged items. Active users and groups that aren't changed within the indicated time in the task are considered to be inactive. Therefore, the task deletes the items.

## Resolution

### For Configuration Manager current branch, version 1910

This problem is fixed if you update to the globally available release of [Configuration Manager current branch version 1910](/mem/configmgr/core/plan-design/changes/whats-new-in-version-1910) from [Update for Microsoft Endpoint Configuration Manager version 1910, early update ring](https://support.microsoft.com/help/4535819/). Otherwise, follow [The Delete Aged Discovery Data task incorrectly removes active records in Configuration Manager](https://support.microsoft.com/help/4537369) to fix the problem.

### For Configuration Manager current branch, version 1906 and 1902

To fix this problem, run the following TSQL query against the site database on the central administration site and primary sites.

> [!NOTE]
> Before you run the TSQL query in your production environment, we recommend that you test it in a test environment and back up your site databases.

```sql
IF EXISTS( SELECT 1 FROM Sites WHERE SiteType in (4,2) AND SiteCode = dbo.fnGetSiteCode() AND (BuildNumber >=8790 AND BuildNumber <8913) )
AND NOT EXISTS (SELECT 1 FROM CM_UpdatePackages where FullVersion = '5.00.8913.1012' and State = '196612')

BEGIN
DECLARE @query as nvarchar(MAX);

SET @query = 'ALTER PROCEDURE sp_GetAgedDiscoveryItems @cutoffDate varchar(100), @discArchKey int as
begin
    set nocount on

    declare @siteRangeStart int
    declare @siteRangeEnd int
    set @siteRangeStart = dbo.fnGetSiteRangeStart()
    set @siteRangeEnd = dbo.fnGetSiteRangeEnd()

    declare @isReservedRangedSite int
    select @isReservedRangedSite =  isnull(Value3, 0) from SC_SiteDefinition_Property where SiteNumber = dbo.fnGetSiteNUmber() and Name = N''ReplicatesReservedRanges''

    if @discArchKey = 4 or @discArchKey = 3   -- user/security group
    begin
        -- user site number is 123, unknown system is 122 and max site number is 128
        -- so special range is 123*16777216 to 128*16777216-1
        select DiscArchKey, ItemKey
        from DiscItemAgents dia
        where ((ItemKey between @siteRangeStart and @siteRangeEnd) or ((ItemKey between 2063597568 and 2147483647) and @isReservedRangedSite = 1))
        group by dia.ItemKey, dia.DiscArchKey
        -- for agents honoring DueForAgeOut flag, Aged = aged for all agents on all sites
        having sum(cast(isnull(dia.DueForAgeOut, 0) AS int)) = count(dia.ItemKey)  and dia.DiscArchKey = @discArchKey
    end
    else if @discArchKey = 5 -- non-mobile devices
    begin
        select dia.DiscArchKey, dia.ItemKey
        from DiscItemAgents dia inner join System_DISC sd on dia.ItemKey = sd.ItemKey
        where ((dia.ItemKey between @siteRangeStart and @siteRangeEnd) or ((dia.ItemKey between 2063597568 and 2147483647) and @isReservedRangedSite = 1))
        group by dia.ItemKey, dia.DiscArchKey, sd.Client_Type0
        having max(AgentTime) <= @cutoffDate and dia.DiscArchKey =  @discArchKey and isnull(sd.Client_Type0, 1) = 1
    end
    else  -- other archs
    begin
        select DiscArchKey, ItemKey
        from DiscItemAgents dia
        where ((ItemKey between @siteRangeStart and @siteRangeEnd) or ((ItemKey between 2063597568 and 2147483647) and @isReservedRangedSite = 1))
        group by dia.ItemKey, dia.DiscArchKey
        having max(AgentTime) <= @cutoffDate and dia.DiscArchKey = @discArchKey
    end
end'

EXECUTE sp_executesql @query

END
ELSE
PRINT 'This script is not applicable on this site or database. Applicable on CAS\PRI on version running 1902 and 1906 only.'
```

---
title: DRS performance issue after installing hotfix 3125525
description: Describes DRS performance issues that are experienced after you install hotfix 3125525 in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Configuration Manager DRS performance issue after you install hotfix 3125525

This article provides a solution for the Configuration Manager Database Replication Service (DRS) performance issues that occur after you install hotfix [3125525](https://support.microsoft.com/help/3125525).

_Original product version:_ &nbsp; Configuration Manager (current branch), Microsoft System Center 2012 R2 Configuration Manager,  Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 4024301

## Symptom

After you install hotfix [3125525](https://support.microsoft.com/help/3125525), you experience the following performance issues when you use Configuration Manager DRS:

- Messages are processed very slowly, for example, less than 1,000 messages are processed in an hour.
- If it takes more than 30 minutes (by default) to process a message, the replication link may become degraded.
- The average CPU time for SQL Server change tracking is 2.7 to 4 seconds.

> [!NOTE]
> Hotfix 3125525 is included in the following SQL Server cumulative updates:
>
> - [Cumulative Update 13 for SQL Server 2014](https://support.microsoft.com/help/3144517)
> - [Cumulative Update 6 for SQL Server 2014 Service Pack 1](https://support.microsoft.com/help/3167392)
> - [Cumulative Update 1 for SQL Server 2012 Service Pack 3](https://support.microsoft.com/help/3123299)

## Resolution

To fix the issue, install the latest Cumulative Update for your SQL Server version:

|SQL Server version|The latest Cumulative Update|
|---|---|
|SQL Server 2012 Service Pack 3| [Download the latest cumulative update](https://www.microsoft.com/download/details.aspx?id=50733)|
|SQL Server 2014 RTM| [Download the latest cumulative update](https://www.microsoft.com/download/details.aspx?id=51187)|
|SQL Server 2014 Service Pack 1| [Download the latest cumulative update](https://www.microsoft.com/download/details.aspx?id=51186)|
|SQL Server 2014 Service Pack 2| [Download the latest cumulative update](https://www.microsoft.com/download/details.aspx?id=53592)|
|SQL Server 2016 RTM| [Download the latest cumulative update](https://www.microsoft.com/download/details.aspx?id=53338) or [Install SQL Server 2016 Service Pack 1](https://www.microsoft.com/download/details.aspx?id=54276)|
  
## More information

For more information about the fixes for this issue, see the following articles:

- [CPU usage increases significantly when you execute queries that contain CHANGETABLE functions in SQL Server 2012 Service Pack 3](https://support.microsoft.com/help/3188672)
- [FIX: Queries that use CHANGETABLE use much more CPU in SQL Server 2014 SP1 or in SQL Server 2016](https://support.microsoft.com/help/3180060)

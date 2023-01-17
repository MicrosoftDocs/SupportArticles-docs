---
title: Can't impersonate user for data source 
description: Fixes an issue where you receive the Cannot impersonate user for data source error when selecting a report in the Service Manager console.
ms.date: 08/03/2020
---
# Cannot impersonate user for data source error when selecting a report in Service Manager

This article helps you fix an issue where you receive the **Cannot impersonate user for data source** error when selecting a report in the Service Manager console.

_Original product version:_ &nbsp; System Center 2012 Service Manager  
_Original KB number:_ &nbsp; 2834789

## Symptoms

Selecting a report in the System Center 2012 Service Manager console fails with the following error:

> An error has occurred during report processing (rsProcessingAborted)  
> Cannot impersonate user for data source 'DWDataMart' (rsErrorImpersonatingUser)  
> Log on failed. Ensure the User name and password are correct. (rsLogonFailed)  
> The parameter is incorrect  

## Cause

This issue can occur if data sources are missing entries or are incorrectly configured in SQL Server Reporting Services (SSRS).

## Resolution

To resolve this issue, use the following query to get the data sources:

```sql
select Path,Cast(Cast(Content as varbinary(max)) as varchar(max))
from dbo.[Catalog]
where Type = 5
```

Once you obtain the data sources, verify the data source string for each module and reenter as necessary.

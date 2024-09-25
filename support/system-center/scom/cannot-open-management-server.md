---
title: Can't open the Management Server view
description: Fixes an issue where you receive the System.ArgumentOutOfRangeException error when you open the Management Server view in the Operations Manager console.
ms.date: 04/15/2024
---
# System.ArgumentOutOfRangeException error when opening the Management Server view

This article helps you fix an issue where you receive the **System.ArgumentOutOfRangeException** error when you open the **Management Server** view in the Operations Manager console.

_Original product version:_ &nbsp; Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2828790

## Symptom

When trying to open the **Management Server** view in the **Administrator** pane of the System Center 2012 Operations Manager console, the following error is generated:

> System.ArgumentOutOfRangeException: Specified argument was out of the range of valid values

## Cause

It can occur if the Network Management Pack is missing or not installed. To view the management packs installed on the server, run the following queries on the Operations Manager database:

```sql
SELECT * FROM ManagedType
SELECT MPName, MPVersion, MPKeyToken from ManagementPack MP
```

If the Network Management Pack is missing, you will not see **System.networkmanagement.node** in the results.

## Resolution

To resolve this issue, install the Network Management Pack from the System Center 2012 Operations Manager installation media. After doing so, you can successfully access the **Management Server** list.

## More information

The method throwing the exception is doing a series of `GetClass` calls for different types. The error **ArgumentOutOfRangeException** would be thrown when any of these types aren't found.

---
title: Triggered runbook never completes
description: Fixes an issue where a triggered runbook never completes in System Center Orchestrator.
ms.date: 06/26/2024
---
# Triggered runbook never completes in System Center Orchestrator

This article helps you fix an issue where a triggered runbook never completes in System Center Orchestrator.

_Applies to:_ &nbsp; All versions of Orchestrator  
_Original KB number:_ &nbsp; 2805832

## Symptoms

A runbook uses the **invoke method** to trigger a child runbook. The triggered runbook never finishes, and in the policy module log the process shows as terminated.

> \<MsgCode>_com_error\</MsgCode>  
> \<Params>  
> \<Param>Unspecified error\</Param>  
> \<Param>\</Param>  
> \<Param>-2147467259\</Param>  
> \</Params>  
> \</Exception>\</Prev>  
> \</Exception>\</Prev>  
> \</Exception>  
> 1 Process terminated: exception caught.

## Cause

This can occur if disallow results from triggers is enabled on the SQL Server.

## Resolution

To resolve this issue, change the disallow results from triggers value to **0**.

First run following SQL statements in SQL Server Management Studio to verify the current setting:

```sql
USE master  
XEC sp_configure 'show advanced option',1  
RECONFIGURE  
XEC sp_configure
```

If the value is **1**, change the setting to **0** by running the following command:

```sql
EXEC sp_configure 'disallow results from triggers',0  
RECONFIGURE
```

## More information

This issue has been corrected.

This feature will be removed in the later version of SQL Server and the recommended setting for this value is **1**. For more information, see [disallow results from triggers Server Configuration Option](/sql/database-engine/configure-windows/disallow-results-from-triggers-server-configuration-option).

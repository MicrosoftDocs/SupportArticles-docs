---
title: Orchestration console can't open after upgrade
description: Fixes an issue that prevents the Orchestration web console from starting after you upgrade to System Center 2012 R2 Orchestrator.
ms.date: 08/04/2020
ms.reviewer: matthofa, dewitth
---
# The Orchestration console can't be opened after upgrading to System Center 2012 R2 Orchestrator

This article helps you fix an issue where you can't open the Orchestration console after upgrading to Microsoft System Center 2012 R2 Orchestrator.

_Original product version:_ &nbsp; Microsoft System Center 2012 Orchestrator, Microsoft System Center 2012 R2 Orchestrator  
_Original KB number:_ &nbsp; 2919041

## Symptoms

After you upgrade to System Center 2012 R2 Orchestrator, you can no longer start the Orchestration web console. In this situation, you receive the following pop-up error messages in the browser:

> Error Executing the current operation  
> [httpwebrequest_webexception_remoteserver]  
> Arguments: NotFound

> Error Executing the Current Operation

## Cause

This is a known problem in the Orchestrator 2012 R2 upgrade process.

## Resolution

To resolve this issue, use SQL Server Management Studio to run the following Transact-SQL statements against your Orchestrator database:

```sql
GRANT EXECUTE ON object::[Microsoft.SystemCenter.Orchestrator].[GetSecurityToken] TO [Microsoft.SystemCenter.Orchestrator.Operators]
GRANT SELECT ON object::[Microsoft.SystemCenter.Orchestrator.Internal].[Settings] TO [Microsoft.SystemCenter.Orchestrator.Operators]
```

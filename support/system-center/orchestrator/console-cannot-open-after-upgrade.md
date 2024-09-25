---
title: Orchestration console can't open after upgrade
description: Fixes an issue that prevents the Orchestration web console from starting after you upgrade System Center Orchestrator.
ms.date: 06/26/2024
ms.reviewer: matthofa, dewitth
---
# The Orchestration console can't be opened after upgrading System Center Orchestrator

This article helps you fix an issue where you can't open the Orchestration console after upgrading Microsoft System Center Orchestrator.

_Applies to:_ &nbsp; All versions of Orchestrator  
_Original KB number:_ &nbsp; 2919041

## Symptoms

After you upgrade System Center Orchestrator, you can no longer start the Orchestration web console. In this situation, you receive the following pop-up error messages in the browser:

> Error Executing the current operation  
> [httpwebrequest_webexception_remoteserver]  
> Arguments: NotFound

> Error Executing the Current Operation

## Cause

This is a known problem in the Orchestrator upgrade process.

## Resolution

To resolve this issue, use SQL Server Management Studio to run the following Transact-SQL statements against your Orchestrator database:

```sql
GRANT EXECUTE ON object::[Microsoft.SystemCenter.Orchestrator].[GetSecurityToken] TO [Microsoft.SystemCenter.Orchestrator.Operators]
GRANT SELECT ON object::[Microsoft.SystemCenter.Orchestrator.Internal].[Settings] TO [Microsoft.SystemCenter.Orchestrator.Operators]
```

---
title: AG remains in the resolving state
description: This article provides a workaround for the problem where Always On Availability Group that contains the SSISDB database remains in the resolving state after a failover in SQL Server.
ms.date: 09/22/2020
ms.custom: sap:Integration Services
---
# Always On Availability Group remains in the resolving state after a failover in SQL Server

This article helps you resolve the problem where Always On Availability Group that contains the SSISDB database remains in the resolving state after a failover in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 3139534

## Symptoms

Assume that the SSISDB database is a member of an Always On Availability Group, and that Availability Group fails over while a package from SSISDB is executing synchronously. In this situation, the Availability Group may remain in the resolving state on the (now formerly) primary replica until package execution completes.

In this scenario, the failover operation succeeds, but the Availability Group on the (newly) secondary replica remains in the resolving state until package execution completes. During this time, the SQL Server error log displays a message that resembles the following:

> Nonqualified transactions are being rolled back in database SSISDB for an Always On Availability Groups state change. Estimated rollback completion: 0%. This is an informational message only. No user action is required.

Querying the session status shows that the session that was used to execute the job is in the KILLED/ROLLBACK state. If or when execution does complete, it may trigger errors such as the following:

> Msg 0, Level 11, State 0, Line 6  
A severe error occurred on the current command. The results, if any, should be discarded.  
Msg 0, Level 20, State 0, Line 6  
A severe error occurred on the current command. The results, if any, should be discarded.

## Cause

This issue occurs because the threads that are used to execute the SSIS package are outside the control of the mechanism that's used to kill a SQL Server session. When a package is executed synchronously, this causes the execution of a loop that prevents SQL Server from terminating the session until package execution has completed.

## Workaround

To work around this issue, configure the SSIS package to execute asynchronously. Asynchronous package execution is the default behavior.

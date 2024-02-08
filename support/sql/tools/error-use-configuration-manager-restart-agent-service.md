---
title: Error when you use Configuration Manager
description: This article helps you resolve the problem that occurs when you use SQL Server Configuration Manager to restart the SQL Server Agent service after changing the password for the service account.
ms.date: 11/19/2020
ms.custom: sap:Other tools
---
# Error when you use SQL Server Configuration Manager to restart the SQL Server Agent service in SQL Server

This article helps you resolve the problem that occurs when you use SQL Server Configuration Manager to restart the SQL Server Agent service after changing the password for the service account.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 955494

## Symptoms

When you use SQL Server Configuration Manager to restart the SQL Server Agent service in Microsoft SQL Server, you receive the following error message:

> The request failed or the service did not respond in a timely fashion. Consult the event log or other applicable error logs for details.

When this problem occurs, CPU utilization is high, and you cannot dismiss the error message by clicking **OK**. You may have to use Task Manager to end the SQL Server Configuration Manager process.

> [!NOTE]
> You may also receive this error message in other circumstances.

## Workaround

To work around this problem, start the SQL Server Agent service by using the Services management console (Services.msc).

## Steps to reproduce this problem

1. Specify an account for the SQL Server Agent service.
2. Change the password of the SQL Server Agent startup account.
3. Use SQL Server Configuration Manager to restart the SQL Server Agent service.

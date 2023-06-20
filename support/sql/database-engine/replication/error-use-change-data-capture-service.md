---
title: Error when you use Change Data Capture Service
description: This article provides resolution for the problem that occurs when you use the Change Data Capture Service for Oracle by Attunity.
ms.date: 11/10/2020
ms.custom: sap:Replication, change tracking, change data capture
ms.reviewer: JasonH, jasonh
---
# Error message when you use the Microsoft Change Data Capture Service for Oracle by Attunity

This article helps you resolve the problem that occurs when you use the Change Data Capture Service for Oracle by Attunity.

_Original product version:_ &nbsp; SQL Server 2012 Enterprise, SQL Server 2012 Developer  
_Original KB number:_ &nbsp; 2672759

## Symptoms

The Microsoft Change Data Capture Service for Oracle by Attunity stops capturing data during idle periods. When this issue occurs, you receive the following message on the Status tab in the Oracle Change Data Capture Designer management console:

> Trying to retrieve next change record from source database

Additionally, you receive the following message when you try to use the Collect Diagnostics link to read the Xdbcdc_trace table in the SQL Server CDC database:

> ORACDC517E:Oracle Call Interface (OCI) method failed: ORA-00600: internal error code, arguments: [krvxgintocol11

## Cause

This issue occurs if the Oracle database is version 11.1.0.7 or an earlier version.

## Resolution

To resolve this issue, do one of the following:

- Download and install an update for the existing version of the Oracle database.
- Update the Oracle database to version 11.2.0.1 or a later version.

## More information

You can enable data collection to help detect the issue that is described in the "Symptoms" section. To do this, follow these steps:

1. Reproduce the issue.
2. Click **Collect Diagnostics** on the **Status** tab in the Oracle Change Data Capture Designer management console.
3. Review the output and log files for the error message that is mentioned in the [Symptoms](#symptoms) section. For example, the error message that is mentioned in the [Symptoms](#symptoms) section may appear in one or more of the following output files:

   - `\app\administrator\diag\rdbms\orclcdc\orclcdc\alert\log.xml`
   - `\app\administrator\diag\rdbms\orclcdc\orclcdc\trace\orclcdc_ora_1932.trc`

For more information about the issue, enable tracing in the Oracle Change Data Capture Designer management console. To do this, add a new property in the **Advanced Settings** grid on the **Advanced** tab, set the name of the property to **trace**, and then set the value to **Source**. After the issue occurs, run the following query to view the trace data:

```sql
SELECT * FROM xdbcdc_trace
```

> [!NOTE]
> After you view the trace information, delete the property in the **Advanced Settings** grid to avoid performance issues.

## References

For more information about the updates that are described in the [Resolution](#resolution) section, see [My Oracle Support](https://support.oracle.com/portal/).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

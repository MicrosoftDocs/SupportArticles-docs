---
title: Troubleshoot SQL Agent Job Failures with Error 258
description: Learn how to troubleshoot and resolve repeated crashes of the SQL Agent service. Follow step-by-step solutions to fix registry issues and improve stability.
ms.date: 12/04/2025
ms.custom: sap:SQL Agent (Jobs, Alerts, Operators)\Job failures, job scheduling and monitoring
ms.reviewer: prmadhes, v-shaywood
---

# SQL Agent job fails with error 258

This article provides troubleshooting guidance for an issue where SQL Agent jobs fail with error code 258.

## Symptoms

The SQL Agent service is running, but scheduled SQL Agent jobs are not being executed. The SQL Server and Agent logs show network and login timeouts as well as failed logons.

The following is an example of the error message that is added to the logs:

```output
SQLServer Error: 258, TCP Provider: Timeout error [258]
ODBC Error: 0, Login timeout expired [SQLSTATE HYT00]
SQLServer Error: 258, Unable to complete login process due to delay in prelogin response [SQLSTATE 08001]
Logon to server '<ServerName>' failed (ConnLogJobHistory)
```

## Cause

This issue can be caused by any of the following underlying problems:

- Blocking of `msdb` system tables used by Agent, which prevents job metadata reads and writes.
  - Example system tables: `dbo.sysjobs`, `dbo.sysjobschedulers`, and `dbo.jobsteps`.
- Hangs inside important SQL Server Agent threads or other process-level problems.
- Worker thread exhaustion in SQL Server (no workers available), making the Agent unable to connect or process schedules.

## Solution



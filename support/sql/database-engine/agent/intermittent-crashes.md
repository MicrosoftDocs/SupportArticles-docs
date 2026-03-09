---
title: Troubleshoot Repeated SQL Server Agent Service Failures
description: Resolve repeated failures of the SQL Server Agent service. Follow step-by-step solutions to fix registry issues and improve stability.
ms.date: 12/04/2025
ms.custom: sap:SQL Agent (Jobs, Alerts, Operators)\SQL Agent Service is unable to start, stops or restarts unexpectedly
ms.reviewer: prmadhes, v-shaywood
---

# SQL Agent service fails intermittently

This article provides troubleshooting guidance for an issue where the SQL Agent service repeatedly stops responding at regular intervals.

## Symptoms

The SQL Server Agent service fails intermittently on a SQL Server Always On Cluster. When the service fails, the following error message is added to the SQL Server Agent log:

```log
[510] SQLAgent failed, dump generated in \<SQL_Instance_Log_Directory\>  
[LOG] Exception 29539 caught at line 233 of file sql\mpu\SqlAgent\src\autostrt.cpp. SQLServerAgent initiating self-termination.
```

## Cause

These failures occur if the SQL Server Agent service doesn't retrieve the following registry subkey:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\<InstanceID>\SQLServerAgent\AutoRegistryRefresh`

When the registry subkey retrieval fails, the SQL Server Agent service reports an exception in the log, and then it terminates itself.

Registry subkey retrieval can fail because of the following reasons:

- Antivirus or endpoint protection software that interferes with registry access
- Missing or misconfigured registry keys
- Transient access failures in Windows registry

## Solution

To resolve this issue, follow these steps.

### Step 1: Verify the registry key

1. Start Registry Editor (`regedit.exe`).
1. Go to the following path: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\<InstanceID>\SQLServerAgent`.
1. Check whether the `AutoRegistryRefresh` key exists.
1. If the `AutoRegistryRefresh` key is missing, create a _DWORD (32-bit) Value_ that's named `AutoRegistryRefresh`, and set its value to `1`.

### Step 2: Exclude SQL Server from antivirus scanning

> [!IMPORTANT]
> The process of adding an exclusion to your antivirus or endpoint protection software varies by publisher. Check with the publisher of your software for specific instructions.

1. Configure your antivirus or endpoint protection software to exclude the common SQL Server processes:
    - `sqlservr.exe`
    - `sqlagent.exe`
    - `ReportingServicesService.exe`
    - `msmdsrv.exe`
    - `fdlauncher.exe`
    - `fdhost.exe`
1. Also, exclude the folder where SQL Server is installed. For example, `C:\Program Files\Microsoft SQL Server\`.

For more information about how to configure your antivirus or endpoint protection software to work together with SQL Server, see [Configure antivirus software to work with SQL Server](../security/antivirus-and-sql-server.md).

### Step 3: Check event logs and dump files

Check whether the logs or the most recent SQL Agent dump file contain any new errors:

1. Review the SQL Server Agent logs that are located in: `<SQL_Instance_Log_Directory>\SQLAGENT.OUT\`.
1. Review the Application and system logs in Event Viewer for related errors.
1. Analyze the SQL Agent dump file. If multiple dump files are generated, focus on the most recent one.

If no new errors are reported, go to the next step. If new errors exist, repeat the previous steps, and then check the event logs and dump files again.

### Step 4: Restart SQL Server Agent service

Restart the SQL Server Agent service in order for the changes to take full effect.

### Step 5: Monitor stability

1. Monitor the SQL Server Agent logs for any recurrence of the error.
1. Verify that no new dump files are generated in the log folder.

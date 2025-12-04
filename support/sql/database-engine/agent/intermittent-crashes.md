---
title: Troubleshoot Repeated SQL Agent Service Failures
description: Learn how to troubleshoot and resolve repeated crashes of the SQL Agent service. Follow step-by-step solutions to fix registry issues and improve stability.
ms.date: 12/04/2025
ms.custom: sap:SQL Agent (Jobs, Alerts, Operators)\SQL Agent Service is unable to start, stops or restarts unexpectedly
ms.reviewer: prmadhes, v-shaywood
---

# SQL Agent services crashes intermittently

This article provides troubleshooting guidance for an issue where the SQL Agent service repeatedly crashes on a regular interval.

## Symptoms

The SQL Agent service crashes intermittently on a SQL Server Always On Cluster. When the SQL Agent service crashes the following error message is added to the ???? log: <!-- Ask SME where the error message is reported. Popup, command output, log entry? -->

> [510] SQLAgent failed, dump generated in \<SQL_Instance_Log_Directory\>
> [LOG] Exception 29539 caught at line 233 of file sql\mpu\SqlAgent\src\autostrt.cpp. SQLServerAgent initiating self-termination.

## Cause

These crashes occur when the SQL Agent service fails to retrieve the following registry key:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\<InstanceID>\SQLServerAgent\AutoRegistryRefresh`

When the registry key retrieve fails, the SQL Agent service reports an exception in the log then terminates itself.

Registry key retrieval can fail due to the following:

- Antivirus or endpoint protection software interfering with registry access.
- Missing or misconfigured registry keys.
- Transient access failures in Windows registry.

## Solution

Use the following steps to resolve this issue:

### Step 1: Verify the registry key

1. Open the Registry Editor (`regedit.exe`).
1. Navigate to the following path: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\<InstanceID>\SQLServerAgent`.
1. Check if the `AutoRegistryRefresh` key exists.
1. If the `AutoRegistryRefresh` key is missing, create a new _DWORD (32-bit) Value_ named `AutoRegistryRefresh` and set its value to `1`

### Step 2: Exclude SQL Server from antivirus scanning

> [!IMPORTANT]
> The process of adding an exclusion to your antivirus or endpoint protection software will vary by publisher. Check with the publisher of your software for specific instructions.

1. Configure your antivirus or endpoint protection software to exclude the common SQL Server processes:
    1. `sqlservr.exe`
    1. `sqlagent.exe`
    1. `ReportingServicesService.exe`
    1. `msmdsrv.exe`
    1. `fdlauncher.exe`
    1. `fdhost.exe`
1. Also, exclude the directory where SQL Server is installed, for example `C:\Program Files\Microsoft SQL Server\`

For more info on configuring your antivirus or endpoint protection software to work with SQL Server, see [Configure antivirus software to work with SQL Server](/troubleshoot/sql/database-engine/security/antivirus-and-sql-server).

### Step 3: Check event logs and dumps

<!-- Check with SME what the user is looking for when they review these logs and dumps  -->

1. Review the SQL Agent logs located in: `<SQL_Instance_Log_Directory>\SQLAGENT.OUT\`.
1. Review the Application and System logs in Event Viewer for related errors.
1. Analyze the SQL Agent dump file (if multiple dumps are generated, focus on the most recent one).

### Step 4: Restart SQL Agent service

Restart the SQL Agent service for the previous changes to take effect.

### Step 5: Monitor stability

1. Monitor the SQL Agent logs for recurrence of the error.
1. Confirm that no new dumps are generated in the log folder.

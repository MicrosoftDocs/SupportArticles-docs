---
title: Troubleshoot SQL Agent Startup Failures with Error 1053
description: Troubleshoot SQL Server Agent error 1053. Follow step-by-step guidance to fix registry issues and restore service functionality after Windows updates.
ms.date: 12/05/2025
ms.custom: sap:Startup, shutdown, restart issues (instance or database)\Database or Server is taking long time to start or shut down or restart
ms.reviewer: prmadhes, v-shaywood
---

# Error 1053: The service did not respond to the start or control request in a timely fashion

This article provides troubleshooting guidance for an issue where the [SQL Server Agent](/ssms/agent/sql-server-agent) fails to start and returns error 1053.

## Symptoms

When this issue occurs, you see the following symptoms:

- The SQL Server Agent service fails to start after a recent Windows update.
- The [Windows Event Log](/windows/win32/wes/windows-event-log) service also fails to start.

When the SQL Server Agent fails to start, it returns the following error message:

> Windows could not start the SQL Server Agent service on Local Computer. Error 1053: The service did not respond to the start or control request in a timely fashion.

## Cause

This issue occurs when one or more registry keys found under `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog` are stored as a `DWORD` type rather than the correct `REG_SZ` (string) type.

These incorrect registry keys cause the Windows Event Log service to fail, which prevents the SQL Server Agent from starting.

## Solution

1. Verify that the SQL Agent fails to start by attempting to start it with one of the following tools:
    1. [Service Control Manager (services.msc)](/windows/win32/services/about-services)
    1. [SQL Server Configuration Manager](/sql/tools/configuration-manager/sql-server-configuration-manager)
    1. [Command Prompt](/sql/database-engine/configure-windows/start-stop-pause-resume-restart-sql-server-services#command-prompt-window-using-net-commands)
    1. [PowerShell](/sql/database-engine/configure-windows/start-stop-pause-resume-restart-sql-server-services#powershell)
1. Check the SQL Agent logs located in `%ProgramFiles%\Microsoft SQL Server\<Instance>\MSSQL\Log\SQLAGENT.OUT` after attempting to start the SQL Agent. If no new entries are added to the logs, this confirmation that the SQL Agent service fails before initialization.
1. Attempt to start the Event Log service by using the following command:

    ```cli
    NET START EVENTLOG
    ```

    If the Event Log service fails to start, no logs appear when you open the [Event Viewer](/host-integration-server/core/windows-event-viewer1).
1. Check the Event Log folder (`C:\Windows\System32\winevt\Logs`) and verify that it contains log files. <!-- Check with SME what they should do if there are no log files -->
1. Use the [System File Checker (SFC)](/troubleshoot/windows-server/installing-updates-features-roles/system-file-checker) to repair any corrupted system components by running the following command:

    ```cli
    sfc /scannow
    ```

1. Identify any invalid registry keys under `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog`. Look for keys of type `DWORD` instead of `REG_SZ`. <!-- Ask SME why we are identifying individual keys when we're going to delete all of them in a later step -->
1. Create a backup of the existing registry keys before making any registry changes, run the following command:

    ```cli
    reg export "HKLM\SOFTWARE\Policies\Microsoft\Windows\EventLog" "<Path_To_Store_Backup>/EventLog_Backup.reg"
    ```

1. Delete the problematic `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog` key by running the following command:

    ```cli
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\EventLog" /f
    ```

1. Restart your device.
1. After your device restarts, start the Windows Event Log service by running the following command:

    ```cli
    NET START EVENTLOG
    ```

    The Event Log service should now start successfully.

1. Start the SQL Server Agent service by running the following command:

    ```cli
    NET START SQLSERVERAGENT
    ```

    The SQL Server Agent service should now start successfully.

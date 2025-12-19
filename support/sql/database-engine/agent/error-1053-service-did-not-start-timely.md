---
title: Troubleshoot SQL Agent Startup Failures with Error 1053
description: Troubleshoot SQL Server Agent error 1053. Follow step-by-step guidance to fix registry issues and restore service functionality after Windows updates.
ms.date: 12/05/2025
ms.custom: sap:Startup, shutdown, restart issues (instance or database)\Database or Server is taking long time to start or shut down or restart
ms.reviewer: prmadhes, v-shaywood
---

# Error 1053: The service did not respond to the start or control request in a timely fashion

This article provides troubleshooting guidance for an issue where the [SQL Server Agent](/ssms/agent/sql-server-agent) fails to start and returns error _1053_.

## Symptoms

When this issue occurs, you see the following symptoms:

- The SQL Server Agent service fails to start after a recent Windows update.
- The [Windows Event Log](/windows/win32/wes/windows-event-log) service also fails to start.

When the SQL Server Agent fails to start, it returns the following error message:

> Windows could not start the SQL Server Agent service on Local Computer.  
> Error 1053: The service did not respond to the start or control request in a timely fashion.

## Cause

This issue occurs when one or more registry keys under `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog` use the `DWORD` type instead of the correct `REG_SZ` (string) type.

These invalid registry keys prevent the Windows Event Log service from starting. Because the SQL Server Agent depends on the Windows Event Log service, when the Windows Event Log service is unavailable the SQL Server Agent also fails to start and returns error _1053_.

> [!IMPORTANT]
> If the registry key `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog` doesn't exist, no Event Log policies are configured for your system. In that case, the solution provided in this article doesn't apply.

## Solution

1. Verify that the SQL Server Agent fails to start by attempting to start it by using one of the following methods:
    * [Service Control Manager (services.msc)](/windows/win32/services/about-services)
    * [SQL Server Configuration Manager](/sql/tools/configuration-manager/sql-server-configuration-manager)
    * [Command Prompt](/sql/database-engine/configure-windows/start-stop-pause-resume-restart-sql-server-services#command-prompt-window-using-net-commands)

       ```cli
       NET START SQLSERVERAGENT
       ```

    * [PowerShell](/sql/database-engine/configure-windows/start-stop-pause-resume-restart-sql-server-services#powershell)

       ```powershell
       Start-Service SQLSERVERAGENT
       ```

1. If the SQL Server Agent starts successfully, the problem is resolved. However, if the SQL Server Agent fails to start and returns error 1053, proceed to the next step.
1. Check the SQL Agent logs located in `%ProgramFiles%\Microsoft SQL Server\<Instance>\MSSQL\Log\SQLAGENT.OUT` after attempting to start the SQL Agent. If no new entries are added to the logs, this condition confirms that the SQL Server Agent fails before initialization. Proceed to the next step.
1. Attempt to start the Event Log service by running the following command in an elevated command prompt:

    ```cli
    NET START EVENTLOG
    ```

    If the Event Log service fails to start, no logs appear when you open the [Event Viewer](/host-integration-server/core/windows-event-viewer1). Proceed to the next step.
1. Check the Event Log folder `C:\Windows\System32\winevt\Logs` for event log files:
   - If the folder contains `.evtx` log files, proceed to the next step.
   - If the folder doesn't contain log files, the Windows Event Log might be corrupted. To troubleshoot a corrupted Windows Event Log, see [How to delete corrupt Event Viewer Log files](~/windows-server/application-management/delete-corrupt-event-viewer-log-files.md).
1. Use the [System File Checker (SFC)](/troubleshoot/windows-server/installing-updates-features-roles/system-file-checker) to repair any corrupted system components by running the following command from an elevated command prompt:

    ```cli
    sfc /scannow
    ```

1. Create a backup of the existing registry keys before making any registry changes, use one of the following methods:

   - Open the [Registry Editor](~/windows-server/performance/windows-registry-advanced-users#use-the-windows-user-interface.md), then right-click the `HKLM\SOFTWARE\Policies\Microsoft\Windows\EventLog` key and select **Export**.

   - From an elevated command prompt, run the following command:

     ```cli
     reg export "HKLM\SOFTWARE\Policies\Microsoft\Windows\EventLog" "<Path_To_Store_Backup>/EventLog_Backup.reg"
     ```

1. Open the [Registry Editor](~/windows-server/performance/windows-registry-advanced-users#use-the-windows-user-interface.md) and navigate to `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog`.
1. Under the `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog` key and all its subkeys:
   1. Identify and delete any registry values that are configured as a `DWORD` type.
   1. Recreate the deleted `DWORD` values by using the same name and the `REG_SZ` type.

1. Delete the problematic `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog` key by running the following command:

    ```cli
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\EventLog" /f
    ```

1. Restart your device, so Windows can recreate the Event Log configuration by using default settings.
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

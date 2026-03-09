---
title: Troubleshoot SQL Agent Startup Failures with Error 1053
description: Troubleshoot SQL Server Agent Error 1053. Follow step-by-step guidance to fix registry issues and restore service functionality after Windows updates.
ms.date: 12/05/2025
ms.custom: sap:Startup, shutdown, restart issues (instance or database)\Database or Server is taking long time to start or shut down or restart
ms.reviewer: prmadhes, v-shaywood
---

# "Error 1053: The service did not respond to the start or control request in a timely fashion"

This article provides troubleshooting guidance for an issue in which the [SQL Server Agent](/ssms/agent/sql-server-agent) doesn't start, and it returns Error _1053_.

## Symptoms

When this issue occurs, you see the following symptoms:

- The SQL Server Agent service doesn't start after a recent Windows update is installed.
- The [Windows Event Log](/windows/win32/wes/windows-event-log) service doesn't start.

If the SQL Server Agent doesn't start, it returns the following error message:

> Windows could not start the SQL Server Agent service on Local Computer.  
> Error 1053: The service did not respond to the start or control request in a timely fashion.

## Cause

This issue occurs if one or more registry keys under the `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog` subkey use the `DWORD` type instead of the correct `REG_SZ` (string) type.

These invalid registry keys prevent the Windows Event Log service from starting. The SQL Server Agent depends on the Windows Event Log service. Therefore, if the Windows Event Log service is unavailable, the SQL Server Agent also doesn't start, and it returns Error _1053_.

> [!IMPORTANT]
> If the registry key `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog` doesn't exist, no event log policies are configured for your system. In that case, the solution that's provided in this article doesn't apply.

## Solution

[!INCLUDE [registry-important-alert](~/includes/registry-important-alert.md)]

1. Verify that the SQL Server Agent didn't start. Try to start it by using any of the following methods:
    - [Service Control Manager (services.msc)](/windows/win32/services/about-services)
    - [SQL Server Configuration Manager](/sql/tools/configuration-manager/sql-server-configuration-manager)
    - [Command prompt](/sql/database-engine/configure-windows/start-stop-pause-resume-restart-sql-server-services#command-prompt-window-using-net-commands)

       ```cli
       NET START SQLSERVERAGENT
       ```

    - [PowerShell](/sql/database-engine/configure-windows/start-stop-pause-resume-restart-sql-server-services#powershell)

       ```powershell
       Start-Service SQLSERVERAGENT
       ```

1. If the SQL Server Agent starts successfully, the problem is resolved. However, if the SQL Server Agent doesn't start, and it returns Error 1053, go to the next step.
1. Check the SQL Agent logs, located at `%ProgramFiles%\Microsoft SQL Server\<Instance>\MSSQL\Log\SQLAGENT.OUT`, after you try to start the SQL Server Agent. If no new entries are added to the logs, this condition confirms that the SQL Server Agent fails before initialization. Go to the next step.
1. Try to start the Event Log service by running the following command in an elevated Command Prompt window:

    ```cli
    NET START EVENTLOG
    ```

1. If the Event Log service starts successfully, the problem is resolved. However, if the Event Log service doesn't start (no logs appear when you open the [Event Viewer](/host-integration-server/core/windows-event-viewer1)) go to the next step.
1. Check the Event Log folder `C:\Windows\System32\winevt\Logs` for event log files:
   - If the folder contains `.evtx` log files, go to the next step.
   - If the folder doesn't contain log files, the Windows event log might be corrupted. To troubleshoot a corrupted Windows event log, see [How to delete corrupt Event Viewer Log files](~/windows-server/application-management/delete-corrupt-event-viewer-log-files.md).
1. Use the [System File Checker (SFC)](../../../windows-server/installing-updates-features-roles/system-file-checker.md) to repair any corrupted system components by running the following command in an elevated Command Prompt window:

    ```cli
    sfc /scannow
    ```

1. Create a backup of the existing registry keys before you make any registry changes. Use one of the following methods:

   - Open [Registry Editor](~/windows-server/performance/windows-registry-advanced-users.md#use-the-windows-user-interface), right-click the `HKLM\SOFTWARE\Policies\Microsoft\Windows\EventLog` key, and then select **Export**.

   - In an elevated Command Prompt window, run the following command:

     ```cli
     reg export "HKLM\SOFTWARE\Policies\Microsoft\Windows\EventLog" "<Path_To_Store_Backup>/EventLog_Backup.reg"
     ```

1. Open the [Registry Editor](~/windows-server/performance/windows-registry-advanced-users.md#use-the-windows-user-interface), and navigate to `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog`.
1. Under the `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog` subkey and all its sub-entries:
   1. Identify and delete any registry values that are configured as a `DWORD` type.
   1. Re-create the deleted `DWORD` values by using the same name and the `REG_SZ` type.

1. Delete the problematic `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog` subkey by running the following command:

    ```cli
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\EventLog" /f
    ```

1. Restart your device to let Windows re-create the event log configuration by using default settings.
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

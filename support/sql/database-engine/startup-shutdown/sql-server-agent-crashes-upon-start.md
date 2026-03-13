---
title: SQL Server Agent Stops Responding When You Try to Start It
description: Resolves an issue in which SQL Server Agent doesn't start, and provides troubleshooting guidance for multiple job entries and missing ODBC drivers.
ms.date: 12/03/2025
ms.reviewer: ramakoni1, v-jayaramanp, v-shaywood
ms.custom: sap:Startup, shutdown, restart issues (instance or database)
---

# SQL Server Agent shuts down unexpectedly when you try to start it

This article provides troubleshooting guidance for an issue in which the SQL Server Agent service stops responding or takes longer than you expect when you try to start it. Many different underlying problems can cause this issue. This article covers some of the most common scenarios.

_Original product version:_ &nbsp; SQL Server  \
_Original KB number:_ &nbsp; 2795690

## Symptoms

A SQL Server Agent fails when you try to start it, or it takes longer than you expect to start. Additionally, you might experience one or more of the following scenarios:

- **Scenario 1**: The following error message is logged in the [System event log](/host-integration-server/core/windows-event-viewer1):
  > The SQL Server Agent (MSSQLSERVER) service failed to start due to the following error:  
  > The service did not respond to the start or control request in a timely fashion.
- **Scenario 2**: The status of the agent appears as "Starting" in Control Panel, and the following error message is logged in the _SQLAgent.log_ file:
  > An idle CPU condition has not been defined - OnIdle job schedules will have no effect.

  Additionally, the following entries might be logged in the _SQLAgent.log_ file:

  ```output
  <Time Stamp> - ? [431] Populating subsystems cache... 
  <Time Stamp> - ? [432] There are 7 subsystems in the subsystems cache 
  <Time Stamp> - ? [124] Subsystem 'ActiveScripting' successfully loaded (maximum concurrency: 40)
  <Time Stamp> - ? [124] Subsystem 'ANALYSISCOMMAND' successfully loaded (maximum concurrency: 400)
  <Time Stamp> - ? [124] Subsystem 'ANALYSISQUERY' successfully loaded (maximum concurrency: 400)
  <Time Stamp> - ? [124] Subsystem 'CmdExec' successfully loaded (maximum concurrency: 40)
  <Time Stamp> - ? [124] Subsystem 'PowerShell' successfully loaded (maximum concurrency: 2)
  <Time Stamp> - ? [124] Subsystem 'SSIS' successfully loaded (maximum concurrency: 400)
  <Time Stamp> - ? [124] Subsystem 'TSQL' successfully loaded (maximum concurrency: 80)
  <Time Stamp> - ! [364] The Messenger service has not been started - NetSend notifications will not be sent
  <Time Stamp> - ? [129] SQLSERVERAGENT starting under Windows NT service control
  <Time Stamp> - + [396] An idle CPU condition has not been defined - OnIdle job schedules will have no effect
  <Time Stamp> - ? [110] Starting SQLServerAgent Monitor using '' as the notification recipient...
  <Time Stamp> - ? [146] Request servicer engine started
  <Time Stamp> - ? [133] Support engine started
  <Time Stamp> - ? [167] Populating job cache...
  <Time Stamp> - ? [131] SQLSERVER service stopping due to a stop request from a user, process, or the OS...
  <Time Stamp> - ? [134] Support engine stopped
  <Time Stamp> - ? [197] Alert engine stopped
  <Time Stamp> - ? [168] There are 4731 job(s) [0 disabled] in the job cache
  <Time Stamp> - ? [170] Populating alert cache...
  <Time Stamp> - ? [171] There are 0 alert(s) in the alert cache
  <Time Stamp> - ? [149] Request servicer engine stopped
  <Time Stamp> - ? [248] Saving NextRunDate/Times for all updated job schedules...
  <Time Stamp> - ? [249] 0 job schedule(s) saved
  <Time Stamp> - ? [127] Waiting for subsystems to finish...
  <Time Stamp> - ? [128] Subsystem 'ActiveScripting' stopped (exit code 1)
  <Time Stamp> - ? [128] Subsystem 'ANALYSISCOMMAND' stopped (exit code 1)
  <Time Stamp> - ? [128] Subsystem 'ANALYSISQUERY' stopped (exit code 1)
  <Time Stamp> - ? [128] Subsystem 'CmdExec' stopped (exit code 1)
  <Time Stamp> - ? [128] Subsystem 'PowerShell' stopped (exit code 1)
  <Time Stamp> - ? [128] Subsystem 'SSIS' stopped (exit code 1)
  <Time Stamp> - ? [175] Job scheduler engine stopped
  ```

- **Scenario 3**: The database engine displays a `session_id` from the _SQLAgent - Generic Refresher_ service and the following job is displayed as query text running in that session: `EXECUTE msdb.dbo.sp_sqlagent_refresh_job`

## Cause 1: Multiple job entries

This issue can occur if you configure a large number of jobs in SQL Server Agent with many schedules. This configuration can continuously activate the Generic refresher task, keeping it in busy state.

For example, the issue can occur if you unintentionally set up multiple subscriptions for your reports in the [SQL Server Reporting Services Configuration Manager](/sql/reporting-services/install-windows/reporting-services-configuration-manager-native-mode).

### Workaround

To work around this issue, delete the jobs that you don't need.

If there are many job entries because you unintentionally set up many subscriptions, delete the unnecessary subscriptions by using the [Reporting Services Configuration Manager](/sql/reporting-services/install-windows/reporting-services-configuration-manager-native-mode).

## Cause 2: ODBC driver missing or not functioning

This issue can occur if the SQL Server [Open Database Connectivity (ODBC)](/sql/odbc/microsoft-open-database-connectivity-odbc) driver is removed or not functioning (often after system updates). SQL Server Agent uses the SQL Server ODBC driver to connect to SQL Server. If the driver is missing or not functioning, a SQL Server Agent fails to start.

For information about the ODBC driver requirements for different versions of SQL Server, see [Hardware and software requirements for SQL Server](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-2025).

### Solution

1. To check if the SQL Server ODBC driver is missing, run one of the following commands in an elevated Command Prompt window or PowerShell:
   1. Command Prompt:

      ```cli
      odbcad32.exe
      ```

      This command opens the [ODBC Data Source Administrator](/host-integration-server/core/odbc-data-source-administrator).

   1. PowerShell:

      ```powershell
      Get-OdbcDriver
      ```

      This command outputs a list of the installed ODBC drivers.

1. Check if the required SQL Server ODBC driver is present by comparing it to the table found in [SQL Server versions and ODBC and OLE DB drivers](/sql/connect/connect-history#sql-server-versions-and-odbc-and-ole-db-drivers). The table lists the version of the SQL Server ODBC driver shipped with each SQL Server engine and used by SQL Server Agent to connect to SQL Server engine.
   1. If the required ODBC driver version is present, repair it by following the steps in [ODBC Driver is present](#odbc-driver-is-present).
   1. If the ODBC driver is missing, install it by following the steps in [ODBC driver is missing](#odbc-driver-is-missing).

#### ODBC driver is present

1. Open **Add or Remove Programs** and select **Microsoft ODBC Driver \<Driver_Version\> for SQL Server**.
1. Select the three dots (**...**) and choose **Modify**.
1. In the wizard that opens, choose the **Repair** option and follow the steps to repair the driver.
1. After you complete the repair steps, you can test the connection to SQL Server by configuring a test DSN with the repaired SQL Server driver. For more information, see [ODBC Data Source Administrator DSN options](/sql/connect/odbc/windows/odbc-administrator-dsn-creation).

#### ODBC driver is missing

1. [Download the ODBC Driver for SQL Server](/sql/connect/odbc/download-odbc-driver-for-sql-server).
1. Install the driver by using the GUI or a silent installation.
   1. To perform a silent installation, run the following command:

      ```cli
      msiexec /i <ODBC_Driver_MSI> /qn
      ```

1. After the driver installation finishes, restart the SQL Server Agent.
1. Verify that the _SQL SERVER AGENT_ service is running.
    1. For an unnamed SQL Server instance, run the following PowerShell command:

       ```powershell
       Get-Service -Name SQLSERVERAGENT
       ```

    1. For a named SQL Server instance, run the following PowerShell command:

       ```powershell
       Get-Service -Name SQLAgent$<InstanceName>
       ```

## Cause 3: Waiting for SQLAgent - Generic Refresher service

When SQL Server Agent starts, the _SQLAgent – Generic Refresher_ component runs the `msdb.dbo.sp_sqlagent_refresh_job` procedure to refresh job metadata. During this operation, SQL Server might repeatedly check Windows group membership for job owners or proxy accounts. These checks use [Windows API](/windows/win32/api/) calls, which can cause the session to enter one or more of the following wait types:

- `PREEMPTIVE_OS_LOOKUPACCOUNTSID`
- `PREEMPTIVE_OS_AUTHORIZATIONOPS`
- `ASYNC_NETWORK_IO`

Use the following query to identify the session and the associated command text:

```sql
SELECT
    s.session_id,
    r.status,
    r.wait_type,
    r.wait_time,
    s.program_name,
    t.text
FROM sys.dm_exec_requests AS r
RIGHT JOIN sys.dm_exec_sessions AS s
    ON r.session_id = s.session_id
OUTER APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
WHERE s.program_name = 'SQLAgent - Generic Refresher';
```

When this issue occurs, the session is in a _RUNNABLE_ state, and regularly waits for the `PREEMPTIVE_OS_LOOKUPACCOUNTSID` wait type. Or, the session is in a waiting state for the `ASYNC_NETWORK_IO` wait type.

### Workaround

To reduce delays related to Windows authorization lookups:

- Ensure domain controllers are reachable and responsive.
- Avoid using highly nested or very large [Active Directory](/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview) groups for SQL Agent job ownership or proxy accounts.
- Restart SQL Server Agent after significant Active Directory group membership changes to refresh the service account’s access token.
- Consider using SQL logins instead of AD groups for job ownership when appropriate.
- Review SQL Agent jobs and proxies to identify Windows principals that might contribute to expensive Windows security lookups.

## More information

- For more information about how to delete a job, see [Delete One or More Jobs](/sql/ssms/agent/delete-one-or-more-jobs).
- For more information about how to manage your reporting services subscriptions, see [Create and Manage Subscriptions for Native Mode Report Servers](/sql/reporting-services/subscriptions/create-and-manage-subscriptions-for-native-mode-report-servers?redirectedfrom=MSDN).
- For more information about various wait types, see [SQL Server wait types](/sql/relational-databases/system-dynamic-management-views/sys-dm-os-wait-stats-transact-sql).

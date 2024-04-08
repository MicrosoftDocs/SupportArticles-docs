---
title: Troubleshoot DPM console crashes
description: Diagnose and resolve crash-related issues with the admin console in Data Protection Manager.
ms.date: 04/08/2024
ms.reviewer: Mjacquet
---
# Troubleshoot Data Protection Manager console crashes

This guide helps you diagnose and resolve crash-related issues with the admin console in System Center 2016 Data Protection Manager (DPM 2016) and later. Common crash error IDs include 917, 999, 948 and 1069.

_Original product version:_ &nbsp; System Center 2016 Data Protection Manager and later  
_Original KB number:_ &nbsp; 10057

Before you start troubleshooting, make sure that you have the latest update rollup package for System Center Data Protection Manager installed. For the latest version, see [System Center - Data Protection Manager build versions](/system-center/dpm/release-build-versions).

## Error 917: Connection to the DPM service has been lost

When dealing with console crashes, it's important to understand that the console on the DPM server relies on several services being available. If any of these services stop running or fail, you will likely receive error 917:

> Connection to the DPM service has been lost.  
> Review the application event log for information about a possible service shutdown.

Here is the screenshot of this error:

:::image type="content" source="media/troubleshoot-data-protection-manager-console-crash/error-917.png" alt-text="Error ID 917 Connection to the DPM service has been lost." border="false":::

If the crash occurs when you launch the console, verify that all of the DPM services are running. The services that must be running are listed in the error message:

- DPM
- DPMRA
- SQL Server Agent (for DPM instance)
- SQL Server (for DPM instance)
- Virtual Disk Service
- Volume Shadow Copy Service

> [!NOTE]
> When DPM is installed in Windows Server 2016 or later versions, the Hyper-V Virtual Machine Management service is also required to be running.

If one of the services isn't running, try starting it and then reopen the DPM console.

If the services are started and you still experience the issue, [check if the database is in recovery mode](#check-if-the-database-is-in-recovery-mode).

If there is a problem starting the service, the error message should give a clue as to the cause of the failure.

### Error 1069: The service did not start due to a logon failure

If you are having trouble starting one of the DPM related services, it may be caused by the service Run As account. The service fails to start with the following error:

> Error 1069: The service did not start due to a logon failure.

Here is a sample screenshot of the error:

:::image type="content" source="media/troubleshoot-data-protection-manager-console-crash/error-1069.png" alt-text="Error ID 1069 The service did not start due to a logon failure." border="false":::

The only services that might be running with an account other than SYSTEM are the SQL Server accounts. Use the following table to verify that the accounts are correct and that they have valid passwords.

> [!NOTE]
> The best way to change the SQL Server user accounts is using the SQL Server Configuration Manager interface.

|Service name|Run As account|Startup type|Investigate if not running?|
|---|---|---|---|
|MSDPM|SYSTEM|Manual|Yes|
|DPMRA|SYSTEM|Automatic|No|
|*SQL Server Agent (for DPM instance)|SYSTEM|Automatic|Yes|
|*SQL Server (for DPM instance)|SYSTEM|Automatic|Yes|
|Virtual Disk Service|SYSTEM|Manual|Yes|
|Volume Shadow Copy Service|SYSTEM|Manual|Yes|
|DPM Access Manager|SYSTEM|Automatic|Yes|
|DPM Agent Coordinator|SYSTEM|Manual|No|
|DPM CPWrapper|SYSTEM|Manual|No|
|DPM Writer|SYSTEM|Automatic|Yes|
|DPMLA|SYSTEM|Manual|No|
|DPM VMM Helper Service|SYSTEM|Manual|No|

\* If library sharing is enabled, SQL Server services will be using a domain account (must be local admin).

## Check if the database is in recovery mode

If the database is in recovery mode, it can cause problems when services attempt to connect to it. The database is put into recovery mode due to a DPMSync - Sync failure or crash. To check whether this is the case, run the following SQL query against the DPMDB:

```sql
select * from tbl_DLS_GlobalSetting
where PropertyName like 'DbRecovery'
```

If the `PropertyValue` returned is **1**, the database is in recovery mode.

Run the following SQL query to take the database out of recovery mode:

```sql
update tbl_DLS_GlobalSetting
set PropertyValue = '0'
where PropertyName like 'DbRecovery'
```

Once complete, restart the DPM service and try the console again.

## Service times out

If the service Run As accounts are properly configured, you may be experiencing an issue with service timeouts. If the service times out when trying to start, you can apply the following registry entry:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control`

**DWORD**: `ServicesPipeTimeout`  
**Value**: **300000**  

If the entry doesn't exist, you can create it. The value is the timeout in milliseconds (ms), for example 60000 equals 1 minute (60 seconds). You must restart the service to implement the change. Adjust the value when necessary.

## The service starts but then crashes

If the service starts and then crashes, check the Application Event Log for an error indicating which service has crashed. Check for any entries with **Error** as the level and **MSDPM** (or any other DPM service) as the source at the time of the crash. The **General** tab for the event should contain information about the service that crashed and some details about the crash.

For example, the **MSDPM** process that fails with event ID 999 has the following details:

> The description for Event ID 999 from source MSDPM cannot be found. Either the component that raises this event is not installed on your local computer or the installation is corrupted. You can install or repair the component on the local computer.
>
> If the event originated on another computer, the display information had to be saved with the event.
>
> The following information was included with the event:
>
> An unexpected error caused a failure for process 'msdpm'. Restart the DPM process 'msdpm'.

Here is the screenshot of this event:

:::image type="content" source="media/troubleshoot-data-protection-manager-console-crash/event-999.png" alt-text="Details of the Event ID 999 that shows when MSDPM process fails.":::

In this example, the **Problem Details** section shows that it failed with the error code 0x80004015 that maps to:

> The class is configured to run as a security id different from the caller

Then we can start investigating the issue as a user account issue. Since it was the MSDPM service that crashed, the next step is to take a look at the corresponding DPM error log. The default location for these DPM error logs is similar to `C:\Program Files\Microsoft System Center\DPM\DPM\Temp\`.

The error logs are named for the service they log, and the current log file for each service is named as *\<service>curr.errlog*.

If the service has crashed, the system also creates a .crash file similar to those shown below:

:::image type="content" source="media/troubleshoot-data-protection-manager-console-crash/crash-file.png" alt-text="Screenshot of a crash file example.":::

The crash event is recorded at the very end of the file and shows you more details.

When troubleshooting the various services crashes, their causes and resolutions are beyond the scope of this guide. The Event Logs, error logs and .crash files should provide you enough information to troubleshoot the most common errors.

## Error 948: Unable to connect to DPM Server

If the service is unable to connect to the DPM database, it will likely be unable to start. In this case, you will see errors similar to the following:

> Unable to connect to \<DPM Server>. (ID: 948)  
> Verify that the DPM service is running on this computer.

The **Problem Details** section in the event log should provide additional information about the nature of the failure. Typically the database is offline or not contactable (more likely if it's on a remote server), or you may have a login failure. In such scenarios, you will probably see an error in the event log similar to one of the following examples:

:::image type="content" source="media/troubleshoot-data-protection-manager-console-crash/event-details-1.png" alt-text="Details of the Error 948 Unable to connect to DPM Server example 1." border="false":::

:::image type="content" source="media/troubleshoot-data-protection-manager-console-crash/event-details-2.png" alt-text="Details of the Error 948 Unable to connect to DPM Server example 2." border="false":::

Some common reasons include:

### Login failure

The account that fails to log in should be clear in the error message. Otherwise, you can check **msdpmcurr.errlog** in the DPM Temp folder. If this doesn't make things clear, try the ERRORLOG files in the SQL Server installation location (for example `C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Log`). The path may vary depending on the exact version of SQL Server installed or if it was installed to a non-default location.

This error log file should include any failed login audit entries. Resolve these errors by assigning permissions to the account mentioned for the database referenced. This is normally either the SQL Server Run As account or the SYSTEM account:

- For the SYSTEM account, you can add the relevant permissions in SQL Server Management Studio by going to **Security** > **Logins** and then right-clicking the **System** account. Ensure that it has the **sysadmin** role selected as shown below:

    :::image type="content" source="media/troubleshoot-data-protection-manager-console-crash/sysadmin-role.png" alt-text="Make sure the sysadmin option is selected for the SYSTEM account.":::

- For the SQL Server Run As account, reset the account in the SQL Server Configuration Manager.

### Database/instance is offline

You should have checked that the SQL Server service is running at this point. Otherwise, check it now. Once the SQL Server service is running, try to connect to the instance from SQL Server Management Studio (SSMS). Occasionally this can fail if the server is logged in under a different account than the account it was installed under. In this scenario, try running SSMS as Administrator. If you can connect successfully, the DPMDB is online. If DPMDB is offline, it will look like the following:

:::image type="content" source="./media/troubleshoot-data-protection-manager-console-crash/dbmdb-offline.png" alt-text="The status of DPMDB is offline and you need to set it to online.":::

If DPMDB is offline, right-click DPMDB, select **Tasks** and then select **Bring online**. After it's online, verify if the problem is resolved.

### Network related issues

If you see errors that suggest there is a network-related problem, test the connection to the database from the DPM server by completing the following steps:

1. Create a .udl file. The easiest way is to rename a blank .txt file with a .udl extension.
2. Double-click the UDL file and select the instance and database to test from the dropdown list.
3. Click **Test Connection**.

    :::image type="content" source="./media/troubleshoot-data-protection-manager-console-crash/test-connection.png" alt-text="Select the Test Connection in the Data Link Properties dialog box.":::

If this fails, check if you can ping the SQL Server from the DPM server and verify that name resolution is working correctly. Also verify that the IP address returned is correct. Verify that the address is also correct in SQL Server > DPM server. Check for any other obvious reasons why traffic might not get through, such as firewalls.

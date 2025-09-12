---
title: Troubleshoot scheduled backup job failures
description: Discusses techniques for troubleshooting scheduled backup job failures in System Center 2012 Data Protection Manager and later versions.
ms.date: 04/08/2024
ms.reviewer: Mjacquet
---
# Troubleshoot scheduled backup job failures in Data Protection Manager

This article discusses how to troubleshoot scheduled backup job failures in Microsoft System Center Data Protection Manager (DPM).

_Original product version:_ &nbsp; System Center Data Protection Manager  
_Original KB number:_ &nbsp; 4456295

Sometimes, recovery point jobs aren't run as scheduled even though the protection status of the respective data sources continues to appear as green (**OK**) in the DPM console. This problem usually occurs when SQL Server Agent fails to invoke the DPM engine to run the scheduled job.

> [!NOTE]
> This problem doesn't affect ad-hoc manual jobs because SQL Server Agent isn't used when you run manual jobs from the DPM console.

## How scheduled job execution works

When protection groups are set up, DPM creates backup jobs (incremental syncs, express full, and so on) in SQL Server for each data source, together with other maintenance jobs. A component that's known as `TriggerJob.exe` is used to invoke the DPM engine by passing the Job Definition ID for the data source to begin execution of the backup job. `TriggerJob.exe` is run by the SQL Server Agent Scheduler at the scheduled time through the following command syntax:

```console
triggerjob.exe <JobDefinitionID> <ScheduleID> <FQDN-DPMServer>
```

The following one is an example of a typical command that's run by Schedule Agent Scheduler to begin execution of the job at the scheduled time:

```console
C:\Program Files\Microsoft System Center 2012 R2\DPM\DPM\bin\TriggerJob.exe 1bd305ae-f158-4948-93f8-e935103b168f 1e53fd39-0339-4d41-96ec-89fdf587f1e5 <FQDN-DPMServer>
```

> [!NOTE]
> This path may differ depending on DPM version and whether it's an upgrade (same path) or a fresh installation (different path).

For some reason, the command doesn't run and call `Triggerjob.exe`, the DPM engine isn't invoked. So the backup job doesn't run. Because SQL Server didn't run the command, DPM doesn't know about this failure and continues to display the protection status of the data sources as green.

The following sections provide a few techniques to troubleshoot scheduled backup job failures.

## Check the Application log

When a scheduled backup job fails to be invoked by SQL Server, DPM doesn't raise any alerts for those job failures because it was a failure on the SQL Server side. However, these events are captured in the Application log as SQL Server, Windows Error Reporting, or MSDPM events, depending on the cause of the problem. Make sure that you check the Application log in Event Viewer for any events from SQL Server that are related to the scheduled job failure. If your DPM computer is using remote SQL Server for DPMDB, review the Application log on the remote server.

For example, the following event may be found in the Application log to indicate that the SQL Server Agent experience some problem when it tried to run the command line.

> Log Name: Application  
> Source: SQLAgent$MSDPM2012  
> Date: \<Date & Time>  
> Event ID: 208  
> Task Category: Job Engine  
> Level: Warning  
> Keywords: Classic  
> User: N/A  
> Computer: \<DPMServerName>  
> Description:  
> SQL Server Scheduled Job '00890b12-9058-4f42-8143-291dc3de4d78' (0xC52C50485ED1754EB12D16117B258DD7) - Status: Failed - Invoked on: \<Date & Time>- Message: The job failed. The Job was invoked by User \<UserName>. The last step to run was step 1 (Default JobStep).

Here is a sample event from Windows Error Reporting:

> Fault bucket , type 0  
> Event Name: DPMException  
> Response: Not available  
> Cab Id: 0
>
> Problem signature:  
> P1: TriggerJob  
> P2: 3.0.7696.0  
> P3: TriggerJob.exe  
> P4: 3.0.7696.0  
> P5: System.UnauthorizedAccessException  
> P6: System.Runtime.InteropServices.Marshal.ThrowExceptionForHRInternal  
> P7: 20B9A72D  
> P8:  
> P9:  
> P10:  

Another sample event from DPM engine:

> Log Name: Application  
> Source: MSDPM  
> Date: \<Date & Time>  
> Event ID: 976  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<FQDN of DPMServerName>  
> Description:  
> The description for Event ID 976 from source MSDPM cannot be found. Either the component that raises this event is not installed on your local computer or the installation is corrupted. You can install or repair the component on the local computer.  
> The DPM job failed because it could not contact the DPM engine.
>
> Problem Details:  
> \<JobTriggerFailed>\<__System>\<ID>9\</ID>\<Seq>0\</Seq>\<TimeCreated>\<Date & Time>\</TimeCreated>\<Source>TriggerJob.cs\</Source>\<Line>76\</Line>\<HasError>True\</HasError>\</__System>\<Tags>\<JobSchedule />\</Tags>\</JobTriggerFailed>

## Run the job manually from SQL Server Management Studio

You can try running the job manually from SQL Management Studio. To do this, follow these steps:

1. Start SQL Server Management Studio, and connect to the SQL Server instance that's used for the DPMDB database. Expand **SQL Server Agent** > **Jobs**. The GUIDs values in the list under **Jobs** provide the **Schedule ID** for each job. Right-click a job, and then select **Start Job at Step** on the context menu.

    :::image type="content" source="media/troubleshoot-scheduled-backup-job-failures/start-job-at-step.png" alt-text="Right-click the job that is listed under Jobs and select the Start Job at Step option.":::

2. If the job doesn't run, you should receive an error message that resembles the following.

    > Execution of job '00890b12-9058-4f42-8143-291dc3de4d78' failed.

    :::image type="content" source="media/troubleshoot-scheduled-backup-job-failures/execution-job-failed-error.png" alt-text="The execution error that occurs if the job doesn't run.":::

3. This message confirms that the SQL Server Agent wasn't able to run the job because of incorrect permissions or some other reason. See [Check the logon account credentials](#check-the-logon-account-credentials) section to troubleshoot this issue.

## Run the job manually at a command prompt

You can run `Triggerjob.exe` at a command line to manually check whether the command will be run and the backup job will start in DPM correctly. To do this, follow these steps:

1. Start SQL Server Management Studio, and then connect to the SQL Server instance that's used for the DPMDB database. Expand **SQL Server Agent** > **Jobs**. Right-click one of the jobs, and then select **Properties**.

    :::image type="content" source="media/troubleshoot-scheduled-backup-job-failures/select-properties.png" alt-text="Right-click one of the jobs and then select Properties.":::

2. In the **Properties** dialog box, select **Steps** on the left, and then select the **Edit** button at the bottom.

    :::image type="content" source="media/troubleshoot-scheduled-backup-job-failures/job-properties.png" alt-text="Edit properties for a job in the Job Properties dialog box." border="false":::

3. In the **Job Step Properties** dialog box, copy the command from the Command Prompt window, as shown in the following screenshot.

    :::image type="content" source="media/troubleshoot-scheduled-backup-job-failures/command-window.png" alt-text="In the Job Step Properties dialog box, copy the command from the Command Prompt window." border="false":::

4. Run the copied command, as appropriate:

    - At an elevated command prompt on the DPM server (that's running a local instance of SQL Server), run the following example command:

      ```console
      C:\Program Files\Microsoft System Center 2012 R2\DPM\DPM\bin\TriggerJob.exe F60C8734-2DF5-4E86-8C7D-43558BD5A071 2F481ACB-2C3D-4F48-8C70-CA989C3E8FF2 <FQDN of DPMServer>
      ```

      If the command runs successfully, the problem is likely related to incorrect permissions or logon credentials. See the [Check the logon account credentials](#check-the-logon-account-credentials) section to troubleshoot this issue.

    - At an elevated command prompt on the remote SQL server, run the following example command (if applicable):

      ```console
      C:\Program Files\Microsoft Data Protection Manager\DPM2012R2\SQLPrep\TriggerJob.exe F60C8734-2DF5-4E86-8C7D-43558BD5A071 2F481ACB-2C3D-4F48-8C70-CA989C3E8FF2 <FQDN of DPMServer>
      ```

      In the remote SQL Server scenario, if the command finishes successfully on the DPM server but fails on the remote SQL Server, focus your troubleshooting efforts on the remote SQL Server to rule out any permissions, network, and firewall issues.

      > [!NOTE]
      > When you look at the list of Schedule IDs for the jobs in SQL Server, it might be challenging to find the mapping of the Schedule ID and the data source that it's associated with. You can run the following SQL query to find more details about the jobs that include some user-friendly information:

        ```sql
        use DPMDB –Change to actual name of DPMDB if it is different

        select

        sche.ScheduleId as 'SQL agent Schedule Job Name',

        sche.JobDefinitionId,

        prot.FriendlyName as 'Protection Group', am.ServerName as 'Servername or NULL',

        case

        when jobd.type = 'C9B259D2-6402-486D-8E36-C6C1ADAE0912' then 'Maintenance job that runs @ midnight'

        when jobd.Type = '3D859D8C-D0BB-4142-8696-C0D215203E0D' then 'Synchronization (file/volume) / Express Full (application)'

        when jobd.Type = '84021B5E-B4DC-9B27-2B7E-3B99BB1225FF' then 'Volume/Share/System State Recovery Point'

        when jobd.Type = '913afd2d-ed74-47bd-b7ea-d42055e5c2f1' then 'Backup to tape (D-T)'

        when jobd.Type = 'B5A3D25C-8EB2-4032-9428-C852DA5CE2C5' then 'Backup to tape (D-D-T)'

        when jobd.Type = 'C4CAE2F7-F068-4A37-914E-9F02991868DA' then 'Consistency Check'

        when jobd.Type = '5ECC82D0-3475-4E81-8ADD-55B1C1D23DB1' then 'SharePoint catalog generation'

        when jobd.Type = '6E7C76F4-A832-4418-A772-8E58FD7466CB' then 'Azure Online backup'

        end

        as Operation

        from tbl_SCH_ScheduleDefinition sche

        left join dbo.tbl_JM_JobDefinition jobd

        join tbl_IM_ProtectedGroup prot

        on jobd.ProtectedGroupId = prot.ProtectedGroupId

        on sche.JobDefinitionId = jobd.JobDefinitionId

        left join dbo.tbl_AM_Server AM

        on AM.ServerId = jobd.serverid

        where sche.IsDeleted = '0' and jobd.ProtectedGroupId is not null

        order by prot.FriendlyName
        ```

        The output of the SQL query will resemble the following example. Based on this output, you can pick a Schedule ID for a data source that's small and quick for testing.

        :::image type="content" source="media/troubleshoot-scheduled-backup-job-failures/output-query.png" alt-text="The output of the SQL query which contains Schedule IDs for data sources.":::

## Check whether SQL Server jobs are disabled

The scheduled jobs might be disabled in SQL Server. To check and enable the jobs, follow these steps:

1. In SQL Server Management Studio, connect to the SQL Server instance for DPM, and then run the SQL query that's mentioned in the previous section to find the list of scheduled jobs.

1. Expand **SQL Server Agent** > **Jobs**. Compare the jobs that are listed there with the output from the SQL query that you ran in step 1. If a job from the query is listed as **Disabled** (arrow pointing down), right-click the job, select **Enable**, and then run the job manually from SQL Server by following the steps that are mentioned in the [Run the job manually at a command prompt](#run-the-job-manually-at-a-command-prompt) section.

    :::image type="content" source="media/troubleshoot-scheduled-backup-job-failures/check-enable-jobs.png" alt-text="Enable the SQL Server jobs under SQL Server Agent.":::

## Check the logon account credentials

DPM enters the SQL Server Agent account name into the registry. It then checks that account each time that it starts. The internal interfaces to DPM are secured by using this account, so the account name must match the account name that the SQL Server Agent uses.

> [!NOTE]
> The account that's used by SQL Server Agent and SQL Server services for the SQL Server instance that hosts DPMDB should be a local account (such as **MICROSOFT$DPM$Acct** or **NTAuthority\System**). If these services are configured to run under a domain service account, check whether there is any specific reason as to why those were configured to use a domain account. The scenarios that would require a domain account for SQL Server services include the following:
>
> - Remote SQL Server: DPM is configured to use a remote SQL Server instance to host its DPMDB database.
> - Library sharing is enabled: Check whether library sharing is enabled. If it's not, change the account to the local account at both locations (SQL Server services and the registry keys that are mentioned in step 2 in the following steps). Or, change the registry key values to match the domain account that's used by SQL Server services, depending on the situation.

Follow these steps to verify the account information and make changes as necessary:

1. Check the logon account that's configured for the following services of the SQL Server instance for DPM:
   - SQL Server (InstanceName)
   - SQL Server Agent (InstanceName)

2. Check the values in the following registry subkey to verify that the values are different. Update the values to reflect the user account that's used for the SQL Server Agent service.

    `HKLM\Software\Microsoft\Microsoft Data Protection Manager\Setup`

    - `SqlAgentAccountName`
    - `SchedulerJobOwnerName`

    > [!NOTE]
    > For the steps to verify the SQL Server accounts that are in the registry, see [System Center 2012 R2 Data Protection Manager install fails and generates ID: 4323: "A member could not be added"](https://support.microsoft.com/help/2930276).

3. After you change the account information in the registry, restart the SQL Server Agent and the SQL Server services.

4. On the DPM server, select the protection group, select **Modify** on the ribbon, and then complete and update the protection group without making any changes.

    > [!NOTE]
    > This step is necessary to regenerate the jobs in SQL Server by using the updated account information.

5. If you're using an account other than the **Microsoft$DPM$Acct** service account, update DDCOM launch and access permissions to match what was granted to **Microsoft$DPM$Acct**. To do this, follow these steps:

    1. Start DCOMCNFG.exe at a command prompt, and then navigate to **Component Services** > **Computers** > **My Computer** > **DCOM Config** > **Microsoft System Center Data Protection Manager 2010 Service**.

    1. Right-click the service name, and then select **Properties**.

    1. Select the **Security** tab, and then select **Edit** in the **Launch and Activation Permissions** area.

    1. Add the new account, and grant all permissions to it.

6. Check the permissions on the following folders (in which Triggerjob.exe is located), as applicable:

   - DPM Server: `C:\Program Files\Microsoft System Center 2012 R2\DPM\DPM\bin`

   - Remote SQL Server: `C:\Program Files\Microsoft Data Protection Manager\DPM2012R2\SQLPrep`

        The DPM service account, **Microsoft$DPM$Acct**, or the account that's used per the previous section (if the SQL Server is remote) should have **Full Control** permissions.

## Check the triggerjob.exe path on the remote SQL Server

If you're using a remote SQL Server instance for both DPM 2012 SP1 and DPM 2012 R2, the DPM 2012 R2 SQL Server Prep overwrites the Triggerjob.exe path on the remote SQL Server for DPM 2012 SP1, and it changes the path as shown:

- **Before**

    `%DPMInstall%\Program files\Microsoft Data Protection Manager\DPM2012\SQLPrep`

- **After**

    `%DPMInstall%\Program files\Microsoft Data Protection Manager\DPM2012R2\SQLPrep`

This behavior causes the SQL Server Agent to fail to find Triggerjob.exe when DPM 2012 SP1 scheduled jobs are run. If this symptom matches your scenario, rerun DPM 2012 SP1 SQL Server Prep to resolve the issue.

For more information about this specific symptom, see this [System Center Data Protection Manager Blog article](https://techcommunity.microsoft.com/t5/system-center-blog/support-tip-after-installing-dpm-2012-r2-sql-prep-on-a-remote/ba-p/349002).

## Check network and firewall settings

If you're using multiple network interface controllers (NICs) and different networks for SQL Server or DPM, and the SQL Server Agent or host file on the SQL Server points to the DPM server, run the following tests to rule out a bad IP address or incorrect firewall settings:

1. Make sure that `Triggerjob.exe` is in the path specified.
2. Run the `Triggerjob.exe` command manually by using the hostname and IP address of the DPM server, each one in turn. Then, check whether the command finishes and invokes the DPM engine successfully.
3. Make sure that DNS resolution is working correctly and that a firewall isn't blocking communications. To do it, follow these steps:

    1. On the SQL Server, add a host file entry for the DPM server name and IP address.
    2. Add the following firewall rules on the DPM server:

        - `advfirewall firewall add rule name="SMB for installation (TCP-139,445-In)" dir=in action=allow profile=any localport=139,445 protocol=tcp remoteip=agentIPAddresses`

        - `advfirewall firewall adds rule name="SMB for installation (UDP- 137,138-In)" dir=in action=allow profile=any localport=137,138 protocol=udp remoteip=agentIPAddresses`

        - `advfirewall firewall adds rule name="RPC for DPM (TCP- 135,5718,5719,49152-65535-In)" dir=in action=allow profile=any localport=135,5718,5719,49152-65535 protocol=tcp remoteip=agentIPAddresses,SQLIPAddress`

## Proactively monitor for scheduled job failures

You can set up an alert outside DPM to monitor for SQL Server Agent Scheduler failures. For example, if you have System Center 2012 Operations Manager deployed in your environment, you can configure it to monitor and generate alerts for warnings or errors messages that are generated by `SQLAgent$MSDPM2012` source. Or, you can specifically monitor for event ID 208.

> [!NOTE]
> To avoid any surprises, make sure that you periodically check the status of recovery point jobs and their availability by reviewing recovery points in the **Recovery** task area in the DPM console.

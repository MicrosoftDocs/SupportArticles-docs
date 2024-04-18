---
title: Troubleshoot Exchange protection and recovery issues
description: Describes how to troubleshoot Exchange protection and recovery issues in Data Protection Manager.
ms.date: 04/08/2024
ms.reviewer: Mjacquet
---
# Troubleshoot Exchange protection and recovery issues in Data Protection Manager

With System Center Data Protection Manager, the majority of the problems with Exchange data sources are caused by an issue on the Exchange server.

_Original product version:_ &nbsp; System Center 2012 Data Protection Manager, System Center 2012 R2 Data Protection Manager  
_Original KB number:_ &nbsp; 10061

Investigation of the Exchange server event logs during the time of the DPM failure will usually point to the root cause. Some general examples are missing logs, database or copies not in a healthy state, or perhaps something preventing the Exchange writer or information store from truncating the logs after a backup is complete.

Because of this, the first step when troubleshooting Exchange protection issues is to check the Exchange server and resolve any issues.

## Cannot enumerate Exchange nodes

Many times, protection problems lie with the inability to enumerate the Exchange nodes.

If you don't see any nodes or databases, verify that the agent is installed on the desired node. Also verify that the database you're attempting to numerate exists on the node with the agent installed.

## Failure to see passive nodes

When you create a protection group for an Exchange Database Availability Group (DAG) and select a database that has multiple passive copies on other nodes, you may find that DPM only displays the active node.

This is usually caused by a registry value that's created outside DPM when some other method is employed to back up and restore Exchange data, such as Windows Server Backup.

The registry value is named `EnableVSSWriter` and is located under `HKEY_LOCAL_MACHINE\Software\Microsoft\ExchangeServer\v14\Replay\Parameters\`.

By default, `EnableVSSWriter` doesn't exist. If you see it, it was probably created manually and set to **0**.

In this case, change the registry value to **1** (hex) which turns it on. Or delete the registry value.

## Recovery point failures

A common cause is an issue with port conflicts. When this occurs, you will see an error similar to the following:

> No connection could be made because the target machine actively refused it (0x8007274D)

You can get this error if network ports 5718 and 5719 on the Exchange server are used by another program. You can verify this by running `netstat -ano` from a command prompt and identifying which process is using these ports. If another program is using the ports, decide which program will be configured to stop using those ports.

### Resolution 1: Configure DPM to use other ports

Configure the DPMRA port and select a nondefault port by using the following steps:

1. On the DPM server, open an administrative command prompt and change the directory to the location where the *SetAgentCfg.exe* utility is located.

    > [!NOTE]
    > By default, the utility is located in the following folder:
    >
    > `%PROGRAMFILES%/Microsoft System Center/DPM/DPM/Setup`

1. Run the *SetAgentCfg.exe* utility by using the following command:

    ```console
    setagentcfg.exe s <protected_server_FQDN> <alternative_port>
    ```

    > [!NOTE]
    > In this command, the \<alternative_port> boilerplate represents a free nondefault port.

1. Verify that a new entry is created in the following registry subkey:

    `HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft Data Protection Manager\Agent\2.0\PsPortConfig`

1. Copy the *setagentcfg.exe* file from the DPM server to the following folder on the protected server.

    `%PROGRAMFILES%\Microsoft Data Protection Manager\DPM\bin`

1. Run the following command on the protected server:

    ```console
    setagentcfg.exe e DPMRA <alternative_port>
    ```

    > [!NOTE]
    > Use the same port number that is specified in step 2.

1. Restart the DPM server.

1. Restart the DPMRA service on the protected server.

### Resolution 2: Configure the conflicting application to use another port

Set the registry to restrict those ports or restarting\removing the conflicting application. Consult the application vendor for more information about reconfiguring port usage.

DPM is the registered owner of ports 5718 and 5719.

## Cyclic Redundancy Check (CRC) errors

CRC errors with Exchange server protection are often indicated by an error message similar to the one below:

> DPM encountered an error while performing an operation for \\\\?\GLOBALROOTDevice\HarddiskVoIumeShadowCopyGUID.log on \<servername> (ID 2033 Details Data error (cyclic redundancy check) (0x80070017))

The most likely cause is a corrupted Exchange transaction log on the Exchange server. However, pay attention to the path in the error message. If the path looks similar to the one below, there is a possibility that the log is corrupted on the DPM server:

`C:\Program Files\Microsoft System Center\DPM\DPM\Volumes\Replica\vol_<VOL GUID>\<GUID>\Full\C-Vol\E0400121F44.log`

To resolve this issue, rename the log file that's mentioned in the error message and copy a known good version from another DAG member. If the corrupted file is on the DPM server's replica volume, replace the file by using the following steps and then run a consistency check. Using the PowerShell commands to mount a replica volume and locate the offending or corrupted log file.

1. Get all protection groups by using the following cmdlets:

    ```powershell
    $pg = get-protectiongroup
    $pg
    ```

1. Get all data sources in the selected protection group based on the zero-based `$pg[index#]` by using the following cmdlets:

    ```powershell
    $ds = get-datasource $pg[#]
    $ds
    ```

1. Mount the replica volume by only specifying the `-datasource` parameter and the zero-based `$pg[index#]`:

    ```powershell
    mount-dpmrecoverypoint -datasource $ds[#]
    ```

1. Note the mount path that the replica was mounted under. For example:

    `C:\Program Files\Microsoft System Center\DPM\DPM\Volumes\Replica\<VOL GUID>`

1. Download the [PsExec tool](/sysinternals/downloads/psexec).

1. From an administrative command prompt, run the following command to run a new *cmd.exe* in the system context.

    ```console
    Psexec.exe -s -i cmd.exe
    ```

1. Change the directory to the replica path. For example:

    `CD C:\Program Files\Microsoft System Center\DPM\DPM\Volumes\Replica\<VOL GUID>`

1. Locate the corrupted log file by using the following command:

    ```console
    `DIR /S E0400121F44.log`
    ```

1. Rename the corrupted log and copy a known good version from another DAG member. Then, close the command prompt.

1. Dismount the replica for the same data source by using the following cmdlet:

    ```powershell
    dismount-dpmrecoverypoint -datasource $ds[#]
    ```

1. Run a consistency check.

## The replica is inconsistent

If the replica is inconsistent, you will see an error similar to the following:

> Data consistency verification check failed for LOGS of Exchange Mailbox Database \<database name> on \<Exchange Node>, (ID 30146 Details: Unknown error (0xfffffdf0) (0xFFFFFDF0))

You may also see the following error in the DPM server Application event log:

> Log Name: Application  
> Source: McLogEvent  
> Event ID: 259  
> Level: Error  
> Description: The file \\\\?\\\<DPM Volume>\\\<Guid>\Full\\\<log volume of Exchange database name>\\<Log#>.log file contains the \<virus name>. Undetermined clean error, deleted successfully. Detected using scan engine version 5400.1158 DAT version 7285.0000
>
> Log Name: Application  
> Source: ESE  
> Event ID: 518  
> Level: Error  
> Task Category: Logging/Recovery  
> Description: eseutil (12472) JetDBUtilities - 13804: The log file \\\\?\\\<DPM Volume>\logs\\\<database name>\\<Log#>.log is missing (error -528 and cannot be used. If this log file is required for recovery, a good copy of the log file will be needed for recovery to complete successfully

This issue usually occurs if you have an antivirus application installed and it is deleting log files that are flagged as infected.

To resolve this issue, use one of the following methods:

- Set DPM antivirus exclusions based on [Run antivirus software on the DPM server](/previous-versions/system-center/system-center-2012-R2/hh757911(v=sc.12)).
- Disable the antivirus application on the server.
- Run an integrity check on the Exchange logs files for the affected database.

> [!NOTE]
> There are other 30146 errors that could have slightly different resolutions, and usually it points to possible corruption on the Exchange server side. See [Error ID: 30146](/previous-versions//hh859405(v=technet.10)) for more information.

## Synchronization failures

When synchronization failures occur, you will see errors similar to the following:

> DPM has detected a discontinuity in the log chain for Exchange Mailbox Database \<mailboxname> on \<Servername> since the last synchronization. (ID 30216 Details: Unspecified error (0x80004005))

The most likely cause is a break in the Exchange transaction logs.

### Resolution 1: Turn on circular logging and flush the logs

1. Disable DPM protection.
2. Turn on circular logging on the database.
3. If needed, mount and dismount the database.
4. Turn off circular logging.
5. Enable DPM protection and run an express full backup.

### Resolution 2: Clear logs older than the missing log file

1. Run `eseutil /k "x:\path\path\ENN" > output.txt`. ENN is the placeholder for Exchange checkpoint file, for example *E01.chk*.
2. Examine the output file to identify gaps in the log stream. For example:

    E010000A.log  
    E010000B - E01000E.log missing  
    E010000E.log  

3. Identify the latest gap and remove all log files prior to it to a different directory.
4. Confirm that the remaining logs are in order by running the `eseutil /k` command as specified in the initial step.
5. Run an express full backup.

## General mailbox issues

Many Exchange server recovery issues involve user mailboxes not visible in the DPM console recovery tab.

If you try to enumerate user mailboxes on the recovery tab of the DPM console and nothing is there, most likely the SG\DB was renamed, which is not supported.

To fix the issue in DPM, complete the following steps:

1. Remove protection while retaining data for the Exchange database.
2. Ensure that the Exchange services or server has been restarted, as the VSS writers will not update until this is done.
3. Refresh the protected server. Then, reprotect the data source and run a consistency check. Recoverable items should appear.

> [!NOTE]
> There will be a gap in the enumeration for any days that backup occurred and the Exchange writer metadata was not updated. These cannot be restored but will eventually be removed as retention expires.

## Some user mailboxes are missing

If you try to enumerate user mailboxes on the recovery tab of the DPM console and only some of the mailboxes are listed as recoverable items, it's possible that the **Read Exchange Information** permission is missing for authenticated users under **Security** > **Advanced** for the particular users in Active Directory.

All mailbox configured users require **Read Exchange Information** permission. To resolve this issue, follow these steps:

1. In Active Directory, go into the properties of the OU > **Advanced** and add an additional **Authenticated Users** group.
2. Select **Edit**.
3. On the **Permission** entry for **User Structure Windows**, select **Properties**.
4. Select **Descendant User Objects**.
5. Select the permission **Read Exchange Information**.
6. Click **OK** three times to complete the operation.
7. Create a recovery point with express full backup.

At this point, all mailboxes should be visible.

## Restore to original location fails

When trying to restore to the original location, you may discover that the option doesn't appear in the DPM console. Usually this is caused by an incorrect selection.

Ensure **All Protected Exchange Data** is highlighted and that **Latest** is selected for the recovery time. Then select the database and select Recover.

> [!NOTE]
> The database being overwritten must have the **Allow overwrite from recovery** flag selected in the Exchange database properties for the restore to work.

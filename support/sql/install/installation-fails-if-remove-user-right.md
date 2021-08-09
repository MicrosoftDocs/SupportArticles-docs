---
title: Installation fails when you remove user rights
description: This article helps you resolve the problem that occurs when you install or upgrade Microsoft SQL Server after tightening security.
ms.date: 10/22/2020
ms.prod-support-area-path: Database Engine
ms.prod: sql
---
# SQL Server installation fails if the Setup account doesn't have certain user rights

This article helps you resolve the problem that occurs when you install or upgrade Microsoft SQL Server after tightening security.

_Original product version:_ &nbsp; SQL Server 2008, SQL Server 2008 R2, SQL Server 2012  
_Original KB number:_ &nbsp; 2000257

## Symptoms

Consider the following scenario. To tighten security, you remove some default user rights to the local administrators group on a Windows operating system. In preparation for setting up SQL Server on this system, you add the Setup account to the local administrators group.

In this scenario, if you either install or upgrade SQL Server, the installation process may fail, and you receive various error messages as noted in the following sections.

- **Scenario 1:** For a new installation, the Setup program fails, and you receive the following error message:

    > Access is denied
    Additionally, you may notice error messages that resemble the following in the Detail.txt file:
    2009-01-02 13:00:17 SQLEngine: --SqlServerServiceSCM: Waiting for nt event 'Global\sqlserverRecComplete$NIIT' to be created
    2009-01-02 13:00:20 SQLEngine: --SqlServerServiceSCM: Waiting for nt event 'Global\sqlserverRecComplete$NIIT' or sql process handle to be signaled
    2009-01-02 13:00:20 Slp: Configuration action failed for feature SQL_Engine_Core_Inst during timing ConfigRC and scenario ConfigRC.
    2009-01-02 13:00:20 Slp: Access is denied
    2009-01-02 13:00:20 Slp: Configuration action failed for feature SQL_Engine_Core_Inst during timing ConfigRC and scenario ConfigRC.
    2009-01-02 13:00:20 Slp: System.ComponentModel.Win32Exception: Access is denied
    2009-01-02 13:00:20 Slp:    at System.Diagnostics.ProcessManager.OpenProcess(Int32 processId, Int32 access, Boolean throwIfExited)
    2009-01-02 13:00:20 Slp:    at System.Diagnostics.Process.GetProcessHandle(Int32 access, Boolean throwIfExited)
    2009-01-02 13:00:20 Slp:    at System.Diagnostics.Process.OpenProcessHandle()
    2009-01-02 13:00:20 Slp:    at System.Diagnostics.Process.get_Handle()
    2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlEngine.SqlServerServiceBase.WaitSqlServerStart(Process processSql)
    2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlEngine.SqlServerServiceSCM.StartSqlServer(String[] parameters)
    2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlEngine.SqlServerStartup.StartSQLServerForInstall(String sqlCollation, String masterFullPath, Boolean isConfiguringTemplateDBs)
    2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlEngine.SqlEngineDBStartConfig.ConfigSQLServerSystemDatabases(EffectiveProperties properties, Boolean isConfiguringTemplateDBs, Boolean useInstallInputs)
    2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlEngine.SqlEngineDBStartConfig.DoCommonDBStartConfig(ConfigActionTiming timing)
    2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlEngine.SqlEngineDBStartConfig.Install(ConfigActionTiming timing, Dictionary`2 actionData, PublicConfigurationBase spcb)
    2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlConfigBase.PrivateConfigurationBase.Execute(ConfigActionScenario scenario, ConfigActionTiming timing, Dictionary`2 actionData, PublicConfigurationBase spcbCurrent)
    2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlConfigBase.SqlFeatureConfigBase.Execute(ConfigActionScenario scenario, ConfigActionTiming timing, Dictionary`2 actionData, PublicConfigurationBase spcbCurrent)
    2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlConfigBase.SlpConfigAction.ExecuteAction(String actionId)
    2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlConfigBase.SlpConfigAction.Execute(String actionId, TextWriter errorStream)
    2009-01-02 13:00:20 Slp: Exception: System.ComponentModel.Win32Exception.
    2009-01-02 13:00:20 Slp: Source: System.
    2009-01-02 13:00:20 Slp: Message: Access is denied.

- **Scenario 2** : Upgrades to SQL Server 2008 will report the following error message on the `Engine_SqlEngineHealthCheck` rule:

    > Rule name:Engine_SqlEngineHealthCheck
    Rule description: Checks whether the SQL Server service can be restarted; or for a clustered instance, whether the SQL Server resource is online.
    Result: Failed
    Message/Corrective Action: The SQL Server service cannot be restarted; or for a clustered instance, the SQL Server resource is not online
    Additionally, you may notice error messages that resemble the following in the Detail.txt file
    2009-05-27 17:50:20 SQLEngine: : Checking Engine checkpoint 'GetSqlServerProcessHandle_1'
    2009-05-27 17:50:20 SQLEngine: --SqlServerServiceSCM: Waiting for nt event 'Global\sqlserverRecComplete$SQL10' to be created
    2009-05-27 17:50:22 SQLEngine: --SqlServerServiceSCM: Waiting for nt event 'Global\sqlserverRecComplete$SQL10' or sql process handle to be signaled
    2009-05-27 17:50:22 SQLEngine: --FacetSqlEngineHealthCheck: Engine_SqlEngineHealthCheck: Error: Access is denied

- **Scenario3:** A new installation of SQL Server 2012 or SQL Server 2008 R2 fails

    You see the following error message when you try to install a new instance of SQL Server 2012 or SQL Server 2008 R2:

    > Rule "Setup account privileges" failed.
    The account that is running SQL Server Setup does not have one or all of the following rights: the right to back up files and directories, the right to manage auditing and the security log and the right to debug programs. To continue, use an account with both of these rights.

- **Scenario 4** : Installing SQL Server 2012 or a later instance fails when you specify a network share (UNC path) for the Backup directory location. When this issue occurs, you receive the following error message:

    > SQL Server setup account does not have the SeSecurityPrivilege privilege on the specified file server in the path \<UNC backup location>. This privilege is needed in folder security setting action of SQL Server setup program. To grant this privilege, use the Local Security Policy console on this file server to add SQL Server setup account to "Manage auditing and security log" policy. This setting is available in the "User Rights Assignments" section under Local Policies in the Local Security Policy console.

  > [!NOTE]
  > This issue occurs because the SQL Server Setup account doesn't have `SeSecurityPrivilege` permissions on the file server that hosts the network share.

## Cause

This behavior is by design. In addition to adding the user account that's running Setup as a local administrator, the Setup user account requires the following default user rights for setup to be completed successfully.

|Local Policy Object Display Name|User Right|
|---|---|
|Backup files and directories|SeBackupPrivilege|
|Debug Programs|SeDebugPrivilege|
|Manage auditing and security log|SeSecurityPrivilege|
|||

> [!NOTE]
> For more information about the permissions that are required to install SQL Server, see the "Prerequisites" section of the following MSDN articles:

- [How to: Install SQL Server 2008 (Setup)](/previous-versions/sql/sql-server-2008/ms143219(v=sql.100))

- [Install SQL Server 2012 from the Installation Wizard (Setup)](/previous-versions/sql/sql-server-2012/ms143219(v=sql.110))

Additionally, if SMB Fileshare is used as a storage option for data directory or any other directories (User database directory, user database log directory, TempDB directory, TempDB log directory or backup directory), the following additional permissions are required for the setup account on SMB fileserver as documented in the following MSDN article:[Install SQL Server with SMB fileshare storage](/sql/database-engine/install-windows/install-sql-server-with-smb-fileshare-as-a-storage-option)

| SMB Network share folder| FULL CONTROL| SQL Setup account |
|---|---|---|
| SMB Network share folder| FULL CONTROL| SQL Server and SQL Server Agent Service account |
| SMB Fileserver| SeSecurityPrivilege| SQL Setup account |
||||

## Resolution

To add the rights to the local administrator account, follow these steps:

1. Log on to the computer as a user who has administrative credentials.
2. Click **Start**, click **Run**, type *Control admintools*, and then click **OK**.
3. Double-click **Local Security Policy**.
4. In the **Local Security Settings** dialog box, click **Local Policies**, double-click **User Rights Assignment**, and then double-click **Backup Files and Directories**.
5. In the **Backup Files and Directories Properties** dialog box, click **Add User or Group**.
6. In the **Select User or Groups** dialog box, type the user account that is being used for setup, and then click **OK** two times.
7. Repeat the procedure for the other two policies that are mentioned in the [Cause](#cause) section.
8. On the **File** menu, click **Exit** to close the **Local Security Settings** dialog box.

## More information

- To check the list of privileges that are currently associated with the account that is used for Setup, you can use the AccessChk.exe tool. To download this tool, see [AccessChk v6.13](/sysinternals/downloads/accesschk).

  **Usage**: accesschk.exe- a \<setup account> *

    For example:
    `c:\tools\accesschk.exe -a testdc\setupaccount *`

  ```console
    Sample output:
           SeSecurityPrivilege
            SeBackupPrivilege
            SeRestorePrivilege
            SeSystemtimePrivilege
            SeShutdownPrivilege
            SeRemoteShutdownPrivilege
            SeTakeOwnershipPrivilege
            SeDebugPrivilege
            SeSystemEnvironmentPrivilege
            SeSystemProfilePrivilege
            SeProfileSingleProcessPrivilege
            SeIncreaseBasePriorityPrivilege
            SeLoadDriverPrivilege
            SeCreatePagefilePrivilege
            SeIncreaseQuotaPrivilege
            SeChangeNotifyPrivilege
            SeUndockPrivilege
            SeManageVolumePrivilege
            SeImpersonatePrivilege
            SeCreateGlobalPrivilege
            SeTimeZonePrivilege
            SeCreateSymbolicLinkPrivilege
            SeInteractiveLogonRight
            SeNetworkLogonRight
            SeBatchLogonRight
            SeRemoteInteractiveLogonRight
  ```

- [Configure Windows Service Accounts and Permissions](/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions)

- **Frequently asked questions**  
  - Why is **SeSecurityPrivilege** required on the file server for the Backup directory on the  UNC share?

    This permission is required in order to retrieve ACLs on the default backup directory to make sure that the SQL Server service account has full permissions on the folder. This also sets the ACLs if permissions are missing for the SQL Service account so that it can perform a backup on the directory. Setup performs these checks for the default backup directory so that if backup is performed on the default backup directorypost-installation, the user doesn't encounter an error or issue (because of missing permissions) when you perform backup on the default directory.

    > [!NOTE]
    > **SeSecurityPrivilege** is required in order to change the get/set ACLs from the directories and subfolders. This is the case because even users who have FULL CONTROL permissions on the directories don't have permissions to get/set OWNER and Audit information from the directory.

  - Why does the error that's described in Scenario 4 occuronlyin SQL Server 2012 and later versions of SQL Server?

    In SQL Server 2012 and later versions, Microsoft started supporting data and log files on the SMB file share. As part of this improvement, the setup experience was further enhanced to tighten the checks so that customers don't encounter errors or issues because of insufficient permission post-installation. In pre-SQL Server 2012 versions, customers can still set up the network share path for the Backup directory when the SQL Service account doesn't have permissions to perform backup. However, they will encounter an error post-installation in this situation. These scenarios are now prevented when you start the SQL 2012 setup check on a network share.

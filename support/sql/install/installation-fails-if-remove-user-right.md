---
title: Installation fails when you remove user rights
description: This article helps you resolve a problem that may occur when you install or upgrade Microsoft SQL Server after tightening security.
ms.date: 03/11/2022
ms.custom: sap:Database Engine
author: rielsql
ms.author: v-jayaramanp
ms.prod: sql
---
# SQL Server installation fails if the Setup account doesn't have certain user rights

This article helps you resolve a problem that may occur when you install or upgrade Microsoft SQL Server after tightening security.

_Applies to_: SQL Server
_Original KB number:_ &nbsp; 2000257

## Symptoms

Consider the scenario where you remove some default user rights from the local administrators group on a Windows operating system to tighten security. To set up SQL Server on your system, you add the Setup account to the local administrators group.

If you try to install or upgrade SQL Server, the installation process may fail and you may receive one of the error messages similar to the errors messages provided in the following sections.

- **Scenario 1:** If  a new installation fails, you may see the following error message:

    > Access is denied
    
    You may also receive error messages that resemble the following in the *Detail.txt* file:
    
    > 2009-01-02 13:00:17 SQLEngine: --SqlServerServiceSCM: Waiting for nt event 'Global\sqlserverRecComplete$NIIT' to be created  
    > 2009-01-02 13:00:20 SQLEngine: --SqlServerServiceSCM: Waiting for nt event 'Global\sqlserverRecComplete$NIIT' or sql process handle to be signaled  
    > 2009-01-02 13:00:20 Slp: Configuration action failed for feature SQL_Engine_Core_Inst during timing ConfigRC and scenario ConfigRC.  
    > 2009-01-02 13:00:20 Slp: Access is denied  
    > 2009-01-02 13:00:20 Slp: Configuration action failed for feature SQL_Engine_Core_Inst during timing ConfigRC and scenario ConfigRC.  
    > 2009-01-02 13:00:20 Slp: System.ComponentModel.Win32Exception: Access is denied  
    > 2009-01-02 13:00:20 Slp:    at System.Diagnostics.ProcessManager.OpenProcess(Int32 processId, Int32 access, Boolean throwIfExited)  
    > 2009-01-02 13:00:20 Slp:    at System.Diagnostics.Process.GetProcessHandle(Int32 access, Boolean throwIfExited)  
    > 2009-01-02 13:00:20 Slp:    at System.Diagnostics.Process.OpenProcessHandle()  
    > 2009-01-02 13:00:20 Slp:    at System.Diagnostics.Process.get_Handle()  
    > 2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlEngine.SqlServerServiceBase.WaitSqlServerStart(Process processSql)  
    > 2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlEngine.SqlServerServiceSCM.StartSqlServer(String[] parameters)  
    > 2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlEngine.SqlServerStartup.StartSQLServerForInstall(String sqlCollation, String masterFullPath, Boolean isConfiguringTemplateDBs)  
    > 2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlEngine.SqlEngineDBStartConfig.ConfigSQLServerSystemDatabases(EffectiveProperties properties, Boolean isConfiguringTemplateDBs, Boolean useInstallInputs)  
    > 2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlEngine.SqlEngineDBStartConfig.DoCommonDBStartConfig(ConfigActionTiming timing)  
    > 2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlEngine.SqlEngineDBStartConfig.Install(ConfigActionTiming timing, Dictionary<string, string> actionData, PublicConfigurationBase spcb)  
    > 2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlConfigBase.PrivateConfigurationBase.Execute(ConfigActionScenario scenario, ConfigActionTiming timing, Dictionary<string, string> actionData, PublicConfigurationBase spcbCurrent)  
    > 2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlConfigBase.SqlFeatureConfigBase.Execute(ConfigActionScenario scenario, ConfigActionTiming timing, Dictionary<string, string> actionData, PublicConfigurationBase spcbCurrent)  
    > 2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlConfigBase.SlpConfigAction.ExecuteAction(String actionId)  
    > 2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlConfigBase.SlpConfigAction.Execute(String actionId, TextWriter errorStream)  
    > 2009-01-02 13:00:20 Slp: Exception: System.ComponentModel.Win32Exception.  
    > 2009-01-02 13:00:20 Slp: Source: System.  
    > 2009-01-02 13:00:20 Slp: Message: Access is denied.  

- **Scenario 2:**  If a new installation of SQL Server 2012 or SQL Server 2008 R2 fails, you may see the following error message:

    > Rule "Setup account privileges" failed.  
    > The account that is running SQL Server Setup doesn't have one or all of the following rights: the right to back up files and directories, the right to manage auditing and the security log and the right to debug programs. To continue, use an account with both of these rights.

- **Scenario 3:** If the installation of SQL Server 2012 or a later version fails when you specify a network share (UNC path) for the Backup directory location, you may see the following error message:

    > SQL Server setup account does not have the SeSecurityPrivilege on the specified file server in the path *\<UNC backup location>*. This privilege is required in folder security setting action of SQL Server setup program. To grant this privilege, use the Local Security Policy console on this file server to add SQL Server setup account to "Manage auditing and security log" policy. This setting is available in the "User Rights Assignments" section under Local Policies in the Local Security Policy console.

  > [!NOTE]
  > This issue occurs because the SQL Server Setup account doesn't have `SeSecurityPrivilege` permissions on the file server that hosts the network share.

## Cause

If a user account is running Setup as a local administrator, the user account requires the following user rights for setup to be completed successfully.

|Local Policy Object Display Name|User Right|
|---|---|
|Backup files and directories|SeBackupPrivilege|
|Debug Programs|SeDebugPrivilege|
|Manage auditing and security log|SeSecurityPrivilege|
|||

> [!NOTE]
> For more information about the permissions which are required to install SQL Server, review the "Prerequisites" section in the following articles:
> - [Planning a SQL Server Installation](/sql/sql-server/install/planning-a-sql-server-installation)
> - [Install SQL Server from the Installation Wizard (Setup)](sql/database-engine/install-windows/install-sql-server-from-the-installation-wizard-setup)

If a storage option for data directory or other directories (user database directory, user database log directory, TempDB directory, TempDB log directory or backup directory) uses SMB file share, the setup account requires the following additional permissions on the SMB file server as described in [Install SQL Server with SMB fileshare storage](/sql/database-engine/install-windows/install-sql-server-with-smb-fileshare-as-a-storage-option).

| SMB Network share folder| FULL CONTROL| SQL Setup account |
|---|---|---|
| SMB Network share folder| FULL CONTROL| SQL Server and SQL Server Agent Service account |
| SMB Fileserver| SeSecurityPrivilege| SQL Setup account |
||||

## Resolution

To add the rights to the setup account, follow these steps:

1. Log on to the computer as an Administrator.
2. Select **Start** > **Run**. Enter *Control admintools*, and then select **OK**.
3. Double-click **Local Security Policy**.
4. In the **Local Security Settings** dialog box, select **Local Policies**, open **User Rights Assignment**, and then double-click **Backup Files and Directories**.
5. In the **Backup Files and Directories Properties** dialog box, select **Add User or Group**.
6. In the **Select User or Groups** dialog box, enter the user account that you want to use for setup, and then select **OK** twice.
7. Follow the same procedure for *Debug Programs* and *Manage auditing and security log* policies to add the user account.
8. On the **File** menu in the **Local Security Settings** dialog box, select **Exit** to close.

## Frequently asked questions

  - Why is **SeSecurityPrivilege** required on the file server for the Backup directory on the UNC share?

    This permission is required to retrieve ACLs on the default backup directory to make sure that the SQL Server service account has full permissions on the folder. This also sets the ACLs if permissions are missing for the SQL Service account so that it can perform a backup on the directory. The Setup program performs these checks for the default backup directory so that if a backup is performed post-installation, you won't face an error or issue (because of missing permissions) when you back up the default directory.

    > [!NOTE]
    > **SeSecurityPrivilege** is required to change the `get/set ACLs` from the directories and subfolders. This is the case where even users who have FULL CONTROL permissions on the directories don't have permissions to `get/set OWNER` and Audit information from the directory.

  - Why does the error that's described in Scenario 3 occur only in SQL Server 2012 and later versions?

    In SQL Server 2012 and later versions, Microsoft has started supporting data and log files on the SMB file share. As part of this improvement, the setup experience was further enhanced to tighten the checks so that customers don't encounter errors or issues because of insufficient permission post-installation. In the pre-SQL Server 2012 versions, customers can still set up the network share path for the Backup directory when the SQL Service account doesn't have permissions to perform backup. However, they will encounter an error post-installation in this situation. These scenarios are now prevented when you start the SQL 2012 setup check on a network share.

## More information

- To check the list of privileges that are currently associated with the Setup account, use the *AccessChk.exe* tool. To download this tool, see [AccessChk v6.13](/sysinternals/downloads/accesschk).

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

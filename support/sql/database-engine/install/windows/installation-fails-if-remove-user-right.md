---
title: Installation fails after you remove user rights
description: This article helps you resolve a problem that occurs when you install or upgrade Microsoft SQL Server after tightening security.
ms.date: 03/17/2022
ms.custom: sap:Database Engine
author: rielsql
ms.author: joriel
ms.reviewer: v-jayaramanp
ms.topic: troubleshooting
---

# SQL Server installation fails after default user rights are removed

This article helps you resolve a problem that occurs when you install or upgrade Microsoft SQL Server after you tighten security.

_Applies to_: SQL Server

## Symptoms

Consider the scenario where you're running Microsoft SQL Server in Windows. To tighten security, you remove some default user rights from the local administrators group. To set up SQL Server on the system, you add the setup account to the local administrators group.

In this scenario, if you try to install or upgrade SQL Server, the installation process fails, and you might receive an error message that resembles one of the messages that are listed as follows:

- **Scenario 1:** If a new installation fails, you receive the following error message:

    ```output
    Access is denied
    ```

    You may also receive error messages that resemble the following in the _Detail.txt_ file:

    ```output
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
    2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlEngine.SqlEngineDBStartConfig.Install(ConfigActionTiming timing, Dictionary<string, string> actionData, PublicConfigurationBase spcb)  
    2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlConfigBase.PrivateConfigurationBase.Execute(ConfigActionScenario scenario, ConfigActionTiming timing, Dictionary<string, string> actionData, PublicConfigurationBase spcbCurrent)  
    2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlConfigBase.SqlFeatureConfigBase.Execute(ConfigActionScenario scenario, ConfigActionTiming timing, Dictionary<string, string> actionData, PublicConfigurationBase spcbCurrent)  
    2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlConfigBase.SlpConfigAction.ExecuteAction(String actionId)  
    2009-01-02 13:00:20 Slp:    at Microsoft.SqlServer.Configuration.SqlConfigBase.SlpConfigAction.Execute(String actionId, TextWriter errorStream)  
    2009-01-02 13:00:20 Slp: Exception: System.ComponentModel.Win32Exception.  
    2009-01-02 13:00:20 Slp: Source: System.  
    2009-01-02 13:00:20 Slp: Message: Access is denied.  
    ```

- **Scenario 2:**  If a new installation of Microsoft SQL Server 2012 or Microsoft SQL Server 2008 R2 fails, you receive one of the following error messages:

    ```output
    Rule "Setup account privileges" failed.  
    
    The account that is running SQL Server Setup doesn't have one or all of the following rights: the right to back up files and directories, the right to manage auditing and the security log and the right to debug programs. To continue, use an account with both of these rights.
    ```

- **Scenario 3:** If the installation of SQL Server 2012 or a later version fails when you specify a network share (UNC path) for the backup directory location, you receive the following error message:

   ```output
   SQL Server setup account does not have the `SeSecurityPrivilege` on the specified file server in the path *\<UNC backup location>*. This privilege is required to set folder security in the SQL Server setup program. To grant this privilege, use the Local Security Policy console on this file server to add SQL Server setup account to **Manage auditing and security log** policy. This setting is available in the **User Rights Assignments** section under Local Policies in the Local Security Policy console.
   ```

  > [!NOTE]
  > This issue occurs because the SQL Server setup account doesn't have the `SeSecurityPrivilege` permissions on the file server that hosts the network share.

## Cause

If you are running the setup as a local administrator, you require the following user rights for setup to run successfully:

|Local Group Policy Object display name|User right|
|---|---|
|**Backup files and directories**|`SeBackupPrivilege`|
|**Debug Programs**|`SeDebugPrivilege`|
|**Manage auditing and security log**|`SeSecurityPrivilege`|
  
> [!NOTE]
> For more information about the permissions that are required to install SQL Server, see the "Prerequisites" section in the following articles:
>
> - [Planning a SQL Server Installation](/sql/sql-server/install/planning-a-sql-server-installation)
> - [Install SQL Server from the Installation Wizard (Setup)](/sql/database-engine/install-windows/install-sql-server-from-the-installation-wizard-setup)

If a storage option for data directory or other directories (user database directory, user database log directory, TempDB directory, TempDB log directory, or backup directory) uses SMB file share, the Setup account requires the following additional permissions on the SMB file server as described in [Install SQL Server with SMB file share storage](/sql/database-engine/install-windows/install-sql-server-with-smb-fileshare-as-a-storage-option).

| SMB Network share folder| FULL CONTROL| SQL Setup account |
|---|---|---|
| SMB Network share folder| FULL CONTROL| SQL Server and SQL Server Agent Service account |
| SMB File server| `SeSecurityPrivilege`| SQL setup account |
  
## Resolution

To add the rights to the setup account, follow these steps:

1. Log on as an administrator.
2. Select **Start** > **Run**, type _Control admintools_, and then select **OK**.
3. Double-click **Local Security Policy**.
4. In the **Local Security Settings** dialog box, select **Local Policies**, open **User Rights Assignment**, and then double-click **Backup Files and Directories**.
5. In the **Backup Files and Directories Properties** dialog box, select **Add User or Group**.
6. In the **Select User or Groups** dialog box, enter the user account that you want to use for setup, and then select **OK** two times.
   > [!NOTE]
   > To add the user account for the **Debug Programs** and **Manage auditing and security log** policies, perform steps 1 through 6 .
7. From **File** menu, open the **Local Security Settings** dialog box, and then select **Exit** to close.

## Frequently asked questions (FAQs)

### Why is `SeSecurityPrivilege` required on the file server for the backup directory on the UNC share?

This permission is required to retrieve Access Control Lists (ACLs) on the default backup directory to make sure that the SQL Server service account has full permissions on the folder. The service account also sets the ACLs if permissions are missing for the SQL service account so that a backup of the directory can be run. The setup program runs these checks for the default backup directory so that if a backup is performed post-installation, you won't experience an error (because of missing permissions).

 > [!NOTE]
 > `SeSecurityPrivilege` is required to change the `get/set ACLs` from the directories and subfolders. This is true even if users who have FULL CONTROL permissions on the directories don't have permissions to `get/set OWNER` and audit information from the directory.

### Why does the error that's described in scenario 3 occur only in Microsoft SQL Server 2012 and later versions?

Starting in SQL Server 2012, Microsoft provides support for data and log files on the SMB file share. As part of this improvement, the setup experience is further enhanced to tighten the security checks so that customers don't encounter errors or issues because of insufficient permissions post-installation. In pre-SQL Server 2012 versions, users can still set up the network share path for the backup directory if the SQL Service account doesn't have permissions to run a backup. However, those users will experience an error post-installation in this situation. These scenarios are now prevented when you start the SQL 2012 setup check on a network share.

## More information

- To check the list of privileges that are currently associated with the setup account, use the _AccessChk.exe_ tool. To download this tool, see [AccessChk v6.13](/sysinternals/downloads/accesschk).

  **Usage**: `accesschk.exe- a \<setup account> *`

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

- For more information, see [Configure Windows Service Accounts and Permissions](/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions).

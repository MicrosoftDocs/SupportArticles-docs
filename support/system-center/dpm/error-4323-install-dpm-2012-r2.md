---
title: Error 4323 installing DPM
description: Fixes an issue in which you get the DPM Setup failed to add a user to the local group error message when you install System Center Data Protection Manager.
ms.date: 04/08/2024
ms.reviewer: Mjacquet
---
# DPM installation fails and generates error 4323: A member could not be added

This article helps you fix an issue in which you get the **DPM Setup failed to add a user to the local group** error message when you install System Center Data Protection Manager.

_Original product version:_ &nbsp; System Center Data Protection Manager  
_Original KB number:_ &nbsp; 2930276

## Symptoms

When you try to install System Center Data Protection Manager, either for the first time or as an upgrade, the installation fails and you receive the following error message:

> Error: DPM Setup failed to add a user to the local group. Review the error details, take the appropriate action, and then run DPM Setup again.  
> ID: 4323. Details: A member could not be added to or removed from the local group because the member does not exist

You may also see entries that resemble the following in the Setup.log file:

> [10/23/2013 11:07:42 AM] Information : Start configuration.  
> [10/23/2013 11:07:42 AM] Information : Starting Service:MSSQL$MSDPM\<version\> on machine:DPMServerName flag restart:False  
> [10/23/2013 11:07:42 AM] Information : Starting Service:SQLAgent$MSDPM\<version\> on machine:DPMServerName flag restart:False  
> [10/23/2013 11:07:42 AM] Information : Starting Service:ReportServer$MSDPM\<version\> on machine:DPMServerName flag restart:False  
> [10/23/2013 11:07:42 AM] Information : Create a registry containing sql agent account information  
> [10/23/2013 11:07:42 AM] Information : Querying WMI Namespace: \\\\DPMServerName\root\cimv2 for query: `SELECT * FROM Win32_Service WHERE Name='SQLAgent$MSDPM<version>'`  
> [10/23/2013 11:07:42 AM] Information : Sql Agent account name = contoso-old\DPMServerName$  
> [10/23/2013 11:07:42 AM] Information : Create a registry containing the trigger job path information  
> [10/23/2013 11:07:42 AM] Data : TriggerJobPath = D:\Microsoft System Center \<version\>\DPM\DPM\bin\  
> [10/23/2013 11:07:42 AM] Information : Add user: contoso-old\DPMServerName$ to local group: Distributed COM Users on server: DPMServerName  
> [10/23/2013 11:07:42 AM] \* Exception : => DPM Setup failed to add a user to the local group.Review the error details, take the appropriate action, and then run DPM Setup again.Microsoft.Internal.EnterpriseStorage.Dls.Setup.Exceptions.BackEndErrorException: Exception of type 'Microsoft.Internal.EnterpriseStorage.Dls.Setup.Exceptions.BackEndErrorException' was thrown.  
> at Microsoft.Internal.EnterpriseStorage.Dls.Setup.NativeConfigHelper.AddAccountToLocalGroup(String accountName, String localGroupName, String machineName)  
> at Microsoft.Internal.EnterpriseStorage.Dls.Setup.Wizard.RemoteDatabaseConfiguration.AddSqlAgentAccountToLocalGroups(String sqlAgentAccountName)  
> at Microsoft.Internal.EnterpriseStorage.Dls.Setup.Wizard.BackEnd.MachineSpecificConfiguration(Boolean existingDB, Boolean upgrading, Boolean isRemoteDb, String sqlServerMachineName, String sqlInstanceName, Boolean isRemoteReporting, String reportingMachineName, String reportingInstanceName)  
> at Microsoft.Internal.EnterpriseStorage.Dls.Setup.Wizard.BackEnd.Configure(Boolean existingDB, Boolean upgrading, String databaseLocation, String sqlServerMachineName, String sqlInstanceName, String reportingMachineName, String reportingInstanceName, Boolean oemSetup)  
> at Microsoft.Internal.EnterpriseStorage.Dls.Setup.Wizard.DpmInstaller.ConfigurePostMsiUpgrade()
at Microsoft.Internal.EnterpriseStorage.Dls.Setup.Wizard.ProgressPage.UpgradeDpm()  
> at Microsoft.Internal.EnterpriseStorage.Dls.Setup.Wizard.ProgressPage.InstallerThreadEntry()
\*** Mojito error was: AddUserToLocalGroupFailed; 1387; WindowsAPI  
> [10/23/2013 11:07:44 AM] \*** Error : DPM Setup failed to add a user to the local group. Review the error details, take the appropriate action, and then run DPM Setup again.  
> ID: 4323. Details: A member could not be added to or removed from the local group because the member does not exist  
> [10/23/2013 11:07:44 AM] Information : The DPM upgrade failed.  
> For more details, click the Error tab.  
> To troubleshoot this issue, see `http://go.microsoft.com/fwlink/?LinkID=164487`.

## Cause

This issue can occur if the environment has a disjointed namespace (that is, the domain has different NetBIOS and DNS names). For example, assume that the domain has a NetBIOS name of *contoso.com* and a DNS name of *contoso-old.com*. When users are added in the Windows UI, they are displayed in the format of *contoso\ComputerName*. However, you notice in the error log that there was an attempt to add a computer account in the format of *contoso-old\ComputerName*.

## Workaround: Upgrade

1. Create a new domain user account that's named MICROSOFT$DPM$Acct. If you cannot create a new domain account, you can use a standard user account.

2. Locate the DPMDB database files and make sure that the new account that you identified or created in step 1 has full permissions to that directory.

3. Change the **MSSQL$MSDPM\<version\>** and **SQLAgent$MSDPM\<version\>** services so that when they start they use the new domain user account from step 1.

> [!NOTE]
> We recommend that you use Microsoft SQL Server Configuration Manager as it provides the easiest way to make this change.

The upgrade installation should now finish successfully.

When the upgrade is complete, revert the two services that are mentioned in step 3 so that they start using the local account designation (MICROSOFT$DPM$Acct).

## Workaround: Fresh installation

1. Create a new domain user account that is named MICROSOFT$DPM$Acct.

2. Create a new local user account on the DPM server that has the same name MICROSOFT$DPM$Acct. Passwords don't have to match between accounts.

3. Change the **MSSQL$MSDPM\<version\>** and **SQLAgent$MSDPM\<version\>** services so that when they start they use the new domain user account from step 1.

Installation should now complete successfully. For a fresh installation, you don't have to revert the two services as mentioned in the [Upgrade](#workaround-upgrade) section as the registry will already have the correct information for the services.

## Verify functionality after an upgrade

> [!NOTE]
> Only follow these steps if you have done an upgrade. Fresh installation don't require this.

To make sure that jobs continue to run as scheduled, follow these steps on the DPM server:

1. In Registry Editor, locate the following registry subkey:

    `HKLM\Software\Microsoft\Microsoft Data Protection Manager\Setup`

2. Make sure that the following values reflect the `%MachineName%\Microosft$DPM$Acct` local account:

    - `SqlAgentAccountName`
    - `SchedulerJobOwnerName`

    > [!NOTE]
    > This account should also have full permissions to the DPM\Bin folder on the DPM server and on the server that's running Microsoft SQL Server, if SQL Server is hosted remotely.

3. Start `DCOMCNFG.exe`, and then locate the following folder:

    `Component Services\Computers\My Computer\DCOM Config\Microsoft System Center Data Protection Manager <version> Service`

4. Right-click the service name, and then select **Properties**.
5. Select the **Security** tab.
6. In the **Launch and Activation Permissions** area, select **Edit**, and then verify that the account exists and has all permissions assigned.
7. Start SQL Server Management Studio for the DPM instance, and then verify that the account has the Sysadmin role.

## Additional steps if the upgrade installation fails

If the upgrade installation fails, and the program doesn't roll back, you must restore a working version of DPM before you can try to install the upgrade again. To do this, follow these steps:

1. Locate the backup copy of your DPMDB file that you created before you started the upgrade process.
2. If DPM is installed, uninstall it.

    > [!IMPORTANT]
    > Make sure that you maintain your data. To do this, select **Retain disk-based recovery points** on the **Uninstallation Options** page.

3. Install DPM. If you had any updates installed, reinstall them in the same sequence that you had installed them previously.

    > [!NOTE]
    > We recommend that you mount the database from step 1, and then run the following query on the DPM database in Administrator mode to locate the sequence in which the updates were originally applied:

    ```sql
    Select distinct MajorVersionNumber,MinorVersionNumber ,BuildNumber, FileName FROM [DPMDB].[dbo].[tbl_AM_AgentPatch] where MajorVersionNumber = 4 and MinorVersionNumber =1 order by BuildNumber desc
    ```

4. To restore the backup database copy, run the following command at an elevated command prompt:

    ```console
    dpmsync -restoredb (with appropriate switches)
    ```

5. To synchronize the databases, run the following command in DPM Management Shell:

    ```console
    dpmsync -sync
    ```  

6. Start the DPM Administrator console, and then make sure that all agents have the same version number as the DPM server.

After you follow these steps, the status of your DPM installation should be restored to its original state. Now, try again to perform the [workaround steps](#workaround-upgrade) and the upgrade installation.

---
title: DP installation, upgrade, and configuration
description: Describes Distribution points installation, upgrade, configuration changes, removal, and how these operations work.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Content Management\Distribution Point Installation, Upgrade or Configuration
---
# Distribution points installation, upgrade, and configuration

This article describes distribution points installation, upgrade, configuration changes, removal and how these operations work. It's important to understand these flows to properly identify and diagnose the issue.

_Original product version:_ &nbsp; Configuration Manager current branch, Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  

## Introduction

When troubleshooting DP installation and upgrade issues, it is important to remember that DP installation/upgrade is performed by a thread from the DP upgrade processing thread pool. Review the DP installation/upgrade process flow to understand how to identify the thread performing the DP installation/upgrade and filter the **DistMgr.log** for the identified thread. Review the filtered **DistMgr.log** to identify whether the DP installation/upgrade failed/succeeded and proceed accordingly.

When troubleshooting DP removal issues, it is important to remember that the DP removal is performed by the DP Manager thread, which is single-threaded. This means that if multiple DPs are removed at the same time, the DP removal will be performed one by one and can take a long time if a large number of DPs are removed. Review the DP Removal process to understand how to identify the DP Manager thread and filter the **DistMgr.log** for the identified thread.

## DP installation

The DP installation involves the steps listed below. These steps cover a typical DP installation initiated from the Configuration Manager console after the administrator has finished the DP installation wizard. Each step is described, followed by an example of how the step can be monitored by examination of the associated log file. If you have a problem with DP installation, the log files should show you exactly where in the process the problem is occurring and provide vital clues to why the process is failing.  

### Step 1: The admin console creates an instance of the `SMS_SCI_SysResUse` WMI class for the new DP

After the administrator completes the DP installation wizard, the admin console creates an instance of the `SMS_SCI_SysResUse` WMI class within the SMS Provider namespace. **SMSProv.log** shows the creation of this instance and contains other useful entries such as the *SMSAppName*, *MachineName*, *UserName*, *ApplicationName*, which can be helpful when investigating problems.

> SMS Provider 4180 (0x1054) ~  
> SMS Provider 4180 (0x1054) CExtUserContext::EnterThread : User=CONTOSO\Admin Sid=\<SID> Caching IWbemContextPtr=00000000046687B0 in Process 0x540 (1344)~  
> SMS Provider 4180 (0x1054) Context: **SMSAppName** =Configuration Manager Administrator console~  
> SMS Provider 4180 (0x1054) Context: **MachineName** =PS1SITE.CONTOSO.COM~  
> SMS Provider 4180 (0x1054) Context: **UserName** =CONTOSO\Admin~  
> SMS Provider 4180 (0x1054) Context: ObjectLockContext=\<ContextID>~  
> SMS Provider 4180 (0x1054) Context: **ApplicationName** =Microsoft.ConfigurationManagement.exe~  
> SMS Provider 4180 (0x1054) Context: ApplicationVersion=5.0.8355.1000~  
> SMS Provider 4180 (0x1054) Context: LocaleID=MS\0x409~  
> SMS Provider 4180 (0x1054) Context: __ProviderArchitecture=32 ~  
> SMS Provider 4180 (0x1054) Context: __RequiredArchitecture=0 (Bool)~  
> SMS Provider 4180 (0x1054) Context: __ClientPreferredLanguages=en-US,en~  
> SMS Provider 4180 (0x1054) Context: __CorrelationId={CorrelationID}~  
> SMS Provider 4180 (0x1054) Context: __GroupOperationId=170804 ~  
> SMS Provider 4180 (0x1054) CExtUserContext : Set ThreadLocaleID OK to: 1033~  
> SMS Provider 4180 (0x1054) CSspClassManager::PreCallAction, dbname=CM_PS1~  
> SMS Provider 4180 (0x1054) PutInstanceAsync SMS_SCI_SysResUse~  
> SMS Provider 4180 (0x1054) CExtProviderClassObject::DoPutInstanceInstance~  
> SMS Provider 4180 (0x1054) INFO: 'PS1DP1.CONTOSO.COM' is a valid FQDN.  
> SMS Provider 4180 (0x1054) Auditing: User CONTOSO\Admin created an instance of class SMS_SCI_SysResUse.~  
> SMS Provider 4180 (0x1054) CExtUserContext::LeaveThread : Releasing IWbemContextPtr=73828272~  
> SMS Provider 4180 (0x1054) ~

When this WMI instance is created, SMS Provider also inserts a row in the database:

```sql
insert into vSMS_SC_SysResUse (SiteNumber, RoleName, NALPath, NALResType) values (1, N'SMS Site System', N'["Display=\\PS1DP1.CONTOSO.COM\"]MSWNET:["SMS_SITE=PS1"]\\PS1DP1.CONTOSO.COM\', N'Windows NT Server')
```

### Step 2(optional): SMS Provider adds the newly created DP to a boundary group if specified during the wizard

During the DP installation wizard, the administrator has the option to specify whether the new DP should be added to an existing or a new boundary group. SMS Provider is responsible for making these changes and logs the following entries:

> SMS Provider 4180 (0x1054) AddSiteSystem~~  
> SMS Provider 4180 (0x1054) Adding site system ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\ to the boundary group PS1 Assignment And Content ~  
> SMS Provider 4180 (0x1054) Successfully added 1 servers to boundary group PS1 Assignment And Content~  
> SMS Provider 4180 (0x1054) Auditing: User CONTOSO\Admin modified an instance of class SMS_BoundaryGroup.~  
> SMS Provider 4180 (0x1054) CExtUserContext::LeaveThread : Releasing IWbemContextPtr=73828272~  
> SMS Provider 4180 (0x1054) ~

### Step 3: SMSDBMON detects a site control change and notifies HMAN to process site control file

SMSDBMON constantly monitors various tables in the database and thus detects a change to the site control file related tables (in step 1). On receiving (denoted as RCV in the log) a change, SMSDBMON notifies the appropriate components by dropping/sending (denoted as SND in the log) files in the component inbox. In this case, SMSDBMON notifies HMAN to process the site control file for changes:

> SMS_DATABASE_NOTIFICATION_MONITOR 2580 (0xa14) RCV: UPDATE on SiteControl for SiteControl_AddUpd_HMAN [PS1 ][1027921]  
> SMS_DATABASE_NOTIFICATION_MONITOR 2580 (0xa14) SND: Dropped E:\ConfigMgr\inboxes\HMAN.box\PS1.SCU [1027921]

### Step 4: HMAN processes the site control file and processes all distribution points

HMAN wakes up to process the SCU file dropped by SMSDBMON, and then starts processing the site control file. During this process, HMAN will look at all distribution points to determine if any DPs are new or changed.

**4a**: For the new DPs, HMAN detects that there is a new site system and inserts data in the `DistributionPoints` table:

> SMS_HIERARCHY_MANAGER 2448 (0x990) ~Processing site control file: Site PS1  
> SMS_HIERARCHY_MANAGER 2448 (0x990) New site system: PS1 PS1DP1.CONTOSO.COM SMS Distribution Point  
> SMS_HIERARCHY_MANAGER 2448 (0x990) New site system: PS1 PS1DP1.CONTOSO.COM SMS Site System  
> SMS_HIERARCHY_MANAGER 2448 (0x990) ~Server Info of site PS1 has changed. Update the DPInfo table in the database.  
> SMS_HIERARCHY_MANAGER 2448 (0x990) ~ **Distribution Points of site PS1 have changed**. Update the DistributionPoints table in the database.  
> SMS_HIERARCHY_MANAGER 2448 (0x990) ~Inserted DP ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\. CRC:439BCA34,PDP:0,PullDP:0  
> SMS_HIERARCHY_MANAGER 2448 (0x990) SQL>>>insert DistributionPoints ( ServerName, NALPath, ShareName, SMSSiteCode, IsPullDP, IsPeerDP, IsBITS, PreStagingAllowed, IsMulticast, AnonymousEnabled, TokenAuthEnabled, SslState, DPType, Priority, TransferRate, DPFlags, IsProtected, DPDrive, Type, MinFreeSpace, IsPXE, IsActive, ResponseDelay, UdaSetting, BindPolicy, SupportUnknownMachines, CertificateType, IdentityGUID, BindExcept, PXEPassword, Action, Account, Description, DPCRC ) values ( N'PS1DP1.CONTOSO.COM', N'["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\', N'', N'PS1', 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, 0, 1, N'', N'Windows NT Server', 50, 0, 0, 0, 0, 0, 0, 0, N'23a72b6c-eace-4218-929c-4c80638c031e', N'', N'', 0, N'', N'PS1 Standard DP', N'439BCA34' )

**4b**: In addition to inserting a new row for the DP in the `DistributionPoints` table, HMAN also distributes the default client packages to the DP:

> SMS_HIERARCHY_MANAGER 2448 (0x990) Loaded client upgrade settings from DB successfully. FullClientPackageID=CS100002, StagingClientPackageID=CS100024, ClientUpgradePackageID=CS100003, PilotingUpgradePackageID=CS100025, ClientUpgradeAdvertisementID=CS120000, ClientPilotingAdvertisementID=(null)  
> SMS_HIERARCHY_MANAGER 2448 (0x990) INFO: Successfully added client package (ID=CS100002) to DP ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\~  
> SMS_HIERARCHY_MANAGER 2448 (0x990) INFO: Successfully added client package (ID=CS100003) to DP ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\~  
> SMS_HIERARCHY_MANAGER 2448 (0x990) INFO: Successfully added client package (ID=CS100024) to DP ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\~  
> SMS_HIERARCHY_MANAGER 2448 (0x990) INFO: Successfully added client package (ID=CS100025) to DP ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\~

**4c**: HMAN updates the DP certificate (self-signed or PKI) information in the database by calling the `spUpdateDPCert` stored procedure:

> SMS_HIERARCHY_MANAGER 2448 (0x990) DP cert query: EXEC spUpdateDPCert N'PS1DP1.CONTOSO.COM', N'23a72b6c-eace-4218-929c-4c80638c031e', ... ...

Note that for any distribution points that haven't changed, HMAN logs an entry:

> SMS_HIERARCHY_MANAGER 2448 (0x990) ~Will not update DP ["Display=\\\PS1SITE.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SITE.CONTOSO.COM\\. DBCRC:13639BB,NewCRC:13639BB,Action:0,PDP:0,PullDP:0  
> SMS_HIERARCHY_MANAGER 2448 (0x990) ~Will not update DP ["Display=\\\PS1SQL.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SQL.CONTOSO.COM\\. DBCRC:DB8F08DA,NewCRC:DB8F08DA,Action:0,PDP:0,PullDP:1  
> SMS_HIERARCHY_MANAGER 2448 (0x990) ~Will not update DP ["Display=\\\PS1SYS.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SYS.CONTOSO.COM\\. DBCRC:B65C605F,NewCRC:B65C605F,Action:0,PDP:0,PullDP:0

> [!NOTE]
> If HMAN encounters a failure trying to insert or update any of the DPs, the entire transaction is rolled back and none of the DPs are processed. If this continues, you will see issues where DPs do not get installed or DP property changes do not take effect.  

### Step 5: HMAN finishes processing the site control file and raises a status message

When HMAN finishes processing the site control file, it raises a status message with ID 3306 which means *Hierarchy Manager successfully processed `E:\ConfigMgr\inboxes\hman.box\PS1.SCU`*, which in our example represents the site control file for site *ConfigMgr Primary Site 1 (PS1)*:

> SMS_HIERARCHY_MANAGER 2448 (0x990) **STATMSG: ID=3306** SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_HIERARCHY_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=1956 TID=2448 GMTDATE=Wed May 11 18:33:34.813 2016 ISTR0="E:\ConfigMgr\inboxes\HMAN.box\PS1.SCU" ISTR1="ConfigMgr Primary Site 1" ISTR2="PS1" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=0

### Step 6: SMSDBMON detects a change in `DistributionPoints` table, and notifies DistMgr to install the DP

SMSDBMON detects a change in the `DistributionPoints` table (from step 4a) and instructs DistMgr to begin the DP installation by dropping a **\<*DPID*>.INS** file into the `DistMgr.box` folder:

> SMS_DATABASE_NOTIFICATION_MONITOR RCV: INSERT on DistributionPoints for DistributionPoints_Ins [32 ][1027928]  
> SMS_DATABASE_NOTIFICATION_MONITOR SND: Dropped E:\ConfigMgr\inboxes\distmgr.box\32.INS [1027928]

In this example, 32 is the distribution point ID. You can find the DP name from the DPID by running the following SQL query against the database:

```sql
SELECT * FROM DistributionPoints WHERE DPID = 32
```

### Step 7: DistMgr wakes up to process the INS file and starts a DP upgrade worker thread to install the DP

DistMgr wakes up to process the *.INS* file that was dropped by SMSDBMON. DP installations and upgrades are handled by the main DP upgrade processing thread. To perform the DP installation, the DP upgrade processing thread uses a thread from the DP upgrade processing thread pool which is set to use a maximum of 50 threads by default. In the following log entries, the main DP upgrade processing thread ID is 2860, which creates a new worker thread with ID 4788 (0x12b4) for the DP installation:

> SMS_DISTRIBUTION_MANAGER 2860 (0xb2c) DP upgrade processing thread: Upgrading DP with ID 32. Thread 0x12b4. Used 1 threads out of 50.

Next, DP processing worker thread 4788 (0x12b4) starts the installation process for DPID 32, which is our new DP:

> SMS_DISTRIBUTION_MANAGER 4788 (0x12b4) ~Processing 32.INS  
> SMS_DISTRIBUTION_MANAGER 4788 (0x12b4) ~DPID 32 - NAL Path ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\ , ServerName = PS1DP1.CONTOSO.COM, DPDrive = , IsMulticast = 0, PXE = 0, RemoveWDS = 0

### Step 8: DistMgr DP upgrade worker thread installs the DP

Here, DistMgr thread 4788 starts the actual DP installation where it completes the following:

- Copies necessary files to the DP
- Installs IIS (if specified during the installation wizard)
- Installs MSXML and the Visual C++ Redistributable components
- Installs the DP WMI Provider
- Creates virtual directories and configures IIS
- Updates the registry settings on the DP server
- Installs the PXE Role (if configured)

Note that the log entries below are truncated to only show relevant information:

> SMS_DISTRIBUTION_MANAGER 4788 (0x12b4) Installed ISAPI on PS1DP1.CONTOSO.COM, copied E:\ConfigMgr\bin\x64\\..\x64\smsfileisapi.dll to \\\PS1DP1.CONTOSO.COM\ADMIN$\system32\inetsrv\smsfileisapi.dll  
> SMS_DISTRIBUTION_MANAGER 4788 (0x12b4) ~Successfully created share SMS_DP$ on server PS1DP1.CONTOSO.COM  
> SMS_DISTRIBUTION_MANAGER 4788 (0x12b4) ~OS version 6.3.9600: installed IIS on remote server PS1DP1.CONTOSO.COM.  
> SMS_DISTRIBUTION_MANAGER 4788 (0x12b4) MSXML 6.0 is configured on DP PS1DP1.CONTOSO.COM successfully  
> SMS_DISTRIBUTION_MANAGER 4788 (0x12b4) Run command 'C:\SMS_DP$\sms\bin\vcredist_x64.exe /q /norestart /log "C:\SMS_DP$\sms\bin\vcredist.log"' to install VC redist  
> SMS_DISTRIBUTION_MANAGER 4788 (0x12b4) ~Successfully installed DP WMI provider on the remote distribution point  
> SMS_DISTRIBUTION_MANAGER 4788 (0x12b4) Configure IIS virtual directories successfully on the distribution point PS1DP1.CONTOSO.COM  
> SMS_DISTRIBUTION_MANAGER 4788 (0x12b4) ConfigureDP  
> SMS_DISTRIBUTION_MANAGER 4788 (0x12b4) DP registry settings have been successfully updated on PS1DP1.CONTOSO.COM  
> SMS_DISTRIBUTION_MANAGER 4788 (0x12b4) **ConfigurePXE**  
> SMS_DISTRIBUTION_MANAGER 4788 (0x12b4) ~["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\ is a Pull DP

> [!TIP]
> Once you reach step 8, it's a lot easier to monitor the installation progress by filtering the log for the worker thread ID (4788 in this example).  

### Step 9 (optional): PXE Provider Role and Windows Deployment Services is installed on the DP (if enabled)

If the DP is enabled for PXE, PXE installation is initiated when **ConfigurePXE** is logged in **DistMgr.log**. At this time, **SMSDPProv.log** on the distribution point will show the PXE/WDS installation progress:

> CcmInstallPXE  
> Running: C:\SMS_DP$\sms\bin\vcredist_x64.exe /q /norestart /log "C:\SMS_DP$\sms\bin\vcredist.log"  
> Waiting for the completion of: C:\SMS_DP$\sms\bin\vcredist_x64.exe /q /norestart /log "C:\SMS_DP$\sms\bin\vcredist.log"  
> Run completed for: C:\SMS_DP$\sms\bin\vcredist_x64.exe /q /norestart /log "C:\SMS_DP$\sms\bin\vcredist.log"  
> Created the DP mutex key for WDS.  
> Finding Wimgapi.Dll  
> MsiEnumRelatedProducts failed  
> FindProduct failed; 0x80070103  
> Found C:\Windows\system32\wimgapi.dll  
> Wimgapi.dll is already installed.  
> Path to smsdp.dll is 'C:\SMS_DP$\sms\bin\smsdp.dll' 05-11-2016 14:36:57.000    PXE performance counters have been initialized  
> Failed to open WDS service.  
> WDS is NOT INSTALLED  
> Installing WDS.  
> Running: ServerManagerCmd.exe -i WDS -a  
> Failed (2) to run: ServerManagerCmd.exe -i WDS -a  
> Running: PowerShell.exe -Command Import-Module ServerManager; Get-WindowsFeature WDS; Add-WindowsFeature WDS  
> Waiting for the completion of: PowerShell.exe -Command Import-Module ServerManager; Get-WindowsFeature WDS; Add-WindowsFeature WDS  
> Run completed for: PowerShell.exe -Command Import-Module ServerManager; Get-WindowsFeature WDS; Add-WindowsFeature WDS  
> Successfully installed WDS.  
> Machine is running Windows Server. (NTVersion=0X603, ServicePack=0)  
> WDS is INSTALLED  
> Setting TFTP config key as: System\CurrentControlSet\Services\WDSSERVER\Providers\WDSTFTP  
> Configuring TFTP read filters  
> SetupComplete is set to 0  
> REMINST not set in WDS  
> WDS is NOT Configured  
> Share (REMINST) does not exist. (NetNameNotFound) (0x00000906)  
> GetFileSharePath failed; 0x80070906  
> REMINST share does not exist. Need to create it.  
> Enumerating drives A through Z for the NTFS drive with the most free space.  
> Drive 'C:\' is the best drive for the SMS installation directory.  
> Creating REMINST share to point to: C:\RemoteInstall  
> Succesfully created share REMINST  
> Removing existing PXE related directories  
> Registering WDS provider: SourceDir: C:\SMS_DP$\sms\bin  
> Registering WDS provider: ProviderPath: C:\SMS_DP$\sms\bin\smspxe.dll  
> DoPxeProviderRegister 05-11-2016 14:37:10.000    PxeLoadWdsPxe  
> Loading wdspxe.dll from C:\Windows\system32\wdspxe.dll  
> wdspxe.dll is loaded  
> PxeProviderRegister has suceeded (0x00000000)  
> Disabling WDS/RIS functionality  
> Found privilege otifyPrivilege on service WDSServer  
> Found privilege SeRestorePrivilege on service WDSServer  
> Found privilege SeBackupPrivilege on service WDSServer  
> Found privilege SeSecurityPrivilege on service WDSServer  
> Privilege SeTakeOwnershipPrivilege NOT found service WDSServer  
> ChangeServiceConfig2 succeeded for WDSServer. Added privilege SeTakeOwnershipPrivilege  
> ChangeServiceConfig succeeded for WDSServer. StartType: 0x2  
> WDSServer status is 1  
> WDSServer is NOT STARTED  
> Failed to restart WDS service  
> Running: WDSUTIL.exe /Initialize-Server /REMINST:"C:\RemoteInstall"  
> Waiting for the completion of: WDSUTIL.exe /Initialize-Server /REMINST:"C:\RemoteInstall"  
> Run completed for: WDSUTIL.exe /Initialize-Server /REMINST:"C:\RemoteInstall"  
> Machine is running Windows Server. (NTVersion=0X603, ServicePack=0)  
> ProcessBootImages failed; 0x80070003  
> CcmInstallPXE: Deleting the DP mutex key for WDS.  
> Installed PXE

### Step 10: DP installation finishes successfully

Once the DP installation finishes successfully, the worker thread raises a status message with ID 2399 which means 'Successfully completed the installation or upgrade of the distribution point on computer \<*DPNALPath*>':

> SMS_DISTRIBUTION_MANAGER 4788 (0x12b4) **STATMSG: ID=2399** SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=1956 TID=4788 GMTDATE=Wed May 11 18:36:58.062 2016 ISTR0="["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\" ISTR1="PS1DP1.CONTOSO.COM" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=404 AVAL0="["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\"  

### Step 11 (for Pull DPs only): DistMgr upgrade processing thread instructs DP WMI Provider to install pull DP by running pulldp.msi

If the DP is configured to be a pull DP, the DistMgr upgrade processing thread starts another DP upgrade worker thread to perform the pull DP installation. This DP upgrade worker thread instructs the SMS DP Provider to run `pulldp.msi` to install the pull DP.

> SMS_DISTRIBUTION_MANAGER 2188 (0x88c) Upgrading PullDP with ID 33. Thread 0x9c0. Used 1 threads out of 50.  
> SMS_DISTRIBUTION_MANAGER 2496 (0x9c0) ~DPID 33 - NAL Path ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\ , ServerName = PS1DP2.CONTOSO.COM, DPDrive = , IsMulticast = 0, PXE = 1, RemoveWDS = 0  
> SMS_DISTRIBUTION_MANAGER 2496 (0x9c0) ConfigurePullDP  
> SMS_DISTRIBUTION_MANAGER 2496 (0x9c0) ~NAL Path ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\ is a Pull DP  
> SMS_DISTRIBUTION_MANAGER 2496 (0x9c0) For server PS1DP2.CONTOSO.COM processor architecture is x64~  
> SMS_DISTRIBUTION_MANAGER 2496 (0x9c0) File '\\\PS1DP2.CONTOSO.COM\SMS_DP$\sms\bin\pulldp.msi' is signed and trusted.
> SMS_DISTRIBUTION_MANAGER 2496 (0x9c0) File '\\\PS1DP2.CONTOSO.COM\SMS_DP$\sms\bin\pulldp.msi' is signed with MS root cert.  
> SMS_DISTRIBUTION_MANAGER 2496 (0x9c0) Installing PullDP, check \\\PS1DP2.CONTOSO.COM\SMS_DP$\sms\logs\smsdpprov.log and \\\PS1DP2.CONTOSO.COM\SMS_DP$\sms\logs\pulldp_install.log  
> SMS_DISTRIBUTION_MANAGER 2496 (0x9c0) PullDP ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\ is marked Installed

At this time, the **SMSDPProv.log** file on the pull DP will show that the installation of pull DP has been initiated:

> 2020 (0x7e4) Started process C:\SMS_DP$\sms\bin\vcredist_x64.exe /q /norestart /l C:\SMS_DP$\sms\logs\vcredist.log  
> 2020 (0x7e4) Run completed for: C:\SMS_DP$\sms\bin\vcredist_x64.exe /q /norestart /l C:\SMS_DP$\sms\logs\vcredist.log  
> 2020 (0x7e4) Started process msiexec.exe /quiet /i C:\SMS_DP$\sms\bin\pulldp.msi /log C:\SMS_DP$\sms\logs\pulldp_install.log

When pull DP is installed on a server which has the ConfigMgr client installed, the command used for installation is:

> 4744 (0x1288) Started process E:\SMS_DP$\sms\bin\ccmsetup.exe /autoupgrade /upgradetolatest /postinstallmsi:"E:\SMS_DP$\sms\bin\pulldp.msi;E:\SMS_DP$\sms\logs\pulldp_install.log"

Pull DP installation progress can be reviewed and monitored by looking at the MSI log file **pulldp_install.log**.

## DP upgrade

Distribution point upgrade involves the steps listed below. These steps cover a typical DP upgrade that is initiated after upgrading a ConfigMgr 1511 site to ConfigMgr 1602. Note that the process is similar when installing a service pack or cumulative update on various Configuration Manager 2012 versions.  

### Step 1: Upgrade results in a site reset, which reinstalls DistMgr component and drops resetdps.trn file in DistMgr.box

After the site upgrade finishes successfully, a site reset is initiated to re-install all the Configuration Manager components. As part of this process, Site Component Manager (SiteComp) reinstalls Distribution Manager and while reinstalling DistMgr, it creates `resetdps.trn` file in `DistMgr.box` to instruct DistMgr to upgrade all the DPs.

> SMS_SITE_COMPONENT_MANAGER    4364 (0x110c)    Reinstalling component SMS_DISTRIBUTION_MANAGER...  
> SMS_SITE_COMPONENT_MANAGER    4364 (0x110c)    Updating DistributionPoints table  
> SMS_SITE_COMPONENT_MANAGER    4364 (0x110c)    Creating E:\ConfigMgr\inboxes\distmgr.box\resetdps.trn file.

### Step 2: DistMgr starts upgrade of all the DPs after detecting the resetdps.trn file

DistMgr starts up after reinstallation and detects the resetdps.trn file:

> SMS_DISTRIBUTION_MANAGER    3048 (0xbe8)    SMS_EXECUTIVE started SMS_DISTRIBUTION_MANAGER as thread ID 4984 (0x1378).  
> SMS_DISTRIBUTION_MANAGER    4984 (0x1378)   Found file resetdps.trn, will upgrade all the Distribution Points

### Step 3: DistMgr upgrade processing thread starts DP upgrade worker threads to perform the DP upgrade

DistMgr upgrade processing thread starts and starts DP upgrade worker threads to upgrade all the DPs. Each of these worker threads work simultaneously and upgrade multiple DPs at once. For DP upgrade processing, we can start up to 50 threads by default, however this is a configurable site control value and is governed by the `DPUpgradeThreadLimit` property for `SMS_DISTRIBUTION_MANAGER` component.

> SMS_DISTRIBUTION_MANAGER    4984 (0x1378)    ~Starting the DP upgrade processing thread, thread ID = 0x7C (124)  
> SMS_DISTRIBUTION_MANAGER    124 (0x7c)    DP upgrade processing thread: Started, will perform any pending work then will wait for additional work.  
> SMS_DISTRIBUTION_MANAGER    124 (0x7c)    DP upgrade processing thread: Upgrading DP with ID 1. Thread 0x13d0. Used 1 threads out of 50.  
> SMS_DISTRIBUTION_MANAGER    124 (0x7c)    DP upgrade processing thread: Upgrading DP with ID 5. Thread 0x8c8. Used 2 threads out of 50.  
> SMS_DISTRIBUTION_MANAGER    124 (0x7c)    DP upgrade processing thread: Upgrading DP with ID 14. Thread 0x100c. Used 3 threads out of 50.

Each individual DP upgrade worker thread starts upgrading a distribution point. In this example, we will focus on thread 2248 (0x8c8) which is going to upgrade DP with DPID 5:

> SMS_DISTRIBUTION_MANAGER    2248 (0x8c8)    ~Processing 5.INS  
> SMS_DISTRIBUTION_MANAGER    2248 (0x8c8)    ~DPID 5 - NAL Path ["Display=\\\PS1SYS.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SYS.CONTOSO.COM\\ , ServerName = PS1SYS.CONTOSO.COM, DPDrive = , IsMulticast = 0, PXE = 1, RemoveWDS = 0

### Step 4: DP upgrade worker thread performs the DP Upgrade

DP upgrade worker thread performs the upgrade of the DP. This process is identical to the DP installation process step 8.

> SMS_DISTRIBUTION_MANAGER    2248 (0x8c8)    Installed ISAPI on PS1SYS.CONTOSO.COM, copied E:\ConfigMgr\bin\x64\\..\x64\smsfileisapi.dll to \\\PS1SYS.CONTOSO.COM\ADMIN$\system32\inetsrv\smsfileisapi.dll  
> SMS_DISTRIBUTION_MANAGER    2248 (0x8c8)    DP share SMS_DP$ already exist on the remote DP~  
> SMS_DISTRIBUTION_MANAGER    2248 (0x8c8)    Install Internet server= 2  
> SMS_DISTRIBUTION_MANAGER    2248 (0x8c8)    Skipping OS configuration for distribution point ["Display=\\\PS1SYS.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SYS.CONTOSO.COM\\. You should install and configure IIS manually. Please ensure RDC is also enabled.  
> SMS_DISTRIBUTION_MANAGER    2248 (0x8c8)    MSXML 6.0 is configured on DP PS1SYS.CONTOSO.COM successfully  
> SMS_DISTRIBUTION_MANAGER    2248 (0x8c8)    Run command 'C:\SMS_DP$\sms\bin\vcredist_x64.exe /q /norestart /log "C:\SMS_DP$\sms\bin\vcredist.log"' to install VC redist  
> SMS_DISTRIBUTION_MANAGER    2248 (0x8c8)    ~Successfully installed DP WMI provider on the remote distribution point  
> SMS_DISTRIBUTION_MANAGER    2248 (0x8c8)    Configure IIS virtual directories successfully on the distribution point PS1SYS.CONTOSO.COM  
> SMS_DISTRIBUTION_MANAGER    2248 (0x8c8)    ConfigureDP  
> SMS_DISTRIBUTION_MANAGER    2248 (0x8c8)    DP registry settings have been successfully updated on PS1SYS.CONTOSO.COM  
> SMS_DISTRIBUTION_MANAGER    2248 (0x8c8)    ConfigurePXE

#### Step 5: DP upgrade worker threads resets the pull DP installation state

DP upgrade worker thread resets the installation state for the pull DP so that it can be updated. Note that this is logged even for Standard DPs but isn't relevant for standard DPs.

> SMS_DISTRIBUTION_MANAGER 2248 (0x8c8) PullDP ["Display=\\\PS1SYS.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SYS.CONTOSO.COM\\ is marked Uninstalled

### Step 6: DP Upgrade finishes successfully

Once the DP installation finishes successfully, the worker thread raises a status message with ID 2399 which means 'Successfully completed the installation or upgrade of the distribution point on computer \<*DPNALPath*>'.

> SMS_DISTRIBUTION_MANAGER    2248 (0x8c8)    STATMSG: ID=2399 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=3444 TID=2248 GMTDATE=Fri Apr 08 22:31:56.637 2016 ISTR0="["Display=\\\PS1SYS.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SYS.CONTOSO.COM\\" ISTR1="PS1SYS.CONTOSO.COM" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=404 AVAL0="["Display=\\\PS1SYS.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SYS.CONTOSO.COM\\"

### Step 7(Pull DPs only): DP worker thread starts instructs DP WMI Provider to upgrade the pull DP

After the pull DP is marked uninstalled, DP upgrade worker thread instructs DP WMI Provider to perform the pull DP upgrade.

> SMS_DISTRIBUTION_MANAGER    2032 (0x7f0)    ConfigurePullDP  
> SMS_DISTRIBUTION_MANAGER    2032 (0x7f0)    ~NAL Path ["Display=\\\PS1SYS.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SYS.CONTOSO.COM\\ is a Pull DP  
> SMS_DISTRIBUTION_MANAGER    2032 (0x7f0)    For server PS1SYS.CONTOSO.COM processor architecture is x64~  
> SMS_DISTRIBUTION_MANAGER    2032 (0x7f0)    File '\\\PS1SYS.CONTOSO.COM\SMS_DP$\sms\bin\pulldp.msi' is signed and trusted.  
> SMS_DISTRIBUTION_MANAGER    2032 (0x7f0)    File '\\\PS1SYS.CONTOSO.COM\SMS_DP$\sms\bin\pulldp.msi' is signed with MS root cert.  
> SMS_DISTRIBUTION_MANAGER    2032 (0x7f0)    Installing PullDP, check \\\PS1SYS.CONTOSO.COM\SMS_DP$\sms\logs\smsdpprov.log and \\\PS1SYS.CONTOSO.COM\SMS_DP$\sms\logs\pulldp_install.log  
> SMS_DISTRIBUTION_MANAGER    2032 (0x7f0)    PullDP ["Display=\\\PS1SYS.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SYS.CONTOSO.COM\\ is marked Installed

At this time, the **SMSDPProv.log** on the pull DP will show that the installation of pull DP has been initiated:

> 2920 (0xb68)    Started process F:\SMS_DP$\sms\bin\vcredist_x64.exe /q /norestart /l F:\SMS_DP$\sms\logs\vcredist.log  
> 2920 (0xb68)    Run completed for: F:\SMS_DP$\sms\bin\vcredist_x64.exe /q /norestart /l F:\SMS_DP$\sms\logs\vcredist.log  
> 2920 (0xb68)    Started process msiexec.exe /quiet /i F:\SMS_DP$\sms\bin\pulldp.msi /log F:\SMS_DP$\sms\logs\pulldp_install.log

When pull DP is installed on a server which has the ConfigMgr client installed, the command used for installation is:

> 4744 (0x1288) Started process E:\SMS_DP$\sms\bin\ccmsetup.exe /autoupgrade /upgradetolatest /postinstallmsi:"E:\SMS_DP$\sms\bin\pulldp.msi;E:\SMS_DP$\sms\logs\pulldp_install.log"

Pull DP installation progress can be reviewed and monitored by looking at the MSI log file **pulldp_install.log**.

## DP change

The following steps explain what happens when you change properties of a DP in the console. These steps cover a scenario where DP description was modified in the **DP Properties** > **General** tab from *PS1 Standard DP* to *PS1 Standard DP - TestPropertyChange1*.  

### Step 1: Admin console changes the instance of SMS_SCI_SysResUse WMI class for the modified DP

After the administrator modifies the DP properties, admin console updates the instance of the `SMS_SCI_SysResUse` WMI class within the SMS Provider namespace for the modified DP. **SMSProv.log** shows:

> SMS Provider    4460 (0x116c)    PutInstanceAsync SMS_SCI_SysResUse~  
> SMS Provider    4460 (0x116c)    CExtProviderClassObject::DoPutInstanceInstance~  
> SMS Provider    4460 (0x116c)    INFO: 'PS1DP1.CONTOSO.COM' is a valid FQDN.  
> SMS Provider    4460 (0x116c)    Auditing: User CONTOSO\Admin modified an instance of class SMS_SCI_SysResUse.~

When this WMI instance is modified, SMS Provider also updates the database:

```sql
update vSMS_SC_SysResUse_Properties set ID = 72057594037928006, Name = N'Description', Value1 = N'PS1 Standard DP - TestPropertyChange1', Value2 = N'', Value3 = 0 where ID = 72057594037928006 and Name = N'Description'  
```

### Step 2: SMSDBMON detects the site control change and notifies HMAN to process the site control file

SMSDBMON detects a change to the site control file related tables (step 1). On receiving (denoted as RCV in the log) a change, SMSDBMON takes appropriate action and notifies appropriate components by dropping/sending (denoted as SND in the log) files in the component inbox. In this case, SMSDBMON notifies HMAN to process the site control file for changes.

> SMS_DATABASE_NOTIFICATION_MONITOR    3120 (0xc30)    RCV: UPDATE on Sites for Sites_AddUpd_HMAN [PS1  ][1031575]  
> SMS_DATABASE_NOTIFICATION_MONITOR    3120 (0xc30)    SND: Dropped E:\ConfigMgr\inboxes\hman.box\PS1.SSU  [1031575]

### Step 3: HMAN processes the site control file and processes all DPs

HMAN wakes up to process the SCU file dropped by SMSDBMON, and starts processing the site control file. During this process, HMAN will look at all distribution points and determine if any DPs are new or changed. For more details on this step, see step 4 in [DP installation](#dp-installation).

> SMS_HIERARCHY_MANAGER    4912 (0x1330)    ~Processing site control file: Site PS1  
> SMS_HIERARCHY_MANAGER    4912 (0x1330)    ~Server Info of site PS1 has not changed.HMAN will not update the DPInfo table in the database.  
> SMS_HIERARCHY_MANAGER    4912 (0x1330)    ~Distribution Points of site PS1 have changed. Update the DistributionPoints table in the database.  
> SMS_HIERARCHY_MANAGER    4912 (0x1330)    ~Updated DP ["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\. DBCRC:151AC30,NewCRC:5EAEB9DF,Action:0,PDP:0,PullDP:0  
> SMS_HIERARCHY_MANAGER    4912 (0x1330)    SQL>>>update DistributionPoints set IsPullDP = 0, IsPeerDP = 0, SMSSiteCode = 'PS1', IsBITS = 0, PreStagingAllowed = 0, IsMulticast = 0, AnonymousEnabled = 0, TokenAuthEnabled = 0, SslState = 0, DPType = 0, Priority = 200, TransferRate = 3972, DPFlags = 0, IsProtected = 1, MinFreeSpace = 50, DPDrive = N'', IsPXE = 0, IsActive = 0, ResponseDelay = 0, UdaSetting = 0, BindPolicy = 0, SupportUnknownMachines = 0, CertificateType = 0, IdentityGUID = N'23a72b6c-eace-4218-929c-4c80638c031e', BindExcept = N'', PXEPassword = N'', Account = N'', Description = N'PS1 Standard DP - TestPropertyChange1', DPCRC = N'5EAEB9DF', Action = 0 where NALPath = N'["Display=\\\PS1DP1.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP1.CONTOSO.COM\\' ~  
> SMS_HIERARCHY_MANAGER    4912 (0x1330)    DP cert query: EXEC spUpdateDPCert N'PS1DP1.CONTOSO.COM', N'23a72b6c-eace-4218-929c-4c80638c031e', …  
> SMS_HIERARCHY_MANAGER    4912 (0x1330)    ~Will not update DP ["Display=\\\PS1SITE.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SITE.CONTOSO.COM\\. DBCRC:13639BB,NewCRC:13639BB,Action:0,PDP:0,PullDP:0  
> SMS_HIERARCHY_MANAGER    4912 (0x1330)    ~Will not update DP ["Display=\\\PS1SQL.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SQL.CONTOSO.COM\\. DBCRC:DB8F08DA,NewCRC:DB8F08DA,Action:0,PDP:0,PullDP:1  
> SMS_HIERARCHY_MANAGER    4912 (0x1330)    ~Will not update DP ["Display=\\\PS1SYS.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1SYS.CONTOSO.COM\\. DBCRC:D9EAF006,NewCRC:D9EAF006,Action:0,PDP:0,PullDP:0

> [!NOTE]
> If HMAN encounters a failure trying to insert or update any of the DPs, the entire transaction is rolled back and none of the DPs gets processed. If this continues, you would see issues where DPs do not get installed, or DP property changes do not take effect.

### Step 4: HMAN finishes processing the site control file

When HMAN finishes the site control file processing, it raises a status message with ID 3306 which means 'Hierarchy Manager successfully processed `E:\ConfigMgr\inboxes\hman.box\PS1.SCU`', which represented the site control file for site *ConfigMgr Primary Site 1 (PS1)*.

> SMS_HIERARCHY_MANAGER    4912 (0x1330)    STATMSG: ID=3306 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_HIERARCHY_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=4224 TID=4912 GMTDATE=Fri May 13 16:41:55.881 2016 ISTR0="E:\ConfigMgr\inboxes\hman.box\PS1.SCU" ISTR1="ConfigMgr Primary Site 1" ISTR2="PS1" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=0

## DP removal

The following steps explain what happens after you remove the Distribution Point role for a site system from the console:

### Step 1: Admin console deletes the instance of `SMS_SCI_SysResUse WMI` class for the deleted DP

After the administrator removes the Distribution Point role, admin console deletes the instance of the `SMS_SCI_SysResUse` WMI class within the SMS Provider namespace for the deleted DP. **SMSProv.log** shows:

> SMS Provider    3652 (0xe44)    DeleteInstanceAsync SMS_SCI_SysResUse.FileType=2,ItemName="["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\,SMS Distribution Point",ItemType="System Resource Usage",SiteCode="PS1"~  
> SMS Provider    3652 (0xe44)    Requested class =SMS_SCI_SysResUse~  
> SMS Provider    3652 (0xe44)    CExtProviderClassObject::DoDeleteInstance~  
> SMS Provider    3652 (0xe44)    Auditing: User CONTOSO\Admin deleted an instance of class SMS_SCI_SysResUse.~

When this WMI instance is modified, SMS Provider also deletes the DP from the database:

```sql
delete vSMS_SC_SysResUse from vSMS_SC_SysResUse where SiteNumber = 1 and RoleName = N'SMS Distribution Point' and NALPath = N'["Display=\\PS1DP2.CONTOSO.COM\"]MSWNET:["SMS_SITE=PS1"]\\PS1DP2.CONTOSO.COM\'
```

### Step 2: SMSDBMON detects the Site Control change and notifies HMAN to process the site control file

SMSDBMON detects a change to the site control file related tables (step 1). On receiving (denoted as RCV in the log) a change, SMSDBMON takes appropriate action and notifies appropriate components by dropping/sending (denoted as SND in the log) files in the component inbox. In this case, SMSDBMON notifies HMAN to process the site control file for changes.

> SMS_DATABASE_NOTIFICATION_MONITOR    3120 (0xc30)    RCV: UPDATE on SiteControl for SiteControl_AddUpd_HMAN [PS1  ][1031673]  
> SMS_DATABASE_NOTIFICATION_MONITOR    3120 (0xc30)    SND: Dropped E:\ConfigMgr\inboxes\hman.box\PS1.SCU  [1031673]  

### Step 3: HMAN processes the site control file and marks the DP as deleted in `DistributionPoints` table

HMAN wakes up to process the SCU file dropped by SMSDBMON, and starts processing the site control file. During this process, HMAN detects that the DP role was removed and marks the DP as **Deleted** (Action = 3) in the `DistributionPoints` table, in addition to removing the DP from the `SysResList` table. HMAN also inserts a row in the `DPNotification` table, in order to provide a DP change notification to SMSDBMON.

> SMS_HIERARCHY_MANAGER    4912 (0x1330)    ~Processing site control file: Site PS1  
> SMS_HIERARCHY_MANAGER    4912 (0x1330)    Site system no longer in use: PS1 PS1DP2.CONTOSO.COM SMS Distribution Point  
> SMS_HIERARCHY_MANAGER    4912 (0x1330)    SQL>>> DELETE FROM SysResList WHERE SiteCode=N'PS1' AND RoleName=N'SMS Distribution Point' AND NALPath=N'["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\'  
> SMS_HIERARCHY_MANAGER    4912 (0x1330)    ~Distribution Points of site PS1 have changed. Update the DistributionPoints table in the database.  
> SMS_HIERARCHY_MANAGER    4912 (0x1330)    SQL>>>update DistributionPoints set Action = 3, State = 0 where DPID = 34  
> SMS_HIERARCHY_MANAGER    4912 (0x1330)    SQL>>>delete vSMS_SC_Address from vSMS_SC_Address where SiteNumber = 1 and DestinationSiteCode = N'PS1DP2.CONTOSO.COM' and AddressType = N'MS_LAN'~  
> SMS_HIERARCHY_MANAGER    4912 (0x1330)    SQL>>>insert DPNotification (DPID, TimeKey) values (34, GetDate())

> [!NOTE]
> If HMAN encounters a failure trying to insert/update any of the DPs, the entire transaction is rolled back and none of the DPs gets processed. If this continues, you would see issues where DPs do not get installed, or DP property changes do not take effect.

When HMAN finishes the site control file processing, it raises status message with ID 3306:

> SMS_HIERARCHY_MANAGER    4912 (0x1330)    STATMSG: ID=3306 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_HIERARCHY_MANAGER" SYS=PS1SITE.CONTOSO.COM SITE=PS1 PID=4224 TID=4912 GMTDATE=Fri May 13 17:43:17.607 2016 ISTR0="E:\ConfigMgr\inboxes\hman.box\PS1.SCU" ISTR1="ConfigMgr Primary Site 1" ISTR2="PS1" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=0

### Step 4: SMSDBMON notifies DistMgr that a DP has changed for required processing by dropping a DPN file

SMSDBMON detects the change in the `DPNotification` table and instructs DistMgr to process the DP change by dropping a \<*DPID*>.DPN file.

> SMS_DATABASE_NOTIFICATION_MONITOR    3120 (0xc30)    RCV: INSERT on DPNotification for DPNotify_ADD [34  ][1031679]  
> SMS_DATABASE_NOTIFICATION_MONITOR    3120 (0xc30)    SND: Dropped E:\ConfigMgr\inboxes\distmgr.box\34.DPN  [1031679]

### Step 5: DistMgr uses the DP Manager thread to uninstall the DP

DistMgr uses the DP Manager thread to process the DP change notification and starts uninstallation of the DP.

DP Manager thread is single-threaded, so if multiple DPs are removed, DistMgr will remove them one at a time. DP removal consists of the following steps:

- Removal of DP from the database, except `DistributionPoints` table
- Removal of PXE role (if needed)
- Removal of Monitoring and Usage Scheduled tasks
- Removal of PDP (if needed)
- Removal of DP WMI Provider
- Removal of DP files: SMS_DP$, SCCMContentLib$ and SMSDIG$ shares

  This can take a long time if there's a lot of content in content library.

- Removal of DP virtual directories from IIS
- Removal of DP registry from the DP

> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    ~Created policy provider trigger for ID 34  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    ConfigurePXE  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    ~["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\ is NOT a Pull DP  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    Uninstalling distribution point files from server PS1DP2.CONTOSO.COM~  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    Deleting DP provider classes from server ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    Deleted provider classes on distribution point  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    Uninstalling distribution point files from server PS1DP2.CONTOSO.COM~  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    ~Uninstalling DP provider from remote distribution point.  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    Unregistering DPProvider on server PS1DP2.CONTOSO.COM.  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    Removed share SMS_DP$ from server PS1DP2.CONTOSO.COM  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    Failed to remove SMS_DP$ directory with error 5, will try to unload distribution point provider and try again.  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    Successfully unloaded provider SMSDPProvider - root\SCCMDP  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    Waiting for provider to be released by COM. Timeout is 300 seconds.  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    Successfully removed SMS_DP$ directory.  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    Removed share SCCMContentLib$ from server PS1DP2.CONTOSO.COM  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    Removed share SMSSIG$ from server PS1DP2.CONTOSO.COM  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    ~Completed uninstalling distribution on the remote distribution point  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    Deleting DP registry on NAL Path = ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\ , ServerName = PS1DP2.CONTOSO.COM

**5a**: (Pull DPs only) If the DP being removed is a pull DP, DistMgr detects that and initiates removal of the pull DP component as well.

> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    ~NAL Path ["Display=\\\PS1DP2.CONTOSO.COM\\"]MSWNET:["SMS_SITE=PS1"]\\\PS1DP2.CONTOSO.COM\\ is a Pull DP  
> SMS_DISTRIBUTION_MANAGER    3848 (0xf08)    Uninstalling PullDP, check \\\PS1DP2.CONTOSO.COM\SMS_DP$\sms\logs\smsdpprov.log and \\\PS1DP2.CONTOSO.COM\SMS_DP$\sms\logs\pulldp_install.log

Finally, the DP is removed from the `DistributionPoints` table.

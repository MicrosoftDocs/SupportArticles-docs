---
title: Understand and troubleshoot Updates and Servicing
description: This article helps administrators understand Updates and Servicing and troubleshoot some common issues in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Understand and troubleshoot Updates and Servicing in Configuration Manager

This article helps administrators understand the **Updates and Serving** node in Configuration Manager (current branch). It can also help you troubleshoot common issues that you may meet during the process.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4490424

Configuration Manager synchronizes with the Microsoft cloud service to get updates that apply to your infrastructure and version. You can install these updates from within the Configuration Manager console.

To view and manage the updates, make sure that you have the [required permissions](/mem/configmgr/core/servers/manage/install-in-console-updates#assign-permissions-to-view-and-manage-updates-and-features). Then navigate to **Administration** > **Cloud Services** > **Updates and Servicing** in the Configuration Manager console. For more information, see [Install in-console updates for Configuration Manager](/mem/configmgr/core/servers/manage/install-in-console-updates).

## List of primary components used for Updates and Servicing

|Name|Component name|Friendly name|Binary|Description|
|---|---|---|---|---|
|Configuration Manager Update|CONFIGURATION_MANAGER_UPDATE|`CMUpdate`|CMUpdate.exe|Service that installs update|
|Distribution Manager|SMS_DISTRIBUTION_MANAGER|DistMgr|Distmgr.dll|Manages content and creates jobs for PkgXferMgr|
|Hierarchy Manager|SMS_HIERARCHY_MANAGER|`Hman`|HMAN.dll|Creates, checks, processes, and replicates updates to the site hierarchy|
|Sender|SMS_SENDER|Sender|Sender.dll|Starts inter-site communications across TCP/IP networks|
|Despooler|SMS_DESPOOLER|Despooler|Despool.dll|Processes incoming replication files from parent or child sites|
|Scheduler|SMS_SCHEDULER|Scheduler|Schedule.dll|Creates sender jobs|
|Database Notification Monitor|SMS_DATABASE_NOTIFICATION_MONITOR|SmsDbMon|Smsdbmon.dll|Watches the database for changes to certain tables, and creates files in the inboxes of components that are responsible for processing those changes|
|DMP Download|SMS_DMP_DOWNLOADER|DmpDownloader|Dmpdownloader.dll|Responsible for downloading new servicing updates to top-level site server|
|SMS Provider|SMS Provider|SMSProv|Smsprov.dll|Windows Management Instrumentation (WMI) Provider that assigns Read and Write access to the Configuration Manager database at a site|

## Downloading updates

The [service connection point](/mem/configmgr/core/servers/deploy/configure/about-the-service-connection-point) is responsible for downloading updates that apply to your Configuration Manager infrastructure. In online mode, it automatically checks for updates every 24 hours. And it downloads available new updates for your current infrastructure and product version to make them available in the Configuration Manager console. When your service connection point is in offline mode, use the [service connection tool](/mem/configmgr/core/servers/manage/use-the-service-connection-tool#use-the-service-connection-tool) to manually sync with the Microsoft cloud.

The following steps explain the [flow](/mem/configmgr/core/servers/manage/download-updates-flowchart) in which an online service connection point downloads in-console updates:

### Step 1: Service connection point checks every 24 hours for available updates - DMPDownloader is used to download manifest cab

Every 24 hours, the service connection point (SCP) downloads ConfigMgr.Update.Manifest.cab, and copies it to the `inboxes\hman.box\CFD` folder. The manifest identifies whether there's a new update or hotfix available for download. The following entries are logged in DMPDownloader.log:

> Download manifest.cab  
> Redirected to URL <https://download.microsoft.com/download/5/2/C/52C5F0D5-2095-4227-BBA4-D3205D9B9714/ConfigMgr.Update.Manifest.cab>  
> Got fwd link and recreating the httprequest/response  
> File 'C:\Program Files\Microsoft Configuration Manager\EasySetupPayload\ConfigMgr.Update.Manifest.cab' is signed and trusted.  
> Signing root cert's thumbprint: cdd4eeae6000ac7f40c3802c171e30148030c072  
> Finished calling verify manifest  
> Manifest.cab was successfully moved to the connector outbox

### Step 2: Hierarchy Manager (Hman) checks for the download signature, extracts the manifest, and then processes the manifest and checks applicability of the packages

1. SMSDBMon drops a blank file (\<SiteCode>.SCU) to `C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box`. It triggers `Hman` to start processing, as follows:

    > STATMSG: ID=3306 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_HIERARCHY_MANAGER"
    > SYS=PrimarySiteMG.MGLAB.com SITE=MG1 PID=2168 TID=4888 GMTDATE=Wed Dec 21 16:15:08.957 2016 ISTR0="C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CAS.SCU"

2. `Hman` checks for the download signature, extracts the manifest, and then processes the manifest and checks applicability of the packages. The following entries are logged in Hman.log:

    > File 'C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CFD\ConfigMgr.Update.Manifest.CAB' is signed and trusted.  
    > Signing root cert's thumbprint: cdd4eeae6000ac7f40c3802c171e30148030c072  
    > Extracting file C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CFD\ConfigMgr.Update.Manifest.CAB to C:\Program Files\Microsoft Configuration Manager\CMUStaging\  
    > Extracted C:\Program Files\Microsoft Configuration Manager\CMUStaging\Manifest.xml  
    > Processing Configuration Manager Update manifest file C:\Program Files\Microsoft Configuration Manager\CMUStaging\manifest.xml  
    > C:\Program Files\Microsoft Configuration Manager\CMUStaging\ApplicabilityChecks\CM1610-KB3209501_AppCheck_10AA8BA0.sql has hash value SHA256:EB2C2D2E27EA0ACE8D4B6E4806FD2698BDE472427F28E60FB969A11BC5D811AB  
    > Configuration Manager Update (PackageGuid=10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C) is applicable

    If a package isn't applicable, the following entries are logged in Hman.log:

    > C:\Program Files\Microsoft Configuration Manager\CMUStaging\ApplicabilityChecks\CM1610-KB3211925_AppCheck_9390F966.sql has hash value SHA256:048DA8137C249AAD11340A855FF7E0E8568F5325FED5F503C4D9C329E73AD464  
    > SQL MESSAGE:  - Not a 1610 FR2 build, skip this hotfix  
    > Configuration Manager Update (PackageGuid=9390F966-F1D0-42B8-BDC1-8853883E704A) is not applicable and should be filtered.

   `Hman` runs `ApplicabilityCheck` SQL queries from the database. When you enable SQL logging, you can see each query run against the database. To run this process manually, follow these steps:

    1. Download the cab file, and extract it to your local computer.
    2. To manually download the cab file, go to [https://download.microsoft.com/download/5/2/C/52C5F0D5-2095-4227-BBA4-D3205D9B9714/ConfigMgr.Update.Manifest.cab](https://download.microsoft.com/download/5/2/C/52C5F0D5-2095-4227-BBA4-D3205D9B9714/ConfigMgr.Update.Manifest.cab).
    3. Use 7-zip or a similar tool to extract the cab file.
    4. After the file is extracted, you can see all the update GUIDs of every update that has been released so far. Each GUID is unique.
    5. Go to the `ApplicabilityChecks` folder.

       > [!NOTE]
       > This folder contains SQL queries to run against the site server database to determine which update is applicable and which one is installed. For example, the Applicability_1602Release_public.sql file.
    6. After each query runs, it updates **State** and **Flag** in the `CM_UpdatePackages` table. The value of **State** shows the current state of the package.

### Step 3: DMPdownloader downloads the payload and redistributable files

If the update is applicable, DMPdownloader downloads the payload and redistributable files by using Setupdl.exe. The following entries are logged:

> INFO: setupdl.exe: Start Configuration Manager Setup  
> INFO: Downloading files to \\\CAS.Contoso.com\EasySetupPayload\c63b412d-7c4b-4c0d-be8c-18fb35b2ff79\redist  
> INFO: Downloading component manifest...  
> INFO: Downloading `http://go.microsoft.com/fwlink/?LinkID=746984` as ConfigMgr.LN.Manifest.cab  
> No proxy information is specified. Connect without proxy.  
> INFO: WinHttpQueryHeaders() in Download() returned OK (200)  
> INFO: Downloading `http://go.microsoft.com/fwlink/?LinkID=746986` as ConfigMgr.Manifest.cab  
> INFO: Extracted file C:\windows\TEMP\ConfigMgr.LN.Manifest.xml  
> INFO: File will be downloaded from `http://go.microsoft.com/fwlink/?LinkID=808179`.

After the update is successfully downloaded, the following entries are logged in ConfigMgrSetup.log:

> INFO: File hash check successfully for DeviceClient_WinCE7.0_X86.CAB  
> INFO: setupdl.exe: Finish

To download the redistributable file, DMPDownloader reads from the Manifest.xml file that is located in the \<_InstallDir_>\Bin\x64 folder. For example:

> \<RedistManifestVersion>201702\</RedistManifestVersion>  
> \<Redist ManifestUrl=[http://go.microsoft.com/fwlink/?LinkID=841450](https://go.microsoft.com/fwlink/?LinkID=841450)"/>  
> \<LanguagePack ManifestUrl="[http://go.microsoft.com/fwlink/?LinkID=841442](https://go.microsoft.com/fwlink/?LinkID=841442)"/>

You can manually download redistributable files by using the following command:

```console
setupdl.exe /RedistUrl http://go.microsoft.com/fwlink/?LinkID=841450 /LnManifestUrl http://go.microsoft.com/fwlink/?LinkID=841442 /RedistVersion 201702 /NoUI "C:\temp\redist"
```  

### Step 4: DMPDownloader puts a CMU file into the service connection point outbox

- If the outbox has a remote role, it's located at `MP\OUTBOXES\MCM.box`.
- If the outbox is on the site server, it's located at `inboxes\hman.box\ForwardingMsg`.

The file displacement manager (FDM) moves the `.CMU` file from the service connection point outbox to `inboxes\hman.box\ForwardingMsg` for the site server. This notification file marks that the update package is available to be installed.

If you haven't configured your hierarchy to have a Microsoft Intune subscription, the following entry is logged in Hman.log:

> Validate CMU file C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CFD\e8e74b72-504a-4202-9167-8749c223d2a5.CMU with no Intune subscription.

If you've configured a subscription, the package is processed and no log entry is created.

### Step 5: Admin console is updated with applicable updates for your environment

The Configuration Manager Admin console shows applicable updates as available. It can be verified by checking the **State** column in the `CM_UpdatePackages` table. The following state types show an update as available within the console:

- APPLICABILITY_SUCCESS  =  327682
- APPLICABILITY_HIDE  =  393213
- APPLICABILITY_NA  =  393214
- Available  =  262146

Consider the following relevant folders:

- `%Program Files%\Microsoft Configuration Manager\CMUStaging`

    This folder contains ConfigMgr manifest cab (for example: [https://download.microsoft.com/download/5/2/C/52C5F0D5-2095-4227-BBA4-D3205D9B9714/ConfigMgr.Update.Manifest.cab](https://download.microsoft.com/download/5/2/C/52C5F0D5-2095-4227-BBA4-D3205D9B9714/ConfigMgr.Update.Manifest.cab)) that is downloaded and extracted by `Hman`.

- `%Program Files%\Microsoft Configuration Manager\EasySetupPayload`

    This folder contains the actual installation files for an update. There's no Setup.exe file. Instead, an Install.map file is used for installing.

- `%Program Files%\Microsoft Configuration Manager\CMUClient`

    This folder contains the latest client installation files. The files are copied directly from the EasySetupPayload folder. They will become a package that's named **Configuration Manager Client Package** and that gets replicated to all child primary sites.

## Troubleshoot downloading issues

Collect the following data before you start troubleshooting:

- Hman.log
- DMPDownloader.log
- Files inside each subfolder of Hman.box
- Output of the following SQL queries:

  ```sql
  select * from CM_UpdatePackages
  select * from CM_UpdatePackageSiteStatus
  ```

- Output of the following registry keys:

  - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\COMPONENTS\SMS_DMP_DOWNLOADER`
  - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\AIUS`
  - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\SMS_DMP_CONNECTOR`

When an update is stuck at **Downloading** in the console, check DMPDownloader.log to see whether the service connection point is now downloading files. For connection issues, check whether the [Internet access requirements](/mem/configmgr/core/servers/deploy/configure/about-the-service-connection-point#bkmk_urls) are met.

Download failures may occur during the following phases:

- Downloading the manifest cab.

    You can test by using the direct download link in Internet Explorer to get the output. For example, use:

    [https://download.microsoft.com/download/5/2/C/52C5F0D5-2095-4227-BBA4-D3205D9B9714/ConfigMgr.Update.Manifest.cab](https://download.microsoft.com/download/5/2/C/52C5F0D5-2095-4227-BBA4-D3205D9B9714/ConfigMgr.Update.Manifest.cab)

- Downloading the actual Easy Setup package.

    You can test by using the direct download link in Internet Explorer to get the output. For example, use:

    `http://download.microsoft.com/download/E/3/A/E3A89E8D-F1F4-4AAA-BF2F-1C157142894B/609F1263-04E0-49A8-940B-09E0E34DE2D2.cab`

You can replace the package GUID in the sample URLs by using the GUID that is returned by the following SQL query:

```sql
select * from CM_Updatepackages
```  

### Issue 1: Failed to download easy setup payload with exception: The remote server returned an error: (400) Bad Request

The following error is logged in DMPDownloader.log:

> WARNING: Failed to download easy setup payload with exception: The remote server returned an error: (400) Bad Request.

To fix the issue, follow these steps:

1. Check the `ProxyName` value of the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\AIUS` registry subkey.
2. Verify the current proxy configuration by running the following commands:

    ```console
    netsh winhttp show proxy
    ```

    ```console
    netsh winhttp show proxy source=ie
    ```

3. Check the bypass list, and make sure that **\*.microsoft.com** and **\*.windowsupdate.com** are added to the bypass list. Otherwise, run the following command:

    ```console
    netsh winhttp set proxy proxy-server="ProxyServerName" bypass-list="*.microsoft.com", "*.windowsupdate.com"
    ```

4. Restart the SMS Executive Service (SMSExec).
5. If the issue persists, reinstall the Service Connection Point role.  

### Issue 2: Failed to download Admin UI content payload with exception: The underlying connection was closed

The following error is logged in DMPDownloader.log:

> ERROR: Failed to download Admin UI content payload with exception: The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel.  
> \...  
> The remote certificate is invalid according to the validation procedure.

To fix this issue, enter the following URL in Internet Explorer, and check whether it can be downloaded:

<http://download.windowsupdate.com/windowsupdate/redist/standalone/7.4.7600.226/windowsupdateagent30-x86.exe>

If the file can't be downloaded, check the firewall to make sure that it doesn't block the connection. TCP port 443 and 80 must be exempted from the following source and destination:

- Source = SiteServer or proxy server (if proxy is used)  
- Destination = windowsupdate.com and microsoft.com

### Issue 3: Failed to call AdminUIContentDownload. error = [error code: -2147467261, error message: Invalid pointer]

The following error is logged in DMPDownloader.log:

> Failed to call AdminUIContentDownload. error = [error code: -2147467261, error message: Invalid pointer]

To fix this issue, use the resolution for [Issue 1](#issue-1-failed-to-download-easy-setup-payload-with-exception-the-remote-server-returned-an-error-400-bad-request).

### Issue 4: Failed to call Initialize. error = [error code: -2147467261, error message: Invalid pointer]

The following error is logged in DMPDownloader.log:

> Failed to call Initialize. error = [error code: -2147467261, error message: Invalid pointer].

To fix this issue, check whether the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\SMS_DMP_CONNECT` registry subkey exists. If it doesn't, create the subkey. Then, delete all files in the `Hman.box\CFD` folder, and restart the SMS Executive Service (SMSExec).

## Before you install an update

Review the following steps before you install updates from within the Configuration Manager console.

### Step 1: Review the update checklist

Review the following applicable update checklist for actions to take before you start the update:

- [Checklist for installing update 2002](/mem/configmgr/core/servers/manage/checklist-for-installing-update-2002)
- [Checklist for installing update 1910](/mem/configmgr/core/servers/manage/checklist-for-installing-update-1910)
- [Checklist for installing update 1906](/mem/configmgr/core/servers/manage/checklist-for-installing-update-1906)
- [Checklist for installing update 1902](/mem/configmgr/core/servers/manage/checklist-for-installing-update-1902)
- [Checklist for installing update 1810](/mem/configmgr/core/servers/manage/checklist-for-installing-update-1810)
- [Checklist for installing update 1806](/mem/configmgr/core/servers/manage/checklist-for-installing-update-1806)
- [Checklist for installing update 1802](/mem/configmgr/core/servers/manage/checklist-for-installing-update-1802)
- [Checklist for installing update 1710](/mem/configmgr/core/servers/manage/checklist-for-installing-update-1710)
- [Checklist for installing update 1706](/mem/configmgr/core/servers/manage/checklist-for-installing-update-1706)
- [Checklist for installing update 1702](/mem/configmgr/core/servers/manage/checklist-for-installing-update-1702)
- [Checklist for installing update 1610](/mem/configmgr/core/servers/manage/checklist-for-installing-update-1610)
- [Checklist for installing update 1606](/mem/configmgr/core/servers/manage/checklist-for-installing-update-1606)
- [Checklist for installing update 1602](/mem/configmgr/core/servers/manage/checklist-for-installing-update-1602)
- [Upgrade to Configuration Manager current branch](/mem/configmgr/core/servers/deploy/install/upgrade-to-configuration-manager)

### Step 2: Test the database upgrade

Because of changes that are introduced in Configuration Manager, testing the database upgrade is no longer a required or recommend step if the following conditions are true:

- Your database isn't suspect.
- Your database isn't modified by customizations that aren't explicitly supported by Configuration Manager.

If you upgrade to Configuration Manager from an older product, such as System Center 2012 Configuration Manager, we still recommend that you test database upgrades.

For more information, see [Test the database upgrade when installing an update](/mem/configmgr/core/servers/manage/test-database-upgrade).

### Step 3: Run the prerequisite checker before you install an update

Before you install an update, consider running the prerequisite check for that update. For more information, see [Before you install an in-console update](/mem/configmgr/core/servers/manage/install-in-console-updates#bkmk_beforeinstall).

## Update replication

The following steps explain the [flow](/mem/configmgr/core/servers/manage/update-replication-flowchart) for an in-console update in which the installation replicates to other sites:

### Step 1: The process starts at the central administration site or standalone primary site

The process starts when the administrator selects **Install** to start the update installation or runs a prerequisite check.

### Step 2: Hierarchy manager (Hman) creates or updates the package by using the shared folder \\\\[servername]\EasySetupPayload as the source

1. `CM_UpdatePackages_UPD_HMAN` begins the process and SMSDBMON drops the file to wake up `Hman` to begin processing. The following entries are logged in Smsdbmon.log:

    > RCV: UPDATE on CM_UpdatePackages for CM_UpdatePackages_UPD_HMAN [2  ]        SMS_DATABASE_NOTIFICATION_MONITOR  
    > Modified trigger definition for Hierarchy Manager[CM_UpdatePackages_UPD_HMAN]: table CM_UpdatePackages(State) on update, file ESC in dir C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CFD\  
    > SND: Dropped C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CFD\2.ESC

2. `Hman` runs the following query to check which update was selected to install:

    ```sql
    SELECT TOP 1 convert(NVARCHAR(40), PackageGuid) FROM CM_UpdatePackages WHERE State=2
    ```

    The following entries are logged in Hman.log:

    > INFO: 2.ESC file was found. Easy setup package needs to be updated.  
    > Get update package 10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C, \\SiteServerFQDN\EasySetupPayLoad\10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C

3. If the package hash is the same for the downloaded package, the following entry is logged:

   > Easy setup source folder hash is not changed. Skip updating.

   Otherwise, the following entries are logged:

   > INFO: Successfully requested package CAS10001 to be updated from its source.  
   > Info: Updated package CAS10001 and SMS_DISTRIBUTION_MANAGER will replicate the content to all the site servers except the secondary sites. The content will be stored in the content library on the site servers. Check distmgr.log for replication status.

There's an inbox trigger for HMAN that is invoked when it sees a file in the `Hman.box\CFD` folder. Verify that this trigger exists. To do so, examine the following registry subkey on the site server (CFD is the new inbox that's introduced in version 1511):

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Triggers\<SiteServer>\CM_UpdatePackages_UPD_HMAN`

Value Name and Data:

- **Filter** - (State = 2 or State = 196612) and UPDATE(State)
- **Target Service** - Hierarchy Manager (CFD)

### Step 3: Within the site database, the EasySetupSettings table is updated to have the PackageID of the update

The following entries are logged:

> Get update package 10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C, \\\SiteServerFQDN\EasySetupPayLoad\10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C  
> Updating easy setup settings with EXEC sp_UpdateEasySetupSettings N'CAS10001','2',N'561BE7B704CA99A8DB6697886E75BD7C4812324D0A637708E863EC9DF97EFB94'

You can find the `PackageID` value of the update by running one of the following SQL queries:

```sql
Select * from EasySetupSettings
Select PkgID from SMSPackages where name = 'Configuration Manager Easy Setup Package'
```

SMSDBMon drops \<PackageGUID>.CME in `Hman.box\CFD` to keep HMAN busy so that other files aren't processed. The following entry is logged in the Smsdbmon.log:

> SND: Dropped C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CFD\10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C.CME

### Step 4: Distribution manager (Distmgr) copies the update files from \\\\[servername]\EasySetupPayLoad to the content library folder ContentLib on the central administration site or standalone primary site server computer

The following entries are logged in Distmgr.log:

> Found package properties updated notification for package 'CAS10001'  
> Info: package 'CAS10001' is set to replicate to site servers only.  
> Taking package snapshot for package CAS10001 from source \\\SiteServerFQDN\EasySetupPayLoad\10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C

You can filter Distmgr.log for the thread ID to check the status. To get the thread ID, examine the **Package Processing Queue** value of the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\COMPONENTS\SMS_DISTRIBUTION_MANAGER` registry key.

### Step 5: Distribution manager creates a mini job to replicate content to child primary sites (if applicable)

The following entries are logged in Distmgr.log:

> Setting CMiniJob transfer root to C:\SMSPKG\CAS10001.PCK.1  
> Created minijob to send compressed copy of package CAS10001 to site MG1.  Transfer root = C:\SMSPKG\CAS10001 .PCK.1

### Step 6: Scheduler schedules a file replication job to transfer the content to child primary sites

The following entries are logged in Scheduler.log:

> 1 jobs found in memory, 10 jobs found in job source.  
> ~Instruction file = C:\Program Files\Microsoft Configuration Manager\inboxes\schedule.box\tosend\00000391.Idb  
> \<Updating JOB 00000391> [Software Distribution for Configuration Manager Easy Setup Package, Package ID = CAS10001]~  
> \<JOB STATUS - COMPLETE>~

### Step 7: Sender manages the transfer of the update to all child primary sites (if applicable)

The following entries are logged in Sender.log:

> ~Package file = C:\SMSPKG\CAS10001.DLT.5.6  
> ~Instruction file = C:\Program Files\Microsoft Configuration Manager\inboxes\schedule.box\tosend\00000391.Idb  
> ~Sending Started [C:\SMSPKG\CAS10001.DLT.5.6]  
> ~Finished sending SWD package CAS10001 version 6 to site PRI  
> ~Sending completed successfully

### Step 8: The replication process continues at the primary site. After the sender completes the transfer of the update to the child primary site, the site server wakes up to begin processing the update

The following entries are logged:

> 1 jobs found in memory, 10 jobs found in job source.  
> ~Instruction file = C:\Program Files\Microsoft Configuration Manager\inboxes\schedule.box\tosend\00000391.Idb  
> \<Updating JOB 00000391> [Software Distribution for Configuration Manager Easy Setup Package, Package ID = CAS10001]~  
> \<JOB STATUS - COMPLETE>~

### Step 9: Despooler moves the content file into the ContentLib content library folder on the primary site server computer

The following entries are logged in Despool.log:

> Received package MG100006 version 1. Compressed file -  C:\SMSPKG\CAS10001.PCK.1 as C:\Program Files\Microsoft Configuration Manager\inboxes\despoolr.box\receive\ds_r7or9.pkg  
> Content Library: C:\SCCMContentLib  
> Extracting from C:\SMSPKG\CAS10001.PCK.temp  
> Extracting package CAS10001  
> Extracting content CAS10001.1  
> Writing package definition for CAS10001  
> Package CAS10001 (version 0) exists in the distribution source, save the newer version (version 1).  
> Stored Package CAS10001. Stored Package Version = 1

### Step 10: Distribution Manager marks the process for the package as successful

The following entries are logged in Distmgr.log:

> Found package properties updated notification for package 'CAS10001'  
> Adding package 'CAS10001' to package processing queue.  
> Started package processing thread for package 'CAS10001',  
> Start updating the package CAS10001...  
> Successfully created/updated the package CAS10001

Then, a notification file is created for Configuration Manager Update at child primary sites:

> Created notification file (10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C.CMI) for CONFIGURATION_MANAGER_UPDATE

## Troubleshoot replication issues

General troubleshooting steps:

### Step 1: Check the history and current status of the package in question

Determine the `PackageGUID` of the package in question. To do so, run the following SQL queries:

```sql
select * from EasySetupSettings
select SourceVersion, StoredPkgVersion from SMSPackages where PkgID in (select packageid from EasySetupSettings)
```

Run the following SQL queries, and then review the **State** column for the `PackageGUID` in question:

```sql
select * from CM_UpdatePackages
select * from CM_UpdatePackages_Hist order by RecordTime desc
```  

### Step 2: Review relevant logs for central administration site and relevant primary sites

Review the following logs:

- Hman.log or Hman.lo_
- CMUpdate.log or CMUpdate.lo_
- Distmgr.log or Distmgr.lo_
- Sender.log or Sender.lo_
- Scheduler.log or Scheduler.lo_

### Step 3: Determine whether the package was successfully copied into the SCCMContentLib folder on central administration site and relevant primary sites

To do so, compare the following folders:

- \\\\\<Service Connection Point>\EasySetupPayloader\\\<PackageGUID>
- SCCMContentLib\DataLib\\\<PackageGUID\> (on the site servers)

### Step 4: Retry content replication for EasySetup package

To do so, follow these steps:

1. Start Windows PowerShell.
2. Run the following command:

    ```powershell
    (gwmi -Namespace "ROOT\SMS\site_<SITE CODE>" -query "select * from SMS_CM_UpdatePackages where PackageGuid = '<PACKAGE GUID>'").RetryContentReplication($true)
    ```

3. The output should look like this example:

    ```output
    __GENUS          : 2
    __CLASS          : __PARAMETERS
    __SUPERCLASS     : 
    __DYNASTY        : __PARAMETERS
    __RELPATH        : 
    __PROPERTY_COUNT : 1
    __DERIVATION     : {}
    __SERVER         : 
    __NAMESPACE      : 
    __PATH           : 
    ReturnValue      : 0
    PSComputerName   : 
    ```

4. Review _Distmgr.log_ to check whether the package replicates successfully.

### Issue 1: Error "Failed to calculate hash SMS_HIERARCHY_MANAGER"

**Symptom**

You receive an error message that resembles the following example in Hman.log:

> Get update package 91406B1D-7C14-42D8-A68B-484BE5C5E9B8, \\\\\<SiteServer>\EasySetupPayLoad\91406B1D-7C14-42D8-A68B-484BE5C5E9B8 SMS_HIERARCHY_MANAGER 12/19/2016 5:15:34 PM 13688 (0x3578)  
Failed to calculate hash SMS_HIERARCHY_MANAGER 12/19/2016 5:15:34 PM 13688 (0x3578)

In this case, you can't access the `\\<SiteServer>\EasySetupPayLoad` folder.

**Resolution**

To fix this issue, make sure that the EasySetupPayLoad folder is shared on the site server.

## Prerequisite check

The following steps explain the process of extracting the update to run prerequisite checks before installing updates at a central administration site or primary sites.

### Step 1: Notification

After you select the update package and select **Run prerequisite check**, the following entries are logged in smsdbmon.log:

> RCV: UPDATE on CM_UpdatePackages for CM_UpdatePackages_UPD_HMAN \[2 ][1009663]  
> Modified trigger definition for Hierarchy Manager \[CFD](CM_UpdatePackages_UPD_HMAN): table CM_UpdatePackages(State) on update, file ESC in dir C:\Program Files\Microsoft Configuration Manager  
> \inboxes\hman.box\CFD\  
> SND: Dropped C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CFD\2.ESC [1009663]

After SMSDBMON drops the 2.ESC file in `Hman.box\CFD`, an inbox trigger for HMAN is invoked. To verify the trigger, check the following registry subkey on the site server (CFD is the new inbox that's introduced in version 1511):

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Triggers\<SiteServer>\CM_UpdatePackages_UPD_HMAN`

Value Name and Data:

- **Filter** - (State = 2 OR State = 196612) AND UPDATE(State)
- **Target Service** - Hierarchy Manager (CFD)

### Step 2: Preparation

`Hman` gets the `packageGUID` that was downloaded through manifest and updates the `EasySetupSettings` table. The following entries are logged:

> Get update package 79FB5420-BB10-44FF-81BA-7BB53D4EE22F, \\\CAS\EasySetupPayLoad\79FB5420-BB10-44FF-81BA-7BB53D4EE22F  
> Updating easy setup settings with EXEC sp_UpdateEasySetupSettings N'CAS00008','6',N''

To find the `PackageID` value of the update, run the following SQL query:

```sql
select PkgID from smspackages where name = 'Configuration Manager Easy Setup Package'
```

SMSDBMon drops \<PackageGUID>.CME in `Hman.box\CFD` to keep `Hman` busy so that other files aren't processed. The following entry is logged in Smsdbmon.log:

> SND: Dropped C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CFD\79FB5420-BB10-44FF-81BA-7BB53D4EE22F.CME

### Step 3: Replication

HMAN invokes Distmgr to replicate packages to all child primary sites. Consider that the Easy Setup package doesn't replicate to secondary sites or distribution points.

The following entry is logged in Hman.log:

> Info: Updated package CAS00008 and SMS_DISTRIBUTION_MANAGER will replicate the content to all the site servers except the secondary sites. The content will be stored in the content library on the site servers. Check distmgr.log for replication status.

SMSDBmon drops a `.pkn` file to notify Distmgr to start replication. The following entries are logged:

> Dropped C:\Program Files\Microsoft Configuration Manager\inboxes\distmgr.box\CAS00008.PKN  [1009665]  
> Found package properties updated notification for package 'CAS00008'  
> Adding package 'CAS00008' to package processing queue.  
> ~Started package processing thread for package 'CAS00008', thread ID = 0x16E8 (5864)

You can filter Distmgr.log by using the thread ID to check the status. To find the queue, examine the **Package Processing Queue** value of the following registry subkey:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\COMPONENTS\SMS_DISTRIBUTION_MANAGER`

Distmgr creates a mini job for the sender to send the compressed package to child primary sites. The following entries are logged in Distmgr.log:

> Taking package snapshot for package CAS00008 from source \\\CAS\EasySetupPayLoad\79FB5420-BB10-44FF-81BA-7BB53D4EE22F  
> ~Use drive C for storing the compressed package.  
> ~Successfully created/updated the package CAS00008  
> ~Sending a copy of package CAS00008 to site PRI  
> ~Use drive C for storing the compressed package.  
> ~Setting CMiniJob transfer root to C:\SMSPKG\CAS00008.DLT.5.6  
> ~Created minijob to send compressed copy of package CAS00008 to site PRI.  Transfer root = C:\SMSPKG\CAS00008.DLT.5.6.

DistMgr notifies Scheduler to schedule a job to send the compressed package. The following entries are logged in Scheduler.log:

> 1 jobs found in memory, 10 jobs found in job source.  
> ~Instruction file = C:\Program Files\Microsoft Configuration Manager\inboxes\schedule.box\tosend\00000391.Idb  
> \<Updating JOB 00000391> [Software Distribution for Configuration Manager Easy Setup Package, Package ID = CAS00008]~  
> \<JOB STATUS - COMPLETE>~

The following entries are logged in Sender.log:

> ~Package file = C:\SMSPKG\CAS00008.DLT.5.6  
> ~Instruction file = C:\Program Files\Microsoft Configuration Manager\inboxes\schedule.box\tosend\00000391.Idb  
> ~Sending Started [C:\SMSPKG\CAS00008.DLT.5.6]  
> ~Finished sending SWD package CAS00008 version 6 to site PRI  
> ~Sending completed successfully

Metadata and settings for the package are also updated to child primary sites by using the `CMUpdates` replication group. The following tables are updated:

> UPDATE on SMSPackages_G for SMS_Package_ins_upd_SMSProv [CAS00008  ][1009664]  
> INSERT on PkgNotification for PkgNotify_Add [CAS00008  ][1009665]  
> INSERT on CM_UpdatePackageSiteStatus for CM_UpdatePackageSiteStatus_INS_UPD_HMAN [79FB5420-BB10-44FF-81BA-7BB53D4EE22F  ][1009666]  
> INSERT on CM_UpdatePackageSiteStatus for CM_UpdatePackageSiteStatus_INS_UPD_HMAN [79FB5420-BB10-44FF-81BA-7BB53D4EE22F  ][1009667]  

The following entries are logged in Despool.log at child primary sites:

> ~Package CAS00008 (version 6) exists in the distribution source, save the newer version (version 7).  
> ~Stored Package CAS00008. Stored Package Version = 7  
> Removed older package version CAS00008.6.

A notification file is then created. The following entry is logged in Hman.log at child primary sites:

> Created notification file (79FB5420-BB10-44FF-81BA-7BB53D4EE22F.CMI) for CONFIGURATION_MANAGER_UPDATE

The following entry is logged in Smsdbmon.log:

> UPDATE on SMSPackages_G for SMS_Package_ins_upd_SMSProv [CAS00008  ][1009664]

Unlike the Easy Setup package, client upgrade packages are replicated to all child primary sites, secondary sites, and DPs. Here's a sample log entry:

> Loaded client upgrade settings from DB successfully. FullClientPackageID=CAS00001, StagingClientPackageID=CAS00012, ClientUpgradePackageID=CAS00002, PilotingUpgradePackageID=CAS00013, ClientUpgradeAdvertisementID=CAS20000, ClientPilotingAdvertisementID=(null)  
> INFO: Detected the full client package (ID=CAS00001)~

### Step 4: Replication and prerequisites check on child primary sites

In Hman.log at the top-level site, the following line is repeated:

> Successfully checking Site server readiness for update.

It means that the `spCMUProcessUpdateReadiness` procedure is running and checking the following tables for readiness:

```sql
SELECT PackageGuid FROM EasySetupSetting
SELECT flag, State FROM CM_UpdatePackages
Select * from CM_UpdateReadiness
Select * from CM_UpdateReadinesssite
```

This procedure is responsible for notifying the database that the update is installed and ready for primary sites.

Continue to monitor Despool.log and Distmgr.log to see whether the replication succeeds.  

### Step 5: Prerequisite check finishes

After replication on primary sites finishes, DistMgr is notified of the successful update of the package.

The following entry is logged in CMUpdate.log:

> Content replication succeeded. Start extracting the package to run prereq check...

And the following entries are logged in Distmgr.log:

> STATMSG: ID=2301 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=CAS SITE=CAS PID=12812 TID=5864 ISTR0="Configuration Manager Easy Setup Package" ISTR1="CAS00008" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=400 AVAL0="CAS00008"  
> ~Exiting package processing thread for package CAS00008.

`Hman` creates \<PackageGUID>.CMI file under `CMUpdate` inbox. The following entries are logged:

> Created notification file (79FB5420-BB10-44FF-81BA-7BB53D4EE22F.CMI) for CONFIGURATION_MANAGER_UPDATE  
> INFO: setup type: 8, top level: 1.

In the log, **top level: 1** means that it's the top-level site.

The following entry is logged in Hman.log:

> Prereq check passed. Setup will not continue since it is prereq only.

`CMUpdate` then takes control of the process and starts running the update. The following entry is logged in CMUpdate.log:

> update package content 79FB5420-BB10-44FF-81BA-7BB53D4EE22F has been expanded to folder \\\\?\C:\Program Files\Microsoft Configuration Manager\CMUStaging\79FB5420-BB10-44FF-81BA-7BB53D4EE22F\

## Troubleshoot prerequisite check issues

> [!IMPORTANT]
> Don't delete anything from the database. Before you modify the `State` value in the database, make sure that you understand the state.

What you have to know before you start:

- Prerequisite check for the Easy Setup package is different from media installation.
- During prerequisite check, various checks are done, including (but not limited to) the following ones:

  - Whether the site is a top-level site
  - Whether the site is in interop mode
  - Whether replication for Easy Setup, Client Upgrade, and Client Pilot package succeeded
  - Whether DRS is active

- Prerequisite check usually doesn't occur for most updates. It occurs only on major upgrades, such as to version 1610, 1606, or 1602.

When you troubleshoot issues during prerequisite check, collect the results of the following SQL queries from the central administration site and all primary sites:

```sql
Select PackageGuid, State, Flag from CM_updatepackages
Select PackageGUID, SiteNumber, Name, State, SiteStatus, RecoveryCount from CM_UpdatePackageSiteStatus a inner join serverdata b on a.SiteNumber = b.ID
Select * from CM_UpdatePackagePrereqStatus where PackageGUID = 'GUID of the package to be installed'
Select * from CM_UpdateReadiness
Select * from CM_UpdateReadinessSite
Select * from EasySetupSettings
```

Check the version of the Easy Setup package, and match it to the version of Distmgr and the `Smspackages` table.

Refer to the [prerequisite check](#prerequisite-check) process, and determine the step in which the process gets stuck. Also, look for specific status messages that indicate the issue to fix.

## Installing updates

The following steps explain the process in which a site starts installing updates.

### Step 1: Check site server readiness to make sure that site server is ready to apply update

The following entries are logged in Hman.log:

> Successfully checking Site server readiness for update.  
> INFO: Waiting for CONFIGURATION_MANAGER_SERVICE to be ready to apply update: 10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C  
> C:\Program Files\Microsoft Configuration Manager\CMUStaging\10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C\SMSSetup\update.map has hash value SHA256:A19A48371F031C5E93CD8850E59E24DAE1217E1B37C7A74D98A92F053B5381FB  
> Successfully validated file C:\Program Files\Microsoft Configuration Manager\CMUStaging\10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C\SMSSetup\update.map  
> Successfully read file C:\Program Files\Microsoft Configuration Manager\CMUStaging\10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C\SMSSetup\update.map

### Step 2: The Configuration Manager Update service is stopped and then updated to the newer version. Then, the service is restarted to begin upgrade

The following entries are logged:

> Detected change in update.map for component CONFIGURATION_MANAGER_UPDATE. It will be updated first.  
> Successfully copied file from C:\Program Files\Microsoft Configuration Manager\CMUStaging\10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C\SMSSetup\bin\x64\cmupdate.exe to C:\Program Files\Microsoft Configuration Manager\bin\x64\cmupdate.exe  
> INFO: Starting service CONFIGURATION_MANAGER_UPDATE

### Step 3: Extract the update package and verify redistributable packages

The following entries are logged in CMUpdate.log:

> Checking if the CMU Staging folder already has the content extracted.  
> Creating hash for algorithm 32780  
> Staging folder has hash = 8CF9F066B452F35EE723DD2016E99392C1433B2287EDEA8BA8635D22E32E9C84  
> Staging folder (\\\\?\C:\Program Files\Microsoft Configuration Manager\CMUStaging\10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C\) has hash 561BE7B704CA99A8DB6697886E75BD7C4812324D0A637708E863EC9DF97EFB94 which does not match hash from content library 8CF9F066B452F35EE723DD2016E99392C1433B2287EDEA8BA8635D22E32E9C84  
> Delete folder \\\\?\C:\Program Files\Microsoft Configuration Manager\CMUStaging\10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C\ returned 0. Extracting the content from content library...  
> update package content 10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C has been expanded to folder \\\\?\C:\Program Files\Microsoft Configuration Manager\CMUStaging\10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C\

### Step 4: Configuration Manager services are stopped and installation begins

Here are the detailed steps. Log entries can be found in CMUpdate.log.

- Verify that Configuration Manager Update service is updated.
- Check Service Window to make sure that the update can be applied.
- Turn off SQL Server Service Broker.
- Stop Configuration Manager Services.
- Unload WMI provider.
- Delete SMSDBMON triggers.
- Save site control settings.
- Upgrade the Configuration Manager database.
- Update SQL registry.
- Update RCM registry.
- Install files, language packs, components, and controls.
- Upgrade site control settings.
- Configure SQL Server Service Broker.
- Start WMI, and install services.
- Update the site table.
- Update Admin console binaries.
- Turn on SQL Server Service Broker.

### Step 5: Post installation task runs and update installation is marked as successful

Here are the detailed steps:

1. Verify that SMS_Executive service is installed.
2. Verify that the SMSDBMon component is installed.
3. Verify that the SMSHman component is installed.
4. Verify that the RCM component is installed.
5. Monitor replication initialization.
6. Update Configuration Manager client preproduction package.
7. Update client folder on the site server.
8. Update Configuration Manager client package.
9. Turn on features that are specified in the upgrade wizard. Then reopen the console to display the features.

> [!NOTE]
>
> - Update.map contains the list of updates and files to be replaced and added. To review the list of files, open update.map in Notepad.
> - Install.map contains the list of steps that the installation process runs. It serves as a workflow for Cmupdate.exe that provides the steps and parameters to run in order.
> - For major upgrades, check ConfigMgrSetup.log for details.
> - For minor upgrades, check CMUpdate.log for details.

## Troubleshoot installation issues

When an update gets stuck in the **Installing** state in the console, it may be caused by one of the following reasons:

- A top-level site is installing the update. In this case, check CMUpdate.log for details.
- Content Replication hasn't finished. In this case, check DistMgr.log and Sender.log by using the `PackageID` value.
- The child primary site is still installing the update.
- Installation can't start because of errors in `CMUpdate`.

    In this case, review CMUpdate.log. Because `CMUpdate` is single threaded, you can look for the thread ID, and then filter the log by using the thread ID.

    If the error is related to permissions, verify the permissions.

    If the error shows a script or table failure, collect more logs, such as SQL Server logs, and then find the relevant table.

### Issue 1: Failed to open file \\\\?\C:\Program Files\Microsoft Configuration Manager\CMUStaging\ApplicabilityChecks\CM1606-KB3184153_AppCheck.sql for reading. Code 0x80070003

**Symptom**

You receive an error message that resembles the following example in CMUpdate.log:

> Failed to open file "\\\\?\C:\Program Files\Microsoft Configuration Manager\CMUStaging\ApplicabilityChecks\CM1606-KB3184153_AppCheck.sql" for reading. Code 0x80070003

**Resolution**

To fix this issue, check whether the file exists. If not, delete the CMUStaging folder, and restart Smsexec. If the files aren't downloaded, reinstall the Service Connection Point role to start downloading.  

### Issue 2: Error in verifying the trust of file \\\\?\C:\Program Files\Microsoft Configuration Manager\CMUStaging\79FB5420-BB10-44FF-81BA-7BB53D4EE22F\SMSSetup\update.map.cab

**Symptom**

You receive an error that resembles the following example in CMUpdate.log:

> update package content 79FB5420-BB10-44FF-81BA-7BB53D4EE22F has been expanded to folder \\\\\?\C:\Program Files\Microsoft Configuration Manager\CMUStaging\79FB5420-BB10-44FF-81BA-7BB53D4EE22F\  
> Error in verifying the trust of file '\\\\?\C:\Program Files\Microsoft Configuration Manager\CMUStaging\79FB5420-BB10-44FF-81BA-7BB53D4EE22F\SMSSetup\update.map.cab'.

**Cause**

This issue occurs because the files aren't downloaded correctly.

**Resolution**

To fix this issue, follow these steps:

1. Stop Smsexec.
2. Delete the Easy Setup package and the CMUStaging folder.
3. Restart Smsexec.
4. Uninstall the Service Connection Point role, and then reinstall the role.

### Issue 3: Console gets stuck displaying Downloading

**Symptom**

This issue occurs even if CMUpdate.log shows that the installation fails.

**Resolution**

To fix this issue, follow these steps:

1. Restart the SMS Executive service (Smsexec).
2. Run the [Update reset tool](/mem/configmgr/core/servers/manage/update-reset-tool).

### Issue 4: Content replication fails

If there's a failure during content replication, retry the replication by running the following cmdlet:

```powershell
(gwmi -Namespace "ROOT\SMS\site_<SITE CODE>" -query "select * from SMS_CM_UpdatePackages where PackageGuid = '<PACKAGE GUID>'").RetryContentReplication($true)
```

It tells `HMan` to start a package notification and update thread in DistMgr to start replicating the content again. Consider that it changes the package version and copies the content to all child primary sites again.

### Issue 5: Update is installed on central administration site and primary sites, but console still displays Installing

When a primary site completes the installation, it drops a state message for sites and server data tables. It changes the actual state of site in sites table, but it doesn't change the status in CM tables. A global replication group that's named **`CMUpdates`** is used to replicate changes to all sites. By default, **`CMUpdates`** has 1 minute of sync time.

To find which tables are replicated, run the following SQL queries:

```sql
select * from ReplicationData where ReplicationGroup = 'CMUpdates'
select * from ArticleData where ReplicationID in (select ID from ReplicationData where ReplicationGroup = 'CMUpdates')
```

To get the status of Initialization of **`CMUpdates`**, run the following SQL query:

```sql
select * from RCM_DrsInitializationTracking where ReplicationGroup = 'CMUpdates'
```

If the returned value of status is less than 6 or 7, initialization is still pending. In this case, you may have to troubleshoot DRS replication issues.

### Retry installation of a failed update in console

To do so, see [Retry installation of a failed update](/mem/configmgr/core/servers/manage/install-in-console-updates#bkmk_retry).

## Complete list of state codes

The following are the state codes and the states that they represent:

- UNKNOWN = 0x0
- ENABLED = 0x2
- DOWNLOAD_IN_PROGRESS = 262145
- DOWNLOAD_SUCCESS = 262146
- DOWNLOAD_FAILED = 327679
- APPLICABILITY_CHECKING = 327681
- APPLICABILITY_SUCCESS = 327682
- APPLICABILITY_HIDE = 393213
- APPLICABILITY_NA  = 393214
- APPLICABILITY_FAILED = 393215
- CONTENT_REPLICATING = 65537
- CONTENT_REPLICATION_SUCCESS = 65538
- CONTENT_REPLICATION_FAILED = 131071
- PREREQ_IN_PROGRESS = 131073
- PREREQ_SUCCESS = 131074
- PREREQ_WARNING = 131075
- PREREQ_ERROR = 196607
- INSTALL_IN_PROGRESS = 196609
- INSTALL_WAITING_SERVICE_WINDOW = 196610
- INSTALL_WAITING_PARENT = 196611
- INSTALL_SUCCESS = 196612
- INSTALL_PENDING_REBOOT = 196613
- INSTALL_FAILED = 262143
- INSTALL_CMU_VALIDATING = 196614
- INSTALL_CMU_STOPPED = 196615
- INSTALL_CMU_INSTALLFILES = 196616
- INSTALL_CMU_STARTED = 196617
- INSTALL_CMU_SUCCESS = 196618
- INSTALL_WAITING_CMU = 196619
- INSTALL_CMU_FAILED = 262142
- INSTALL_INSTALLFILES = 196620
- INSTALL_UPGRADESITECTRLIMAGE = 196621
- INSTALL_CONFIGURESERVICEBROKER = 196622
- INSTALL_INSTALLSYSTEM  = 196623
- INSTALL_CONSOLE = 196624
- INSTALL_INSTALLBASESERVICES = 196625
- INSTALL_UPDATE_SITES = 196626
- INSTALL_SSB_ACTIVATION_ON = 196627
- INSTALL_UPGRADEDATABASE = 196628
- INSTALL_UPDATEADMINCONSOLE = 196629  

## Useful SQL queries

- Check the overall state:

  ```sql
  select * from CM_UpdatePackages
  ```

  The following are some values from the **State** column and the states that they represent:

  - 327681 = APPLICABILITY_CHECKING
  - 262146 = DOWNLOAD_SUCCESS
  - 2 = ENABLED

    When Flag = 1, it means prerequisite check only. When Flag = 2, it means continue installation.

  - 65537 = CONTENT_REPLICATING
  - 65538 = CONTENT_REPLICATION_SUCCESS
  - 196609 = INSTALL_IN_PROGRESS
  - 196612 = INSTALL_SUCCESS

- Check the state per site:

    ```sql
    select * from CM_UpdatePackageSiteStatus
    ```

- Check the overall state history:

    ```sql
    select * from CM_UpdatePackages_Hist order by RecordTime desc
    ```

- Check the state history per site:

    ```sql
    select * from CM_UpdatePackageSiteStatus_HIST order by RecordTime desc
    ```

- Check the server readiness:

    ```sql
    select * from CM_UpdateReadiness
    ```

- Check the Configuration_Manager_Update service readiness:

    ```sql
    select * from CM_UpdateReadinessSite
    ```

- Check current software distribution package used for update:

    ```sql
    select * from EasySetupSettings
    ```

- Check the content version of the package stored in content library:

    ```sql
    select SourceVersion, StoredPkgVersion, * from SMSPackages where PkgID in (select packageid from EasySetupSettings)
    ```

- `Hman` decides what to install:

    ```sql
    SELECT TOP 1 convert(NVARCHAR(40), PackageGuid) FROM CM_UpdatePackages WHERE State=2
    ```

- Determine how `Hman` gets Easy Setup settings:

  ```sql
  SELECT TOP 1 PackageID,PackageVersion,PackageHash FROM EasySetupSettings
  ```

  `Hman` checks the site server that is ready for upgrade:

    ```sql
    Stored procedure spCMUCheckSiteServerReadyForUpdate
     if (EXISTS (SELECT * FROM EasySetupSettings WHERE PackageGuid = @packageGuid))
         BEGIN
             SELECT @readyParent = Flag FROM CM_UpdateReadiness
             WHERE SiteNumber = dbo.fnGetSiteNumber() AND PackageGuid = @packageGuid
             SELECT @cmuUpdated = Flag FROM CM_UpdateReadinessSite
             WHERE SiteNumber = dbo.fnGetSiteNumber() AND PackageGuid = @packageGuid
         END
    ```

- `Hman` returns package updates that are in progress:

    ```sql
    SELECT @flag = ISNULL(Flag, 0), @state = ss.State, @redistVersion = ISNULL(oa.RedistVersion, N''), @pubFlag = ISNULL(oa.PublisherFlags, 2)
         FROM CM_UpdatePackages oa
         INNER JOIN CM_UpdatePackageSiteStatus ss ON oa.PackageGuid = ss.PackageGuid AND ss.SiteNumber = dbo.fnGetSiteNumber()
         WHERE oa.State IN (
                         65538,      -- CONTENT_REPLICATION_SUCCESS = 0x00010002
                         131073,     -- PREREQ_IN_PROGRESS          = 0x00020001
                         131074,     -- PREREQ_SUCCESS              = 0x00020002
                         196609,     -- INSTALL_IN_PROGRESS         = 0x00030001
                         196610,     -- INSTALL_WAITING_SERVICE_WINDOW  = 0x00030002
                         196611,     -- INSTALL_WAITING_PARENT      = 0x00030003
                         196619,     -- INSTALL_WAITING_CMU         = 0x0003000B
                         131075      -- PREREQ_WARNING              = 0x00020003
                             )
         AND oa.PackageGuid = @packageGuid
    ```

- Check Configuration Manager update history:

    See [ConfigMgr Update History TSQL Query](https://gallery.technet.microsoft.com/ConfigMgr-Update-History-d5cca015?redir=0).

- Check Configuration Manager build numbers that are mapped by using build release names:

    See [ConfigMgr Build Numbers mapped with Build Release Names and Update types](https://gallery.technet.microsoft.com/ConfigMgr-Build-Numbers-62840395?redir=0).  

## Tips

- Don't manually clean up the EasySetupPayload folder for the Configuration Manager update that is being downloaded or processed.
- Don't manually clean up the CMUStaging folder without verifying the correct state and content library for the Easy Setup package.
- Don't restore the Configuration Manager database and Configuration Manager site server if there's an error in `CMUpdate`. In particular, never attempt to restore from a Virtual Machine snapshot as well. Fix the issue, and retry installation.
- Don't reinstall Service Connection Point if an update is in process.
- Don't use files from the `CD.Latest` folder to install a standalone primary site.
- Don't use the `CD.Latest` folder to upgrade a site that's running version 1511, or sites that are running 2012 R2 SP1 or earlier versions.
- Don't manually clean up or change values in any Cm_Update\* tables.
- Don't restart the `CMUpdate` service during installation.
- Don't keep the CMUStaging\\\<GUID> folder open during the installation.  

### Enable verbose trace logging

To enable SQL trace logging, set the `SQLEnabled` value to **1** under the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing` registry key.

To increase log file size and number of copies maintained, increase the value of `MaxFileSize` and `LogMaxHistory` under the following registry keys:

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\CONFIGURATION_MANAGER_UPDATE`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\SMS_HIERARCHY_MANAGER`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\SMS_DMP_DOWNLOADER`

### Capture a Process Monitor trace

Use [Process Monitor](/sysinternals/downloads/procmon) to capture a process monitor trace.

### Capture WinHTTP logs

For more information, see [Capturing WinHTTP Logs](/windows/win32/wsdapi/capturing-winhttp-logs).

## References

For more information about Updates and Servicing in Configuration Manager, see the following articles:

- [Install in-console updates for Configuration Manager](/mem/configmgr/core/servers/manage/install-in-console-updates)
- [Walking through an upgrade from Microsoft ConfigMgr 1511 to ConfigMgr 1602](https://techcommunity.microsoft.com/t5/configuration-manager-archive/walking-through-an-upgrade-from-microsoft-configmgr-1511-to/ba-p/273996)

You can also post a question in our [Configuration Manager support forum](https://social.technet.microsoft.com/Forums/en-US/home?forum=ConfigMgrDeployment%2CConfigMgrMigration%2CConfigMgrMDM%2CConfigMgrCompliance%2CConfigMgrPowerShell%2CConfigMgrAppManagement%2CConfigMgrCBGeneral%2CConfigMgrCBOSD&filter=alltypes&sort=lastpostdesc).

Visit [our blog](https://techcommunity.microsoft.com/t5/Configuration-Manager-Blog/bg-p/ConfigurationManagerBlog) for tech tips and all the latest news and information about Configuration Manager.

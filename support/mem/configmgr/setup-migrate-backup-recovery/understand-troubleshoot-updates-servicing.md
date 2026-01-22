---
title: Understand and Troubleshoot the Updates and Servicing process
description: This article helps administrators understand Updates and Servicing, and troubleshoot some common issues in Configuration Manager.
ms.date: 11/17/2025
ms.reviewer: kaushika, payur
ms.custom: sap:Configuration Manager Setup, High Availability, Migration and Recovery\Updates and Servicing
---
# Understand and troubleshoot Updates and Servicing in Configuration Manager

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4490424

This article helps administrators understand the Updates and Servicing process in Configuration Manager (current branch). This article can also help you troubleshoot common issues that you might encounter when you install updates.

Configuration Manager synchronizes with the Microsoft Cloud service to get updates that apply to your infrastructure and version. You can use the Configuration Manager console to install these updates.

To view and manage the updates, open the Configuration Manager console that's connected to the top-level site, and then go to **Administration** > **Cloud Services** > **Updates and Servicing**. For more information, see [Install in-console updates for Configuration Manager](/intune/configmgr/core/servers/manage/install-in-console-updates).

## Best practices for updates

Before you install updates by using the Configuration Manager console, review the following steps.

### Step 1: Review the update checklists

Review the following update checklists for actions to take before you start the update:

- [Checklist for installing update 2509](/intune/configmgr/core/servers/manage/checklist-for-installing-update-2509)
- [Checklist for installing update 2503](/intune/configmgr/core/servers/manage/checklist-for-installing-update-2503)
- [Checklist for installing update 2409](/intune/configmgr/core/servers/manage/checklist-for-installing-update-2409)


### Step 2: Run the prerequisite checker before you install an update

Before you install an update, consider running the prerequisite check for that update. For more information, see [Before you install an in-console update](/intune/configmgr/core/servers/manage/prepare-in-console-updates#before-you-install-an-in-console-update).

## Glossary

| Term | Explanation |
|---|---|
| Update package | A collection of files and metadata that are used to update the Configuration Manager infrastructure. |
| Service connection point (SCP) | A site system role that connects Configuration Manager to the Microsoft cloud to synchronize updates. |
| Service connection tool (SCT) | A tool that's used to synchronize and download update packages offline. |
| Easy setup payload | The actual payload of an update package. |
| Redists | A set of redistributable software components that are required to install updates. |
| Easy setup package | A hidden Configuration Manager package that's used to replicate the payload and redists of an update package. |

## List of primary components

| Name | Component name | Friendly name | Binary | Description |
|---|---|---|---|---|
| DMP Downloader | SMS_DMP_DOWNLOADER | DmpDownloader | Dmpdownloader.dll | Part of the Service Connection Point role. Responsible for synchronizing and downloading update packages. |
| Service connection tool | - | SCT | ServiceConnectionTool.exe | Tool that's used for Offline Site Servicing. |
| Hierarchy Manager | SMS_HIERARCHY_MANAGER | HMAN | HMAN.dll | Site server component that processes update packages. |
| Configuration Manager Update | CONFIGURATION_MANAGER_UPDATE | CMUpdate | CMUpdate.exe | Service that installs update packages. |

## Prepare to troubleshoot Updates and Servicing issues

> [!IMPORTANT]  
> When you troubleshoot an Updates and Servicing issue, avoid taking the following actions:
>
> - Manually cleaning up any related folders (\\EasySetupPayload, \\CMUStaging). Only manually change these folder locations if Microsoft Support instructs you to.
> - Manually cleaning up any SQL tables. Don't manually change information in these tables unless a Microsoft Support agent instructs you to.
> - Restoring the Configuration Manager database or Configuration Manager site server if an error occurs during the upgrade. Instead, fix the issue, and then try again to install.
> - Reinstalling a Service Connection Point during the installation.
> - Restarting the Configuration Manager Update service during the installation.
> - Keeping the \CMUStaging\ folder open during the installation.

> [!NOTE]  
> After an update package starts installing, don't use [CMUpdateReset.exe](/intune/configmgr/core/servers/manage/update-reset-tool).

### Identify the update package GUID

Before you troubleshoot an update issue, identify the GUID of the update package. To view the GUID of an update package that's visible in the Configuration Manager console, add the **Package Guid** column to the **Administration** > **Update and Servicing** node.

If the console doesn't list the affected update package, you can find the GUID in the Configuration Manager database. To find the GUID, run a SQL query that resembles the following example:

```sql
SELECT Name, PackageGuid FROM v_LocalizedUpdatePackageMetaData_SiteLoc
```

For reference, the following table lists well-known update package GUIDs. The list doesn't include opt-in releases or hotfixes.

| Update Name | Package GUID |
|---|---|
| Configuration Manager 2309 | FD3D0214-F4DC-4664-B6BB-997E381B7C9D |
| Configuration Manager 2403 | 5B8886C7-F967-4F8A-92AA-009E28368853 |
| Configuration Manager 2403 HFRU | A02D38C5-021E-4144-8249-E7CDE48DA83F|
| Configuration Manager 2409 | 3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E |
| Configuration Manager 2409 HFRU | 345A6BE1-3D07-43ED-B6E5-FAC0889DA04C |
| Configuration Manager 2503 | AA928926-5C76-4DE0-B51F-0FE4D365DFE2 |
| Configuration Manager 2503 HFRU | 6B0783D9-B8A2-4848-82F6-8EFE956F4988|
| Configuration Manager 2509 | 420E3E18-73C5-4BE9-88B0-6F1E30A012CA |

### Identify the installation stage of the update

During the update process, an update package passes through the following stages:

- Synchronization
- Applicability check
- Download
- Replication
- Prerequisite check
- Installation

Knowing the stage at which the update failed gives you a starting point for troubleshooting the issue. Use the following diagram to identify the stage of the update package installation.

> [!NOTE]  
> The Replication stage is part of either the Prerequisite check stage or the Installation stage. Therefore, it's not shown separately in the diagram.

:::image type="content" source="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-scope-issue-to-stage.png" alt-text="Diagram of a decision tree to identify the installation state." lightbox="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-scope-issue-to-stage-expanded.png":::

> [!IMPORTANT]  
> If the update package doesn't appear in either the console or in the Windows PowerShell output, the installation might be in the Applicability stage. Search the top-level site's SQL CM_UpdatePackages table. Use a query that resembles the following example:
>
> ```sql
> SELECT PackageGuid,State FROM CM_UpdatePackages where PackageGUID = '<Package GUID>'
> ```
>
> This table should contain the record of the target package.

Select one of the following links to troubleshoot a particular stage, or work through the sections for each stage.

- [Investigate the Synchronization and Applicability check stages](#investigate-the-synchronization-and-applicability-check-stages)
- [Investigate the Download stage](#investigate-the-download-stage)
- [Review progress through the Replication, Prerequisite check, and Installation stages](#review-progress-through-the-replication-prerequisite-check-and-installation-stages)

## Investigate the Synchronization and Applicability check stages

The [service connection point (SCP)](/intune/configmgr/core/servers/deploy/configure/about-the-service-connection-point) downloads updates that apply to your Configuration Manager infrastructure. In online mode, it automatically checks for updates every 24 hours. When your SCP is in offline mode, use the [Service Connection Tool](/intune/configmgr/core/servers/manage/use-the-service-connection-tool) to manually download updates.

The following steps provide an overview of the process that an online SCP uses to download in-console updates. For a diagram of this process, see [Flowchart - Download updates for Configuration Manager](/intune/configmgr/core/servers/manage/download-updates-flowchart).  
<br/>
<details>
   <summary>Select here to see the Synchronization and Applicability steps for an online SCP.</summary>

### Process step 1: DMPDownloader synchronizes the latest update information

Every 24 hours, the DMPDownloader component on the SCP checks for new update packages. During this process, it logs entries in DMPDownloader.log that resemble the following example:

```output
Hasn't synced recently.
Generating state message: 0 for package 00000000-0000-0000-0000-000000000000~~
Write the state message in E:\ConfigMgr\inboxes\auth\statesys.box\incoming\high\___CMUhxpzo31n.SMX~~
Successfully Dropped the state message 0~~
```

DMPDownloader sends the `0 (START_PROCESS)` high-priority state message to the site server to indicate that the synchronization process is starting.

Then DMPDownloader checks for the latest update manifest by downloading the ConfigMgr.Update.Manifest.cab file from the manifest link. The manifest contains all recently released Configuration Manager updates and their metadata. During this process, DMPDownloader logs entries in DMPDownloader.log that resemble the following example:

```output
Checking for preview version~~
Site is preview? no~~
Is it a fast channel? :False~~
Easysetup fwlink to download the manifest: https://go.microsoft.com/fwlink/?LinkId=2309745~~
Download Easy setup payloads~~
Get manifest.cab url~~
Get manifest.cab from download center.~~
GetSABranchInfo: Site is at 1 branch.~~
Redirected to URL https://sccm.manage.microsoft.com/SCCMConnectedService.svc~~
The flighting request url is https://sccm.manage.microsoft.com/SCCMConnectedService.svc/Manifest?Tenant=WsklMWus1G4EphGKZHLtnQzE494yuqfhvdyMP%2foS3CQ%3d&Version=5.00.9135.1000&Ring=2376918;Branch=1~~
Flighting is not configured, fallback to default setting.~~
Generating state message: 1 for package 00000000-0000-0000-0000-000000000000~~
Write the state message in E:\ConfigMgr\inboxes\auth\statesys.box\incoming\high\___CMUp4qnqtjp.SMX~~
Successfully Dropped the state message 1~~
```

DMPDownloader sends the `1 (START_VERIFY_MANIFEST)` state message to the site server to indicate that the manifest download is in progress. After it sends the message, it downloads the manifest to the \\EasySetupPayload folder. During this process, DMPDownloader logs entries that resemble the following example:

```output
Download manifest.cab~~
Redirected to URL https://download.microsoft.com/download/6e09da86-4e81-4c36-a2f4-98b7bc4e261c/70.KB33177653_CM2403_9128.1033_CM2409_9132.1027_CM2503_9135.1006/ConfigMgr.Update.Manifest.cab~~
Got fwdlink and recreating the httprequest/response~~
manifest.cab (http response) size is 11526232~~
Generating state message: 2 for package 00000000-0000-0000-0000-000000000000~~
Write the state message in E:\ConfigMgr\inboxes\auth\statesys.box\incoming\high\___CMUdrcn3u4r.SMX~~
Successfully Dropped the state message 2~~
```

DMPDownloader sends the `2 (START_VERIFY_MANIFESTFILE_TRUSTED)` state message to indicate that DMPDownloader is about to verify the digital signature of the ConfigMgr.Update.Manifest.cab file. As it verifies the signature, DMPDownloader logs entries that resemble the following example:

```output
File 'E:\ConfigMgr\EasySetupPayload\ConfigMgr.Update.Manifest.cab' is signed and trusted.
File 'E:\ConfigMgr\EasySetupPayload\ConfigMgr.Update.Manifest.cab' is signed with MS root cert.
Finished calling verify manifest~~
Generating state message: 3 for package 00000000-0000-0000-0000-000000000000~~
Write the state message in E:\ConfigMgr\inboxes\auth\statesys.box\incoming\high\___CMUhclfcg15.SMX~~
Successfully Dropped the state message 3~~
```

DMPDownloader sends the `3 (VERIFIED_MANIFEST)` state message to confirm that the file has a trusted signature.

Finally, DMPDownloader renames ConfigMgr.Update.Manifest.cab to ___CABConfigMgr.Update.Manifest.mcm, and then moves the renamed file to one of the following locations:

- If the SCP is remote from the site server, DMPDownloader stores the file at MP\\OUTBOXES\\MCM.box. The MP File Dispatch manager (MPFDM) moves the file to the site server.
- If the SCP is co-located together with the site server, the file is saved directly to inboxes\\hman.box\\ForwardingMsg.

During this process, DMPDownloader logs entries that resemble the following example:

```output
Manifest.cab was successfully moved to the connector outbox~~
Generating state message: 4 for package 00000000-0000-0000-0000-000000000000~~
Write the state message in E:\ConfigMgr\inboxes\auth\statesys.box\incoming\high\___CMUbcfe5xql.SMX~~
Successfully Dropped the state message 4~~
```

DMPDownloader sends the`4 (MANIFEST_DOWNLOADED)` state message to indicate that this process finished.

In Hierarchy Manager (HMAN), a message forwarding thread moves the incoming MCM file to hman.box\\CFD\\ConfigMgr.Update.Manifest.CAB. This operation doesn't generate log entries.

### Process step 2: HMAN checks whether any new updates apply

HMAN checks for the manifest for the download signature, extracts the manifest, and then processes the manifest and checks that the update packages are applicable.

The SMSDBMon component drops a blank file that's named \<SiteCode>.scu to the \<ConfigMgr installation Directory>\\inboxes\\hman.box folder.

> [!NOTE]  
> In these file and path names, \<SiteCode> represents the code of your Configuration Manager site, and \<ConfigMgr installation Directory> represents the local directory where Configuration Manager is installed.

This event triggers HMAN to start processing. It logs entries in HMAN.log that resemble the following example:

```output
STATMSG: ID=3306 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_HIERARCHY_MANAGER"
SYS=<Site Server FQDN> SITE=XXX PID=2168 TID=4888 GMTDATE=Wed Dec 21 16:15:08.957 2016 ISTR0="C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CAS.SCU"
```

HMAN checks for the download signature, and then extracts the manifest to the \\CMUStaging folder on the site server. During this process, HMAN logs entries that resemble the following example:

```output
File 'E:\ConfigMgr\inboxes\hman.box\CFD\ConfigMgr.Update.Manifest.CAB' is signed and trusted.
File 'E:\ConfigMgr\inboxes\hman.box\CFD\ConfigMgr.Update.Manifest.CAB' is signed with MS root cert.
Extracting file E:\ConfigMgr\inboxes\hman.box\CFD\ConfigMgr.Update.Manifest.CAB to E:\ConfigMgr\CMUStaging\~
```

The extracted files include an ApplicabilityChecks folder, which contains SQL query files. HMAN runs these queries to assess the applicability of the update packages in the manifest. During this process, HMAN logs entries that resemble the following example:

```output
Extracted C:\Program Files\Microsoft Configuration Manager\CMUStaging\Manifest.xml  
Processing Configuration Manager Update manifest file C:\Program Files\Microsoft Configuration Manager\CMUStaging\manifest.xml  
C:\Program Files\Microsoft Configuration Manager\CMUStaging\ApplicabilityChecks\CM1610-KB3209501_AppCheck_10AA8BA0.sql has hash value SHA256:EB2C2D2E27EA0ACE8D4B6E4806FD2698BDE472427F28E60FB969A11BC5D811AB  
Configuration Manager Update (PackageGuid=10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C) is applicable
```

If a package doesn't apply, the HMAN logs entries that resemble the following example:

```output
C:\Program Files\Microsoft Configuration Manager\CMUStaging\ApplicabilityChecks\CM1610-KB3211925_AppCheck_9390F966.sql has hash value SHA256:048DA8137C249AAD11340A855FF7E0E8568F5325FED5F503C4D9C329E73AD464  
SQL MESSAGE:  - Not a 1610 FR2 build, skip this hotfix  
Configuration Manager Update (PackageGuid=9390F966-F1D0-42B8-BDC1-8853883E704A) is not applicable and should be filtered.
```

</details>

### Results of the Synchronization and Applicability check processes

The console displays new applicable updates and labels their state as **Available to Download** or **Ready to Install**. The applicability check might hide some update packages. To verify an update's state, check the **State** column in the CM_UpdatePackages table. In the table, available updates have entries in this column that resemble the following examples:

- `APPLICABILITY_SUCCESS  =  327682`
- `DOWNLOAD_SUCCESS  =  262146`

Updates that aren't applicable (and aren't visible in the console) have entries in this column that resemble the following examples:

- `APPLICABILITY_HIDE  =  393213`
- `APPLICABILITY_NA  =  393214`

### Troubleshoot the Synchronization stage

If you suspect that your issue occurs in the Synchronization stage, use the following flowchart to investigate which components might be involved and which processes the issue affects.

:::image type="content" source="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-synchronization-stage.png" alt-text="Diagram of a decision tree to isolate an issue that might occur during the Synchronization stage." lightbox="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-synchronization-stage-expanded.png":::

The following steps summarize this troubleshooting process. The steps vary depending on whether your SCP is configured in Online mode or Offline mode.

- **SCP in Online mode**

  1. On the SCP, check the DMPDownloader.log file for any error messages that the DMPDownloader generated while it downloaded and processed the manifest CAB file.
  1. Verify that the HMAN.log file contains entries that resemble the following example:

     ```output
     Extracting file E:\ConfigMgr\inboxes\hman.box\CFD\ConfigMgr.Update.Manifest.CAB to E:\ConfigMgr\CMUStaging\~
     Extracted E:\ConfigMgr\CMUStaging\Manifest.xml
     ```

     These log entries indicate that DMPDownloader successfully downloaded and processed the CAB file.

- **SCP in Offline mode**

  > [!NOTE]  
  > The following steps refer to the ServiceConnectionTool.log file, which resides in the same directory as the service connection tool. For more information about this file, see the [Log files](/intune/configmgr/core/servers/manage/use-the-service-connection-tool#log-files) section of "Use the service connection tool for Configuration Manager."

  1. Check the data that you downloaded in the [Import](/intune/configmgr/core/servers/manage/use-the-service-connection-tool#import) step, and verify that the ConfigMgr.Update.Manifest.enc file is present.
     1. If the file is missing, review the entries in ServiceConnectionTool.log that were recorded during the [Connect](/intune/configmgr/core/servers/manage/use-the-service-connection-tool#connect) step. Check for any errors that relate to downloading ConfigMgr.Update.Manifest.enc.
     1. If the file is present, review the ServiceConnectionTool.log that were recorded during the Import step. If the file downloaded successfully, the log contains a state message 4 entry that resembles the following example:

     ```output
     Successfully Dropped the state message 4~~
     ```

### Troubleshoot the Applicability check stage

> [!NOTE]  
> An issue in the Applicability check stage typically indicates that the Site Version information is in an inconsistent state because of a manual database change or a previous failed update. Under such circumstances, the check determines that the update doesn't apply.
>
> If a more recent update is available in the console, try to install it. A more recent update (that has a higher version number) might bypass the issue.

If you suspect that your issue occurs in the Applicability check stage, use the following flowchart to investigate which components might be involved and which processes the issue affects.

:::image type="content" source="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-applicability-stage.png" alt-text="Diagram of a decision tree to isolate an issue that might occur during the Applicability check stage." lightbox="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-applicability-stage-expanded.png":::

 Additionally, you also need information from the top-level Site SQL Database. Use the following query:

```sql
SELECT PackageGuid,State FROM CM_UpdatePackages where PackageGUID = '<Package GUID>'
```

For the relevant log entries, see the HMAN.log file.

#### Verify the site database functions

As part of troubleshooting the Applicability check stage, verify that the site database functions work correctly. The site database functions must return the correct Site Version. To check the scalar function output, run the following SQL query:

```sql
SELECT dbo.fnCurrentSiteVersion()
```

Correlate the returned version information to other sources such as the version of the SMSExec.exe binary file. The following table lists multiple sources of these values.

> [!NOTE]  
> The values might include both regular build numbers (expressed as *nnnn*) and minor build numbers (expressed as *mm*). Only the regular build numbers (*nnnn*) are relevant to troubleshooting this issue.

| Location | Function/Value | Expected value |
|---|---|---|
| SQL DB | fnCurrentSiteVersion | 5.00.*nnnn*.1000 |
| SQL DB | fnSetupFullVersion | 5.00.*nnnn*.10*mm* |
| SQL DB | fnCurrentSiteVersion_INT/fnCurrentSiteVersion_INT_TABLE | 500*nnnn* |
| Registry | HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Setup\Full Version | 5.00.*nnnn*.1000 |
| SQL DB | Sites.Version | 5.00.*nnnn*.1000 |
| SMSExec.exe | Product Version | 5.00.*nnnn*.10*mm* |

If you spot a discrepancy, submit a ticket to Microsoft Support.

## Investigate the Download stage

As described earlier, each update package has a unique GUID (also known as the update GUID or package GUID). To identify the GUID of the update package that you're interested in, you can either search for it in the Manifest.xml file (from the unpacked ConfigMgr.Update.Manifest.cab file) or add the **Package GUID** column to the **Administration** > **Overview** > **Updates and Servicing** node of the console. Use the package GUID to follow all the later processing steps for update packages.  
<br/>
<details><summary>Select here to see the Download steps.</summary>

### Process step 1: DMPDownloader downloads the update and any supporting files

By default, DMPDownloader automatically starts downloading the latest applicable update package. Alternatively, an Administrator can manually download any other applicable update package by selecting it in the console and then selecting **Download**.

In either case, after the process starts, the SMS provider calls the `spAddPackageToDownload` stored procedure. The stored procedure adds the package GUID to the `CM_UpdatePackagesToDownload` table in the SQL database.

DMPDownloader runs the `spCMUCheckAvailableUpdates` stored procedure to pick up the list of package GUIDs. If the list contains at least one package GUID, DMPDownloader logs entries that resemble the following example:

```output
Get new Easy Setup Package IDs~~
Found a new available update~~
```

DMPDownloader uses high-priority [state messages](state-messaging-description.md) to report progress to the site server. DMPDownloader logs entries that resemble the following example:

```output
Generating state message: 6 for package 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e~~
Write the state message in E:\ConfigMgr\inboxes\auth\statesys.box\incoming\high\___CMUaxxtrjtn.SMX~~
Successfully Dropped the state message 6~~
```

> [!NOTE]  
> In this example, `3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e` is an example of a package GUID.

Then DMPDownloader gets the payload URL from the manifest and then downloads the actual update. DMPDownloader logs entries that resemble the following example, and changes the state message from `6 (FOUND_NEW_PACKAGE)` to `10 (PAYLOAD_DOWNLOADED)`.

```output
EasySetupMaintenance - Redownload packages if needed~~
EasySetupMaintenance - Redownload package: 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e~~
EasySetupDownloadSinglePackage downloading 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e. ~~
Generating state message: 8 for package 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e~~
Write the state message in E:\ConfigMgr\inboxes\auth\statesys.box\incoming\high\___CMUiekp0rdo.SMX~~
Successfully Dropped the state message 8~~
Checking IsPayloadLocal with HashAlgorithm = SHA256 ...~~
expected hash = 6C3C912C1C79E3958A0D8EE7F306470A87058E5DC6936F3438BF812D367F976F~~
actual hash = ~~
PayloadExist = -1~~
Content for 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e does not exist locally. Download it from internet~~
Write the package meta data to connector's outbox~~
The CMU file name is E:\ConfigMgr\inboxes\hman.box\ForwardingMsg\___CMU3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e.MCM~~
outerxml is <ConfigurationManagerUpdateContent Guid="3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e" State="262145" ReportTime="2024-12-17T14:49:55" />~~
Successfully write the update meta into outbox for package 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e~~
The payload to be processed is at E:\ConfigMgr\EasySetupPayload\3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e.cab~~
Generating state message: 9 for package 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e~~
Write the state message in E:\ConfigMgr\inboxes\auth\statesys.box\incoming\high\___CMUidgtakwg.SMX~~
Successfully Dropped the state message 9~~
Download content for payload 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e~~
Download large file with BITs~~
Redirected to URL https://configmgrbits.azureedge.net/release/2409SR1_9132.1011/3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E/3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E.cab~~
Generating state message: 10 for package 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e~~
Write the state message in E:\ConfigMgr\inboxes\auth\statesys.box\incoming\high\___CMUqdahi22d.SMX~~
Successfully Dropped the state message 10~~
Write the package meta data to connector's outbox~~
The CMU file name is E:\ConfigMgr\inboxes\hman.box\ForwardingMsg\___CMU3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e.MCM~~
outerxml is <ConfigurationManagerUpdateContent Guid="3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e" State="262145" ReportTime="2024-12-17T14:53:25" />~~
Successfully write the update meta into outbox for package 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e~~
```

DMPDownloader downloads the update to \\EasySetupPayload\\\<Update GUID>.cab on the SCP, where \<Update GUID> represents the GUID of the update. Then it extracts the contents of the file to the folder that has the same name. DMPDownloader logs entries that resemble the following example:

```output
Verify the payload signature, hash value and extract the payload~~
File 'E:\ConfigMgr\EasySetupPayload\3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e.cab' is signed and trusted.
File 'E:\ConfigMgr\EasySetupPayload\3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e.cab' is signed with MS root cert.
File splash.hta is being extracted~~
...
File E:\ConfigMgr\EasySetupPayload\3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e.cab has been extracted with 0~~
Generating state message: 25 for package 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e~~
Write the state message in E:\ConfigMgr\inboxes\auth\statesys.box\incoming\high\___CMUrcscp1g0.SMX~~
Successfully Dropped the state message 25~~
```

DMPDownloader then checks whether the update contains fresh redists. DMPDownloader logs entries that resemble the following example:

```output
Check if there is redist to download for update, 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e~~
Download redist for update 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e~~
Successfully download redist for 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e.~~
Generating state message: 11 for package 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e~~
Write the state message in E:\ConfigMgr\inboxes\auth\statesys.box\incoming\high\___CMUga4ldcw3.SMX~~
Successfully Dropped the state message 11~~
Write the package meta data to connector's outbox~~
The CMU file name is E:\ConfigMgr\inboxes\hman.box\ForwardingMsg\___CMU3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e.MCM~~
outerxml is <ConfigurationManagerUpdateContent Guid="3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e" State="262146" ReportTime="2024-12-17T15:09:52" />~~
Successfully write the update meta into outbox for package 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e~~
Generating state message: 12 for package 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e~~
Write the state message in E:\ConfigMgr\inboxes\auth\statesys.box\incoming\high\___CMUdbkthmu2.SMX~~
Successfully Dropped the state message 12~~
Generating state message: 13 for package 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e~~
Write the state message in E:\ConfigMgr\inboxes\auth\statesys.box\incoming\high\___CMUcneiawu1.SMX~~
Successfully Dropped the state message 13~~
EasySetupDownloadSinglePackage finishes downloading 3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e. ~~
```

To download the redists, DMPDownloader reads the same Manifest.xml file that it used to detect the update. The manifest contains redist and language pack URLs, as the following example shows:

```xml
<Manifest>
<Update>2409</Update>
<MinCMVersion>5.00.9106.1000</MinCMVersion>
<MaxCMVersion>5.00.9132.1009</MaxCMVersion>
<MoreInfoLink>https://go.microsoft.com/fwlink/?LinkID=2298746</MoreInfoLink>
...
<Content ContentUrl="https://go.microsoft.com/fwlink/?LinkID=2298748">
<Hash Algorithm="SHA256">2F1168BD3BF4982CCB2FDF5C869B7E43DD5C2CCEA27CDCA0056C18EAAFF48E2D</Hash>
<Redist ManifestUrl="https://go.microsoft.com/fwlink/?LinkID=2298749"/>
<LanguagePack ManifestUrl="https://go.microsoft.com/fwlink/?LinkId=2298744"/>
</Content>
```

Then DMPDownloader engages SetupDL.exe, the usual Configuration Manager redist downloading process. SetupDL.exe downloads the redists and language manifests, and logs this information in ConfigMgrSetup.log. The entries resemble the following example:

```output
INFO: Attempting to load resource DLL...
INFO: Setup downloader setupdl.exe: STARTED
INFO: Downloading files to E:\ConfigMgr\EasySetupPayload\3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e\redist
INFO: Downloading component manifest...
INFO: Downloading https://go.microsoft.com/fwlink/?LinkId=2298744 as ConfigMgr.LN.Manifest.cab
INFO: Downloading https://go.microsoft.com/fwlink/?LinkID=2298749 as ConfigMgr.Manifest.cab
INFO: Extracted file C:\Windows\TEMP\ConfigMgr.LN.Manifest.xml
```

The manifest XML contains the list of redists to download, the download links, and the expected hashes. SetupDL.exe downloads the files, verifies the hashes, and then unpacks the files to the \\EasySetupPayload\\\<Update GUID>\\redist folder. SetupDL.exe logs entries that resemble the following example:

```output
INFO: Verify directory E:\ConfigMgr\EasySetupPayload\3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e\redist\LanguagePack\MobileDevice\SMSSETUP\BIN\X64\
INFO: Setup downloader setupdl.exe: FINISHED
```

### Process step 2: Completing the download

After step 1 is completed, the \\EasySetupPayload shared folder contains the \\\<Update GUID> folder. The new folder contains an integrated \\Redists folder.

Depending on the SCP configuration, DMPDownloader puts a file that's referred to as the *CMU file* in one of the following locations:

- If the SCP is remote from the site server, DMPDownloader puts the file in MP\\OUTBOXES\\MCM.box. Afterwards, MPFDM moves the file to inboxes\\hman.box\\ForwardingMsg for the site server.
- If the SCP is collocated together with the site server, DMPDownloader saves the file directly to the inboxes\\hman.box\\ForwardingMsg folder.

The file has an .mcm extension, and contains the information that marks the state of the update package as **State="262146"** (also known as **"DOWNLOAD_SUCCESS"**). The corresponding log entries resemble the following example:

```output
The CMU file name is E:\ConfigMgr\inboxes\hman.box\ForwardingMsg\___CMU3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e.MCM~~
outerxml is <ConfigurationManagerUpdateContent Guid="3b7d84fa-eccc-4ea0-b8ab-abbda1e88e0e" State="262146" ReportTime="2024-12-17T15:10:03" />~~
```

The notification file is simply an XML file that contains the update package GUID and its status. `State="262146"` means that the update package was downloaded.

HMAN converts the file back to CMU format, and then moves it to HMAN.box\\CFD. This process resembles the process that's applied to the manifest CAB file during the [Synchronization stage](#process-step-1-dmpdownloader-downloads-the-update-and-any-supporting-files). The CMUHandler thread in HMAN logs an entry to HMAN.log that resembles the following example:

```output
Validate CMU file C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CFD\e8e74b72-504a-4202-9167-8749c223d2a5.CMU with no intune subscription.
```

The CMUHandler thread processes the file and uses the `spCMUSetUpdatePackageState` stored procedure to update the state information in the `CM_UpdatePackages` table to **"262146" (DOWNLOAD_SUCCESS)**. If HMAN is configured to log data at the verbose logging level, it logs entries that resemble the following example:

```output
INFO: File without BOM : (E:\ConfigMgr\inboxes\hman.box\CFD\e8e74b72-504a-4202-9167-8749c223d2a5.CMU)
There is no additional error details E:\ConfigMgr\inboxes\hman.box\CFD\e8e74b72-504a-4202-9167-8749c223d2a5.CMU from file
Updated CMUpdatePackage state to 262146 (PackageGuid=e8e74b72-504a-4202-9167-8749c223d2a5)
deleted file E:\ConfigMgr\inboxes\hman.box\CFD\e8e74b72-504a-4202-9167-8749c223d2a5.CMU
```

If the new state value is **"262146" (DOWNLOAD_SUCCESS)** or **"327679" (DOWNLOAD_FAILED)**, the update package GUID is removed from `CM_UpdatePackagesToDownload` table.

</details>

### Result of the Download processes

The console displays the list of update packages and their status as **Ready to Install**. The downloaded package content resides on the SCP in the EasySetupPayload folder.

### Troubleshoot the Download stage

During the Download stage, the DMPDownloader component downloads the Easy Setup Payload and redists. In Offline mode, SCT imports these files, and then DMPDownloader verifies the files and informs the site server about their availability. As a result, DMPDownloader.log is the primary log to check.

Use the following flowchart to isolate issues that might occur at the Download stage.

:::image type="content" source="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-download-stage.png" alt-text="Diagram of a decision tree to isolate an issue that might occur during the Download stage." lightbox="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-download-stage-expanded.png":::

#### How to approach download issues

Whether you use an online or offline SCP, review the ConfigMgrSetup.log file to make sure that SetupDL.exe downloads redists. If you find that a download from a specific URL failed, look for an entry that resembles the following entry in either DMPDownloader.log (Online mode) or ServiceConnectionTool.log (Offline mode):

```output
ERROR: Failed to download Admin UI content payload with exception: The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel.  
```

Then, follow these steps:

1. Verify that the computer that hosts the SCP meets all [internet access requirements](/intune/configmgr/core/plan-design/network/internet-endpoints#updates-and-servicing) and [TLS 1.2 requirements](/intune/configmgr/core/plan-design/security/enable-tls-1-2).
1. If the site system configuration uses a proxy for connections, verify the proxy configuration.
1. To make sure that the file downloads successfully, copy the affected URL, and paste it into a browser. Make sure that it has a valid digital signature.
1. Use a network tracing tool to collect network traces of the download operation, and then review the results.

For more information about how to troubleshoot issues that affect specific downloads, see [Error when downloading ConfigMgr.AdminUIContent.cab by using SMS_DMP_DOWNLOADER or ServiceConnectionTool.exe](service-connection-tool-not-download-updates.md).

#### How to approach extraction issues

There are rare cases when DMPDownloader doesn't unpack incoming files even if the content itself is fine. Antimalware scans can cause this issue. Make sure that the [Configuration Manager anti-malware exclusions](../endpoint-protection/recommended-antivirus-exclusions.md) are configured correctly.

#### When to restart the update synchronization and download processes

If you suspect that the download is finished, but the content was tampered with, delete the affected update, and retry the operation. To take this step, use the [Update Reset tool](/intune/configmgr/core/servers/manage/update-reset-tool) to clean up update package information from the database and delete all downloaded content. This tool restarts the whole process from the Synchronization stage.

## Review progress through the Replication, Prerequisite check, and Installation stages

After an update package downloads, the console automatically lists it as **Ready to Install**. The next stage for the update is either Prerequisite check or Installation. In both cases, the update package payload content replicates to all primary site content libraries. After the package replicates, Configuration Manager extracts the payload so that it can install the update.

To start troubleshooting issues at this point in the Updates and Servicing process, use the console. Go to **Monitoring** > **Overview** > **Site Servicing** > **Update packages**. If you don't see the current status of the updates, select **Show Status**. The console displays the progress of each update through the following stages:

- Replication
- Prerequisite check
- Installation
- Post-installation

Use the following flowchart to narrow the stage in which your issue occurs.

:::image type="content" source="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-scope-replication-installation-stage.png" alt-text="Diagram of a decision tree to isolate an issue that might occur during the Replication or Installation stages." lightbox="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-scope-replication-installation-stage-expanded.png":::

## Investigate the Replication stage

After an update package downloads, it has to replicate through the site topology before it can install. Configuration Manager reuses the Package concept for this process by creating and maintaining a hidden Easy Setup Package. The Easy Setup Package replicates only to primary site servers.

After the Easy Setup Package replicates, Configuration Manager extracts the update from the site server content library to the CMUStaging folder that's to be used during the installation process.

The following steps explain the [flow](/intune/configmgr/core/servers/manage/update-replication-flowchart) for an in-console update in which the update replicates to other sites.  
<br/>
<details><Summary>Select here to see the Replication steps.</summary>

### Process step 1: Start the replication process and identify the update

At the top-level site, you take one of the following actions:

- Install the update (select **Install**).
- Start a prerequisite check.

The change in the update package state fires the `CM_UpdatePackages_UPD_HMAN` trigger. The SMSDBMON component drops a file that's named 2.esc in the HMAN.box\\CFD folder. This action wakes up HMAN, and HMAN starts processing the update. HMAN uses the  \\\\\<ServerName>\\EasySetupPayload\\\<Update GUID> shared folder as the source to create or update the package. If the verbose logging option is turned on, SMSDBMON logs entries in SMSDBMon.log that resemble the following example:

```output
RCV: UPDATE on CM_UpdatePackages for CM_UpdatePackages_UPD_HMAN [2  ]
Modified trigger definition for Hierarchy Manager[CM_UpdatePackages_UPD_HMAN]: table CM_UpdatePackages(State) on update, file ESC in dir C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CFD\  
SND: Dropped C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CFD\2.ESC
```

When it detects the 2.esc file, HMAN runs the following query to check which update package is selected to install:

```sql
SELECT TOP 1 convert(NVARCHAR(40), PackageGuid) FROM CM_UpdatePackages WHERE State=2
```

HMAN logs entries that resemble the following example:

```output
INFO: 2.ESC file was found. Easy setup package needs to be updated.  
Get  Update Pack E8E74B72-504A-4202-9167-8749C223D2A5, \\<SCP.FQDN>\EasySetupPayLoad\E8E74B72-504A-4202-9167-8749C223D2A5
```

If the package was previously replicated, HMAN logs an entry that resembles the following example:

```output
Easy setup source folder hash is not changed. Skip updating.
```

Otherwise, HMAN logs entries that resemble the following example:

```output
INFO: Successfully requested package CAS10001 to be updated from its source.  
Info: Updated package CAS10001 and SMS_DISTRIBUTION_MANAGER will replicate the content to all the site servers except the secondary sites. The content will be stored in the content library on the site servers. Check distmgr.log for replication status.
Successfully reported ConfigMgr update status (SiteCode=CAS, SubStageID=0xb0001, IsComplete=2, Progress=100, Applicable=1)
```

### Process step 2: HMAN updates the Easy Setup Package

HMAN adds the package GUID of the update package to the `EasySetupSettings` table.

HMAN logs entries that resemble the following example:

```output
Updating easy setup settings with EXEC sp_UpdateEasySetupSettings N'CAS10001','2',N'561BE7B704CA99A8DB6697886E75BD7C4812324D0A637708E863EC9DF97EFB94'
```

If you want to find the **PackageID** value of the Easy Setup Package, run the following SQL query (you can also use TSS for this purpose):

```sql
Select * from vEasySetupPackage
```

To keep HMAN busy and keep it from processing other files, SMSDBMon drops the \<PackageGUID>.cme file in the HMAN.box\\CFD folder. If the verbose logging option is turned on, SMSDBMON logs entries that resemble the following example:

```output
SND: Dropped C:\Program Files\Microsoft Configuration Manager\inboxes\hman.box\CFD\10AA8BA0-04D4-4FE3-BC21-F1874BC8C88C.CME
```

### Process step 3: DistMgr distributes the content

This step is essentially the same as for any intersite content replication process. However, the Easy Setup Package isn't replicated to secondary sites or distribution points.

Distribution Manager (DistMgr) uses \\\\\<SCP.FQDN>\\EasySetupPayLoad\\\<Update GUID> to create a snapshot of the Easy Setup Package and send it to the content library of the top-level site.

DistMgr logs the entries to DistMgr.log that resemble the following example:

```output
Found package properties updated notification for package 'CAS10001'  
Info: package 'CAS10001' is set to replicate to site servers only.  
Taking package snapshot for package CAS10001 from source \\<SCP.FQDN>\EasySetupPayLoad\E8E74B72-504A-4202-9167-8749C223D2A5
```

To check the status of this process, you can filter DistMgr.log for the thread ID. To get the thread ID, examine the **Package Processing Queue** value of the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\COMPONENTS\SMS_DISTRIBUTION_MANAGER` registry subkey.

DistMgr also creates a minijob that replicates content to child primary sites (if they exist). It logs entries that resemble the following example:

```output
Setting CMiniJob transfer root to C:\SMSPKG\CAS10001.PCK.1  
Created minijob to send compressed copy of package CAS10001 to site XXX.  Transfer root = C:\SMSPKG\CAS10001 .PCK.1
```

The Scheduler component schedules a file replication job to transfer the content to any child primary sites. Scheduler logs entries in Scheduler.log that resemble the following example:

```output
1 jobs found in memory, 10 jobs found in job source.  
~Instruction file = C:\Program Files\Microsoft Configuration Manager\inboxes\schedule.box\tosend\00000391.Idb  
<Updating JOB 00000391> [Software Distribution for Configuration Manager Easy Setup Package, Package ID = CAS10001]~  
<JOB STATUS - COMPLETE>~
```

The Sender component manages the actual content transfer. It logs entries in Sender.log that resemble the following example:

```output
~Package file = C:\SMSPKG\CAS10001.DLT.5.6  
~Instruction file = C:\Program Files\Microsoft Configuration Manager\inboxes\schedule.box\tosend\00000391.Idb  
~Sending Started [C:\SMSPKG\CAS10001.DLT.5.6]  
~Finished sending SWD package CAS10001 version 6 to site PRI  
~Sending completed successfully
```

The replication process continues at the primary site. After Sender transfers the Easy Setup Package, the Despooler component of the child primary site unpacks the package content to a content library of the receiving site. Despooler logs entries in Despool.log that resemble the following example:

```output
Received package CAS10001 version 1. Compressed file -  C:\SMSPKG\CAS10001.PCK.1 as C:\Program Files\Microsoft Configuration Manager\inboxes\despoolr.box\receive\ds_r7or9.pkg  
Content Library: C:\SCCMContentLib  
Extracting from C:\SMSPKG\CAS10001.PCK.temp  
Extracting package CAS10001  
Extracting content CAS10001.1  
Writing package definition for CAS10001  
Package CAS10001 (version 0) exists in the distribution source, save the newer version (version 1).  
Stored Package CAS10001. Stored Package Version = 1
```

Each content distribution component updates its `ObjectDistributionState` table as it processes the package. This table's `ObjectDistributionState_ins_updMon` trigger saves the replication stages to the `CM_UpdatePackage_MonitoringStatus` table. If you want to see more details of the Replication and Installation stages, run following SQL query:

```sql
select ServerData.SiteCode, cmums.* from CM_UpdatePackage_MonitoringStatus cmums
Left join serverdata on cmums.SiteNumber=ServerData.ID
where PackageGUID='<Package GUID>'
```

### Process step 4: Finish replicating the package

After the replication finishes, DistMgr marks the process as successful, and logs entries that resemble the following example:

```output
Found package properties updated notification for package 'CAS10001'  
Adding package 'CAS10001' to package processing queue.  
Started package processing thread for package 'CAS10001',  
Start updating the package CAS10001...  
Successfully created/updated the package CAS10001
```

At the child primary sites, HMAN creates a file that's named \<Update GUID>.cmi for Configuration Manager Update Service (CMUpdate.exe). HMAN logs an entry that resembles the following example:

```output
Created notification file (E8E74B72-504A-4202-9167-8749c223d2a5.CMI) for CONFIGURATION_MANAGER_UPDATE
```

CMUpdate moves the update package to the Prerequisite check phase.

</details>

### Result of the Replication processes

The content of the update package (also known as the EasySetup Package) resides in the content library of each child primary site.

### Troubleshoot the Replication stage

To summarize the detailed description of the steps, the replication process starts when HMAN detects a new update package and updates the `EasySetupSettings` SQL table settings. DistMgr takes over to create the Easy Setup Package snapshot from the `\EasySetupPayload\` share, and saves it to the content library as the Easy Setup Package. This package follows the usual intersite content replication flow, and replicates to child primary sites in the same manner as any other classic Package. The best place to start troubleshooting issues in this stage is by filtering the `CM_UpdatePackages` table for the specific update package GUID.

Use the following flowchart to narrow issues that might occur at the Replication stage. This flowchart applies whether the Installation stage or the Prerequisite check stage triggered the Replication stage.

:::image type="content" source="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-replication-stage.png" alt-text="Diagram of a decision tree to isolate an issue that might occur during the Replication stage." lightbox="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-replication-stage-expanded.png":::

In a multi-tier hierarchy, the child primary sites replicate the Easy Setup Package from their parent site. The flow is exactly the same as for any other classic Package. For more information, see [Flowchart - Update replication for Configuration Manager](/intune/configmgr/core/servers/manage/update-replication-flowchart).

#### Troubleshoot issue: Status of the update package remains "State=2 (Enabled)"

The state of the package might not change from `State=2 (Enabled)`. This condition typically means that HMAN can't finish its task. To troubleshoot this issue, analyze HMAN.log:

1. Look for entries that mention processing the 2.esc file.
1. Filter the log by the respective thread.
1. Alternatively, look for the last `SubstageID` value that's recorded in the log. The data that's associated with this value should include either `IsComplete=2 (Success)` or `IsComplete=4 (Failure)`. This information should resemble the following example:

   ```output
   Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xb0001, IsComplete=2, Progress=100, Applicable=1)
   ```

1. If the HMAN.log file rolled over (removing older entries), try to manually re-create the empty 2.esc file in the HMAN.box\\CFD folder. This operation should trigger the same process again.

   > [!NOTE]  
   > Even if SCP is local to the site server, HMAN has to use a share path (such as \\\\\<SCP FQDN>\\EasySetupPayLoad\\\<PackageGUID>) in order to calculate the hash for the Easy Setup Package and to update the `EasySetupSettings` table. If HMAN can't access the share, it logs an error message that resembles the following example:
   >
   > ```output
   > Get update package 05F7ED65-3CB0-46CF-91E7-71193DAF9845, \\<SCP FQDN>\EasySetupPayLoad\05F7ED65-3CB0-46CF-91E7-71193DAF9845
   > Failed to calculate hash
   > ```
   >
   > Make sure that the computer account that the site server uses can access this share.

#### Troubleshoot issue: Status of the update package changed from "State=2 (Enabled)"

If the state of the package isn't `State=2 (Enabled)`, review the **vEasySetupPackage** SQL view of the Easy Setup Package information. The data that this view shows should resemble the following example.

| PackageID | PackageVersion | PackageHash | PackageGUID | StoredPkgHash | Source | SourceSite | LastRefresh | StoredPkgVersion | StorePkgFlag | SourceDate | SourceVersion | SourceSize |
|-----------|----------------|-------------|-------------|---------------|--------|-----------|-------------|------------------|--------------|------------|---------------|------------|
| CS10001F | 1 | E53E...1F25 | C00DC5CD-0955-418F-9F32-F54016659FFF | E53E...1F25 | \\\\SCP.FQDN.COM\\EasySetupPayLoad\\C00DC5CD-0955-418F-9F32-F54016659FFF | CS1 | 2025-09-02 13:05:10.000 | 1 | 2 | 2025-09-02 13:04:42.000 | 1 | 150676 |

Verify the **Source**, **Package Version**, and **PackageID** values. To trace the Easy Setup Package further, check DistMgr.log and the other content replication logs for mentions of the **PackageID** value.

#### Troubleshoot issue: Packages aren't distributed

The rest of the troubleshooting is the same as for typical replicated package. For more information, see [Distribute a package to DP across sites](../content-management/understand-package-actions.md#distribute-a-package-to-dp-across-sites). If the flow failed or the logs rolled over, use the [RetryContentReplication](/intune/configmgr/develop/reference/sum/retrycontentreplication-method-in-class-sms_cm_updatepackages) Windows Management Instrumentation (WMI) method to force the Easy Setup Package information to update. This method is associated with the SMS provider of the top-level site, and you can invoke it by running the following command at a PowerShell command prompt:

```powershell
(gwmi -Namespace "ROOT\SMS\site_<SITE CODE>" -query "select * from SMS_CM_UpdatePackages where PackageGuid = '<PACKAGE GUID>'").RetryContentReplication($true)
```

The output should resemble the following example:

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

As the Easy Setup Package is reprocessed, you can track its progress in the DistMgr.log file.

## Investigate the Prerequisite check stage

The following steps explain the process of extracting the update to run prerequisite checks. These steps occur on the central administration site and child primary sites before the update installs.

For more information about the current set of Prerequisite check rules, see [List of prerequisite checks for Configuration Manager](/intune/configmgr/core/servers/deploy/install/list-of-prerequisite-checks).

> [!NOTE]  
> Only a subset of the prerequisite checks occur before an update installs.  

<br/>
<details><Summary>Select here to see the Prerequisite check steps.</summary>

### Process step 1: Trigger the check

After you select the update package and select **Run prerequisite check**, the console calls the `InitiateUpgrade` WMI method (from the `SMS_CM_UpdatePackages` WMI class of the SMS Provider namespace). The console sets the method's `Flag` parameter to `1 (PREREQ_ONLY)`.

If Configuration Manager didn't yet [replicate the update package](#investigate-the-replication-stage), it does that step now.

### Process step 2: HMAN notifies CMUpdate of the requested check

After HMAN updates the Easy Setup Package, it verifies the state of the CONFIGURATION_MANAGER_UPDATE service, and then creates the `<Update GUID>.cmi` notification in the CMUpdate.box inbox. HMAN logs entries that resemble the following example:

```output
INFO: Starting service CONFIGURATION_MANAGER_UPDATE
CONFIGURATION_MANAGER_UPDATE is already running.
Successfully checking Site server readiness for update.
There are update package in progress. Cleanup will skip this time.
```

### Process step 3: CMUpdate extracts the update

After 10 minutes elapses, or after CMUpdate.box receives an inbox trigger, CMUpdate.exe runs the following SQL stored procedure:

```sql
exec spCMUGetPendingUpdatePackage
```

This stored procedure collects the information from the `CM_UpdatePackages` and `CM_UpdatePackageSiteStatus` tables for the site that's running the check. As soon as the CMUpdate thread detects an update package that has the `State = 65538 (CONTENT_REPLICATION_SUCCESS)` status, it extracts the Easy Setup Package content to the \\CMUStaging\\\<Update GUID>` folder.

CMUpdate logs entries to CMUpdate.log that resemble the following example. The example entries include a reference to `SubStageID=0xd0005`. This value tracks the status of the extraction process (the check starts when the extraction is complete).

```output
Detected a change to the "E:\ConfigMgr\inboxes\cmupdate.box" directory.
INFO: setup type: 8, top level: 1.
Content replication succeeded. Start extracting the package to run prereq check...
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xd0005, IsComplete=1, Progress=1, Applicable=1)
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xd0005, IsComplete=1, Progress=25, Applicable=1)
Checking if the CMU Staging folder already has the content extracted.
Creating hash for algorithm 32780
Staging folder has hash = C2CF43A73903C6E987E1BE5872C292AAE8AC2C5D15F6D145492BECE84D7D47C0
Staging folder (\\?\E:\ConfigMgr\CMUStaging\8576527E-DDE9-4146-8ED9-DB91091C38EF) has hash C2CF43A73903C6E987E1BE5872C292AAE8AC2C5D15F6D145492BECE84D7D47C0 which does not match hash from content library 8055DAEFDDE5FFCE763FA6F1B0DEA2C7115347FF1FFF848A8192AB769DF22FA3
Delete folder \\?\E:\ConfigMgr\CMUStaging\8576527E-DDE9-4146-8ED9-DB91091C38EF\ returned 0. Extractring the content from content library...
update package content 8576527E-DDE9-4146-8ED9-DB91091C38EF has been expanded to foler \\?\E:\ConfigMgr\CMUStaging\8576527E-DDE9-4146-8ED9-DB91091C38EF\
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xd0005, IsComplete=1, Progress=50, Applicable=1)
File '\\?\E:\ConfigMgr\CMUStaging\8576527E-DDE9-4146-8ED9-DB91091C38EF\SMSSetup\update.map.cab' is signed and trusted.
File '\\?\E:\ConfigMgr\CMUStaging\8576527E-DDE9-4146-8ED9-DB91091C38EF\SMSSetup\update.map.cab' is signed with MS root cert.
Extracting file \\?\E:\ConfigMgr\CMUStaging\8576527E-DDE9-4146-8ED9-DB91091C38EF\SMSSetup\update.map.cab to \\?\E:\ConfigMgr\CMUStaging\8576527E-DDE9-4146-8ED9-DB91091C38EF\SMSSetup\~
Extracted \\?\E:\ConfigMgr\CMUStaging\8576527E-DDE9-4146-8ED9-DB91091C38EF\SMSSetup\update.map~
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xd0005, IsComplete=1, Progress=75, Applicable=1)
Successfully read file \\?\E:\ConfigMgr\CMUStaging\8576527E-DDE9-4146-8ED9-DB91091C38EF\SMSSetup\update.map
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xd0005, IsComplete=2, Progress=100, Applicable=1)
```

The same process occurs on the other primary sites.

Additionally, CMUpdate verifies the signature and extracts the Update.map.cab file. This file contains update.map file. This file defines the hashes and the locations for the files that the update affects.

### Process step 4: CMUpdate starts the check

After the content is extracted, CMUpdate.exe starts the prerequisite check:

```output
~FQDN for server <Site Server> is <Site Server FQDN>
INFO: Target computer is a 64 bit operating system.
INFO: Checking for existing setup information.
INFO: Setting setup type to  8.
INFO: Checking for existing SQL information.
INFO: '<Site Database Server>' is a valid FQDN.
INFO: Verifying the registry entry for Asset Intelligence installation
INFO: Setup detected an existing Configuration Manager installation. Currently installed version is 9132~
INFO: Phase is 1C7~
INFO: SDK Provider is on <SMS Provider>.
Set working directory to the staging folder E:\ConfigMgr\CMUStaging\8576527E-DDE9-4146-8ED9-DB91091C38EF\SMSSetup
INFO: Setting the default CSV folder path
INFO: Language: Mobile Device (INTL), LangPack: 0.
INFO: Configuration Manager Build Number = 9135
INFO: Configuration Manager Version = 5.0
INFO: Configuration Manager Minimum Build Number = 800
Preparing prereq check for site server [<Site Server FQDN>]...~
```

During this process, CMUpdate silently sets the `Update State` in the `CM_UpdatePackages` table to `131073 (PREREQ_IN_PROGRESS)`.

Then, CMUpdate looks for the Update.map file in the \\CMUStaging\\\<PackageGUID>\\SMSSetup folder. In the file, CMUpdate looks for the `CONFIGURATION_MANAGER_UPDATE` section for the hashes of the files that it needs. This section of the file resembles the following example:

```xml
BEGIN_COMPONENT_FILELIST
    <CONFIGURATION_MANAGER_UPDATE>
    <268436008>
    BEGIN_DIRECTORY
        <bin\x64>
        <5><AMD64><>
        FILEEX <cmupdate.exe><1><26699848><SHA256><6953438BE14562E2E2A2860195BC7308FE3647ABF803F98269F8976A145063AC>
        FILEEX <setupcore.dll><0><28034624><SHA256><A335EE6EDF6593AF9F1498B1F6297C0B9E49E58BF3C472929AFEA38F09F51C85>
        FILEEX <prereqcore.dll><0><4464648><SHA256><48899098998C712DDF097638B281D5620D8C511FB9B51E2391119281E0ECA43E>
        FILEEX <DcmDigest.xsd><0><73022><SHA256><91E264E70863EC00DAFDE0B2EAC36B7CBA9BC73A4C3CA2520BE9337C4FFB88B7>
        FILEEX <appmgmtdigest.xsd><0><25916><SHA256><F0F2A3880D57E930EAF4A13285F3EDC56EF7032AFF656B2C31833099D15426C7>
        FILEEX <Rules.xsd><0><27433><SHA256><1665E3AF74BFF8BCD5DFD3E71BE869475A53BC60A712BF009D828AEF8C176C3D>
        FILEEX <SecuredRoles.xsd><0><1588><SHA256><3F400C0DC1590CF2A2332741D1D801CC242A6A46FDD6B7CD9A439D16059568EA>
        FILEEX <SoftwareCenterCustomization.xsd><0><4658><SHA256><4B6AD4CDCAF88204961ACC8D563021F9C962A74BBDB270DCF2ED6095D10362C6>
    END_DIRECTORY
    BEGIN_DIRECTORY
        <AI>
        <517><AMD64><>
        FILEEX <LUTables.enc><0><212980419><SHA256><9D43DE730D74B335F77AB2264EE450B233698E94407C6491D136761EEBCFEDE7>
    END_DIRECTORY
    UNIT <SMS>
END_COMPONENT_FILELIST
```

The file of particular interest is Prereqcore.dll. This file contains the actual prerequisite check logic. CMUpdate calculates the hash of the file that resides in \\CMUStaging\\\<PackageGUID>\\SMSSetup\\BIN\\X64, and compares it to the hash in the Update.map file. If the hashes match, the check continues. CMUpdate logs an entry that resembles the following example:

```output
prereqcore has hash value SHA256:48899098998C712DDF097638B281D5620D8C511FB9B51E2391119281E0ECA43E
```

Then, CMUpdate loads prereqcore.dll, and calls the entry point `RunPrereqChecks`. The corresponding log entry resembles the following example:

```output
Running prereq checking against Server [<Site Server>] ...~
```

> [!NOTE]  
> Hotfixes typically don't have a specific section in the Update.map file. In such cases, CMUpdate uses the Prereqcore.dll file that's associated with the installed version of Configuration Manager, and the log entry resembles the following example:
>
> ```output
>update.map has no update for CONFIGURATION_MANAGER_UPDATE
> ```

### Process step 5: The Prerequisite checker component starts

Prerequisite checker starts up within the same thread as CMUpdate (notice the command line). However, Prerequisite checker has its own log file (C:\ConfigMgrPrereq.log). Prerequisite checker passes the list of relevant site roles to the actual worker, and logs entries that resemble the following example:

```output
********************************************
******* Start Prerequisite checking. *******
********************************************
INFO: PrereqCoreRes.dll source path is set to E:\CONFIGMGR\CMUSTAGING\8576527E-DDE9-4146-8ED9-DB91091C38EF\SMSSETUP\BIN\X64
Commandline :~"E:\ConfigMgr\bin\x64\cmupdate.exe"
INFO: Checking SQLNCli version on ServerName <Site Server>
INFO: SQLNCli version is 11.4.7001.0
...
INFO: SDK Provider is on <SMS Provider>.
Check Type: Configuration Manager Update
Check Type: Easy Update ~ Site Server: <Site Server>,~ SQL Server: <Site Database Server>
...
```

### Process step 6: Prerequisite checker performs the checks

After the Prerequisite checker loads, it spawns another thread to go through the actual checklist. The thread sorts the check rules by category, and runs them for each of the targeted roles.

For a site server, Prerequisite checker logs entries that resemble the following example:

```output
INFO: Prerequisite rules for CAS site update are being run.
INFO: Executing prerequisite functions...
===== INFO: Prerequisite Type & Server: SITE_PRI:<Site Server> =====
<<<RuleCategory: Access Permissions>>>
<<<CategoryDesc: Checking access permissions...>>>
...
<<<RuleCategory: Dependent Components>>>
<<<CategoryDesc: Checking dependent components for ConfigMgr...>>>
...
<<<RuleCategory: Site Upgrade Requirements>>>
<<<CategoryDesc: Checking if the target ConfigMgr site is ready to upgrade...>>>
...
```

For a site database server, Prerequisite checker logs entries that resemble the following example. Notice that the thread spawns a bootstrap.

```output
===== INFO: Prerequisite Type & Server: SQL:<Site Database Server> =====
<<<RuleCategory: Access Permissions>>>
<<<CategoryDesc: Checking access permissions...>>>
...
<<<RuleCategory: System Requirements>>>
<<<CategoryDesc: Checking system requirements for ConfigMgr...>>>
...
...
<<<RuleCategory: Dependent Components>>>
<<<CategoryDesc: Checking dependent components for ConfigMgr...>>>
...
<<<RuleCategory: Site Upgrade Requirements>>>
<<<CategoryDesc: Checking if the target ConfigMgr site is ready to upgrade...>>>
...
```

For an SMS provider (also known as SDK), Prerequisite checker logs entries that resemble the following example:

```output
===== INFO: Prerequisite Type & Server: SDK:<SMS Provider Server> =====
<<<RuleCategory: Access Permissions>>>
<<<CategoryDesc: Checking access permissions...>>>
...
<<<RuleCategory: System Requirements>>>
<<<CategoryDesc: Checking system requirements for ConfigMgr...>>>
...
<<<RuleCategory: Dependent Components>>>
<<<CategoryDesc: Checking dependent components for ConfigMgr...>>>
...
<<<RuleCategory: Site Upgrade Requirements>>>
<<<CategoryDesc: Checking if the target ConfigMgr site is ready to upgrade...>>>
...
***************************************************
******* Prerequisite checking is completed. *******
***************************************************
```

During the check, each rule calls the `spCMUAddPrereqMessage` SQL stored procedure. The stored procedure updates the `CM_UpdatePackagePrereqStatus` database table to record the results of each check (`Passed`, `Warning`, or `Failed`) for the specific site.

### Process step 7: CMUpdate completes the check

CMUpdate waits for the Prerequisite checker thread to return the results of the checks, and adds the latest state information to the `CM_UpdatePackagesSiteStatus` table (for example, `PREREQ_SUCCESS`). The `State` and `Flag` combination from the `spCMUGetPendingUpdatePackage` SQL stored procedure define further actions (for example, whether to stop or continue if errors occur). CMUpdate logs entries that resemble the following example:

```output
INFO: SQL Connection succeeded. Connection: SMS ACCESS, Type: Secure
INFO: setup type: 8, top level: 1.
Continue configuration manager update as it is configured to ignore prereq warnings.
```

The change in the `CM_UpdatePackagesSiteStatus` table triggers an operation on the \<PackageGUID>.cme file in the HMAN.box\\CFD inbox. The corresponding log entry resembles the following example:

```output
Check CMU status...
deleted notification file E:\ConfigMgr\inboxes\hman.box\CFD\8576527E-DDE9-4146-8ED9-DB91091C38EF.CME
```

Then, HMAN calls the `spProcessCMUPackages` SQL stored procedure by using a command that resembles the following command:

```sql
exec spProcessCMUPackages
```

That stored procedure, in turn, calls the `spProcessCMU` SQL stored procedure. This stored procedure updates the state information in the `CM_UpdatePackages` table.

In multi-site environments, final result of the prerequisite checks is the worst for all the sites that were checked. For example, if the central administration site (CAS) passed the check, but the primary site didn't pass and generated warnings, the overall result is `PREREQ_WARNING`.

</details>

### Result of the Prerequisite check processes

The console labels the update package as **Prerequisite check passed**, and the `CM_UpdatePackages` table lists the state of the update package by using one of the following values:

- `PREREQ_SUCCESS  131074`
- `PREREQ_WARNING  131075`
- `PREREQ_ERROR    196607`

### Troubleshoot the Prerequisite check stage

If the Prerequisite check takes a long time or fails completely, use the following flow chart to help identify the issue. In multi-tier environments, the chart applies to all primary sites and the CAS.

:::image type="content" source="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-prereq-check-stage.png" alt-text="Diagram of a decision tree to isolate an issue that might occur during the Prerequisite check stage." lightbox="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-prereq-check-stage-expanded.png":::

Typically, Prerequisite check issues belong to one of the following categories:

- The check gets stuck in the **Checking Prerequisites** state. In most cases, the real issue occurred during the [Replication stage](#investigate-the-replication-stage).
- The check finishes, but the final state is **Prerequisites Failed**. In this case, the check ran successfully, and no issues occurred during the [Replication stage](#investigate-the-replication-stage).
  
In the **Prerequisites Failed** case, review the following resources to find the real issue:

- ConfigMgrPrereq.log
- The console, in  **Monitoring** > **Overview** > **Updates and Servicing Status** > **Description** for each site

#### Troubleshooting SQL Client prerequisites

The latest versions of Configuration Manager introduced various SQL client prerequisites. The current installation process for update packages doesn't automatically update these clients. Therefore, it makes sense to install up-to-date SQL clients before you install updates.

Since version 1810, Configuration Manager requires SQL Native Client version 11.4.7001.0 or a later version. To view the current requirement, check the value of the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQLNCLI11\InstalledVersion` registry entry.

Similarly, since version 2303, Configuration Manager requires ODBC Driver 18 for SQL Server or a later version. Since version 2503, Configuration Manager requires ODBC Driver 18.4.1.1 for SQL Server or a later version. To view the current requirement, check the value of the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSODBCSQL18\InstalledVersion` registry entry.

To meet both SQL Server prerequisites, consider manually installing the following MSI files from the \\EasySetupPayload\\\<Update GUID>\\redist folder:

- sqlncli.msi
- msodbcsql.msi

> [!NOTE]  
> These files are available for only major releases.

Alternatively, download the latest binaries from the following URLs in the Microsoft Download Center:

- [SQL Server 2012 Native Client 11.0.7001.0](https://www.microsoft.com/download/details.aspx?id=50402) or [SQL Server 2012 Feature Pack (scroll to Native Client)](https://www.microsoft.com/download/details.aspx?id=29065)
- [ODBC Driver 18 for SQL Server](/sql/connect/odbc/download-odbc-driver-for-sql-server)

#### Troubleshooting blocking checks that frequently recur

The following issues are known to frequently cause failures in the prerequisite checks. It's not possible to bypass these checks. Therefore, you have to resolve the blocking condition. If you're not sure how to resolve an issue, consider contacting Microsoft Support.

##### Site system server runs on Windows Server 2012 or 2012 R2

You see the following message in the console:

> **Windows Server 2012 and 2012 R2 lifecycle**
> Support for Windows Server 2012 and 2012 R2 ends on October 9, 2023. Plan to upgrade your site servers to a supported operating system. For more information, see [New options for SQL Server 2012 and Windows Server 2012 end of support](https://go.microsoft.com/fwlink/?linkid=2186091).

This message means that the Prerequisite checker detects a site server or a site system server that runs on Windows Server 2012 or 2012 R2. The check failed, and you can't install the update.

> [!NOTE]  
> This check doesn't apply to secondary site remote roles, and temporarily doesn't apply to Distribution Points (DPs). If the prerequisite check finds a DP that's running on Windows Server 2012 or Windows Server 2012 R2, you receive a warning, but the check doesn't fail.

If you recently performed an in-place upgrade to Windows Server on a remote site system, restart the affected computer or its SMS_Executive service. The restart makes sure that the Prerequisite checker correctly detects the new operating system version.

##### Deprecated features: Resource access profiles or the certificate registration point role

Resource access profiles and their related features and deployments are deprecated. If Prerequisite checker detects any of these features, it blocks the update. It also blocks the update if it detects any existing co-managed device that has an RA Profile workload that's set toward Configuration Manager.

To pass the check, follow the official guidance in [Co-management workloads](/intune/configmgr/comanage/workloads) to move the **Resource Access Policies workload** slider to **Intune only**. If co-management isn't configured, you have to configure it at least temporarily to be able to move the slider.

This check might also fail if it detects the Certificate Registration Point role. In the console, go to **Administration** > **Overview** > **Site Configuration** > **Servers and Site System Roles**, select the site system that hosts the CRP role, and remove the role.

##### Deprecated features: Cloud Management Gateway (CMG) as a classic cloud service

In the console, you see the following message:

> The option to deploy a cloud management gateway (CMG) as a cloud service (classic) is deprecated. All CMG deployments should use a virtual machine scale set. For more information, see [Process to convert a CMG to a virtual machine scale set](https://go.microsoft.com/fwlink/?linkid=2187166).

Cloud Management Gateway deployed as a classic cloud service is deprecated. If Prerequisite checker detects this configuration, it blocks the update. Prerequisite checker applies the following rule:

> Check for a cloud management gateway (CMG) as a cloud service (classic)

To resolve this issue, follow the official guidance for [moving to CMGv2](/intune/configmgr/core/clients/manage/cmg/modify-cloud-management-gateway#convert).

##### Only enhanced HTTP or HTTPS communication is allowed

In the console, you see the following message:

> HTTPS or Enhanced HTTP are not enabled for client communication. HTTP-only communication is deprecated, and support is removed in this version of Configuration Manager.
>
> To proceed with the upgrade, enable a more secure communication method for the site by enabling either HTTPS or Enhanced HTTP. For more information, see https://go.microsoft.com/fwlink/?linkid=2155007.

Currently, Configuration Manager sites support only Enhanced HTTP or HTTPS for communication. Other options that were supported previously were deprecated in Configuration Manager version 2409 and later versions. 

To resolve this issue, switch the Site Communication to Enhanced HTTP or HTTPS. For official guidance, see [Enable the site for HTTPS-only or enhanced HTTP](/intune/configmgr/core/servers/deploy/install/list-of-prerequisite-checks#enable-site-system-roles-for-https-or-enhanced-http).

## Investigate the Installation stage

Unlike most of the other stages, the Installation stage can start manually. When you select an update in the console and then select **Install Update** (and if applicable, you ignore any warning that appears), the actual site update starts. To make sure that the site is ready for the update, Configuration Manager always reruns the [Prerequisite checks](#investigate-the-prerequisite-check-stage). If the checks fail, the update stops.  
<br/>
<details><Summary>Select here to see the Installation steps.</summary>

### Process step 1: CMUpdate checks the readiness of the site server

After the deployment passes the prerequisite checks, CMUpdate assesses the readiness of the sites and the configured Service Windows. CMUpdate logs entries that resemble the following example:

```output
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xd0007, IsComplete=1, Progress=1, Applicable=1)
INFO: Waiting for CONFIGURATION_MANAGER_SERVICE to be ready to apply update: 3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E
```

CMUpdate upgrades itself to the new version, and logs entries that resemble the following example:

```output
CONFIGURATION_MANAGER_UPDATE service is stopping...
...
CONFIGURATION_MANAGER_UPDATE service is starting...
Microsoft Microsoft Configuration Manager v5.00 (Build 9132)
```

CMUpdate looks for the service window that's configured for the site, and logs entries that resemble the following example:

```output
There is no service window defined for the site server to apply the CM server updates.
```

### Process step 2: CMUpdate verifies the state of the update and redist content

CMUpdate verifies that the CMUStaging content is intact, and then reads the Update.map file. It logs entries that resemble the following example:

```output
Checking if the CMU Staging folder already has the content extracted.
Creating hash for algorithm 32780
Staging folder has hash = 6C3C912C1C79E3958A0D8EE7F306470A87058E5DC6936F3438BF812D367F976F
Content is already found at the staging folder
...
Successfully read file \\?\E:\ConfigMgr\CMUStaging\3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E\SMSSetup\update.map
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xd0005, IsComplete=2, Progress=100, Applicable=1)
```

CMUpdate processes the redists, and creates an in-memory list of files to be copied. It logs entries that resemble the following example:

```output
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xd0006, IsComplete=1, Progress=1, Applicable=1)
Found redist manifest E:\ConfigMgr\CMUStaging\3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E\redist\ConfigMgr.Manifest.cab and set redist folder to E:\ConfigMgr\CMUStaging\3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E\redist.
INFO: Extracted file C:\Windows\TEMP\ConfigMgr.Manifest.xml
INFO: Processing file group "Dot_Net_Framework"
INFO: Processing file "NDP462-KB3151800-x86-x64-AllOS-ENU.exe"
INFO: File will be downloaded from https://go.microsoft.com/fwlink/?LinkID=2171070.
INFO: File for NDP462-KB3151800-x86-x64-AllOS-ENU.exe [.NET Framework Extended 4.6.2 RTM] will be copied with file name: NDP462-KB3151800-x86-x64-AllOS-ENU.exe.
...
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xd0006, IsComplete=2, Progress=100, Applicable=1)
```

### Process step 3: CMUpdate installs the update

At this point, the actual update starts. CMUpdate follows these steps:

1. Unpack and run the pre-upgrade SQL scripts from the \\CMUStaging\\\<Update GUID>\\redist\\ConfigMgr.AutoUpgradeScripts.cab folder.
1. Turn off SQL Server Service Broker.
1. Stop the Configuration Manager services.
1. Unload the WMI providers.
1. Delete the SMSDBMON triggers.
1. Save the site control settings.
1. Update the Configuration Manager database.
1. Update the SQL registry entries.
1. Update the RCM registry entries.
1. Install files, language packs, components, and controls.
1. Update the site control settings.
1. Configure SQL Server Service Broker.
1. Start WMI, and then install services.
1. Update the site table.
1. Update the Admin console binaries.
1. Turn on SQL Server Service Broker.

During this process, CMUpdate also copies the redists from the \\CMUStaging\\\<Update GUID>\\redist` folder. CMUpdate uses the copied files to replace 0-byte placeholder files in the \\CMUStaging\\\<Update GUID>\\SMSSetup\\\* folders.

CMUpdate logs entries that resemble the following example:

```output
INFO: Checking media: E:\ConfigMgr\CMUStaging\3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E\SMSSetup\bin\x64\NDP462-KB3151800-X86-X64-ALLOS-ENU.EXE
INFO: Verifying hash for file 'E:\ConfigMgr\CMUStaging\3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E\SMSSetup\bin\x64\NDP462-KB3151800-X86-X64-ALLOS-ENU.EXE'
Expected hash:B4CBB4BC9A3983EC3BE9F80447E0D619D15256A9CE66FF414AE6E3856705E237, Actual hash:E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855
WARNING: File hash mismatch for E:\ConfigMgr\CMUStaging\3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E\SMSSetup\bin\x64\NDP462-KB3151800-X86-X64-ALLOS-ENU.EXE
INFO: Checking alternate path: E:\ConfigMgr\CMUStaging\3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E\redist\NDP462-KB3151800-X86-X64-ALLOS-ENU.EXE
INFO: Verifying hash for file 'E:\ConfigMgr\CMUStaging\3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E\redist\NDP462-KB3151800-X86-X64-ALLOS-ENU.EXE'
INFO: Verifying signature for file 'E:\ConfigMgr\CMUStaging\3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E\redist\NDP462-KB3151800-X86-X64-ALLOS-ENU.EXE'
INFO: Found valid source in folder: 'E:\ConfigMgr\CMUStaging\3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E\redist\'
INFO: Found valid source for external dependency file 'NDP462-KB3151800-X86-X64-ALLOS-ENU.EXE' at 'E:\ConfigMgr\CMUStaging\3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E\redist\'
This file E:\ConfigMgr\CMUStaging\3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E\redist\NDP462-KB3151800-X86-X64-ALLOS-ENU.EXE will be copied from redist.
e:\configmgr\bin\x64\ndp462-kb3151800-x86-x64-allos-enu.exe file version is up to date (4.6.1590.0).
same version detected, and this file is flagged to compare signing timestamp.
Per digital signature signing time E:\ConfigMgr\CMUStaging\3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E\redist\NDP462-KB3151800-X86-X64-ALLOS-ENU.EXE file version is up to date per signing timestamp.
File E:\ConfigMgr\CMUStaging\3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E\redist\NDP462-KB3151800-X86-X64-ALLOS-ENU.EXE has newer modification time than (e:\configmgr\bin\x64\ndp462-kb3151800-x86-x64-allos-enu.exe) but they have the same hash. It will be skipped.
```

### Process step 4: CMUpdate updates the OSD packages

After CMUpdate installs the files, it updates the OSD packages, and logs entries that resemble the following example:

```output
INFO: Adding default USMT package ...
INFO: USMT package path is C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\User State Migration Tool
INFO: Adding Boot Image Packages, this may take some time...
INFO: Attempting to export x86 boot image from ADK installation source
INFO: Attempting to export x64 boot image from ADK installation source
INFO: Attempting to export arm64 boot image from ADK installation source
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xd001a, IsComplete=3, Progress=100, Applicable=1)
```

Then, CMUpdate asynchronously waits for multiple processes (including SiteComp) to finish. It logs entries that resemble the following example:

```output
~   Starting ConfigMgr Update post installation monitor thread...
```

You can review other entries regarding component reinstallation in the SiteComp.log file.

### Process step 5: CMUpdate updates CD.Latest

CMUpdate updates the CD.Latest file to reflect the new version of Configuration Manager. It logs entries that resemble the following example:

```output
Creating cd backup location at E:\ConfigMgr\cd.latest
Copying contents of update package from E:\ConfigMgr\CMUStaging\3B7D84FA-ECCC-4EA0-B8AB-ABBDA1E88E0E to E:\ConfigMgr\cd.latest
...
successfully updated setup registry to have new external files stored at E:\ConfigMgr\cd.latest\redist
```

Finally, CMUpdate creates a notification file for HMAN that's named 196612.esc, and then starts the post-installation tasks. It logs entries that resemble the following example:

```output
INFO: Successfully dropped update pack installed notification to HMAN CFD box.
```

### Process step 6: Post installation tasks

CMUpdate performs the following post-installation tasks:

1. Verify that the SMS_Executive service is installed.
1. Verify that the SMSDBMon component is installed.
1. Verify that the HMAN component is installed.
1. Verify that the RCM component is installed.
1. Monitor the start of replication.
1. Update the Configuration Manager client preproduction package.
1. Update the client folder on the site server.

HMAN performs the following post-installation tasks:

1. Update the Configuration Manager client package.
1. Turn on features that are specified in the upgrade or update wizard. Then, reopen the console to display the features.

> [!NOTE]
>
> - Update.map contains the list of updates and files to be replaced and added. To review the list of files, open Update.map in Notepad.
> - Install.map contains the list of steps that the installation process runs. It serves as a workflow for CMUpdate.exe that provides the steps and parameters to run in order.
> - For minor updates, check CMUpdate.log for details.

HMAN logs entries that resemble the following example:

```output
INFO: 196612.ESC file was found. Updating client packages. InteropMode = 0
WARN: The current update package's state (196611) is not set to installed yet. Will retry in next cycle.
...
INFO: 196612.ESC file was found. Updating client packages. InteropMode = 0
Loaded client upgrade settings from DB successfully. FullClientPackageID=CS100004, StagingClientPackageID=CS100008, ClientUpgradePackageID=CS100005, PilotingUpgradePackageID=CS100009, ClientUpgradeAdvertisementID=CS120000, ClientPilotingAdvertisementID=(null)
Client piloting is not enabled.
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xe0007, IsComplete=1, Progress=1, Applicable=1)
~Directory \\?\E:\ConfigMgr\StagingClient\i386 exists
Copying ccmsetup from 'E:\ConfigMgr\CMUClient\CcmSetup.exe' to 'E:\ConfigMgr\PilotingUpgrade\CcmSetup.exe'...
...
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xe0007, IsComplete=2, Progress=100, Applicable=1)
...
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xe0009, IsComplete=1, Progress=1, Applicable=1)
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xe0008, IsComplete=1, Progress=1, Applicable=1)
Copying client binaries from 'E:\ConfigMgr\CMUClient' to 'E:\ConfigMgr\Client'...
Copying ccmsetup from 'E:\ConfigMgr\CMUClient\ccmsetup.exe' to 'E:\ConfigMgr\ClientUpgrade\ccmsetup.exe'...
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xe0009, IsComplete=2, Progress=100, Applicable=1)
Successfully reported ConfigMgr update status (SiteCode=CS1, SubStageID=0xe0008, IsComplete=2, Progress=100, Applicable=1)
```

</details>

### Results of the Installation stage

The console labels the update package as **Installed**. In the `CM_UpdatePackages` table, the state value for the update package is `196612`.

> [!NOTE]  
> Because of the Applicability checks, the console typically hides older update packages.

### Troubleshoot the Installation stage

To review the status of the Installation stage, in the console, go to **Administration** > **Overview** > **Updates and Servicing**. Alternatively, you can use the following SQL query to fetch update package states for each a site:

```sql
-- Use Update GUID parameter for monitoring status query
DECLARE @UpdateGUID UNIQUEIDENTIFIER = '<PACKAGE GUID>';

select ServerData.SiteCode, cmupss.* from CM_UpdatePackageSiteStatus cmupss
Left join serverdata on cmupss.SiteNumber=ServerData.ID
where cmupss.PackageGUID = @UpdateGUID and cmupss.state<>196612
```

If the Installation stage is stuck in the **Installing** state or fails completely, go to **Monitoring** > **Overview** > **Updates and Servicing Status** to review the update package state. You should be able to identify the site that has an issue.

Use the following flow chart to help identify the issue.

:::image type="content" source="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-installation-stage.png" alt-text="Diagram of a decision tree to isolate an issue that might occur during the Installation stage." lightbox="./media/understand-troubleshoot-updates-servicing/cm-updates-and-servicing-installation-stage-expanded.png":::

The following issues can cause an update package to appear to be stuck during the Installation stage:

- Installation is actually progressing. To review the current progress, see the CMUpdate.log file.
- The update content didn't finish replicating, or didn't replicate correctly. For assistance, see [Troubleshoot the Replication stage](#troubleshoot-the-replication-stage) earlier in this article.
- One of the sites is waiting for a service window. Make sure that the service window exists and is configured correctly.
- CMUpdate stopped. Therefore, the installation process can't continue.
- The update package content can't replicate between the CAS and the primary sites because of a Database Replication Service (DRS) issue.

Failures can occur at any step of the Installation stage. CMUpdate.log is the primary log to use for investigating installation issues. However, if the failure occurs at any of the post-installation steps, review the SiteComp.log file for information about component reinstallations and the SMSExec.log file for information about component startup.

#### Case studies of Installation stage issues

##### Issue 1: "Error in verifying the trust of file \\\\?\...\CMUStaging\79FB5420-BB10-44FF-81BA-7BB53D4EE22F\SMSSetup\update.map.cab"

In CMUpdate.log, you find an error entry that resembles the following example:

```output
update package content 79FB5420-BB10-44FF-81BA-7BB53D4EE22F has been expanded to folder \\?\...\CMUStaging\79FB5420-BB10-44FF-81BA-7BB53D4EE22F\
Error in verifying the trust of file \\?\...\CMUStaging\79FB5420-BB10-44FF-81BA-7BB53D4EE22F\SMSSetup\update.map.cab.
```

This issue occurs because the files aren't downloaded correctly. To fix this issue, follow these steps:

1. Verify the contents of EasySetupPayload folder: both Payload and Redists should have valid signatures. If it's necessary, switch the SCP to Offline mode.
1. Run the RetryContentReplication WMI method. This method forces the Easy Setup Package to update. Wait for replication to finish.
1. Try again to install the update.

##### Issue 2: Update installs on the CAS and primary sites, but console still displays "Installing"

A specific global replication group, **CMUpdates**, replicates the installation completion information one time per minute. If the replication process isn't working correctly, the console continues to display **Installing** even if the update installed successfully on all sites.

In the console, go to **Monitoring** > **Overview** > **Database Replication**. For each link for the **CMUpdates** replication group states, review the **Initialization** and **Replication** tabs. If you find an issue, see [Troubleshoot database replication service issues in Configuration Manager](../data-transfer-sites/troubleshoot-database-replication-service-issues.md) for help.

##### Issue 3: CONFIGURATION_MANAGER_UPDATE service keeps restarting

The CMUpdate process is the main driver of update package installation. It hosts the CONFIGURATION_MANAGER_UPDATE service. If CMUpdate fails, the installation stops responding at a specific stage, and CMUpdate.log might repeatedly record the same activity. To investigate this issue, open Event Viewer, and review the Windows Application log for Event ID 1000 (Process crash).

Security software can also cause this behavior by preventing the updated CMUpdate binary from running, or by stopping the process. To investigate this issue, turn off the security software, and then try again to update. If the issue persists, use the [ProcDump](/sysinternals/downloads/procdump) tool to collect a process memory dump file. Download and unpack the tool, and then run the following command at a command prompt:

```console
procdump -ma -e cmupdate.exe
```

Create a support ticket, attach the dump file, and then submit it to Microsoft Support.

##### Issue 4: CMUpdate doesn't update the database objects

If this issue occurs, look for the following typical causes:

- Third-party objects in the Configuration Manager SQL Server database. Remove the third-party objects, and then install the update again.
- Third-party software that accesses the Configuration Manager SQL Server database, and locks first-party database objects. For example, an external Configuration Manager database might behave in this manner. Make sure that other software doesn't lock database objects while CMUpdate works in the database.

## Reference

### Relevant folders for installing Configuration Manager updates

| Folder | Location | Description |
|--------|---|-------------|
| \EasySetupPayload | SCP |  This shared folder contains the actual installation files for an update. There's no Setup.exe file. Instead, an Install.map file is used for installing. |
| \CMUStaging | Site server | This folder contains unpacked Configuration Manager manifest CAB file that HMAN downloaded and extracted to perform applicability checks. The installation files are temporarily stored in this folder while the update installs. |
| \CMUClient | Site server | This folder contains the latest client installation files. The files are copied directly from the EasySetupPayload folder. |
| \PilotingUpgrade | Site server | This folder contains the source content for the Client Piloting Package. |
| \ClientUpgrade | Site server | This folder contains the source content for the Client Upgrade Package. |
| \cd.latest | Site server | This folder contains the latest version of the Configuration Manager client installation files. |

### State codes and flags for update packages

The following table lists the state codes and the states that they represent.

| State | Value |
|---|---|
| UNKNOWN | 0 |
| ENABLED | 2 |
| DOWNLOAD_IN_PROGRESS | 262145 |
| DOWNLOAD_SUCCESS | 262146 |
| DOWNLOAD_FAILED | 327679 |
| APPLICABILITY_CHECKING | 327681 |
| APPLICABILITY_SUCCESS | 327682 |
| APPLICABILITY_HIDE | 393213 |
| APPLICABILITY_NA | 393214 |
| APPLICABILITY_FAILED | 393215 |
| CONTENT_REPLICATING | 65537 |
| CONTENT_REPLICATION_SUCCESS | 65538 |
| CONTENT_REPLICATION_FAILED | 131071 |
| PREREQ_IN_PROGRESS | 131073 |
| PREREQ_SUCCESS | 131074 |
| PREREQ_WARNING | 131075 |
| PREREQ_ERROR | 196607 |
| INSTALL_IN_PROGRESS | 196609 |
| INSTALL_WAITING_SERVICE_WINDOW | 196610 |
| INSTALL_WAITING_PARENT | 196611 |
| INSTALL_SUCCESS | 196612 |
| INSTALL_PENDING_REBOOT | 196613 |
| INSTALL_FAILED | 262143 |
| INSTALL_CMU_VALIDATING | 196614 |
| INSTALL_CMU_STOPPED | 196615 |
| INSTALL_CMU_INSTALLFILES | 196616 |
| INSTALL_CMU_STARTED | 196617 |
| INSTALL_CMU_SUCCESS | 196618 |
| INSTALL_WAITING_CMU | 196619 |
| INSTALL_CMU_FAILED | 262142 |
| INSTALL_INSTALLFILES | 196620 |
| INSTALL_UPGRADESITECTRLIMAGE | 196621 |
| INSTALL_CONFIGURESERVICEBROKER | 196622 |
| INSTALL_INSTALLSYSTEM | 196623 |
| INSTALL_CONSOLE | 196624 |
| INSTALL_INSTALLBASESERVICES | 196625 |
| INSTALL_UPDATE_SITES | 196626 |
| INSTALL_SSB_ACTIVATION_ON | 196627 |
| INSTALL_UPGRADEDATABASE | 196628 |
| INSTALL_UPDATEADMINCONSOLE | 196629 |

The following table lists the available flags.

| Flag | Value |
|--|--|
| Normal installation | 0 |
| Prerequisite check only | 1 |
| Ignore warnings | 2 |

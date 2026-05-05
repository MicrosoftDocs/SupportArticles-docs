---
title: Configuration Manager in-console update fails at the Install Files stage
description: Resolves an issue in which a Configuration Manager in-console update fails because redistributable files are missing from the EasySetupPayload or CMUStaging folders.

ms.date: 05/07/2026
ms.topic: troubleshooting
ms.reviewer: kaushika, iliaershov
ms.custom: sap:Configuration Manager Setup, High Availability, Migration and Recovery\Updates and Servicing
---

# Configuration Manager in-console update fails at the Install Files stage because required files are missing

_Original product version:_ Configuration Manager (current branch)

## Symptoms

When you install an in-console update package in Configuration Manager, the update fails at the **Install Files** stage. The CMUpdate.log file contains entries that resemble one of the following examples.

- Example 1:

  ```output
  ERROR: Failed to find folder that stores msi file SQLSysClrTypes.msi
  Failed to find SQLSysClrTypes.msi
  Failed to install SQLSysClrTypes.msi
  Failed to install SQL redist
  ```

- Example 2:

  ```output
  ERROR: File hash check failed: 0x80070002
  ERROR: VerifyExternalFile failed: 0x80070002
  ERROR: Failed to find valid source for required external file
  ERROR: Failed to find valid source for required file 'MMASetup-AMD64.exe'. Aborting setup.
  Setup has encountered fatal errors while performing file operations.
  Failed to install update files.
  ```

## Cause

This issue occurs because the update operation can't find required redistributable files (for example, SQLSysClrTypes.msi or MMASetup-AMD64.exe` in one or both of the following locations:

- Service connection point source content (EasySetupPayload folder):
  - Location for online mode: \\\\*ServiceConnectionPoint*\\EasySetupPayload\\*PackageGuid*\\Redists
  - Location for offline mode: \\\\*ServiceConnectionPoint*\\EasySetupPayload\\Offline\\*PackageGuid*\Redists
- Site server staging content (CMUStaging folder):
  - *ConfigMgrInstallPath*\\CMUStaging\\PackageGuid\\redist

## Resolution

The steps to resolve this issue depend on which folder is missing files (or if files are missing from both folders). To identify the affected folder or folders, follow these steps:

1. Identify the update package GUID.
1. Verify whether the required files exist in the EasySetupPayload folder, in either the online mode or offline mode locations.
1. Verify whether the required files exist in the CMUStaging folder.

After continue to the scenario that matches your findings:

- [Scenario 1: Files are missing in the EasySetupPayload folder](#scenario-1-files-are-missing-in-the-easysetuppayload-folder)
- [Scenario 2: Files are present in the EasySetupPayload folder but missing in the CMUStaging folder](#scenario-2-files-are-present-in-the-easysetuppayload-folder-but-missing-in-the-cmustaging-folder)

### Scenario 1: Files are missing in the EasySetupPayload folder

If files are missing in the EasySetupPayload folder, restore the update payload source first.

#### Restore the update payload for an online service connection point (SCP)

For an online SCP, follow these steps:

1. Verify that the SCP can connect to the internet and to the required endpoint.

1. Try again to download the package from the console. You can download the package manually, or follow these steps to use the [Update reset tool (CMUpdateReset.exe)](/intune/configmgr/core/servers/manage/update-reset-tool).

   > [!NOTE]  
   > Because the update already passed the replication phase, you typically have to change the update state before you can use the Update reset tool.

   1. On a server that hosts the SMS Provider, open a Windows PowerShell Command Prompt window and then run the following cmdlets:

   ```powershell
   $CMUpdateGUID = '<PackageGuid>' # e.g.: 94727833-903B-49EF-9CF7-A43D2BC8826D
   $Flag = 1
   $DesireState = 0x0004FFFF #DOWNLOAD_FAILED
   $CMUpdatePackage = Get-WmiObject -Namespace "root\SMS\site_<SiteCode>" -Class SMS_CM_UpdatePackages -Filter ("PackageGuid = '$($CMUpdateGUID)'")
   Invoke-WmiMethod -InputObject $CMUpdatePackage -Name UpdatePrereqAndStateFlags -ArgumentList @($Flag,[convert]::ToInt32('{0:x}' -f $DesiredState, 16)) | Out-Null
   ```

   > [!NOTE]  
   > In these cmdlets, \<PackageGuid> represents the GUID of the update package file, and \<SiteCode> is the identifier of the site to be updated.

   The update status should now be "Download failed."

   1. Download the update by using the Update reset tool tool.

1. Review the following log files:

   - **dmpdownloader.log**. Look for entries that were recorded during the download attempt that resemble the following examples:

   ```output
   Check if there is redist to download for update, aa928926-5c76-4de0-b51f-0fe4d365dfe2~~
   Download redist for update aa928926-5c76-4de0-b51f-0fe4d365dfe2~~
   Successfully download redist for aa928926-5c76-4de0-b51f-0fe4d365dfe2~~
   ```

   - **ConfigMgrSetup.log**. Look for entries that indicate that the file hash was calculated successfully, such as the following example:

   ```output
   INFO: Downloading https://go.microsoft.com/fwlink/?LinkId=2115685 as SQLSysClrTypes.msi
   INFO: set additional flag.
   No proxy information is specified. Connect without proxy.
   INFO: WinHttpQueryHeaders() in Download() returned OK (200)
   INFO: Verifying hash for file 'E:\ServiceConnectionTool\Update\248DC1EB-4B98-4483-BAF3-08C678C1CD0A\Redist\SQLSysClrTypes.msi'
   4580 (0x11e4)    INFO: Verifying signature for file 'E:\ServiceConnectionTool\Update\248DC1EB-4B98-4483-BAF3-08C678C1CD0A\Redist\SQLSysClrTypes.msi'
   ```

After the download operation finishes, verify that the required files are present in the EasySetupPayload\\*PackageGuid*\\Redists folder. At this point, try again to install the in-console update package.

#### Restore the update payload for an offline SCP

For an offline SCP, use the [service connection tool](/intune/configmgr/core/servers/manage/use-the-service-connection-tool) to download and import the update files again. 

> [!NOTE]
> In service connection tool version 2509 or later, if the tool can't download the required redistributable files, the operation fails at the **Connect** step.

While the tool runs, review the ServiceConnectionTool.log and ConfigMgrSetup.log files to verify the required files download successfully.

- **ServiceConnectionTool.log**. Look for entries that resemble the following examples:

  ```output
  INFO:ConfigMgr.Update.Manifest.cab (size = 15741046) downloaded successfully
  INFO:Downloading Payload 248DC1EB-4B98-4483-BAF3-08C678C1CD0A version 5.0.9058.1000. More information: https://go.microsoft.com/fwlink/?LinkId=2166085
  INFO:Downloaded Payload 248DC1EB-4B98-4483-BAF3-08C678C1CD0A size = 967280807
  INFO:Downloading Redists for 248DC1EB-4B98-4483-BAF3-08C678C1CD0A
  INFO:Successfully downloaded Redists for 248DC1EB-4B98-4483-BAF3-08C678C1CD0A
  ```

- **ConfigMgrSetup.log**. Look for entries that resemble the following examples:

  ```output
  INFO: Downloading https://go.microsoft.com/fwlink/?LinkId=2115685 as SQLSysClrTypes.msi
  INFO: set additional flag.
  No proxy information is specified. Connect without proxy.
  INFO: WinHttpQueryHeaders() in Download() returned OK (200)
  INFO: Verifying hash for file 'E:\ServiceConnectionTool\Update\248DC1EB-4B98-4483-BAF3-08C678C1CD0A\Redist\SQLSysClrTypes.msi'
  4580 (0x11e4)    INFO: Verifying signature for file 'E:\ServiceConnectionTool\Update\248DC1EB-4B98-4483-BAF3-08C678C1CD0A\Redist\SQLSysClrTypes.msi'
  ```

After the download operation finishes, verify that the required files are present in the EasySetupPayload\\Offline\\**PackageGuid**\\Redists folder. At this point, try again to install the in-console update package.

### Scenario 2: Files are present in the EasySetupPayload folder but missing in the CMUStaging folder

If files exist in the EasySetupPayload folder but are missing in the CMUStaging folder, you have to replicate the update content again. To retrigger the update content replication process, on a server that hosts the SMS Provider role for the top-level site, open a PowerShell command prompt. Then run the following cmdlet:

```powershell
(Get-WmiObject -Namespace "ROOT\SMS\site_<SiteCode>" -Query "select * from SMS_CM_UpdatePackages where PackageGuid = '<PackageGuid>'").RetryContentReplication($true)
```

> [!NOTE]  
> In these cmdlets, \<PackageGuid> represents the GUID of the update package file, and \<SiteCode> is the identifier of the site to be updated.

After the replication process finishes, try again to install the in-console update package.

## More information

For end-to-end information about the update workflow and extra troubleshooting guidance, see [Understand and troubleshoot Updates and Servicing in Configuration Manager](understand-troubleshoot-updates-servicing.md).

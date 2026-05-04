---
title: Configuration Manager in-console update fails at the Install Files stage
description: Resolves an issue in which a Configuration Manager in-console update fails because redistributable files are missing from EasySetupPayload or CMUStaging.
author: ErshovIS
ms.author: iliaershov
ms.date: 04/21/2026
ms.topic: troubleshooting
---

# Configuration Manager in-console update fails at the Install Files stage because required files are missing

_Original product version:_ Configuration Manager (current branch)

## Symptoms

When you install an in-console update package in Configuration Manager, the update fails at the **Install Files** stage.

`CMUpdate.log` contains errors that resemble one of the following examples.

```output
ERROR: Failed to find folder that stores msi file SQLSysClrTypes.msi
Failed to find SQLSysClrTypes.msi
Failed to install SQLSysClrTypes.msi
Failed to install SQL redist
```

```output
ERROR: File hash check failed: 0x80070002
ERROR: VerifyExternalFile failed: 0x80070002
ERROR: Failed to find valid source for required external file
ERROR: Failed to find valid source for required file 'MMASetup-AMD64.exe'. Aborting setup.
Setup has encountered fatal errors while performing file operations.
Failed to install update files.
```

## Cause

The update can't find required redistributable files (for example, `SQLSysClrTypes.msi` or `MMASetup-AMD64.exe`) in one or both of these locations:

- Service connection point source content (`EasySetupPayload`):
  - `\\<ServiceConnectionPoint>\EasySetupPayload\<PackageGuid>\Redists` (online mode)
  - `\\<ServiceConnectionPoint>\EasySetupPayload\Offline\<PackageGuid>\Redists` (offline mode)
- Site server staging content (`CMUStaging`):
  - `<ConfigMgrInstallPath>\CMUStaging\<PackageGuid>\redist`

## Resolution

Use the following workflow to validate the file locations and determine the appropriate scenario.

1. Identify the update package GUID.
1. Verify whether the required files exist under `\EasySetupPayload`.
1. Verify whether the same files exist under `\CMUStaging`.

After completing these checks, proceed with the scenario that matches your findings.

### Scenario 1: Files are missing in EasySetupPayload

If files are missing in `\EasySetupPayload`, restore the update payload source first.

- For an online service connection point, verify internet connectivity and required endpoint access, then retry the download from the console. If the update is already in the post-replication phase, you typically can’t use [CMUpdateReset](/intune/configmgr/core/servers/manage/update-reset-tool) to remove it and restart the download. Instead, change the update state using the [UpdatePrereqAndStateFlags](/intune/configmgr/develop/reference/sum/updateprereqandstateflags-method-in-class-sms_cm_updatepackages) WMI method. Run the following PowerShell on a server that hosts the SMS Provider (replace `<SiteCode>` and `<PackageGuid>`):

```powershell
$CMUpdateGUID = '<PackageGuid>' # e.g.: 94727833-903B-49EF-9CF7-A43D2BC8826D
$Flag = 1
$DesireState = 0x0004FFFF #DOWNLOAD_FAILED
$CMUpdatePackage = Get-WmiObject -Namespace "root\SMS\site_<SiteCode>" -Class SMS_CM_UpdatePackages -Filter ("PackageGuid = '$($CMUpdateGUID)'")
Invoke-WmiMethod -InputObject $CMUpdatePackage -Name UpdatePrereqAndStateFlags -ArgumentList @($Flag,[convert]::ToInt32('{0:x}' -f $DesiredState, 16)) | Out-Null
```

The update status should now show Download failed. From here, either run [CMUpdateReset](/intune/configmgr/core/servers/manage/update-reset-tool) to remove the update and restart the download/installation, or redownload the package.

Check `dmpdownloader.log` and look for the following lines during download attempt:

```output
Check if there is redist to download for update, aa928926-5c76-4de0-b51f-0fe4d365dfe2~~
Download redist for update aa928926-5c76-4de0-b51f-0fe4d365dfe2~~
Successfully download redist for aa928926-5c76-4de0-b51f-0fe4d365dfe2~~
```

Also make sure that file hash was calculated successfully in `ConfigMgrSetup.log`:

```output
INFO: Downloading https://go.microsoft.com/fwlink/?LinkId=2115685 as SQLSysClrTypes.msi
INFO: set additional flag.
No proxy information is specified. Connect without proxy.
INFO: WinHttpQueryHeaders() in Download() returned OK (200)
INFO: Verifying hash for file 'E:\ServiceConnectionTool\Update\248DC1EB-4B98-4483-BAF3-08C678C1CD0A\Redist\SQLSysClrTypes.msi'
4580 (0x11e4)    INFO: Verifying signature for file 'E:\ServiceConnectionTool\Update\248DC1EB-4B98-4483-BAF3-08C678C1CD0A\Redist\SQLSysClrTypes.msi'
```

- For an offline service connection point, use the [Service Connection Tool](/intune/configmgr/core/servers/manage/use-the-service-connection-tool) to download and import the update files again. While it runs, review `ServiceConnectionTool.log` and `ConfigMgrSetup.log` to verify the required files download successfully.

`ServiceConnectionTool.log`

```output
INFO:ConfigMgr.Update.Manifest.cab (size = 15741046) downloaded successfully
INFO:Downloading Payload 248DC1EB-4B98-4483-BAF3-08C678C1CD0A version 5.0.9058.1000. More information: https://go.microsoft.com/fwlink/?LinkId=2166085
INFO:Downloaded Payload 248DC1EB-4B98-4483-BAF3-08C678C1CD0A size = 967280807
INFO:Downloading Redists for 248DC1EB-4B98-4483-BAF3-08C678C1CD0A
INFO:Successfully downloaded Redists for 248DC1EB-4B98-4483-BAF3-08C678C1CD0A
```

`ConfigMgrSetup.log`

```output
INFO: Downloading https://go.microsoft.com/fwlink/?LinkId=2115685 as SQLSysClrTypes.msi
INFO: set additional flag.
No proxy information is specified. Connect without proxy.
INFO: WinHttpQueryHeaders() in Download() returned OK (200)
INFO: Verifying hash for file 'E:\ServiceConnectionTool\Update\248DC1EB-4B98-4483-BAF3-08C678C1CD0A\Redist\SQLSysClrTypes.msi'
4580 (0x11e4)    INFO: Verifying signature for file 'E:\ServiceConnectionTool\Update\248DC1EB-4B98-4483-BAF3-08C678C1CD0A\Redist\SQLSysClrTypes.msi'
```

After rerunning the download or import, verify that the required files are present in `\EasySetupPayload\<PackageGuid>\Redists`.

> [!NOTE]
> In Service Connection Tool version 2509 or later, the **Connect** step fails if necessary redistributable files can't be downloaded.

### Scenario 2: Files are present in EasySetupPayload but missing in CMUStaging

If files exist in `\EasySetupPayload` but are missing in `\CMUStaging`, retrigger update content replication.

Run the following command on the server that hosts the SMS Provider role for the top-level site. Replace `<SiteCode>` and `<PackageGuid>`.

```powershell
(Get-WmiObject -Namespace "ROOT\SMS\site_<SiteCode>" -Query "select * from SMS_CM_UpdatePackages where PackageGuid = '<PackageGuid>'").RetryContentReplication($true)
```

Then retry the in-console update package installation.

## More information

For end-to-end update workflow and extra troubleshooting guidance, see [Understand and troubleshoot Updates and Servicing in Configuration Manager](/troubleshoot/mem/configmgr/setup-migrate-backup-recovery/understand-troubleshoot-updates-servicing).

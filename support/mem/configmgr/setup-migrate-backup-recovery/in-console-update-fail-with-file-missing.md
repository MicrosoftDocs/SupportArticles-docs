---
title: onfiguration Manager in-console update fails with "Failed to find SQLSysClrTypes.msi" during update installation 
description: Resolves an issue where Configuration Manager in-console updates fail during SQL redistributable installation because required redist files are missing from the CMUStaging folder.
author: ErshovIS        # the author's GitHub ID - will be auto-populated if set in settings.json
ms.author: iliaershov      # the author's Microsoft alias (if applicable) - will be auto-populated if set in settings.json
ms.date: {@date}           # the date - will be auto-populated when template is first applied
ms.topic: troubleshooting  # the type of article
---

# Configuration Manager in-console update fails at "Install files" step

## Applies to

Microsoft Endpoint Configuration Manager (current branch)

## Symptoms

During ConfigMgr update installation, the following errors could be found in the *CMUpdate.log*:

> ERROR: Failed to find folder that stores msi file SQLSysClrTypes.msi  
> Failed to find SQLSysClrTypes.msi  
> Failed to install SQLSysClrTypes.msi  
> Failed to install SQL redist  

Or

> ERROR: File hash check failed: 0x80070002  
> ERROR: VerifyExternalFile failed: 0x80070002  
> ERROR: Failed to find valid source for required external file  
> ERROR: Failed to find valid source for required file 'MMASetup-AMD64.exe'. Aborting setup.  
> Setup has encountered fatal errors while performing file operations.  
> Failed to install update files.  

## Cause

Required files are missing from one of the following locations on the site server:
- *EasySetupPayload* - the original update payload downloaded from Microsoft (`<ConfigMgrInstallationPath>\EasySetupPayload\<PackageGuid>`)
- *CMUStaging* - the local staging folder where update files are prepared for installation (`<ConfigMgrInstallationPath>\CMStaging`)

## Resolution

Follow the steps based on where the files are missing.

### Scenario 1: Files missing in *EasySetupPayload*

If the files are missing in *EasySetupPayload*, the update payload must be redownloaded or reimported.

#### Online Service Connection Point (SCP)

The files are downloaded automatically.  
Retry the download by restarting the update installation after confirming internet connectivity.

#### Offline Service Connection Point (SCP)

Use the *Service Connection Tool* to download the required files on an internet-connected computer and import them into the site.

For detailed steps, see: https://learn.microsoft.com/en-us/intune/configmgr/core/servers/manage/use-the-service-connection-tool

After importing the files, verify that the missing files now exist under the appropriate *EasySetupPayload* subfolders.

### Scenario 2: Files missing in *CMStaging*

If the files exist in *EasySetupPayload* but are missing from *CMStaging*, retrigger content replication for the update package.

Run the following Windows PowerShell command on a computer that can access the SMS Provider (typically the site server). Replace `<SiteCode>` and `<PackageGuid>` as appropriate.

```powershell
(Get-WmiObject -Namespace "ROOT\SMS\site_<sitecode>" -Query "select * from SMS_CM_UpdatePackages where PackageGuid = '<packageguid>'").RetryContentReplication($true)
```

## More guidance

For a broader overview of how update packages are downloaded, staged, and installed and for other troubleshooting workflows see:
Understand and troubleshoot Updates and Servicing in Configuration Manager 
https://learn.microsoft.com/en-us/troubleshoot/mem/configmgr/setup-migrate-backup-recovery/understand-troubleshoot-updates-servicing

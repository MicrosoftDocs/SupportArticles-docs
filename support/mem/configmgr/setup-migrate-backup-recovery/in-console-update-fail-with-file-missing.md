---
title: onfiguration Manager in-console update fails with "Failed to find SQLSysClrTypes.msi" during update installation 
description: Resolves an issue where Configuration Manager in-console updates fail during SQL redistributable installation because required redist files are missing from the CMUStaging folder.
author: ErshovIS        # the author's GitHub ID - will be auto-populated if set in settings.json
ms.author: iliaershov      # the author's Microsoft alias (if applicable) - will be auto-populated if set in settings.json
ms.date: {@date}           # the date - will be auto-populated when template is first applied
ms.topic: troubleshooting  # the type of article
---

# Configuration Manager in-console update fails with "Failed to find SQLSysClrTypes.msi" or 0x80070002 during update installation

## Applies to
Microsoft Endpoint Configuration Manager (current branch)

## Symptoms
During ConfigMgr update installation, the following errors could be found in the `CMUpdate.log`:

```text
ERROR: Failed to find folder that stores msi file SQLSysClrTypes.msi
Failed to find SQLSysClrTypes.msi
Failed to install SQLSysClrTypes.msi
Failed to install SQL redist
```

Or

```text
ERROR: File hash check failed: 0x80070002
ERROR: VerifyExternalFile failed: 0x80070002
ERROR: Failed to find valid source for required external file 
ERROR: Failed to find valid source for required file 'MMASetup-AMD64.exe'. Aborting setup.
Setup has encountered fatal errors while performing file operations.
Failed to install update files.
```

## Cause
Required files (`SQLSysClrTypes.msi` or `MMASetup-AMD64.exe` are missing under `<ConfigMgrInstallationPath>\EasySetupPayload\<PackageGuid>\redist` (or `<ConfigMgrInstallationPath>\EasySetupPayload\<PackageGuid>\SMSSETUP\BIN\X64` accordingly)

## Resolution
Verify whether file is missing under `<ConfigMgrInstallationPath>\EasySetupPayload\<PackageGuid>\redist` (for `SQLSysClrTypes.msi`) or `<ConfigMgrInstallationPath>\EasySetupPayload\<PackageGuid>\SMSSETUP\BIN\X64` (for `MMASetup-AMD64.exe`)

Re-trigger replication of the update package content so that the required files are restored to the `CMUStaging` folder.
Run the following Windows PowerShell command on a computer that can access the SMS Provider (typically the site server). Replace `<SiteCode>` and `<PackageGuid>` as appropriate.

```powershell
(Get-WmiObject -Namespace "ROOT\SMS\site_<sitecode>" -Query "select * from SMS_CM_UpdatePackages where PackageGuid = '<packageguid>'").RetryContentReplication($true)
```

## Additional guidance
For a broader overview of how update packages are downloaded, staged, and installed—and for additional troubleshooting workflows see:
Understand and troubleshoot Updates and Servicing in Configuration Manager 
https://learn.microsoft.com/en-us/troubleshoot/mem/configmgr/setup-migrate-backup-recovery/understand-troubleshoot-updates-servicing

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

- For an online service connection point, retry the download from the console after you verify internet connectivity and endpoint access.
- For an offline service connection point, use the [Service Connection Tool](/intune/configmgr/core/servers/manage/use-the-service-connection-tool) to download and import the update files again.

After you rerun download or import, confirm that the required files exist under the appropriate `\EasySetupPayload\<PackageGuid>\Redists` folder.

> [!NOTE]
> In Service Connection Tool version 2509 or later, the **Connect** step fails if required redistributable files can't be downloaded.

### Scenario 2: Files are present in EasySetupPayload but missing in CMUStaging

If files exist in `\EasySetupPayload` but are missing in `\CMUStaging`, retrigger update content replication.

Run the following command on the server that hosts the SMS Provider role for the top-level site. Replace `<SiteCode>` and `<PackageGuid>`.

```powershell
(Get-WmiObject -Namespace "ROOT\SMS\site_<SiteCode>" -Query "select * from SMS_CM_UpdatePackages where PackageGuid = '<PackageGuid>'").RetryContentReplication($true)
```

Then retry the in-console update package installation.

## More information

For end-to-end update workflow and additional troubleshooting guidance, see [Understand and troubleshoot Updates and Servicing in Configuration Manager](/troubleshoot/mem/configmgr/setup-migrate-backup-recovery/understand-troubleshoot-updates-servicing).

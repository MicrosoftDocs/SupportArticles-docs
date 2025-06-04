---
title: Configuration Manager client left in provisioning mode after an upgrade to Windows 10
description: Describes an issue that causes the Configuration Manager client to be left in provisioning mode after an upgrade to Windows 10. Provides a resolution.
ms.date: 02/11/2025
ms.reviewer: kaushika, brianhun, mikecure, cmkbreview
ms.custom: sap:Client Operations\Other
---
# Configuration Manager client left in provisioning mode after upgrade to Windows 10

This article solves the issue that the Configuration Manager client is left in provisioning mode after performing an in-place upgrade to Windows 10.

_Original product version:_ &nbsp; Configuration Manager (current branch)
_Original KB number:_ &nbsp; 4021950

## Symptoms

When you use the **Upgrade an operating system from upgrade package** operating system task sequence to perform an in-place upgrade to Windows 10, the Configuration Manager client may be left in provisioning mode after the upgrade succeeds and the client restarts.

## Cause

This issue can occur when you specify an OEM product key for the operating system upgrade.

## Resolution

To fix this issue, only specify volume license or retail product keys for the operating system upgrade.

## More information

The task sequence depends on the execution of SetupComplete.cmd by Windows to take the Configuration Manager client out of provisioning mode. SetupComplete.cmd is disabled when you use OEM product keys. You can check the `C:\Windows\Panther\UnattendGC\Setupact.log` file to determine whether SetupComplete.cmd was executed or skipped.

To clear clients that are already stuck in provisioning mode, run the `SetClientProvisioningMode` method from an elevated command prompt:

```console
Powershell.exe Invoke-WmiMethod -Namespace root\CCM -Class SMS_Client -Name SetClientProvisioningMode -ArgumentList $false
```

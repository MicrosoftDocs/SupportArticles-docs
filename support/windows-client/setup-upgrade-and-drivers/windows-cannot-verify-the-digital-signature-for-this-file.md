---
title: Error (Windows cannot verify the digital signature for this file) occurs when you upgrade to Windows Storage Server 2016 or Windows Server 2016
description: Describes an issue in which an upgrade to Windows Storage Server 2016 or Windows Server 2016 fails at 95 percent completion.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jaysenb, delhan
ms.custom:
- sap:windows setup,upgrade and deployment\installing or upgrading windows
- pcy:WinComm Devices Deploy
---
# Error when you upgrade to Windows Storage Server 2016 or Windows Server 2016: Windows cannot verify the digital signature for this file

This article provides a workaround for an issue where an error (Windows cannot verify the digital signature for this file) occurs when you upgrade to Windows Storage Server 2016 or Windows Server 2016.

_Original KB number:_ &nbsp; 3193460

## Symptoms

When you try to upgrade the system to Windows Storage Server 2016 or Windows Server 2016, the process fails at 95 percent completion, and you receive the following error message:

> The following errors(s) occurred:  
Windows cannot verify the digital signature for this file. A recent hardware or software change might have installed a file that is signed incorrectly or damaged, or that might be malicious software form an unknown source An error occurred during automated setup. You must configure your nodes(s) manually.

This issue occurs if the following conditions are true:

- You upgrade Windows Storage Server 2012 R2 to Windows Storage Server 2016 or Windows Server 2012 R2 to Windows Server 2016.
- The original system has the OEM Appliance OOBE feature installed.

## Cause

This issue occurs because some OEM systems ship together with a custom out-of-box-experience (OOBE) update. This OOBE update is installed through Deployment Imaging and Management (DISM) and has a special rename operation that replaces the main OOBE feature. This replacement causes the digital signature error.

## Workaround

To work around this issue, use DISM to uninstall the OEM Appliance OOBE feature before you upgrade the system. To do this, run the following Dism.exe command:

```console
dism /online /disable-feature /featurename:OEM-Appliance-OOBE
```

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

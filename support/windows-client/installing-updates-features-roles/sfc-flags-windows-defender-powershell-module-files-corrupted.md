---
title: SFC flags Windows Defender PowerShell module files as corrupted
description: Describes an issue where System File Checker incorrectly flags Windows Defender PowerShell module files as corrupted.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-six
ms.custom: sap:Installing Windows Updates, Features, or Roles\Failure to install Windows Updates, csstroubleshoot
---
# System File Checker (SFC) incorrectly flags Windows Defender PowerShell module files as corrupted

This article describes an issue where System File Checker incorrectly flags Windows Defender PowerShell module files as corrupted.

_Applies to:_ &nbsp; Windows Client  
_Original KB number:_ &nbsp; 4513240

## Symptoms

The System File Checker (SFC) tool flags files that are located in the _%windir%\System32\WindowsPowerShell\v1.0\Modules\Defender_ folder as corrupted or damaged. When this issue occurs, you see error entries that resemble the following:

> Hashes for file member do not match.

## Cause

This is a known issue in Windows 10, version 1607 and later versions, and Windows Defender version 4.18.1906.3 and later versions up to version 4.8.1908.

The files for the Windows Defender PowerShell module that are located in _%windir%\System32\WindowsPowerShell\v1.0\Modules\Defender_ ship as part of the Windows image. These files are catalog-signed. However, the manageability component of Windows Defender has a new out-of-band (OOB) update channel. This channel replaces the original files with updated versions that are signed by using a Microsoft certificate that the Windows operating system trusts. Because of this change, SFC flags the updated files as "Hashes for file member do not match."

Future releases of Windows will use the updated files in the Windows image. After this change is implemented, SFC will no longer flag the files.

## Resolution

This issue is fixed in the version 4.8.1908 update of Windows Defender. After this update is applied, PowerShell files that are part of the Windows image are not changed, and the SFC tool no longer flags these files. Internet-connected computers that subscribe to the Windows Update channel automatically download and install this update.

To repair the Windows image files on computers that have been affected by this issue, use the DISM tool. To do this, open a Command Prompt window on the affected computer, and run the following commands:

```console
dism /online /cleanup-image /restorehealth
sfc /scannow
```

If these commands fail and generate an error message that resembles "File not found," make sure that the Install.wim file is accessible, and then run the following commands:

```console
DISM /Online /Cleanup-Image /RestoreHealth /Source:WIM:c:\install.wim:1 /LimitAccess
sfc /scannow
```

For more information about repair commands, see [Repair a Windows image](/windows-hardware/manufacture/desktop/repair-a-windows-image).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

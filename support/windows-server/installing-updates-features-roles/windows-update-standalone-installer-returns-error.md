---
title: Windows Update Standalone Installer (WUSA) returns 0x5 ERROR_ACCESS_DENIED
description: Works around an issue that occurs when you deploy Windows Update .msu files through Windows Remote Management 2.0 and Windows Remote Shell.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Windows Update Standalone Installer (WUSA) returns 0x5 ERROR_ACCESS_DENIED when deploying .msu files through WinRM and Windows Remote Shell

This article helps work around an issue that occurs when you deploy Windows Update .msu files through Windows Remote Management 2.0 and Windows Remote Shell.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2773898

## Symptoms

Windows Update Standalone Installer (WUSA) returns 0x5 ERROR_ACCESS_DENIED when deploying Windows Update .msu files through Windows Remote Management 2.0 and Windows Remote Shell. You may also see the following in the Application Event log:

> *Source: Microsoft-Windows-WUSA*  
*Event ID: 3*  
*Level: Error*  
*Description: Windows update could not be installed because of error 2147942405 "Access is denied."*  

Installing an update using WUSA or the WUA APIs on a remote machine isn't supported.

## Workaround

To work around this issue, use the following method:

Extract the .msu file through Windows Remote Shell with WUSA using the following command:

```console
winrs.exe -r:<computername> wusa.exe <update> /extract:<destination>
```

When complete, install the .cab package with dism.exe or Package Manager. To use dism.exe, use the command below:

```console
winrs.exe -r:<computername> dism.exe /online /add-package /PackagePath:<Path_To_Package>\KBnnnnnnn.cab
```

## More information

The Windows Update Standalone Installer uses the Windows Update Agent API to install update packages. Update packages have a .msu file name extension. The .msu file name extension is associated with the Windows Update Standalone Installer.

The security restrictions on remote use of the WUA APIs are documented here:

[Using WUA From a Remote Computer](https://msdn.microsoft.com/library/windows/desktop/aa387288%28v=vs.85%29.aspx)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).

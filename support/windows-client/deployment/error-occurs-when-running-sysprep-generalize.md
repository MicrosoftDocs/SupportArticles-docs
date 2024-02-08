---
title: Running Sysprep /generalize returns error
description: Describes how to work around the issue that may occur if the Windows Software Licensing Rearm program has run more than three times in a single Windows image.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup, csstroubleshoot
ms.subservice: deployment
---
# A fatal error occurred while trying to Sysprep the machine error when running Sysprep /generalize

This article solves the issue that you can't run the System Preparation Tool (Sysprep) in Windows 7 by using the `/generalize` option.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 929828

## Symptoms

When you try to run the Sysprep in Windows 7, and you use the `/generalize` option, you may receive this error message:

> A fatal error occurred while trying to Sysprep the machine.

The Setuperr.log file may contain lines that resemble the following:

```output
Error [0x0f0082] SYSPRP LaunchDll: Failure occurred while executing 'C:\Windows\System32\slc.dll, SLReArmWindows', returned error code -1073425657  
Error [0x0f0070] SYSPRP RunExternalDlls: An error occurred while running registry sysprep DLLs, halting sysprep execution. dwRet = -1073425657  
Error [0x0f00a8] SYSPRP WinMain: Hit failure while processing sysprep generalize providers; hr = 0xc004d307
```

> [!NOTE]
> The Setuperr.log file is located in the *\Windows\System32\Sysprep\Panther* folder.

## Cause

This error may occur if the Windows Software Licensing Rearm program has run more than three times in a single Windows image.

## Resolution

To resolve this issue, you must rebuild the Windows image.

## Workaround

To work around this issue, use the \<SkipRearm> setting in an XML answer file (Unattend.xml) to skip the Rearm process when you build the Windows image.

The following text is an example of an XML answer file for Windows 7:

```xml
<settings pass="generalize">
    <component name="Microsoft-Windows-Security-SPP" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <SkipRearm>1</SkipRearm>
    </component>
</settings>
```  

> [!NOTE]
> You must make sure that the \<SkipRearm> setting is removed from the final unattended file that is used to deploy computers in a production environment. If \<SkipRearm> is not removed from the unattended file that is used to deploy computers in a production environment, the KMS current client count does not increase for new clients that are added to the network.

For more information about the `skipRearm` tag of Microsoft-Windows-Security-Licensing-SLC component, see [SkipRearm](/previous-versions/windows/it-pro/windows-vista/cc722350(v=ws.10)).

For more information about `skipRearm` tag of Microsoft-Windows-Security-SPP component, see [Microsoft-Windows-Security-SPP](/previous-versions/windows/it-pro/windows-8.1-and-8/ff716103(v=win.10)).

## More information

The Windows Software Licensing Rearm program restores the Windows system to the original licensing state. All licensing and registry data related to activation is either removed or reset. Also, any grace period timers are reset.

To run the Rearm process in Windows 7, use one of the following methods:

- Run `Sysprep /generalize` on the computers that are used to build the custom Windows image.
- Run the Slmgr.vbs script in an elevated Command Prompt window. For example, run `cscript c:\windows\system32\slmgr.vbs -rearm`.

> [!NOTE]
> Administrative credentials are required to run the Rearm process. The Rearm process can be run a maximum of three times in a Windows image.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

---
title: WinRE can't be built after you deploy a Windows 8.1 image
description: Describes an issue in which you can't deploy a Windows 8.1-based image to a UEFI computer when the image was captured from a non-UEFI computer.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# WinRE can't be built after you deploy a Windows 8.1 image

This article provides a solution to an issue in which you can't deploy a Windows 8.1-based image to a UEFI computer when the image was captured from a non-UEFI computer.

_Applies to:_ &nbsp; Windows 8.1  
_Original KB number:_ &nbsp; 2952359

## Symptoms

Assume that you have a Windows 8.1 image that was captured from a non-UEFI computer. After you deploy the image to a UEFI computer, the Windows Recovery Environment (WinRE) can't be built on the UEFI computer.

When this issue occurs, messages that resemble the following are logged in the setupact.log file. The messages indicate that the setup process can't find the staged WinRE image, and that the WinRE can't be built:

> \<DateTime>, Info [setup.exe] WinReInstallOnTargetOS Beginning WinRE installation.  
\<DateTime>, Info [setup.exe] winreCheckRegKeyTest hook (S) present or enabled  
\<DateTime>, Info [setup.exe] WinReInstallOnTargetOS System setup is in progress.  
\<DateTime>, Info [setup.exe] WinReInstallOnTargetOS Checking for downlevel WinRE installation.  
\<DateTime>, Info [setup.exe] ReAgentXMLParser::ParseConfigFile (xml file: \\Recovery\\ReAgentOld.xml) returning 0X3  
\<DateTime>, Info [setup.exe] ReAgentConfig::ParseConfigFile returned with 0x3  
\<DateTime>, Info [setup.exe] WinReInstallOnTargetOS Getting current WinRE configuration.  
\<DateTime>, Info [setup.exe] WinReInstallOnTargetOS Disabling extra ReAgentConfig BCD checks for legacy setup.  
\<DateTime>, Info [setup.exe] WinReInstallOnTargetOS No source winre.wim was specified. Checking for a staged winre.wim.  
\<DateTime>, Info [setup.exe] WinReInstallOnTargetOS Searching for OEM Winre.wim  
\<DateTime>, Info [setup.exe] WinReInstallOnTargetOS Error 0X2 while searching for OEM winre.wim  
\<DateTime>, Warning [setup.exe] WinReInstallOnTargetOS (WinRE)WinREInstall() returning FALSE, gle = 0x64E  

## Cause

This issue occurs because the ImageLocation path tag is set to the \\Recovery\\WindowsRE value and the WinREStaged state tag is set to 1 in the Reagent.xml file. For more information, go to the [more information](#more-information) section.

## Resolution

To resolve this issue, use one of the following methods:

- Use the Windows 8.1 image that was captured from a UEFI computer to deploy to a UEFI computer.
- Change the Reagent.xml file that is located in the \\Windows\\System32\\Recovery\\Reagent.xml path inside the captured .wim file from non-UEFI computers by making the following changes:
  - Remove the value of the ImageLocation path tag by using "".
  - Set the value of the WinREStaged state tag to 0.

For example, change the XML file as follows:

```xml
<?xml version='1.0' encoding='utf-8' standalone='yes'?>
<WindowsRE version="2.0">
    <WinreBCD id=""></WinreBCD>
    <WinreLocation path="" id="0" offset="0"></WinreLocation>
    <ImageLocation path="" id="0" offset="0"></ImageLocation>
    <PBRImageLocation path="" id="0" offset="0" index="0"></PBRImageLocation>
    <PBRCustomImageLocation path="" id="0" offset="0" index="0"></PBRCustomImageLocation>
    <InstallState state="0"></InstallState>
    <OsInstallAvailable state="0"></OsInstallAvailable>
    <CustomImageAvailable state="0"></CustomImageAvailable>
    <WinREStaged state="0"></WinREStaged>
    <ScheduledOperation state="4"></ScheduledOperation>
    <OperationParam path=""></OperationParam>
    <OsBuildVersion path=""></OsBuildVersion>
    <OemTool state="0"></OemTool>
</WindowsRE>
```

## More information

### An example of the Reagent.xml file

After you capture the Windows 8.1 image from a non-UEFI computer by using Microsoft Deployment Toolkit (MDT) 2013, the \\Windows\\System32\\Recovery\\Reagent.xml file inside the WIM image may resemble the following:

```xml
<?xml version='1.0' encoding='utf-8'?>
<WindowsRE version="2.0">
    <WinreBCD id="{00000000-0000-0000-0000-000000000000}"/>
    <WinreLocation path="" id="0" offset="0" guid="{00000000-0000-0000-0000-000000000000}"/>
    <ImageLocation path="\Recovery\WindowsRE" id="4238117423" offset="1048576" guid="{00000000-0000-0000-0000-000000000000}"/>
    <PBRImageLocation path="" id="0" offset="0" guid="{00000000-0000-0000-0000-000000000000}" index="0"/>
    <PBRCustomImageLocation path="" id="0" offset="0" guid="{00000000-0000-0000-0000-000000000000}" index="0"/>
    <InstallState state="0"/>
    <OsInstallAvailable state="0"/>
    <CustomImageAvailable state="0"/>
    <IsAutoRepairOn state="1"/>
    <WinREStaged state="1"/>
    <OperationParam path=""/>
    <OsBuildVersion path="9600.16384.amd64fre.winblue_rtm.130821-1623"/>
    <OemTool state="0"/>
    <IsServer state="0"/>
    <DownlevelWinreLocation path="" id="0" offset="0" guid="{00000000-0000-0000-0000-000000000000}"/>
    <ScheduledOperation state="4"/>
</WindowsRE>
```

In this file, the WinRE image location is set to path \\Recovery\\WindowsRE, and WinREStaged is set to 1. These settings only work well when you deploy them on non-UEFI computers. If you use the image together with this xml file to build the OS on a UEFI computer such as Surface Pro or Surface Pro 2, the WinRE environment can't be built. Because of the lack of a WinRE environment, BitLocker can't be enabled.

### BitLocker does not work when WinRE is disabled

When WinRE is disabled, you can't enable BitLocker, and you receive an error message that resembles the following:

> This PC doesn't support entering a BitLocker recovery password during startup. Ask your administrator to configure Windows Recovery Environment so that you can use BitLocker.

You can also use the `Reagentc.exe /info` command to receive the WinRE status to confirm whether it's enabled. For example, you receive the following results when you run the command:

```console
C:\WINDOWS\system32>Reagentc.exe /info
Windows Recovery Environment (Windows RE) and system reset configuration
Information:

Windows RE status: Enabled
 Windows RE location: \\?\GLOBALROOT\device\harddisk0\partition1\Recovery\WindowsRE
 Boot Configuration Data (BCD) identifier: ########-####-####-####-############
 Recovery image location:
 Recovery image index: 0
 Custom image location:
 Custom image index: 0

REAGENTC.EXE: Operation Successful.
```

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

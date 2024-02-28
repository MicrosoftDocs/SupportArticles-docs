---
title: Previously released updates are reoffered
description: Lists the previously released updates that will be reoffered for systems that were built by using media that contains the November 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Previously released Windows updates are reoffered for some systems

This article lists the previously released updates that will be reoffered for systems and provides a solution to this issue.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3037986

## Symptoms

When systems that were built by using media that contains update rollup [3000850](https://support.microsoft.com/help/3000850?wa=wsignin1.0) (the November 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2) rerun Windows Update, the following previously released updates will be reoffered.

| Article number| Description |
|---|---|
| [2977765](https://support.microsoft.com/help/2977765)|MS14-053: Description of the security update for the .NET Framework 4.5.1 and the .NET Framework 4.5.2 for Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: September 9, 2014|
| [2978041](https://support.microsoft.com/help/2978041)|MS14-057: Description of the security update for the .NET Framework 4.5.1 and the .NET Framework 4.5.2 for Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: October 14, 2014|
| [2978126](https://support.microsoft.com/help/2978126)|MS14-072: Description of the security update for the .NET Framework 4.5.1 and 4.5.2 on Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: November 11, 2014|
| [2979576](https://support.microsoft.com/help/2979576)|MS14-057: Description of the security update for the .NET Framework 4.5.1 and the .NET Framework 4.5.2 for Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: October 14, 2014|
| [2894856](https://support.microsoft.com/help/2894856)|Description of the security update for the .NET Framework 4.5.1 on Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2: December 10, 2013|
| [3002885](https://support.microsoft.com/help/3002885)|MS14-079: Vulnerabilities in kernel-mode driver could allow denial of service: November 11, 2014|
| [2899189](https://support.microsoft.com/help/2899189)|Update adds support for many camera-specific file formats in Windows 8.1 or Windows RT 8.1: December 2013|
| [2976536](https://support.microsoft.com/help/2976536)|November 2014 anti-malware platform update for Windows Defender in Windows 8.1 and Windows 8|
| [2990967](https://support.microsoft.com/help/2990967)|Some versions of the OneDrive desktop app for Windows do not update automatically|
| [2998174](https://support.microsoft.com/help/2998174)|Active camera is switched unexpectedly when you review photos in Camera app in Windows 8.1 or Windows Server 2012 R2|
  
## Cause

The updates that are listed here were not included in the stand-alone November 2014 update package or released in conjunction with that update package.

## Resolution

When you build your reference image, you should either install these updates through Windows Update or download and install them manually.

## More information

There are scenarios in which update [2919355](https://support.microsoft.com/help/2919355)  (Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2 update: April 2014) or will also be reoffered. These scenarios and their resolutions are as follows.

### Scenario 1

Images were built by using the April 2014 volume license media, and you have update 3000850 installed.

Resolution Integrate update 2959977 and update 2934018 by using the DISM method. (This method is described later.)

### Scenario 2

Images that were built by using the November 2014 or April 2014 volume license media on which one of the following language packs was later installed: cs-cz, da-dk, de-de, el-gr, es-es, fi-fi, fr-fr, hu-hu, it-it, ja-jp, ko-kr, nb-no, nl-nl, pl-pl, pt-br ,pt-pt, ru-ru, sv-se, tr-tr, zh-cn, zh-hk, zh-tw.

Resolution Install the language packs that are required for the environment before you install update 2913955. Or, install update 2934018 by using the stand-alone installer.

### Scenario 3

Images that were built by using the November 2014 volume license media in which a language pack was later installed may be reoffered.

Resolution: Use Windows Update to complete the installation of the missing language components

### The DISM method

To integrate packages into an image by using the DISM method, follow these steps:

1. Download the standalone package for the update or updates that you want to integrate.
2. Create a new directory to expand the update package.
3. Extract the update package by using the following command:

    expand -f:* < **path to .msu** > < **destination** >

    For example, the following command expands update 2959977 to the C:\Cabs folder:

    expand -f:* Windows8.1-KB2959977-x64.msu c:\cabs

4. Integrate the expanded cabinet (.cab) file into the image from the expanded package by using the following command:

    DISM /Online /Add-Package /PackagePath:< **path to extracted .cab file from step 3** >

    For example, the command to integrate the update 2959977 .cab file would be as follows:

    DISM /Online /Add-Package /PackagePath:c:\cabs\Windows8.1-KB2959977-x64.cab

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

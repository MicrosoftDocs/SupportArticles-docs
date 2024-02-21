---
title: Can't use ImageX.exe as backup tool
description: Describes the reasons why you cannot use the ImageX.exe tool as a backup tool
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, scottmca
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# You can't use the ImageX.exe tool as a backup tool

This article describes the reasons why you can't use the ImageX.exe tool as a backup tool for a Windows computer. The ImageX.exe tool ships as part of the Windows Automated Installation Kit (WAIK).  

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 935467

## Introduction

You can use the ImageX.exe tool to capture an operating system installation image on which you have run Sysprep (Sysprep.exe) from the Windows Preinstallation Environment (Windows PE). You can then deploy the operating system installation image on another computer.

Although the ImageX.exe tool may appear to be a mechanism to create an image of a computer for backup, there are some issues that prevent using the ImageX.exe tool as a supported backup mechanism.

## Issues when you use imagex.exe as a backup mechanism

- Extended attributes are lost
- Sparse files on the system are captured and applied. However, the sparse files are no long sparse after they have been applied
- Symbolic links and junctions are automatically updated which in some scenarios such as Single Instance Storage(SIS) could lead to reparse points that contain NTFS file id's could be pointing to incorrect locations  

Microsoft recommends you use Windows backup, Windows Server backup, or other tool designed specifically for backup to make a full system image backup.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

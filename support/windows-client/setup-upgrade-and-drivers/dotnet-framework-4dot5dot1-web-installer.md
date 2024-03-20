---
title: .NET Framework 4.5.1 (web installer) for Windows 7 SP1 and Windows Server 2008 R2 SP1
description: Describes the Microsoft .NET Framework 4.5.1 (web installer) for Windows 7 SP1 and Windows Server 2008 R2 SP1.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, preetikr
ms.custom: sap:Windows Setup, Upgrade and Deployment\Installing or upgrading Windows, csstroubleshoot
---
# The .NET Framework 4.5.1 (web installer) for Windows 7 SP1 and Windows Server 2008 R2 SP1

This article provides information about the Microsoft .NET Framework 4.5.1 (web installer) for Windows 7 Service Pack 1 and Windows Server 2008 R2 Service Pack 1.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2859818

## Introduction

The Microsoft .NET Framework 4.5.1 is a highly compatible, in-place update to the Microsoft .NET Framework 4 and the Microsoft .NET Framework 4.5.

The web installer is a small package (less than 1 megabyte) that automatically determines and downloads only the components applicable for a particular platform. The web installer also installs the language pack that matches the language of the user's operating system.

## Download information

The following file is available for download from the Microsoft Download Center:

[Download the package now.](https://go.microsoft.com/fwlink/?linkid=321331)

For more information about how to download Microsoft support files, see [How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591).

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.

## What's new in the .NET Framework 4.5.1

The .NET Framework 4.5.1 supports the writing of code in C#, Visual Basic, and F# programming languages, and includes these significant language and framework enhancements:

- Better performance and reliability
- ASP.NET applications suspend and resume
- On-demand compaction of the large object heap
- 64-bit Edit and Continue
- Activity tracing and sampling
- SQL connection resiliency
- Managed return valuesFor more information about these and other features of the .NET Framework 4.5.1, see the [.NET Framework Developer Center](https://dotnet.microsoft.com/) website. This version of the .NET Framework runs side by side with the Microsoft .NET Framework 3.5 Service Pack 1 (SP1) and earlier versions, but performs an in-place update for the .NET Framework 4 and the .NET Framework 4.5.

## Command-line options for this update

For more information about the various command-line options that are supported by this update, go to the Command-Line options section in [.NET Framework Deployment Guide for Developers](/dotnet/framework/deployment/deployment-guide-for-developers#command_line_options).

## Restart requirement

You may have to restart the computer after you install this software if any affected files are being used. We recommend that you close all applications that are using the .NET Framework before you apply this update.

## Status

Microsoft has confirmed that this is a problem.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

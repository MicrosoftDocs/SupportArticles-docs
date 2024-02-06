---
title: Command line switches supported by Self-Extractor packages
description: Describes the command line switches supported by a software installation package, an update package, or a hotfix package created by using Microsoft Self-Extractor.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Command-line switches supported by a software installation package, an update package, or a hotfix package created with Microsoft Self-Extractor

This article describes the command line switches supported by a software installation package, an update package, or a hotfix package that's created by using Microsoft Self-Extractor.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 912203

## Summary

A Self-Extractor package is a self-extracting executable (.exe) file. You can run the .exe file to install the package. To run the .exe file, use one of the following methods:

- Double-click the .exe file.
- Run the .exe file from a command line.

## Run Self-Extractor packages from a command line

If you run the .exe file from a command line, several switches may be available for use in the package.

> [!NOTE]
> Not all switches may be available in all packages.

To determine which switches are available in the package, use one of the following Help switches:

- `/?`
- `/h`
- `/help`

The following table lists the command-line switches that are supported by Microsoft Self-Extractor.

| Switch| Description |
|---|---|
| `/extract:[path]`|Extracts the content of the package to the path folder. If a path isn't specified, then a **Browse** dialog box appears.|
| `/log:[path to log file]`|Enables verbose logging for the update installation.<br/><br/>Besides the path information, the file name must be included. Because the command doesn't create a folder that doesn't exist, only an existing folder name should be provided. Besides the file name that is specified, a separate log file will be created for each .msi file that is run.|
| `/lang:lcid`|Sets the user interface to the specified locale when multiple locales are available in the package.|
|`/quiet`|Runs the package in silent mode.|
| `/passive`|Runs the update without any interaction from the user.|
| `/norestart`|Prevents prompting of the user when a restart of the computer is needed.|
| `/forcerestart`|Forces a restart of the computer as soon as the update is finished.|
| `/?`, `/h`, `/help`|Shows this help message.|
  
## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

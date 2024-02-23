---
title: Switches with Xcopy and Xcopy32 commands
description: Describes syntax and switches that you can use with xcopy and xcopy32 commands.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, austinm
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Switches that you can use with xcopy and xcopy32 commands

This article describes switches that you can use with `xcopy` and `xcopy32` commands.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 289483

## Summary

The `xcopy` and `xcopy32` commands have the same switches. This article describes the switches that are available when you run the commands:

- outside of Windows (in MS-DOS mode).
- from an MS-DOS window.

## Syntax and switches in MS-DOS mode

The following command line includes the syntax and the switches that you can use with the `xcopy` and `xcopy32` commands in MS-DOS mode:

`xcopy **source** [**destination**] [/a | /m] [/d: **date**] [/p] [/s] [/e] [/v] [/w]`

> [!NOTE]
> The square brackets ([]) indicate optional switches. The brackets aren't part of the command.

The following table describes the optional switches you can use with `xcopy` and `xcopy32`:

|Optional switches|Description|
|---|---|
| source|Specifies the file to copy.|
| destination|Specifies the location and the name of new files.|
| /a|Copies files with the archive attribute set. This switch doesn't change the attribute.|
| /m|Copies files with the archive attribute set, and turns off the archive attribute.|
| /d: date|Copies files changed on or after the specified date.|
| /p|Prompts you before creating each destination file.|
| /s|Copies folders and subfolders except empty ones.|
| /e|Copies any subfolder, even if it's empty.|
| /v|Verifies each new file.|
| /w|Prompts you to press a key before copying.|
  
> [!WARNING]
> Long file names aren't retained in MS-DOS mode.

> [!NOTE]
> In Windows Millennium Edition (Me) only, an `/h` switch is added to the `xcopy` and the `xcopy32` commands. This switch copies hidden and system files in MS-DOS mode. However, the `Xcopy` files aren't automatically included on the Windows Me boot disk.

## Syntax and switches in MS-DOS window

The following command line includes the syntax and the switches for the `xcopy` and `xcopy32` commands when you run it from an MS-DOS window:

`xcopy **source** [ **destination** ] [/a | /m] [/d: **date**] [/p] [/s] [/e] [/w] [/c] [/i] [/q] [/f] [/l] [/h] [/r] [/t] [/u] [/k] [/n]`

> [!NOTE]
> The square brackets ([]) indicate optional switches. The brackets aren't part of the command.

The following table describes the optional switches you can use with `xcopy` and `xcopy32` when you run the command in an MS-DOS window:

|Optional switches|Description|
|---|---|
| source|Specifies the file to copy.|
|destination|Specifies the location and the name of new files.|
| /a|Copies files with the archive attribute set. This switch doesn't change the attribute.|
| /m|Copies files with the archive attribute set, and turns off the archive attribute.|
| /d: date|Copies files changed on or after the specified date.|
| /p|Prompts you before each destination file is created.|
| /s|Copies folders and subfolders except for empty ones.|
| /e|Copies any subfolder, even if it's empty.|
| /w|Prompts you to press a key before copying.|
| /c|Continues copying even if errors occur.|
| /i|If the destination doesn't exist, and you're copying more than one file, this switch assumes that the destination is a folder.|
| /q|Doesn't display file names while copying.|
| /f|Displays full source and destination file names while copying.|
| /l|Displays files that are going to be copied.|
| /h|Copies hidden and system files.|
| /r|Overwrites read-only files.|
| /t|Creates a folder structure, but doesn't copy files. Doesn't include empty folders or subfolders. Use the /t with the /e switch to include empty folders and subfolders.|
| /u|Updates the files that already exist in that destination.|
| /k|Copies attributes. Typical `xcopy` commands reset read-only attributes.|
| /y|Overwrites existing files without prompting you.|
| /-y|Prompts you before overwriting existing files.|
| /n|Copies using the generated short names.|
  
## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

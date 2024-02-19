---
title: Long paths with spaces require quotation marks
description: Solves an issue that occurs when you specify long filenames or paths with spaces.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Long filenames or paths with spaces require quotation marks

This article provides a solution to an issue that occurs when you specify long filenames or paths with spaces.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 102739

## Symptoms

The following error message is given when specifying long filenames or paths with spaces in Windows NT:

> The system cannot find the file specified

## Cause

Long filenames or paths with spaces are supported by NTFS in Windows NT. However, these filenames or directory names require quotation marks around them when they are specified in a command prompt operation. Failure to use the quotation marks results in the error message.

## Resolution

Use quotation marks when specifying long filenames or paths with spaces. For example, typing the `copy c:\my file name d:\my new file name` command at the command prompt results in the following error message:

> The system cannot find the file specified.

The correct syntax is:

```console
copy "c:\my file name" "d:\my new file name"
```

> [!NOTE]
> The quotation marks must be used.

## More information

Spaces are allowed in long filenames or paths, which can be up to 255 characters with NTFS. All operations at the command prompt involving long names with spaces, however, must be treated differently. Normally, it is an MS-DOS convention to use a space after a word to specify a parameter. The same convention is being followed in Windows NT command prompt operations even when using long filenames.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).

---
title: Long paths with spaces require quotation marks
description: Solves an issue that occurs when you specify long filenames or paths with spaces.
ms.date: 09/23/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Setup
ms.technology: windows-server-deployment
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

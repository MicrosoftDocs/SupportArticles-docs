---
title: Third-party backup warnings after you install a servicing update in Windows Server 2016
description: You receive a warning when using a third-party backup application after you install a Windows Servicing Stack Update.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jeffbo
ms.custom: sap:volume-shadow-copy-service-vss, csstroubleshoot
---
# Third-party backup warnings after you install a servicing update in Windows Server 2016

This article provides a solution to the third-party backup warnings that occurs after you install a servicing update in Windows Server 2016.

_Applies to:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4052556

## Symptom

Consider the following scenario:

- On a computer that is running Windows Server 2016 (Version 1607, build 14393.693), you install a servicing stack update. For example, the March 14, 2017 Servicing Stack Update ([KB 4013418](https://support.microsoft.com/help/4013418)).
- The folder C:\\Windows\\servicing\\Version\\10.0.14393.1051 is automatically created, and the amd64_installed and x86_installed files are saved to this folder
- The older-version folder under C:\\Windows\\servicing is emptied. For example, the following files are removed:  
    C:\\Windows\\servicing\\Version\\10.0.14393.0\\amd64_installed  
    C:\\Windows\\servicing\\Version\\10.0.14393.0\\x86_installed
- You run `diskshadow /l output.txt`, and then `list writers detailed` at the diskshadow prompt.

In this scenario, when you examine the system writer metadata in output.txt, you find the amd64_installed and x86_installed files are listed in the old version folder path that no longer exists.

As a result, third-party backup applications may return warnings like the following:  
> Date/TimeANS4251W System Writer file '\\\\?\\globalroot\\device\\harddiskvolumeshadowcopy3\\windows\\servicing\\version\\10.0.14393.0\\amd64_installed': not found.
Date/TimeANS4251W System Writer file '\\\\?\\globalroot\\device\\harddiskvolumeshadowcopy3\\windows\\servicing\\version\\10.0.14393.0\x86_installed': not found.

This issue does not occur with Windows Server 2016 RTM version.
> [!Note]
> This issue does not affect System State backup with Windows Server backup.

## Resolution

To fix the issue, create new placeholder files with the same name for the files that are reported as not found.  
C:\\Windows\\servicing\\Version\\10.0.14393.0\\amd64_installed  
C:\\Windows\\servicing\\Version\\10.0.14393.0\\x86_installed

## More information

The files are no longer needed. However, they are still listed as needing to be backed up. The content of the file is irrelevant and can be empty.

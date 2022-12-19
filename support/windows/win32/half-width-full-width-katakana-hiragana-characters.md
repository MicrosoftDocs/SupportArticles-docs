---
title: Half-width and full-width Japanese characters are treated as different characters
description: This article provides resolutions to the problem where certain half-width and full-width Katakana and Hiragana characters with a consonant mark aren't compared properly by the .NET Framework 4.x applications.
ms.date: 03/12/2020
ms.custom: sap:Desktop app UI development
author: jun-yo
ms.author: v-jayaramanp
ms.reviewer: jun-yo
ms.technology: windows-dev-apps-system-services-dev
---

# Half-width and Full-width Katakana and Hiragana characters with consonant mark are treated as different characters

This article helps you resolve the problem when .NET Framework 4.x applications compare Japanese strings.

_Applies to:_ &nbsp; Windows 10 version 2004, Windows 10 version 20H2, Windows 10 version 21H1, Windows 10 version 21H2, Windows 10 version 22H2  

## Symptoms

Certain Japanese half-width and full-width Katakana and Hiragana characters that have a consonant mark aren't interpreted as the same character. When you use the `ComapreInfo.IndexOf` method with the `IgnoreKataType` and/or `IgnoreWidth` options as `CompareOptions` to compare them, these characters are evaluated as different because of an issue in the sorting rule.

## Cause

Starting with version 2004, Windows 10 updated the version of National Language Support (NLS) to 6.3 and added support for Arabic and Hebrew. This addition affects the rules for sorting Japanese  string comparisons that use NLS will produce different results.

## Solution

There are two workarounds for the problem.

The first workaround reverts the National Language Support (NLS) sorting rule to version 6.2, which is used in Windows 10 version 1909 and earlier versions. When you have to share data between systems, consider applying the workaround consistently. If you use this workaround, perform sufficient testing and evaluations to mitigate problems caused by different sorting rule versions on multiple systems.

1. Open the Command Prompt window (cmd.exe) with administrator privileges.
1. Run `reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Sorting\Versions /ve /d 0006020F /f`
1. Restart the computer or processes to see the full effect.

> [!IMPORTANT]
> If you haven't installed KB4586853 or later on the computer, setting an invalid value in this registry might prevent the computer from starting.

The second workaround sets the NLS sorting rule to version 6.4, which is the same as Windows 11. To do this, you must apply KB5014023 or a later update, and upgrade the version to *.1741 or higher. In this case, version 22H2 is already applied and doesn't need to be updated.

1. Apply KB5014023 or a later update for versions 2004, 20H2, 21H1, and 21H2.
1. Open the Command Prompt window (cmd.exe) with administrator privileges.
1. Run `reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Sorting\Versions /ve /d 00060403 /f`
1. Restart the computer or processes to see the full effect.

Changing registry values can cause problems such as the system not booting. Make changes to the registry in case of unforeseen circumstances, such as creating a system backup.


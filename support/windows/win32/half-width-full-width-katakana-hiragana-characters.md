---
title: Half-width and full-width Japanese characters are treated as different characters
description: This article resolves a problem that prevents certain half-width and full-width Katakana and Hiragana characters that have a consonant mark from being compared correctly by .NET Framework 4.x applications.
ms.date: 12/21/2022
ms.custom: sap:Desktop app UI development
ms.reviewer: junyoshi, v-jayaramanp
ms.technology: windows-dev-apps-system-services-dev
---

# Half-width and Full-width Katakana and Hiragana characters with consonant marks are treated as different

This article helps you resolve a problem that occurs when .NET Framework 4.*x* applications compare Japanese strings.

_Applies to:_ &nbsp; Windows 10 version 2004, Windows 10 version 20H2, Windows 10 version 21H1, Windows 10 version 21H2, Windows 10 version 22H2  

## Symptoms

Certain Japanese half-width and full-width Katakana and Hiragana characters that have a consonant mark aren't interpreted as the same character. When you use the `CompareInfo.IndexOf` method and the `IgnoreKanaType` or `IgnoreWidth` options as `CompareOptions` to make a comparison, these characters are evaluated as different because of an issue in the sorting rule.

## Cause

Starting in version 2004, Windows 10 updated the version of National Language Support (NLS) to 6.3 and added support for Arabic and Hebrew. This addition affects the rules for sorting Japanese string comparisons that use NLS so that the comparisons will produce different results.

## Workaround

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly. These problems could cause you to have to reinstall the operating system or even prevent your machine from starting. Microsoft can't guarantee that these problems can be solved. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/en-us/help/322756) in case problems occur. Modify the registry at your own risk.

### Workaround 1

Revert the NLS sorting rule to version 6.2. This version is used in Windows 10, version 1909 and earlier versions. When you have to share data between systems, consider applying the workaround consistently. If you use this workaround, do sufficient testing and evaluations to mitigate problems that are caused by different sorting rule versions on multiple systems.

To use this workaround, follow these steps:

1. Open a Command Prompt window (*cmd.exe*) as an administrator.
1. Run the following command:

   > `reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Sorting\Versions /ve /d 0006020F /f`
1. Restart the computer or processes to see the full effect.

> [!IMPORTANT]
> If you haven't installed KB4586853 or a later update on the computer, setting an invalid value in this registry entry might prevent the computer from starting.

### Workaround 2

Set the NLS sorting rule to version 6.4. This version is used in Windows 11. To do this, you must apply KB5014023 or a later update, and upgrade the version to version 1741 or a later version. In this case, version 22H2 is already applied and doesn't have to be updated.

1. Apply KB5014023 or a later update for Windows 10 versions 2004, 20H2, 21H1, and 21H2.
1. Open the Command Prompt window (*cmd.exe*) as an administrator.
1. Run the following command:

   > `reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Sorting\Versions /ve /d 00060403 /f`
1. Restart the computer or processes to see the full effect.
